- Modif insert.sql
	- ref_utilisateur  2 était là deux fois. Contrainte d'intégrité clé unique non respecté.
	- Table en cours
		- erreur insertion 4
	- Taches finis
		- insertion 4


- Requetes
	- R2 -INNER JOIN au  lieu de join  pr s'assuser taches renvoyées ont bien été assignées à l'utilisateur précisé
	- R4 - WHERE
  			t.statut <> 'Terminée' , clause pour  vérifier que la  tache que l'on vérifie  n'est pas terminée sinon 
  			cela ne sert pas de vérifier les dépendances
  	- R5 FETCH remplacé par LIMIT 10  car FETCH n'est plus standardisé


 Procédure : 
 prob mais je ne  comprends pas où.

