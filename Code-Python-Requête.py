#!/usr/bin/env python
# coding: utf-8

# # Requête permettant de retourner les femmes ayant un poids inférieur à 80 kg après 5 jours suivant une radiothérapie - Python

# ## Importation des modules

# In[1]:


import pandas as pd
import time
import datetime


# In[2]:


start_time = time.time()


# ## Importation des données sous forme de dataframe - 1000

# In[3]:


# Importation table event
df_event = pd.read_csv('events_1000.csv')
# Visualisation
df_event.info()


# In[4]:


# Importation table period
df_period = pd.read_csv('periods_1000.csv')
# Visualisation
df_period


# In[5]:


# Importation table measure
df_measure = pd.read_csv('measures_1000.csv')
# On convertit la colonne 'Value' en numérique (nécessaire pour faire la demande <80)
df_measure['VALUE'] = pd.to_numeric(df_measure['VALUE'], errors='coerce')
# On convertit la colonne 'PATIENT' en str (nécessaire je pense pour faire le join)
df_measure['PATIENT'] = df_measure['PATIENT'].astype(str)
# Visualisation
df_measure


# In[6]:


# Importation table patient
df_patient = pd.read_csv('patients_1000.csv')
# On convertit la colonne 'Id' en str (nécessaire je pense pour faire le join)
df_patient['Id'] = df_patient['Id'].astype(str)
# Visualisation
df_patient


# ## Requête - pour les csv en 1000

# In[7]:


# On récupère les mesures de poids > 80kg
df_measure_req = df_measure.loc[((df_measure['DESCRIPTION'] =='Body Weight') & (df_measure['VALUE']>80))]
df_measure_req.info()
# On voit qu'on a 4664 lignes encore

# On récupère les id patient dans une Series
patient = df_measure_req.PATIENT
#print(patient)


# In[8]:


# Maintenant on va choisir seulement les femmes, il s'agit donc de la table patient
# Pour la méthode concat, il faut un dataframe de base qui contient déjà les bonnes colonnes donc j'ai pris le patient en enlevant toutes les lignes
df_patient_req = df_patient.copy()
df_patient_req.drop(df_patient_req[(df_patient_req['GENDER'] == 'M') | (df_patient_req['GENDER'] == 'F') ].index, inplace=True)
# print(df_patient_req)
# C'est bien vide

# Maintenant pour chaque id patient de notre premier constat, on va voir si c'est une femme et on l'ajoute si besoin
for id_patient in patient:
    # print(id_patient), on a bien un id patient à chaque fois
    df_patient_1 = df_patient.loc[((df_patient['GENDER'] =='F') & (df_patient['Id'] == str(id_patient)))]
    # print(df_patient_1)
    frame = [df_patient_req, df_patient_1]
    df_patient_req = pd.concat(frame, sort = False)
    
# En cas de doublons
df_patient_req.drop_duplicates
# Visualisation
df_patient_req
# On voit qu'on a 1136 lignes encore


# In[9]:


# la condition temporel, 5 jours suivant une 'combined chemotherapy and radiation therapy (procedure)'

# Transformer les dates en durée pour df_period
df_period.dropna(subset = ['STOP'], inplace = True)
myDate = df_period.STOP
for date in myDate:
    #print(date)
    if isinstance(date, str):
        new_date = datetime.datetime.strptime(date,'%Y-%m-%d')
        year, month, day = new_date.year, new_date.month, new_date.day
        x = date
        df_period.replace(date, datetime.datetime(int(year),int(month),int(day),0,0,0) - datetime.datetime(1900,1,1,0,0,0), inplace = True)
        #df_period['STOP'] = df_period['STOP'].apply(lambda x: datetime.datetime(int(year),int(month),int(day),0,0,0) - datetime.datetime(1900,1,1,0,0,0) if x=date else x)

df_period


# In[10]:


# Transformer les dates en durée pour df_measure_req

df_measure_req.dropna(subset = ['DATE'], inplace = True)
myDate = df_measure_req.DATE
for date in myDate:
    #print(date)
    if isinstance(date, str):
        new_date = datetime.datetime.strptime(date,'%Y-%m-%dT%H:%M:%SZ')
        year, month, day = new_date.year, new_date.month, new_date.day
        x = date
        df_measure_req.replace(date, datetime.datetime(int(year),int(month),int(day),0,0,0) - datetime.datetime(1900,1,1,0,0,0), inplace = True)
        #df_period['STOP'] = df_period['STOP'].apply(lambda x: datetime.datetime(int(year),int(month),int(day),0,0,0) - datetime.datetime(1900,1,1,0,0,0) if x=date else x)

df_measure_req


# In[11]:


# Pour la méthode concat, il faut un dataframe de base qui contient déjà les bonnes colonnes donc j'ai pris la table période en enlevant toutes les lignes
df_period_final = df_period.copy()
df_period_final.drop(df_period_final[(df_period_final.index < 2959)].index, inplace=True)
# print(df_period_final)
# C'est bien vide

patient_2 = df_patient_req.Id
td = datetime.timedelta(days = 5)
i=0
# Maintenant pour chaque id patient de notre second constat, on va voir si la condition temporel, 5 jours suivant une 'combined chemotherapy and radiation therapy (procedure)' est respectée
for id_patient in patient_2:
    # print(id_patient), on a bien un id patient à chaque fois
    date_measure = df_measure_req.iloc[i]['DATE']
    #print(date_measure)
    df_period_1 = df_period.loc[((df_period['DESCRIPTION'] =='Self-care interventions (procedure)') & (df_period['PATIENT'] == str(id_patient)) & (df_period['STOP'] > date_measure) & (df_period['STOP'] < (date_measure+td)))]
    # print(df_patient_1)
    frame = [df_period_final, df_period_1]
    df_period_final= pd.concat(frame, sort = False)
    i +=1

df_period_final                               


# In[12]:


# On ressort la table des patients qui correspondent à la requête

# Pour la méthode concat, il faut un dataframe de base qui contient déjà les bonnes colonnes donc j'ai pris le patient en enlevant toutes les lignes
df_patient_req_final = df_patient.copy()
df_patient_req_final.drop(df_patient_req_final[(df_patient_req_final['GENDER'] == 'M') | (df_patient_req_final['GENDER'] == 'F') ].index, inplace=True)
# print(df_patient_req)
# C'est bien vide
patient_3 = df_period_final.PATIENT

for id_patient in patient_3:
    df_patient_1 = df_patient.loc[(df_patient['Id'] == str(id_patient))]
    # print(df_patient_1)
    frame = [df_patient_req_final, df_patient_1]
    df_patient_req_final= pd.concat(frame, sort = False)

df_patient_req_final 


# In[13]:


print("--- %s seconds ---" % (time.time() - start_time))


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




