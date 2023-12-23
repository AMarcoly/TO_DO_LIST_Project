-- Les procédures et les fonctions

-- Définir une fonction qui calcule le nombre de point gagné/perdu
-- (pour les utilisateurs ayant un programme de score, 
-- en fonction du nombre de tâche terminée/non terminée) 
-- au cours de la semaine en PL/SQL.

CREATE OR REPLACE PROCEDURE calculer_points_semaine IS
    utilisateur_rec Utilisateur%ROWTYPE;
    nombre_taches_termines INT;
    nombre_taches_non_termines INT;
    points_gagnes_perdus INT;
BEGIN
    -- Parcourir les utilisateurs ayant un programme de score
    FOR utilisateur_rec IN (SELECT * FROM Utilisateur WHERE nom_programme IS NOT NULL) LOOP
        -- Calculer le nombre de tâches terminées au cours de la semaine
        SELECT COUNT(*) INTO nombre_taches_termines
        FROM Tache_fini
        WHERE ref_utilisateur = utilisateur_rec.ref_utilisateur
            AND date_realisation >= SYSDATE - 7;

        -- Calculer le nombre de tâches non terminées au cours de la semaine
        SELECT COUNT(*) INTO nombre_taches_non_termines
        FROM Tache_en_cours
        WHERE ref_utilisateur = utilisateur_rec.ref_utilisateur
            AND date_d_echeance >= SYSDATE - 7
            AND statut != 'Terminé';

        -- Calculer les points gagnés ou perdus
        points_gagnes_perdus := nombre_taches_termines - nombre_taches_non_termines;

        -- Mettre à jour le score de l'utilisateur
        UPDATE Utilisateur
        SET score = score + points_gagnes_perdus
        WHERE ref_utilisateur = utilisateur_rec.ref_utilisateur;
    END LOOP;
END calculer_points_semaine;


--   On supposera que la procédure est exécutée chaque semaine (le lundi, à 8h). 
--  Définir une procédure qui archive toutes les tâches passées.


CREATE OR REPLACE PROCEDURE archiver_taches_passees
AS
BEGIN
  -- Définir la date de début de la semaine passée
  DECLARE date_debut DATE := TRUNC(SYSDATE - INTERVAL 7 DAY, 'IW');

  -- Définir la date de fin de la semaine passée
  DECLARE date_fin DATE := TRUNC(SYSDATE, 'IW');

  -- Créer une table temporaire pour stocker les tâches à archiver
  CREATE TABLE tmp_taches_a_archiver
    (
      ref_tache NUMBER,
      nom_categorie VARCHAR2(255)
    );

  -- Insérer les tâches à archiver dans la table temporaire
  INSERT INTO tmp_taches_a_archiver
  (
    ref_tache,
    nom_categorie
  )
  SELECT
    T.ref_tache,
    T.nom_categorie
  FROM Tache T
  WHERE T.date_realisation < date_fin;

  -- Archiver les tâches
  FOR t IN (SELECT * FROM tmp_taches_a_archiver)
  LOOP
    -- Archiver la tâche
    INSERT INTO Tache_archivee
    (
      ref_tache,
      nom_categorie,
      date_realisation
    )
    VALUES
    (
      t.ref_tache,
      t.nom_categorie,
      t.date_realisation
    );

    -- Supprimer la tâche de la table `Tache`
    DELETE FROM Tache
    WHERE ref_tache = t.ref_tache;
  END LOOP;

  -- Supprimer la table temporaire
  DROP TABLE tmp_taches_a_archiver;
END archiver_taches_passees;

