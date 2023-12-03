-- Pour optimiser la deuxième rêquete
CREATE INDEX idx_tache_fini_date_realisation ON Tache_fini(date_realisation);
CREATE INDEX idx_score_cat_tache_nom_cat ON Score_categorie_tache(nom_categorie);
