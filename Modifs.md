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
  - test requete 2 ; attendu : sortie:
  - test requete 3 : attndu : sortie:
  - test requete 4 : notre table tache n'a pas de colonne valide
  - test requete 5 : aucun exemple à mettre

  Il faut créer des tahes non périodiques pour les users

Pour la procédure 1 a t on besoin de changer le score? on nous demande de le faire avec le trigger
Pour la procédure 2 pourquoi 2 procédures qui ont à peu près la même chose?
