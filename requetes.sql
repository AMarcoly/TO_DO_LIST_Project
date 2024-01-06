-- 1. Les listes de tâches ayant au moins 5 tâches et appartenant à des utilisateurs habitant en France
SELECT LT.ref_liste
FROM Liste_tache LT
JOIN Tache_appartenant_a_liste TAL ON LT.ref_liste = TAL.ref_liste
JOIN Utilisateur U ON LT.ref_utilisateur = U.ref_utilisateur
WHERE U.pays = 'France'
GROUP BY LT.ref_liste
HAVING COUNT(TAL.ref_tache) >= 5;

-- 2. Les programmes de tâche ayant le plus de points positifs (somme des points) associés aux tâches terminées.
SELECT U.nom_programme, SUM(S.score) AS total_points
FROM Utilisateur U
INNER JOIN Est_assigne EA ON U.ref_utilisateur = EA.ref_utilisateur
JOIN Tache_fini TF ON EA.ref_tache = TF.ref_tache
JOIN Score_categorie_tache S ON TF.nom_categorie = S.nom_categorie
WHERE S.termine = 'O'
GROUP BY U.nom_programme
ORDER BY total_points DESC;

-- 3. Pour chaque utilisateur, son login, son nom, son prénom, son adresse, son nombre de tâches total (périodique et non-périodique) et son nombre de tâches périodiques total.
SELECT U.login, U.nom, U.prenom, U.adresse, 
       COUNT(DISTINCT TE.ref_tache) + COUNT(DISTINCT TF.ref_tache) AS nb_taches_total,
       COUNT(DISTINCT TE.ref_tache) AS nb_taches_periodiques
FROM Utilisateur U
LEFT JOIN Est_assigne EA ON U.ref_utilisateur = EA.ref_utilisateur
LEFT JOIN Tache_en_cours TE ON EA.ref_tache = TE.ref_tache
LEFT JOIN Tache_fini TF ON EA.ref_tache = TF.ref_tache
GROUP BY U.login, U.nom, U.prenom, U.adresse;

-- 4. Pour chaque tâche, le nombre de tâches qui doivent finir avant qu'elle ne soit exécutée.
SELECT T.ref_tache, COUNT(DISTINCT DD.ref_tache_1) AS nombre_dependances
FROM Tache T
LEFT JOIN Depend_de DD ON T.ref_tache = DD.ref_tache_2
WHERE
  t.statut <> 'Terminée'
GROUP BY T.ref_tache;

-- 5. Les 10 utilisateurs ayant gagné le plus de points sur leur score au cours de la semaine courante.
SELECT U.ref_utilisateur, U.login, U.nom, U.prenom, SUM(SC.score) AS total_points_gagnes
FROM Utilisateur U
JOIN Est_assigne EA ON U.ref_utilisateur = EA.ref_utilisateur
JOIN Tache_fini TF ON EA.ref_tache = TF.ref_tache
JOIN Score_categorie_tache SC ON TF.nom_categorie = SC.nom_categorie
WHERE TF.date_realisation >= TRUNC(SYSDATE, 'IW') -- Début de la semaine courante
AND TF.date_realisation < TRUNC(SYSDATE, 'IW') + 7 -- Fin de la semaine courante
GROUP BY U.ref_utilisateur, U.login, U.nom, U.prenom
ORDER BY SUM(SC.score) DESC
LIMIT 10;
-- FETCH FIRST 10 ROWS ONLY;