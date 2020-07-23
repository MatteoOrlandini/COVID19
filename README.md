# COVID19 TRACKING APP

This MATLAB application allows you to plot some data of the COVID19 disease. You can find the dataset [here](https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases). In this project there is a [MATLAB code](https://github.com/MatteoOrlandini/COVID19/blob/master/COVID19.m) and a [MATLAB graphic application](https://github.com/MatteoOrlandini/COVID19/blob/master/COVID19_App.mlapp) developed using MATLAB App Designer. 

There are nine kind of charts:
* total confirmed
* total recovered
* total deaths
* daily % confirmed cases growth
* daily % recovered cases growth
* daily % deaths cases growth
* daily confirmed cases growth and its linear regression model
* daily recovered cases growth and its linear regression model
* daily deaths cases growth and its linear regression model

# MATLAB Application
The code "COVID19.m" allows the user to show the plots mentioned above. There is a variable called "nation" with which you can select the desired country, this variable is set to "Italy" by default. The variable "saving_enabled" could be true or false, if you want to save the charts plotted or not. The charts are saved [here](https://github.com/MatteoOrlandini/COVID19/tree/master/Charts) and are available in two formats ([.png](https://github.com/MatteoOrlandini/COVID19/tree/master/Charts/PNG) and [.eps](https://github.com/MatteoOrlandini/COVID19/tree/master/Charts/EPS)). 
This is an exampe of linear regression for daily confirmed cases in Italy.

![](https://raw.githubusercontent.com/MatteoOrlandini/COVID19/master/Charts/PNG/Italy%20daily%20confirmed%20growth.png)

# MATLAB Graphic Application
You can download the installer for the standalone application (without Matlab) [here](https://github.com/MatteoOrlandini/COVID19/blob/master/COVID19_APP/for_redistribution) using "MyAppInstaller_web.exe". 
## How to intall
1. Open "MyAppInstaller_web.exe"
2. You need to install the [MATLAB Runtime](https://it.mathworks.com/products/compiler/matlab-runtime.html) to run this app. 
3. Install the application COVID19
4. Run the app

## App behavior
The application will download the dataset on startup and save it in the 'Dataset' folder. If an error occurred, this will be displayed in the application. There are two slection boxes in which to select the country and the graph to be shown.


The following image shows an example of usage of the application.

![](https://github.com/MatteoOrlandini/COVID19/blob/master/APP_Screen.png)

You can choose nine types of charts for all the nations around the world.

![](https://github.com/MatteoOrlandini/COVID19/blob/master/Chart_type.png)
