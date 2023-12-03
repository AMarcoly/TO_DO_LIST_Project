---
title: Base de données pour une application de gestion de listes tâches (<<to-do>> list).
author: MARCOLY Antone && DIALLO Abdoul Aziz
date: 03/12/2023
...

# Requêtes SQL

## Création d'Index pour optimiser les requêtes

En effet, l'efficacité réelle des index dépend de plusieurs facteurs, notamment la taille des table, la cardinalité des données et la manière dont ces données sont interrogées. En supposant que la notre base de données est peuplée de données réalistes, nous allons créer des index pour optimiser les requêtes.

- Pour la requête permettant d'afficher les programmes de tâches ayant le plus de points positifs, on peut créer des index sur les colonnes `date_realisation` de la table `Tache_fini` et `nom_categorie` de la table table `Score_categorie_tache` qui nous permettra d'accélérer les requêtes impliquant des filtrages ou des jointures basées sur ces colonnes.

  ```sql
  CREATE INDEX idx_tache_fini_date_realisation ON Tache_fini(date_realisation);
  CREATE INDEX idx_score_cat_tache_nom_cat ON Score_categorie_tache(nom_categorie);
  ```
