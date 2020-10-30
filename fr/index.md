# Environnement d'analyse collaborative (EAC)

L'Environnement d'analyse collaborative (EAC) fournit des services infonuagiques pour l'ingestion, la transformation la préparation, l'exploration et le traitement des données. Il comprend des outils d'analyse collaborative, des environnements d'apprentissage machine et des fonctions de visualisation des données. Les environnements de
bloc-notes et les machines virtuelles offrent des capacités d'analyses par l'entremise de divers logiciels statistiques comme R, Python et SAS. L'EAC exploite la plateforme Microsoft Azure comme service (PaaS) et les offres de logiciel-service (SaaS).

## Aperçu de l'environnement

Nous mettons actuellement à l'essai différents cas d'utilisation de la plateforme. Chaque cas d'utilisation peut être intégré à l'environnement **principal**. Sinon, il est possible de créer un nouvel environnement **privé**.

### Environnement principal (partagé)

L'environnement est partagé avec les utilisateurs de plusieurs cas d'utilisation. Lorsqu'ils ont accès à cet environnement, les utilisateurs peuvent visualiser et partager les données de ces cas
d'utilisation.

### Environnement privé

Un environnement privé configuré sur demande qui permet l'accès aux fichiers de l'espace de travail seulement aux utilisateurs désignés.

## Ingestion de données

Les données intègrent la plateforme au moyen d'un compte de stockage externe. Une fois dans la plateforme, elles sont stockées dans un compte
de stockage interne (Data Lake). Les sources de données accessibles au public peuvent être ingérées directement à l'aide de l'un des outils de
la plateforme.

### Compte de stockage externe

Les utilisateurs pourront accéder au compte de stockage externe à partir d'Internet et s'en servir pour téléverser et télécharger des données à
partir ou vers l'environnement. Dans certains environnements privés, des restrictions ou des processus de contrôle supplémentaires peuvent être
mis en œuvre pour le téléversement ou le téléchargement de données.

### Compte de stockage interne (Data Lake)

Les fichiers qui sont téléversés dans le compte de stockage externe sont automatiquement déplacés vers un Data Lake interne. Ce Data Lake se
trouve dans un réseau virtuel sécurisé et est uniquement accessible à partir des services des machines virtuelles de la plateforme.