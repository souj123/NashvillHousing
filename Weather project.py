#!/usr/bin/env python
# coding: utf-8

# In[8]:


import pandas as pd


# In[9]:


df = pd.read_csv(r'C:\Users\soujanya\Downloads\1. Weather Data.csv')


# In[11]:


df


# In[9]:


df = pd.read_csv(r'C:\Users\soujanya\Downloads\1. Weather Data.csv')


# In[6]:


df.head()


# In[12]:


df.shape


# In[9]:


df.index


# In[10]:


df.columns


# In[12]:


df.dtypes


# In[16]:


df['Weather'].unique() #shows unique values


# In[17]:


df.nunique() #shows each columns unique values


# In[18]:


df.count()#no null values


# In[67]:


df['Weather'].value_counts() #only for single column. for ex Mainly clear is present 2106 times


# In[24]:


df.info() #provides basic info about our data


# In[29]:


df.nunique()


# In[50]:


#Finding all the unique 'Wind Speed' values in the data.
df['Wind Speed_km/h'].nunique()


# In[13]:


#Finding the number of times when the 'Weather is exactly Clear'.
#df[df.Weather == 'clear']
df.groupby("Weather").get_group("Clear")


# In[57]:


df


# In[15]:


#Finding the number of times when the 'Wind Speed was exactly 4 km/h'.
df.groupby("Wind Speed_km/h").get_group(4)


# In[17]:


#Finding out all the Null Values in the data.
df.isnull().sum()
#df.notnull().sum()


# In[22]:


#Renaming the column name 'Weather' of the dataframe to 'Weather Condition'.
df.rename(columns={'Weather' : 'Weather Condition'})#inplace=true, if you want to rename the column permanently


# In[24]:


#Finding the mean of 'Visibility' column
df.Visibility_km.mean()


# In[25]:


#Finding the Standard Deviation of 'Pressure'  in this data
df.Press_kPa.std()


# In[31]:


#Finding the Variance of 'Relative Humidity' in this data 
df['Rel Hum_%'].var() #have used[''] because there is gap in the column name 


# In[45]:


#Finding all instances when 'Snow' was recorded.
df[df['Weather'].str.contains('Snow')].head(50)


# In[49]:


#Finding all instances when 'Wind Speed is above 24' and 'Visibility is 25'.
df[(df['Wind Speed_km/h']>24) & (df['Visibility_km']==25)]


# In[50]:


#Mean value of each column against each 'Weather Condition
df.groupby('Weather').mean()


# In[51]:


#finding Minimum & Maximum value of each column against each 'Weather Condition
df.groupby('Weather').min()
#df.groupby('Weather').max()


# In[56]:


#Showing all the Records where Weather Condition is Fog.
#df.head(50)
#df.groupby("Weather").get_group('Fog')
df[df['Weather']=='Fog']


# In[60]:


#Finding all instances when 'Weather is Clear' or 'Visibility is above 40'.
df[(df['Weather']=='Clear')|(df['Visibility_km']>40)]


# In[61]:


#Finding all instances when :
#1)'Weather is Clear' and 'Relative Humidity is greater than 50'
#or
#2)'Visibility is above 40'
df[(df['Weather']=='Clear')&(df['Rel Hum_%']>50) | (df['Visibility_km']>40)]


# In[ ]:




