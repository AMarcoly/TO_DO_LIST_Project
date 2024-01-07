SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('------------------Test Procedure calculer_points_semaine-------------------');
    DBMS_OUTPUT.PUT_LINE('Anciens scores');

    FOR utilisateur_rec IN (SELECT ref_utilisateur, score FROM Utilisateur) LOOP
        DBMS_OUTPUT.PUT_LINE('Utilisateur ' || utilisateur_rec.ref_utilisateur || ' - Score : ' || utilisateur_rec.score);
    END LOOP;

    calculer_points_semaine();
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Nouveaus scores');

    FOR utilisateur_rec IN (SELECT ref_utilisateur, score FROM Utilisateur) LOOP
        DBMS_OUTPUT.PUT_LINE('Utilisateur ' || utilisateur_rec.ref_utilisateur || ' - Score : ' || utilisateur_rec.score);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(13) || '--------------Fin Test Procdure calculer_points_semaine --------------');

    DBMS_OUTPUT.PUT_LINE(chr(13) || '------------------Test Procedure ArchivesTaches -------------------');
    DBMS_OUTPUT.PUT_LINE('Avant que les taches terminées ne soient archivées');

    FOR v_tache IN (SELECT * FROM Tache_en_cours) LOOP
        DBMS_OUTPUT.PUT_LINE('Tâche en cours : ' || v_tache.ref_tache || ' Date d''échéance : ' || v_tache.date_d_echeance); -- Afficher les détails de la tâche en cours par exemple
    END LOOP;
    
    ArchiverTaches();
    DBMS_OUTPUT.PUT_LINE('--------------------------------');

    DBMS_OUTPUT.PUT_LINE('Après que les taches terminées sont archivées');

    FOR v_tache IN (SELECT * FROM Tache_en_cours) LOOP
        DBMS_OUTPUT.PUT_LINE('Tâche en cours : ' || v_tache.ref_tache || ' Date d''échéance : '|| v_tache.date_d_echeance); -- Afficher les détails de la tâche en cours par exemple
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(chr(13) || '------------------Fin Test Procdure ArchiverTaches -------------------');

    DBMS_OUTPUT.PUT_LINE(chr(13) || '------------------Test Procdure SuggestionTaches -------------------');
    SuggestionsTaches(2);
    DBMS_OUTPUT.PUT_LINE('------------------Fin Test Procdure SuggestionTaches -------------------');

    DBMS_OUTPUT.PUT_LINE(chr(13) || '------------------Test Trigger creer_taches_associee -------------------');
    DBMS_OUTPUT.PUT_LINE(chr(13) || 'Avant de mettre à jour la date_fin de periodicite');
    FOR v_tache_ass IN (SELECT * FROM Tache_associee) LOOP

        DBMS_OUTPUT.PUT_LINE('Ref Tache : ' || v_tache_ass.ref_tache);
        DBMS_OUTPUT.PUT_LINE('Intitule : ' || v_tache_ass.intitule);
        DBMS_OUTPUT.PUT_LINE('Description : ' || v_tache_ass.description);
        DBMS_OUTPUT.PUT_LINE('Priorite : ' || v_tache_ass.priorite);
        DBMS_OUTPUT.PUT_LINE('URL : ' || v_tache_ass.url);
        DBMS_OUTPUT.PUT_LINE('Date d''échéance : ' || v_tache_ass.date_d_echeance);
        DBMS_OUTPUT.PUT_LINE('Statut : ' || v_tache_ass.statut);
        DBMS_OUTPUT.PUT_LINE('Nom catégorie : ' || v_tache_ass.nom_categorie);
        DBMS_OUTPUT.PUT_LINE('Ref Utilisateur : ' || v_tache_ass.ref_utilisateur);
        DBMS_OUTPUT.PUT_LINE('Date réalisation : ' || v_tache_ass.date_realisation);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
        
        UPDATE periodicite
        SET date_fin = TO_TIMESTAMP(
            '2024-06-29 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        )
        WHERE ref_periodicite = 5;
        
        DBMS_OUTPUT.PUT_LINE(chr(13) || 'Après avoir mis-à-jour la date_fin de periodicite de la 3eme periodicite');
        
        FOR v_tache_ass IN (SELECT * FROM Tache_associee) LOOP

        DBMS_OUTPUT.PUT_LINE('Ref Tache : ' || v_tache_ass.ref_tache);
        DBMS_OUTPUT.PUT_LINE('Intitule : ' || v_tache_ass.intitule);
        DBMS_OUTPUT.PUT_LINE('Description : ' || v_tache_ass.description);
        DBMS_OUTPUT.PUT_LINE('Priorite : ' || v_tache_ass.priorite);
        DBMS_OUTPUT.PUT_LINE('URL : ' || v_tache_ass.url);
        DBMS_OUTPUT.PUT_LINE('Date d''échéance : ' || v_tache_ass.date_d_echeance);
        DBMS_OUTPUT.PUT_LINE('Statut : ' || v_tache_ass.statut);
        DBMS_OUTPUT.PUT_LINE('Nom catégorie : ' || v_tache_ass.nom_categorie);
        DBMS_OUTPUT.PUT_LINE('Ref Utilisateur : ' || v_tache_ass.ref_utilisateur);
        DBMS_OUTPUT.PUT_LINE('Date réalisation : ' || v_tache_ass.date_realisation);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(chr(13) || '------------------Fin Test Trigger creer_taches_associee -------------------');
END;