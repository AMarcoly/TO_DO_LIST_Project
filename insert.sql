INSERT INTO Projet (ref_projet, nom_projet) VALUES (1, 'Projet 1');

INSERT INTO Projet (ref_projet, nom_projet) VALUES (2, 'Projet 2');

INSERT INTO Projet (ref_projet, nom_projet) VALUES (3, 'Projet 3');

-- Pour la table Utilisateur
INSERT INTO
    Utilisateur (
        ref_utilisateur,
        login,
        mot_de_passe,
        score,
        nom,
        prenom,
        adresse,
        pays,
        date_de_naissance,
        date_d_inscription,
        nom_programme
    )
VALUES (
        1,
        'johndoee99',
        'motdepasse1',
        100,
        'Doe',
        'John',
        '123 Rue de la Fontaine',
        'France',
        TO_DATE('1990-05-15', 'YYYY-MM-DD'),
        SYSDATE,
        'Programme1'
    );

INSERT INTO
    Utilisateur (
        ref_utilisateur,
        login,
        mot_de_passe,
        score,
        nom,
        prenom,
        adresse,
        pays,
        date_de_naissance,
        date_d_inscription,
        nom_programme
    )
VALUES (
        2,
        'alicesmi99',
        'password2',
        80,
        'Smith',
        'Alice',
        '456 Main Street',
        'USA',
        TO_DATE('1992-03-15', 'YYYY-MM-DD'),
        TO_DATE('2021-11-15', 'YYYY-MM-DD'),
        'Programme 2'
    );

INSERT INTO
    Utilisateur (
        ref_utilisateur,
        login,
        mot_de_passe,
        score,
        nom,
        prenom,
        adresse,
        pays,
        date_de_naissance,
        date_d_inscription,
        nom_programme
    )
VALUES (
        3,
        'rbobbobb99',
        'pass_word3',
        65,
        'Roberts',
        'Bob',
        '789 Elm Avenue',
        'Canada',
        TO_DATE('1988-07-20', 'YYYY-MM-DD'),
        TO_DATE('2023-05-20', 'YYYY-MM-DD'),
        'Programme 3'
    );

INSERT INTO
    Utilisateur (
        ref_utilisateur,
        login,
        mot_de_passe,
        score,
        nom,
        prenom,
        adresse,
        pays,
        date_de_naissance,
        date_d_inscription,
        nom_programme
    )
VALUES (
        4,
        'jsmithsm33',
        'password2',
        90,
        'Jane',
        'Smith',
        '456 Elm St',
        'USA',
        TO_DATE('1985-08-15', 'YYYY-MM-DD'),
        SYSDATE,
        'Programme 2'
    );

INSERT INTO
    Utilisateur (
        ref_utilisateur,
        login,
        mot_de_passe,
        score,
        nom,
        prenom,
        adresse,
        pays,
        date_de_naissance,
        date_d_inscription,
        nom_programme
    )
VALUES (
        5,
        'edavisis22',
        'password5',
        95,
        'Emma',
        'Davis',
        '202 Cedar St',
        'Germany',
        TO_DATE('1998-03-25', 'YYYY-MM-DD'),
        SYSDATE,
        'Programme 2'
    );

COMMIT;
-- Insertion des taches.

INSERT INTO Tache (ref_tache) VALUES (1001);

INSERT INTO Tache (ref_tache) VALUES (1002);

INSERT INTO Tache (ref_tache) VALUES (1003);

INSERT INTO Tache (ref_tache) VALUES (1004);

INSERT INTO Tache (ref_tache) VALUES (1005);

INSERT INTO Tache (ref_tache) VALUES (1006);

INSERT INTO Tache (ref_tache) VALUES (1007);

INSERT INTO Tache (ref_tache) VALUES (1008);

INSERT INTO Tache (ref_tache) VALUES (1009);

INSERT INTO Tache (ref_tache) VALUES (1010);

INSERT INTO Tache (ref_tache) VALUES (1011);

INSERT INTO Tache (ref_tache) VALUES (1012);

INSERT INTO Tache (ref_tache) VALUES (1013);

INSERT INTO Tache (ref_tache) VALUES (1014);

INSERT INTO Tache (ref_tache) VALUES (1015);

INSERT INTO Tache (ref_tache) VALUES (1016);

COMMIT;

-- Pour la table Periodicite (en jours à secondes)
INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        1,
        TO_TIMESTAMP(
            '2023-01-01 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2023-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '37' DAY
    );

INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        2,
        TO_TIMESTAMP(
            '2023-07-01 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2023-12-31 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '15' DAY
    );

INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        3,
        TO_TIMESTAMP(
            '2024-01-01 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '3' DAY
    );

INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        4,
        TO_TIMESTAMP(
            '2024-01-02 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '3' DAY
    );

INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        5,
        TO_TIMESTAMP(
            '2024-01-03 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '3' DAY
    );
INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        6,
        TO_TIMESTAMP(
            '2024-01-04 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '3' DAY
    );
INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        7,
        TO_TIMESTAMP(
            '2024-01-05 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '3' DAY
    );
INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        8,
        TO_TIMESTAMP(
            '2024-01-06 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '1' DAY
    );
INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        9,
        TO_TIMESTAMP(
            '2024-01-07 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '4' DAY
    );
INSERT INTO
    Periodicite (
        ref_periodicite,
        date_debut,
        date_fin,
        periode
    )
VALUES (
        10,
        TO_TIMESTAMP(
            '2024-01-08 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        TO_TIMESTAMP(
            '2024-06-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        INTERVAL '2' DAY
    );
COMMIT;
-- Pour la table Score_categorie_tache
INSERT INTO
    Score_categorie_tache (
        ref_score_categorie_tache,
        termine,
        score,
        nom_categorie
    )
VALUES ('Cat1', 'O', 85, 'Catégorie A');

INSERT INTO
    Score_categorie_tache (
        ref_score_categorie_tache,
        termine,
        score,
        nom_categorie
    )
VALUES ('Cat2', 'O', 90, 'Catégorie B');

INSERT INTO
    Score_categorie_tache (
        ref_score_categorie_tache,
        termine,
        score,
        nom_categorie
    )
VALUES ('Cat3', 'O', 70, 'Catégorie C');
COMMIT;
-- Pour la table comporte
INSERT INTO
    Comporte (
        nom_programme,
        ref_score_categorie_tache
    )
VALUES ('Programme 1', 'Cat1');

INSERT INTO
    Comporte (
        nom_programme,
        ref_score_categorie_tache
    )
VALUES ('Programme 2', 'Cat2');

INSERT INTO
    Comporte (
        nom_programme,
        ref_score_categorie_tache
    )
VALUES ('Programme 3', 'Cat3');
COMMIT;
-- Pour la table Liste_Tache
INSERT INTO
    Liste_tache (
        ref_liste,
        nom_categorie,
        ref_utilisateur
    )
VALUES (101, 'Catégorie A', 1);

INSERT INTO
    Liste_tache (
        ref_liste,
        nom_categorie,
        ref_utilisateur
    )
VALUES (102, 'Catégorie B', 2);

INSERT INTO
    Liste_tache (
        ref_liste,
        nom_categorie,
        ref_utilisateur
    )
VALUES (103, 'Catégorie C', 3);
COMMIT;
-- Pour la table Contient
INSERT INTO
    Contient (nom_projet, ref_liste)
VALUES ('Projet 1', 101);

INSERT INTO
    Contient (nom_projet, ref_liste)
VALUES ('Projet 2', 102);

INSERT INTO
    Contient (nom_projet, ref_liste)
VALUES ('Projet 3', 103);
COMMIT;
-- Pour la table Est_assigne
INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (1, 1001);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (2, 1002);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (3, 1003);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (4, 1004);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (5, 1005);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (1, 1006);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (2, 1007);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (3, 1008);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (4, 1009);

INSERT INTO
    Est_assigne (ref_utilisateur, ref_tache)
VALUES (5, 1010);
COMMIT;
-- Pour la table Tache_en_cours
-- Insertion 1
INSERT INTO
    Tache_en_cours (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1001,
        'Tâche 1',
        'Description Tâche 1',
        2,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-12-31 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'En cours',
        'Catégorie A',
        1,
        1,
        NULL
    );

-- Insertion 2
INSERT INTO
    Tache_en_cours (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1002,
        'Tâche 2',
        'Description Tâche 2',
        1,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-12-31 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'En cours',
        'Catégorie B',
        2,
        2,
        NULL
    );

-- Insertion 3
INSERT INTO
    Tache_en_cours (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1003,
        'Tâche 3',
        'Description Tâche 3',
        3,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-12-31 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'En cours',
        'Catégorie C',
        3,
        3,
        NULL
    );

-- Insertion 4
INSERT INTO
    Tache_en_cours (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1004,
        'Tâche 4',
        'Description Tâche 4',
        2,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-12-31 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'En cours',
        'Catégorie A',
        4,
        4,
        NULL
    );

-- Insertion 5
INSERT INTO
    Tache_en_cours (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1005,
        'Tâche 5',
        'Description Tâche 5',
        1,
        'http://example.com',
        TO_TIMESTAMP(
            '2024-01-31 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'En cours',
        'Catégorie B',
        5,
        5,
        NULL
    );
COMMIT;
-- Pour la table Tache_fini
INSERT INTO
    Tache_fini (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1006,
        'Tâche 6',
        'Description Tâche 6',
        2,
        'http://example.com',
        TO_TIMESTAMP(
            '2024-11-15 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'Terminée',
        'Catégorie C',
        6,
        1,
        TO_TIMESTAMP(
            '2024-01-05 15:30:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    );

-- Insertion 2
INSERT INTO
    Tache_fini (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1007,
        'Tâche 7',
        'Description Tâche 7',
        1,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-11-20 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'Terminée',
        'Catégorie B',
        7,
        2,
        TO_TIMESTAMP(
            '2023-11-20 09:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    );

-- Insertion 3
INSERT INTO
    Tache_fini (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1008,
        'Tâche 8',
        'Description Tâche 8',
        3,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-11-25 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'Terminée',
        'Catégorie A',
        8,
        3,
        TO_TIMESTAMP(
            '2023-11-25 12:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    );

-- Insertion 4
INSERT INTO
    Tache_fini (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1009,
        'Tâche 9',
        'Description Tâche 9',
        2,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-11-30 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'Terminée',
        'Catégorie C',
        9,
        4,
        TO_TIMESTAMP(
            '2023-11-30 10:45:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    );

-- Insertion 5
INSERT INTO
    Tache_fini (
        ref_tache,
        intitule,
        description,
        priorite,
        url,
        date_d_echeance,
        statut,
        nom_categorie,
        ref_periodicite,
        ref_utilisateur,
        date_realisation
    )
VALUES (
        1010,
        'Tâche 10',
        'Description Tâche 10',
        1,
        'http://example.com',
        TO_TIMESTAMP(
            '2023-12-05 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        ),
        'Terminée',
        'Catégorie B',
        10,
        5,
        TO_TIMESTAMP(
            '2023-12-05 17:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    );
COMMIT;
-- Pour la table Travaille.
-- Insertion 1
INSERT INTO Travaille (ref_projet, ref_utilisateur) VALUES (1, 1);

-- Insertion 2
INSERT INTO Travaille (ref_projet, ref_utilisateur) VALUES (2, 2);

-- Insertion 3
INSERT INTO Travaille (ref_projet, ref_utilisateur) VALUES (3, 3);
COMMIT;
-- Pour la table Depend_de
INSERT INTO Depend_de (ref_tache_1, ref_tache_2) VALUES (1001, 1002);

INSERT INTO Depend_de (ref_tache_1, ref_tache_2) VALUES (1003, 1004);

INSERT INTO Depend_de (ref_tache_1, ref_tache_2) VALUES (1005, 1006);
COMMIT;
-- Pour la table Tache_appartenant_a_liste
INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (101, 1001);

INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (101, 1011);

INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (101, 1012);

INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (101, 1013);

INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (101, 1014);

INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (101, 1015);

-- Insertion 2
INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (102, 1002);

-- Insertion 3
INSERT INTO
    Tache_appartenant_a_liste (ref_liste, ref_tache)
VALUES (103, 1003);
COMMIT;