-- Pour optimiser la deuxième rêquete
CREATE INDEX idx_tache_fini_date_realisation ON Tache_fini(date_realisation);
CREATE INDEX idx_score_cat_tache_nom_cat ON Score_categorie_tache(nom_categorie);

-- Pour optimiser la 3ème requête.
CREATE INDEX idx_tache_en_cours_utilisateur ON Tache_en_cours(ref_utilisateur);
CREATE INDEX idx_tache_periodicite_utilisateur ON Tache_en_cours(ref_periodicite);

-- Pour optimiser la 4ème requête.
CREATE INDEX idx_depend_de_ref_tache_1 ON Depend_de(ref_tache_1);
CREATE INDEX idx_depend_de_ref_tache_2 ON Depend_de(ref_tache_2);

-- Pour optimiser la 5ème requête.
-- CREATE INDEX idx_tache_fini_date_realisation ON Tache_fini(date_realisation);
-- CREATE INDEX idx_score_cat_tache_nom_cat ON Score_categorie_tache(nom_categorie);
CREATE INDEX idx_est_assigne_ref_utilisateur ON Est_assigne(ref_utilisateur);
