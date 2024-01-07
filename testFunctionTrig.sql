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
    
    DBMS_OUTPUT.PUT_LINE('------------------Test Procedure ArchivesTaches -------------------');
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

END;