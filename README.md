# Ironhack Mid-Bootcamp Project |┬áRegression Case Study 
by [Lucas Trost](https://github.com/LucasTrost), May 2022
<br/><br/>
## Prediciting the value of houses

![image](https://user-images.githubusercontent.com/102299197/168103802-4e279a4c-f0ff-4883-93b0-0e0c2b086e30.png)

## Table of content

- [Project Brief](https://github.com/LucasTrost/Ironhack-MidBootProject/blob/main/README.md#project-brief)
- [Exploratory Data Analysis](https://github.com/LucasTrost/Ironhack-MidBootProject/blob/main/README.md#exploratory-data-analysis-eda)
- [Machine Learning Process](https://github.com/LucasTrost/Ironhack-MidBootProject/blob/main/README.md#machine-learning-process)
- [Key Take Aways](https://github.com/LucasTrost/Ironhack-MidBootProject/blob/main/README.md#key-take-aways)
## Project Brief

**Scenario:**
As a market analyst for real estate agency: TheAgency, my job is to work with and utilize data to give us an edge over our competitors. Thus it was only logical, that before we open an office in Seattle, I would do exactly that...

**Challenge:**
Using a dataset I pulled from a market study in 2015, I was to build a model that can predict the price of houses in the Seattle area. In addition, as TheAgency regards itself as a high-end real estate agency, I was tasked to explore what features exactly determine high prices.

Further project details such as deliverables can be found [here](https://github.com/LucasTrost/Ironhack-MidBootProject/tree/main/project%20details)

## Exploratory Data Analysis (EDA)
To explore and understand the data I chose to use the following tools:
### Tableau:
Tableau is a great tool to jump into dataset, play around, and gain insights. I spent a significant chunk of time on Tableau, creating Dashboards and stories, through which I became very familiar with the data.

Feel free to explore the [Tableau](https://public.tableau.com/app/profile/lucas.trost/viz/TableauWorkbookMidBootProjLucasTrost/Task2) and/or the presentation [slides](https://docs.google.com/presentation/d/1a8KI_ejQg2CMe7zK58Rg-I7sInZN08zFe38I-wSfIOk/edit#slide=id.g106fa6903b0_1_0)
### SQL:
Importing the data to SQL was no smooth sailing. Apparently the csv. file from the study was corrupted. In order to circumvent said problem, I exported the excel version of the data into Python, where I turned it into a DataFrame, and downloaded as a csv. 

This seemed to work, and I was able to get started on querying. Overall I was already pretty happy with my understanding of the data, which is why I kept querying to a minimal.

For SQL query file see [here](https://github.com/LucasTrost/Ironhack-MidBootProject/tree/main/SQL%20Querys)

## Machine Learning Process

### Pre-Modeling
Besides EDA there were a few necessary steps to take, in order to ensure valid results end results
The most notable steps here were:
#### Dropping columns
One obvious column to drop straight away, was the Unknown :1 column, which was some form of indexing included in the data. Next I decided to drop the columns: id, date, lat, long as all of these would lead to heavy overfitting. 

I had no trouble dropping lat and long, as the combination of the two is very unique. Date was the only column I had some trouble with. In the end I decided that the data wasn't dense enough to justify keeping the column. In other words, date was quite unique, hence the benefit of keeping it did not outweigh the aspect of overfitting.
#### Dropping outliers
Through extensive work in Tableau I was quite confident with outliers. The only notable one, which seemed like bad data was the property worth ca. 500k, that had a number of 33 bedrooms. Price outliers or anything similar were kept.
#### Scaling
As our DataFrame had vastly differentiating number ranges, and consisted of only numerical columns, I decided it would be best to apply a MinMaxScaler() to the entire DataFrame.

### Model for estimating price

#### Linear Regression Model
I first started with a base line Linear Regressions model. After drafting two more Candidates where I played with choosing between the highly correlating columns around the size of the property (sqft_living,sqft_living15,sqft_above, etc.) and getting no real improvement in accuracy I decided to move on to the next model.
#### K-Nearest-Neighbours Regression Model
The base model alone showed more promising results than the previous candidates, with an increase in accuracy and a decrease in Root Mean Squared Error (RMSE). 

I noticed that yr_renovated may lead to some inaccuracies, with the model disproportionally rewarding said feature. Houses that had no renevation date received a '0' as entry in the feature. 

This led to two strong opposing groups: houses with, and houses without a renovation date. A grouping beforehand (assigning a value of either 2 = freshly renovated, 1 = recently renovated, 0 = not renovated/ renovated long time ago) would fix that problem.

I still believed I was on to something with the correlation concept in the linear regressions model. Thus I experimented a bit, and dropping sqft_basement and sqft_above (which = sqft_living), the model improved yet again.

#### Decision Tree Regression Model
Already being fairly content with my KNN model, I only planned to briefly dip into decision trees. With the base model returning an accuracy of 64%, 8% worse than the KNN, I was more than happy to move on.

### Model to determine importance of features
As already mentioned we, TheAgency, are quite the luxurious real-estate-agency. Thus we were especially interested in houses with a value equal to and greater than $650k. Here a simple pandas query did the trick.

#### Random Forest Regression Model
To determine feature importance one could've based their answer on a correlation matrix. We as a agency, however, have to keep our standards high, which is why I opted for a ensemble method of the Random Forest Regressor. I then ran the model through a inspection method, which gave me my final results.
<img width="777" alt="Screenshot 2022-05-12 at 17 47 27" src="https://user-images.githubusercontent.com/102299197/168116049-4bc0c891-3e47-4c91-9064-92145b5d5ae9.png">

take a look at my python notebook and further anotations [here](https://github.com/LucasTrost/Ironhack-MidBootProject/tree/main/Python%20Notebook)

## Key Take Aways
#### Model for estimating price:
With an accuracy of 72.25% and a RSME of $195k the model is fairly accurate, but no where close for us, TheAgency, to solemnly rely on it for price determination.
#### Model to determine importance of features
Here the results seem alot more promising, as wee gained a clear guideline as to which features determine high prices.
#### Overall conclusion
I believe the two models to be of good aid for our new office in Seattle, especially the ladder. I can see us scanning the real estate market for the determined features, and calculating a rough price range, before sending out one of our agents. Because in the end, little beats the judgement and expertise of a TheAgency's agent.
