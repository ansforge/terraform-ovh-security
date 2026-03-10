# Infrastructure OVHcloud - Security (Stormshield Cluster)

Ce dépôt Terraform gère la couche de sécurité périmétrale de l'infrastructure de production. Il déploie un cluster de deux instances **Stormshield Network Security (SNS)** pour assurer le filtrage inter-VLAN et la terminaison VPN.

## 🛡️ Architecture de Sécurité

Le projet déploie deux nœuds (Master/Slave) rattachés à l'ensemble des réseaux privés du vRack :

* **Instances** : Stormshield SNS (Flavor & Image spécifiques OVH).
* **Connectivité** : 14 interfaces réseau par firewall, couvrant tous les VLANs (Front, Admin, App, K8s, DMZ).
* **Mode Réseau** : Le `port_security` OpenStack est désactivé sur toutes les interfaces pour permettre au Stormshield de gérer lui-même le routage et le filtrage L3/L4 sans interférence.

## 🔑 Gestion des Accès & Clés

* **SSH** : Les clés SSH sont générées dynamiquement par le module via le provider `tls`.
* **Identifiants** : Le provider OpenStack est alimenté par les **Application Credentials** récupérés de manière éphémère dans Vault (`iacrunner-prod/openstack_key`).

## 🏗️ Structure du Module

Le module `security` effectue les actions suivantes :
1.  Génération d'une paire de clés RSA 4096 bits.
2.  Résolution des IDs de réseaux OpenStack à partir des noms fournis.
3.  Création des ports réseau avec IPs statiques réservées (ex: `.254` pour le Master, `.253` pour le Slave).
4.  Instanciation des machines virtuelles avec attachement dynamique des ports.

## 🚀 Déploiement

### Pré-requis
Charger les identifiants de backend S3 (stockés dans Vault) :
```bash
export AWS_ACCESS_KEY_ID=$(vault kv get -field=AWS_ACCESS_KEY_ID iacrunner-prod/aws_key)
export AWS_SECRET_ACCESS_KEY=$(vault kv get -field=AWS_SECRET_ACCESS_KEY iacrunner-prod/aws_key)
