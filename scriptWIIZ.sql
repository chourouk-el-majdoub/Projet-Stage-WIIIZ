CREATE SCHEMA Wizz ;

CREATE TABLE Wizz.Utilisation (
  UT_ID INT NOT NULL,
  UT_Annee INT(4) NOT NULL DEFAULT 2020,
  UT_Date_debut DATETIME NOT NULL,
  UT_Jour_debut INT NOT NULL,
  UT_Mois_debut INT NOT NULL,
  UT_Date_fin DATETIME NOT NULL,
  UT_Jour_fin INT NOT NULL,
  UT_Mois_fin INT NOT NULL,
  UT_Duree INT(6) NOT NULL,
  UT_Conso_horaire INT(7) NOT NULL,
  UT_Conso_totale INT(7) NOT NULL,
  PRIMARY KEY (UT_ID));

CREATE TABLE Wizz.Client (
  CL_ID VARCHAR(45) NOT NULL,
  CL_nom VARCHAR(45) NULL,
  CL_pass VARCHAR(45) NULL,
  CL_utilisation_id INT(11) NOT NULL,
  PRIMARY KEY (CL_ID),
  INDEX fk_Client_1_idx (CL_utilisation_id ASC),
  CONSTRAINT fk_Client_1
    FOREIGN KEY (CL_utilisation_id)
    REFERENCES Wizz.Utilisation (UT_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE Wizz.Borne (
  BO_ID INT NOT NULL,
  BO_nom VARCHAR(80) NOT NULL,
  BO_parc VARCHAR(20) NOT NULL,
  BO_station VARCHAR(80) NOT NULL,
  BO_prise VARCHAR(3) NOT NULL,
  BO_nbr_prise INT(3) NOT NULL,
  BO_fabricant VARCHAR(45) NOT NULL,
  PRIMARY KEY (BO_ID));

CREATE TABLE Wizz.Enregistrement (
  EN_borne_id INT(11) NOT NULL,
  EN_utilisation_id INT(11) NOT NULL,
  PRIMARY KEY (EN_borne_id, EN_utilisation_id),
  INDEX fk_Enregistrement_2_idx (EN_utilisation_id ASC),
  CONSTRAINT fk_Enregistrement_1
    FOREIGN KEY (EN_borne_id)
    REFERENCES Wizz.Borne (BO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Enregistrement_2
    FOREIGN KEY (EN_utilisation_id)
    REFERENCES Wizz.Utilisation (UT_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

       