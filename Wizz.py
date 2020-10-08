#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct  7 10:33:26 2020

@author: simplon
"""


from jinja2 import Template
from jinja2 import Environment, FileSystemLoader
from sqlalchemy import create_engine
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

donnees = pd.read_excel("/home/simplon/Téléchargements/Wizz/Reporting_mensuel_WIIIZ_-_Aout_2020_-_Simplon.xlsx")
engine = create_engine("mysql+pymysql://hadrien:H01011997C@localhost/Wizz")
donnees = donnees.drop(columns = {'Site','Roaming','Année de fin'})
donnees = donnees.rename(columns = {'Année de début':'Annee'})
donnees.columns

borne_columns = ['Parc','Station','Borne','Type de prise','Prise','Fabricant']
borne_id = donnees.Borne
borne_id = borne_id.drop_duplicates()
borne_id = borne_id.reset_index(drop = True).reset_index().rename(columns={"index":"BO_ID"})
borne = donnees[borne_columns].drop_duplicates(subset=['Borne'])
borne = borne.merge(borne_id,on = 'Borne')
borne = borne.drop_duplicates().rename(columns={"Parc":"BO_parc","Station":"BO_station","Type de prise":"BO_prise"
                               ,"Prise":"BO_nbr_prise","Fabricant":"BO_fabricant","Borne":"BO_nom"})
borne.to_sql('Borne',con = engine,if_exists='append',index=False)
