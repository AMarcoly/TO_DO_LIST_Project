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
  Cependant, vous remarquerez que le fichier `index.sql` nous avons commenté les index `idx_tache_fini_date_realisation` et `idx_score_cat_tache_nom_cat` car ils sont déjà crée ci-haut dans `index.sql`.

## Procédures et fonctions PL/SQL
1. On ajoute 10 points aux scores de tous les utilisateurs ayant un programme de score et qui ont terminées plus de 50% de leurs tâches sinon on retire 5 points à leurs scores. Cependant afin que la procedure puisse faire des mis à jour de score il faudra s'assurer que la tâche a été réalisée dans la semaine courante.

2. Afin d'archiver les taches passées, nous devons absolument regarder dans la table `Taches_en_cours` toutes les taches dont la date déchéance est antérieure à la date du jour où la procedure s'execute c'est-à-dire tous les lundis à 8h (Par supposition).

3. 

## Déclencheurs
1. Pour ce déclencheur, nous avons deux corps identiques mais avec un prototype différent, on a avait pensé à utiliser qu'un seul déclencheur qui attend qu'une tâche soit terminée ou archivée mais ORACLE ne supporte pas cette façon de le faire, raison pour laquelle nous avons utilisé deux déclencheurs.

2. On dû créer une autre table Table_associee mais sans la colonne `ref_periodicite` vu que ça sera des taches individuelles pour pouvoir stocker les nouvelles tâches. Il est impossible d'utiliser la table Tache_en_cours car primo la colonne ref_periodicite est `NOT NULL` et deuzio s'il faut utiliser cette colonne on aura plusieurs tâches qui auront la même `ref_periodicite` dans ce cas les cardinalités des relations ne seront pas respectées. C'est pourquoi nous avons décidé de créer une autre table `Tache_associee`.

## Définition de contraintes intégrité

1. `CONTRAINTE FK_COMPORTE_REFSCORE_CATEGORIE` sur la table Comporte :
   Cette contrainte assure que la colonne ref_score_categorie_tache de la table Comporte est une clé étrangère 
   qui fait référence à la colonne ref_score_categorie_tache de la table Score_categorie_tache.

2. `CONTRAINTE FK_CONTIENT_REFLISTE` sur la table Contient :
   Cette contrainte garantit que la colonne ref_liste de la table Contient est une clé étrangère 
   faisant référence à la colonne ref_liste de la table Liste_tache.

3. `CONTRAINTE FK_DEPEND_RETACHE1` et `FK_DEPEND_RETACHE2` sur la table Depend_de :
   Ces contraintes assurent que les colonnes ref_tache_2 et ref_tache_1 de la table Depend_de sont des clés étrangères 
   référençant la colonne ref_tache de la table Tache.

4. `CONTRAINTE FK_EST_ASSIGNE_REFTACHE` et `FK_EST_ASSIGNE_REFUTILISATEUR` sur la table Est_assigne :
   Ces contraintes garantissent que les colonnes ref_tache et ref_utilisateur de la table Est_assigne sont des clés étrangères 
   faisant référence respectivement aux colonnes ref_tache et ref_utilisateur de la table Utilisateur.

5. `CONTRAINTE FK_LISTETACHE_REFUTILISATEUR `sur la table Liste_tache :
   Cette contrainte assure que la colonne ref_utilisateur de la table Liste_tache est une clé étrangère 
   référençant la colonne ref_utilisateur de la table Utilisateur.

6. `CONTRAINTE FK_TACHE_FINI_REF`, `FK_TACHE_FINI_REF_REFUTILISATEUR` et `FK_TACHE_FINI_REFPERIODICITE` sur la table `Tache_fini` :
   Ces contraintes garantissent que les colonnes ref_tache, ref_utilisateur et ref_periodicite de la table Tache_fini sont des clés étrangères 
   faisant référence respectivement aux colonnes ref_tache, ref_utilisateur et ref_periodicite des tables Tache, Utilisateur et Periodicite.

7. CONTRAINTE `FK_TACHE_EN_COURS_REF`, `FK_TACHE_EN_COURS_REFUTILISATEUR` et `FK_TACHE_EN_COURS_REFPERIODICITE` sur la table `Tache_en_cours` :
   Ces contraintes assurent que les colonnes ref_tache, ref_utilisateur et ref_periodicite de la table Tache_en_cours sont des clés étrangères 
   référençant respectivement les colonnes ref_tache, ref_utilisateur et ref_periodicite des tables Tache, Utilisateur et Periodicite.

8. CONTRAINTE `FK_TACHELISTE_REFTACHE` et `FK_TACHELISTE_REFLISTE` sur la table `Tache_appartenant_a_liste` :
   Ces contraintes garantissent que les colonnes ref_tache et ref_liste de la table Tache_appartenant_a_liste sont des clés étrangères 
   référençant respectivement les colonnes ref_tache et ref_liste des tables Tache et Liste_tache.

9. CONTRAINTE `FK_TRAVAILLE_REFUTILISATEUR` et `FK_TRAVAILLE_REFPROJET` sur la table `Travaille` :
   Ces contraintes assurent que les colonnes ref_utilisateur et ref_projet de la table Travaille sont des clés étrangères 
   faisant référence respectivement aux colonnes ref_utilisateur et ref_projet des tables Utilisateur et Projet.

10. CONTRAINTE `check_mot_de_passe_format` sur la table `Utilisateur` :
    Cette contrainte assure que la colonne mot_de_passe de la table Utilisateur suit un format spécifique. 
    Elle autorise uniquement les lettres minuscules, les chiffres et le caractère underscore (_).

11. CONTRAINTE `check_login_format` sur la table `Utilisateur` :
    Cette contrainte garantit que la colonne login de la table Utilisateur suit un format spécifique. 
    Elle exige une lettre minuscule suivie de 7 lettres minuscules et ensuite 2 chiffres.
