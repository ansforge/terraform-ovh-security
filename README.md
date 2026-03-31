Infrastructure OVHcloud - Security (Production)

Ce dépôt Terraform gère la couche sécurité de l’infrastructure OVHcloud :
- déploiement de firewalls Stormshield (cluster)
- génération automatique de clés SSH
- création des interfaces réseau (ports OpenStack)
- attachement multi-réseaux des firewalls
- gestion sécurisée des credentials via Vault

🏗️ Structure du Projet

modules/security/ : Module principal gérant :
- génération des clés SSH (TLS)
- création des keypairs OpenStack
- création des ports réseau
- déploiement des instances firewall (Stormshield)

backend.tf : Configuration du backend distant (S3 OVH Object Storage).

main.tf : Point d’entrée Terraform appelant le module security.

variables.tf : Définition du cluster de firewalls.

security.tfvars : Configuration des instances (master/slave, réseaux, IPs).

🔐 Intégration Vault

Les credentials OpenStack sont récupérés dynamiquement via Vault :

iacrunner-prod/openstack_key :
- OS_AUTH_URL
- OS_APPLICATION_CREDENTIAL_ID
- OS_APPLICATION_CREDENTIAL_SECRET

👉 Utilisation de secrets éphémères :
- aucun secret stocké dans Terraform
- aucune fuite dans le state
- sécurité maximale

---

🔥 Architecture Sécurité

Déploiement d’un cluster Stormshield en haute disponibilité :

- fwfe01 → Master
- fwfe02 → Slave

Caractéristiques :

- Multi-homing (plusieurs interfaces réseau)
- IP statiques sur chaque réseau
- segmentation complète (DMZ / APP / K8S / INFRA)
- interconnexion firewall (HA + interco)

---

🌐 Rattachement Réseau

Chaque firewall est connecté à plusieurs VLANs :

Exemples :

- app_front → exposition applicative
- k8s_front → frontend Kubernetes
- dmz_exposed → zone exposée internet
- dmz_transit → transit réseau
- vrack_vpn → interconnexion VPN
- fw_interco → communication inter-firewall
- fwfe_ha → haute disponibilité
- fwfe_admin → administration
- fw_front → réseau public OVH

👉 Chaque interface possède :
- une IP statique
- un port OpenStack dédié
- aucune sécurité port (désactivée pour Stormshield)

---

⚙️ Fonctionnement technique

1. Génération des clés SSH

resource : tls_private_key

- clé RSA 4096 bits
- générée dynamiquement
- unique par firewall

---

2. Création KeyPair OpenStack

resource : openstack_compute_keypair_v2

- clé publique injectée dans OpenStack
- utilisée pour accès SSH

---

3. Récupération des réseaux

data : openstack_networking_network_v2

- recherche des réseaux par NOM
- évite les hardcodes d’ID
- dépend du projet network

---

4. Création des ports réseau

resource : openstack_networking_port_v2

- 1 port par interface
- IP statique définie
- port_security_enabled = false (obligatoire Stormshield)

---

5. Déploiement des instances

resource : openstack_compute_instance_v2

- attachement via ports (évite erreur 409)
- multi-interface dynamique
- metadata tags injectés

---

🪣 Backend Terraform

- Bucket : infra-prod-sto-object-tf01
- Région : RBX
- Endpoint : https://s3.rbx.io.cloud.ovh.net/

👉 Permet :
- centralisation du state
- cohérence infra
- travail collaboratif

---

🚀 Utilisation

Pré-requis

1. Vault accessible :

export VAULT_ADDR=https://vault.xxx

2. Secret requis :

- iacrunner-prod/openstack_key

3. Infrastructure réseau déjà déployée :
👉 dépend du projet terraform-ovh-network

---

Déploiement

terraform init  
terraform plan -var-file="security.tfvars"  
terraform apply -var-file="security.tfvars"

---

🔧 Variables

security.tfvars :

region = "RBX-A"

firewalls = {
  fwfe01 = {
    name   = "infra-prod-fwfe01"
    flavor = "xxx"
    image  = "xxx"
    networks = [
      { name = "network1", ip = "x.x.x.x", enabled = true }
    ]
    tags = { Env = "prod", Role = "master" }
  }
}

👉 Chaque firewall définit :
- nom instance
- flavor (CPU/RAM)
- image (Stormshield)
- liste des réseaux
- IP associées
- tags

---

📤 Outputs Terraform

fw_private_keys :
- clés privées SSH générées (sensibles)

fw_instance_ids :
- IDs OpenStack des instances

👉 Utilisable pour :
- Ansible
- bastion
- automatisation post-déploiement

---

🛡️ Sécurité

- clés SSH générées dynamiquement
- aucun mot de passe utilisé
- secrets récupérés depuis Vault
- port_security désactivé (compatibilité firewall)
- isolation réseau complète

---

⚠️ Points d’attention

- les réseaux doivent exister (terraform-ovh-network)
- les IPs doivent être libres dans les subnets
- ne pas activer port_security (sinon firewall KO)
- bien configurer les interfaces côté Stormshield

---

🧪 Vérifications post-déploiement

Lister instances :
openstack server list

Lister ports :
openstack port list

Tester accès SSH :
ssh -i <key> admin@<ip>

---

🔄 Améliorations possibles

- automatisation configuration Stormshield (API / Ansible)
- ajout floating IP automatisé
- intégration load balancer
- gestion HA avancée
- monitoring (Prometheus / Grafana)

---

👨‍💻 Auteur

Infrastructure Terraform OVHcloud – Layer sécurité (firewall + segmentation réseau) industrialisée pour production.
