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

- Afin d'optimiser la troisième requête, il est nécessaire de créer un index pour chacune des colonnes suivantes `ref_utilisateur` , `ref_periodicite` de la table `Tache_en_cours` car cela permettra d'accélérer significativement les regroupements et les agrégations par utilisateur et pour compter le nombre de tâches périodiques. D'où :

  ```sql
  CREATE INDEX idx_tache_en_cours_utilisateur ON Tache_en_cours(ref_utilisateur);
  CREATE INDEX idx_tache_periodicite_utilisateur ON Tache_en_cours(ref_periodicite);
  ```

- Des index sur les colonnes `ref_tache_1` et `ref_tache_2` de la table `Depend_de` peuvent être bénéfiques pour accélérer les requêtes cherchant à compter les dépendances pour chaque tâche. Ainsi, on aura les commandes suivantes :

  ```sql
  CREATE INDEX idx_depend_de_ref_tache_1 ON Depend_de(ref_tache_1);
  CREATE INDEX idx_depend_de_ref_tache_2 ON Depend_de(ref_tache_2);
  ```

- Les index sur `date_realisation` de `Tache_fini`, `nom_categorie` de `Score_categorie_tache` et `ref_utilisateur` de `Est_assigne` peuvent améliorer les performances de la jointure et des agrégations pour identifier les utilisateurs ayant gagné le plus de points.

```sql
CREATE INDEX idx_tache_fini_date_realisation ON Tache_fini(date_realisation);
CREATE INDEX idx_score_cat_tache_nom_cat ON Score_categorie_tache(nom_categorie);
CREATE INDEX idx_est_assigne_ref_utilisateur ON Est_assigne(ref_utilisateur);
```
