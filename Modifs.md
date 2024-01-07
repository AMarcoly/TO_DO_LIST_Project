- Modif insert.sql

  - ref_utilisateur 2 était là deux fois. Contrainte d'intégrité clé unique non respecté.
  - Table en cours
    - erreur insertion 4
  - Taches finis
    - insertion 4

- Requetes
  - R2 -INNER JOIN au lieu de join pr s'assuser taches renvoyées ont bien été assignées à l'utilisateur précisé
  - R4 - WHERE
    t.statut <> 'Terminée' , clause pour vérifier que la tache que l'on vérifie n'est pas terminée sinon
    cela ne sert pas de vérifier les dépendances
    - R5 FETCH remplacé par LIMIT 10 car FETCH n'est plus standardisé

Procédure :
prob mais je ne comprends pas où.

- Modif 04/01

  - refactoring reques.sql
  -

- Modif 06-01

  - test requete 1 ; attendu : tache 101 sortie : tache 101 ok
  - test requete 2 ; attendu : 160 sortie: 160
  - test requete 3 : attndu : Chaque utlisateur a une tache sortie: chaque utilisateur 1 tache
  - test requete 4 : attendu : tache 1004 et 1002 ont chacune 1 dépendance sortie: tache 1004 et 1002 ont chacune une dépendance
  - test requete 5 :
    Les gistoires de dates à mettre sur le rapport

  - test procedure 1: efectué
    Il faut créer des tahes non périodiques pour les users

Pour la procédure 1 a t on besoin de changer le score? on nous demande de le faire avec le trigger
Pour la procédure 2 pourquoi 2 procédures qui ont à peu près la même chose?
Suggestions pour la dernière procédure


J'ai dû créer une autre table Table_associee mais sans la colonne `ref_periodicite` vu que ça sera des taches individuelles pour pouvoir stocker les nouvelles tâches. Il est impossible d'utiliser la table Tache_en_cours car primo la colonne ref_periodicite est `NOT NULL` et deuzio s'il faut utiliser cette colonne on aura plusieurs tâches qui auront la même `ref_periodicite` dans ce cas les cardinalités des rélations ne seront pas respectées. C'est pourquoi j'ai décidé de créer une autre table.