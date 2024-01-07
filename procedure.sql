-- Les procédures et les fonctions

-- 1.
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
            IF proportion >= 0.5 THEN
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

-- 2.
--   On supposera que la procédure est exécutée chaque semaine (le lundi, à 8h). 
--  Définir une procédure qui archive toutes les tâches passées.
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


-- 3. 
-- Ecrire le code PL/SQL permettant de générer des suggestions pour un utilisateur, c’est
-- dire N tâches qu’il pourrait ajouter à sa liste de tâche. Les tâches suggérées seront les N
-- tâches apparaissant le plus grand nombre de fois dans les tâches des utilisateurs
-- similaires. Les utilisateurs similaires sont les utilisateurs ayant au moins X tâches
-- similaires avec l’utilisateur pour lequel effectuer les suggestions. Des tâches similaires
-- sont des tâches ayant au moins Y mots communs (dans les mots communs, on ne
-- compte pas les mots vides/stop words comme les articles ou les verbes peu significatifs
-- type faire ou avoir)

-- Fonction pour supprimer les mots vides d'une chaîne de caractères.
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

create or replace PROCEDURE SuggestionsTaches(p_utilisateur_actuel INT) IS
    v_utilisateur_actuel INT := p_utilisateur_actuel; -- ID de l'utilisateur actuel
    v_X INT := 1; -- Nombre minimum de tâches similaires pour considérer un utilisateur comme similaire
    v_Y INT := 1; -- Nombre minimum de mots en commun pour considérer des tâches comme similaires
    v_N INT := 2; -- Nombre de tâches suggérées
    v_taches_trouvees BOOLEAN := FALSE; -- Variable pour suivre si des tâches ont été trouvées ou non

BEGIN
    -- Étape 1 : Identifiez les utilisateurs similaires en utilisant la fonction TrouverUtilisateursSimilaires
    FOR suggested_task IN (
        SELECT DISTINCT T1.ref_tache -- Adapter cette partie à votre scénario spécifique pour sélectionner les tâches suggérées
        FROM Tache_fini T1
        JOIN Tache_fini T2 ON T1.ref_utilisateur <> T2.ref_utilisateur -- Comparaison entre différentes tâches
            AND T1.ref_utilisateur = v_utilisateur_actuel
            AND T1.ref_tache <> T2.ref_tache
            AND REGEXP_COUNT(remove_stop_words(T1.description), '\S+') - 
                REGEXP_COUNT(remove_stop_words(T1.description) || ' ' || remove_stop_words(T2.description), '\S+') >= v_Y
        JOIN Utilisateur U1 ON U1.ref_utilisateur = T1.ref_utilisateur
        JOIN Utilisateur U2 ON U2.ref_utilisateur = T2.ref_utilisateur
        GROUP BY T1.ref_tache
        HAVING COUNT(*) >= v_X
        ORDER BY COUNT(*) DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Tâche suggérée : ' || suggested_task.ref_tache); -- Affichage de la tâche suggérée
        v_taches_trouvees := TRUE; -- Marquer qu'au moins une tâche a été trouvée
    END LOOP;

    -- Si aucune tâche n'a été trouvée, afficher un message approprié
    IF NOT v_taches_trouvees THEN
        DBMS_OUTPUT.PUT_LINE('Aucune tâche à suggérer trouvée');
    END IF;
END;

---------------------------------------------------------------------------------------------------------------


-- TRIGGER
-- 1.
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
END;    



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
END;    

-- 2.
-- Pour chaque tâche périodique avec une date de fin ajoutée ou modifiée, définir les tâches
-- associée (tâche avec une date précise, par exemple une tache périodique réalisée tous les
-- jours à 10h, dont la fin est prévue dans une semaine provoquera la définition de 7
-- tâches, prévue sur 7 jours, à 8h).

-- Pour chaque tâche périodique avec une date de fin ajoutée ou modifiée, définir les tâches associée
CREATE OR REPLACE TRIGGER creer_taches_associees
AFTER INSERT OR UPDATE OF date_fin ON Periodicite
FOR EACH ROW
DECLARE
    v_ref_periodicite Periodicite.ref_periodicite%TYPE;
    v_tache_details Tache_en_cours%ROWTYPE; -- Modifier avec le nom de la table appropriée
    v_interval INTERVAL DAY TO SECOND;
    v_nb_jours NUMBER;
    v_current_ref_periodicite Periodicite.ref_periodicite%TYPE;
    v_current_date TIMESTAMP;

BEGIN
    IF :NEW.date_fin IS NOT NULL THEN
        IF INSERTING THEN 
            v_current_ref_periodicite := :NEW.ref_periodicite;
        ELSIF UPDATING THEN
            v_current_ref_periodicite := :OLD.ref_periodicite;
        END IF;

        -- Récupérer les détails de la tâche périodique
        SELECT * INTO v_tache_details
        FROM Tache_en_cours  -- Modifier avec le nom de la table appropriée
        WHERE ref_periodicite = v_current_ref_periodicite;

        -- Initialiser la date courante à la date de début
        v_current_date := :OLD.date_debut;

        -- Insérer les tâches associées pour chaque jour entre la date de début et de fin
        WHILE v_current_date <= :NEW.date_fin LOOP
        
            -- Ajouter une tâche associée avec une date précise
            INSERT INTO
        Tache_associee (
            ref_tache,
            intitule,
            description,
            priorite,
            url,
            date_d_echeance,
            statut,
            nom_categorie,
            ref_utilisateur,
            date_realisation
        )
        VALUES (
            v_tache_details.ref_tache,
            v_tache_details.intitule,
            v_tache_details.description,
            v_tache_details.priorite,
            v_tache_details.url,
            v_current_date,
            'En cours',
            v_tache_details.nom_categorie,
            v_tache_details.ref_utilisateur,
            NULL
        );
            -- Incrémenter la date courante d'un jour
            v_current_date := v_current_date + :OLD.periode;
        END LOOP;
    END IF;
END;



