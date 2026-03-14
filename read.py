import pandas as pd 

df = pd.read_csv("covid_19_states.txt")
print(df.head())
df.to_csv("covid_19_states.csv", index=False

)