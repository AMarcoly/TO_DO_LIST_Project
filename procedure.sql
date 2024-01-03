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
    proportion NUMBER;
BEGIN
    -- Parcourir les utilisateurs ayant un programme de score
    FOR utilisateur_rec IN (SELECT * FROM Utilisateur WHERE nom_programme IS NOT NULL) LOOP
        -- Initialiser les variables à zéro
        nombre_taches_termines := 0;
        nombre_taches_non_termines := 0;
        points_gagnes_perdus := 0;

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
        IF (nombre_taches_termines + nombre_taches_non_termines) > 0 THEN
            -- Calculer la proportion de tâches terminées sur le total des tâches 
            -- (terminées + non terminées)
            proportion := nombre_taches_termines / (nombre_taches_termines + nombre_taches_non_termines);

            -- Si plus de la moitié des tâches sont terminées, on attribue 
            -- des points à l'utilisateur.
            IF proportion > 0.5 THEN
                -- On attribue 10 points.
                points_gagnes_perdus := 10;
            ELSE
                -- Sinon, on retire des points à l'utilisateur.
                -- On retire 5 points.
                points_gagnes_perdus := -5;
            END IF;
        END IF;

        -- Mettre à jour le score de l'utilisateur
        UPDATE Utilisateur
        SET score = score + points_gagnes_perdus
        WHERE ref_utilisateur = utilisateur_rec.ref_utilisateur;
    END LOOP;
    COMMIT;
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

CREATE OR REPLACE PROCEDURE ArchiverTaches AS
BEGIN
    -- Utilisation de la date actuelle pour identifier les tâches passées
    FOR tache IN (SELECT * FROM Tache_en_cours WHERE date_d_echeance < SYSDATE) LOOP
        -- Insérer les tâches passées dans la table d'archivage
        INSERT INTO Tache_archivee (ref_tache, intitule, description, priorite, 
                                    url, date_d_echeance, statut, nom_categorie, 
                                    ref_periodicite, ref_utilisateur, date_realisation)
        VALUES (tache.ref_tache, tache.intitule, tache.description, tache.priorite, 
                tache.url, tache.date_d_echeance, tache.statut, tache.nom_categorie, 
                tache.ref_periodicite, tache.ref_utilisateur, tache.date_realisation);

        -- Supprimer les tâches archivées de la table Tache_en_cours
        DELETE FROM Tache_en_cours WHERE ref_tache = tache.ref_tache;
    END LOOP;
    COMMIT;
END;

CREATE OR REPLACE FUNCTION remove_stop_words(p_text IN VARCHAR2) RETURN VARCHAR2 IS
    stop_words VARCHAR2(1000) := ' le | la | les | de | des | du | en | et | à | un | une | ce | cet | cette | ces | mon | ma | mes | ton | ta | tes | avoir | faire';
    cleaned_text VARCHAR2(1000);
BEGIN
    cleaned_text := ' ' || p_text || ' ';

    -- Loop through each stop word and remove it from the text (case-insensitive)
    FOR stop_word IN (
        SELECT TRIM(REGEXP_SUBSTR(stop_words, '[^|]+', 1, LEVEL, 'i')) AS word
        FROM DUAL
        CONNECT BY LEVEL <= REGEXP_COUNT(stop_words, '[^|]+')
    ) LOOP
        cleaned_text := REGEXP_REPLACE(cleaned_text, ' ' || stop_word.word || ' ', ' ', 1, 0, 'i');
    END LOOP;

    -- Trim extra spaces and return cleaned text
    RETURN TRIM(cleaned_text);
END;

CREATE OR REPLACE FUNCTION SuggestionsTaches(p_utilisateur_actuel INT) RETURN sys_refcursor IS
    v_utilisateur_actuel INT := p_utilisateur_actuel; -- ID de l'utilisateur actuel
    v_X INT := 5; -- Nombre minimum de tâches similaires pour considérer un utilisateur comme similaire
    v_Y INT := 3; -- Nombre minimum de mots en commun pour considérer des tâches comme similaires
    v_N INT := 10; -- Nombre de tâches suggérées

    v_cursor sys_refcursor;

BEGIN
    -- Étape 1 : Identifiez les utilisateurs similaires
    -- Code pour récupérer les utilisateurs similaires (par ex., avec une requête SQL)
    -- Utilisation de v_utilisateur_actuel dans la requête pour trouver des utilisateurs similaires
    
    -- Étape 2 : Comptez les occurrences des tâches pour les utilisateurs similaires
    -- Code pour compter les occurrences des tâches parmi les utilisateurs similaires
    
    -- Étape 3 : Sélectionnez les N tâches les plus fréquentes
    -- Code pour sélectionner les N tâches les plus fréquentes parmi celles partagées par les utilisateurs similaires
    
    -- Affichage ou traitement des suggestions de tâches
    -- Code pour afficher ou utiliser les tâches suggérées
    
    -- Renvoyer un curseur avec les résultats des suggestions de tâches
    OPEN v_cursor FOR
        SELECT * FROM table_resultats; -- Remplacez par la table appropriée pour les suggestions

    RETURN v_cursor;
END;



-- TRIGGER
-- La valeur de score sera stockée dans une table et mis à jour chaque fois 
-- qu'une tâche est terminée ou archivée.

-- Le score de l'utilisateur sera mia à jour à chaque fois qu'une tâche se termine.
CREATE OR REPLACE TRIGGER maj_score_apres_tache_fini
AFTER INSERT OR UPDATE OF statut ON Tache_fini
FOR EACH ROW
DECLARE
    v_score INT;
    v_nombre_taches_termines INT;
    v_nombre_taches_non_termines INT;
    v_programme_score INT;
BEGIN
   -- Vérifier si l'utilisateur a un programme de score
    SELECT COUNT(*)
    INTO v_programme_score
    FROM Utilisateur
    WHERE ref_utilisateur = :NEW.ref_utilisateur
      AND nom_programme IS NOT NULL;

    -- Si l'utilisateur a un programme de score    
    IF v_programme_score > 0 THEN
        -- Initialiser les variables à zéro
        v_nombre_taches_termines := 0;
        v_nombre_taches_non_termines := 0;

        -- Calculer le nombre de tâches terminées pour l'utilisateur concerné
        SELECT COUNT(*) INTO v_nombre_taches_termines
        FROM Tache_fini
        WHERE ref_utilisateur = :NEW.ref_utilisateur
            AND date_realisation >= SYSDATE - 7;

        -- Calculer le nombre de tâches non terminées pour l'utilisateur concerné
        SELECT COUNT(*) INTO v_nombre_taches_non_termines
        FROM Tache_en_cours
        WHERE ref_utilisateur = :NEW.ref_utilisateur
            AND date_d_echeance >= SYSDATE - 7
            AND statut != 'Terminé';

        -- Calculer le score pour la tâche terminée ou archivée
        IF (v_nombre_taches_termines + v_nombre_taches_non_termines) > 0 THEN
            IF (v_nombre_taches_termines / (v_nombre_taches_termines + v_nombre_taches_non_termines)) > 0.5 THEN
                -- Si plus de la moitié des tâches sont terminées, on attribue 10 points.
                v_score := 10;
            ELSE
                -- Sinon, on retire 5 points.
                v_score := -5;
            END IF;
        ELSE
            -- Si aucune tâche n'a été effectuée au cours de la semaine, le score reste inchangé.
            v_score := 0;
        END IF;

        -- Stocker ou mettre à jour le score dans une table dédiée (score de la table Utilisateur)
        UPDATE Utilisateur
        SET score = score + v_score
        WHERE ref_utilisateur = :NEW.ref_utilisateur;
    END IF;

    COMMIT;
END;    
/


-- Le score de l'utilisateur sera mis à jour à chaque fois qu'une tâche est archivée.
CREATE OR REPLACE TRIGGER maj_score_apres_tache_archivee
AFTER INSERT OR UPDATE OF statut ON Tache_archivee
FOR EACH ROW
DECLARE
    v_score INT;
    v_nombre_taches_termines INT;
    v_nombre_taches_non_termines INT;
    v_programme_score INT;
BEGIN
   -- Vérifier si l'utilisateur a un programme de score
    SELECT COUNT(*)
    INTO v_programme_score
    FROM Utilisateur
    WHERE ref_utilisateur = :NEW.ref_utilisateur
      AND nom_programme IS NOT NULL;

    -- Si l'utilisateur a un programme de score    
    IF v_programme_score > 0 THEN
        -- Initialiser les variables à zéro
        v_nombre_taches_termines := 0;
        v_nombre_taches_non_termines := 0;

        -- Calculer le nombre de tâches terminées pour l'utilisateur concerné
        SELECT COUNT(*) INTO v_nombre_taches_termines
        FROM Tache_fini
        WHERE ref_utilisateur = :NEW.ref_utilisateur
            AND date_realisation >= SYSDATE - 7;

        -- Calculer le nombre de tâches non terminées pour l'utilisateur concerné
        SELECT COUNT(*) INTO v_nombre_taches_non_termines
        FROM Tache_en_cours
        WHERE ref_utilisateur = :NEW.ref_utilisateur
            AND date_d_echeance >= SYSDATE - 7
            AND statut != 'Terminé';

        -- Calculer le score pour la tâche terminée ou archivée
        IF (v_nombre_taches_termines + v_nombre_taches_non_termines) > 0 THEN
            IF (v_nombre_taches_termines / (v_nombre_taches_termines + v_nombre_taches_non_termines)) > 0.5 THEN
                -- Si plus de la moitié des tâches sont terminées, on attribue 10 points.
                v_score := 10;
            ELSE
                -- Sinon, on retire 5 points.
                v_score := -5;
            END IF;
        ELSE
            -- Si aucune tâche n'a été effectuée au cours de la semaine, le score reste inchangé.
            v_score := 0;
        END IF;

        -- Stocker ou mettre à jour le score dans une table dédiée (score de la table Utilisateur)
        UPDATE Utilisateur
        SET score = score + v_score
        WHERE ref_utilisateur = :NEW.ref_utilisateur;
    END IF;

    COMMIT;
END;    
/
