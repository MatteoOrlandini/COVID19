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
There is a variable called "nation" with which you can select the desired country and a variable "saving_enabled" if you want to save the charts plotted. The charts are saved [here](https://github.com/MatteoOrlandini/COVID19/tree/master/Charts) and are available in two formats ([.png](https://github.com/MatteoOrlandini/COVID19/tree/master/Charts/PNG) and [.eps](https://github.com/MatteoOrlandini/COVID19/tree/master/Charts/EPS)). 
This is an exampe of linear regression for daily confirmed cases in Italy.

![](https://raw.githubusercontent.com/MatteoOrlandini/COVID19/master/Charts/PNG/Italy%20daily%20confirmed%20growth.png)

# MATLAB Graphic Application
You can download the installer for the standalone application (without Matlab) [here](https://github.com/MatteoOrlandini/COVID19/blob/master/COVID19_APP/for_redistribution/MyAppInstaller_web.exe). You need to install the [MATLAB Runtime](https://it.mathworks.com/products/compiler/matlab-runtime.html) to run this app. The application will download the dataset and save it on startup in the 'Dataset' folder. If an error occurred, this will be displayed in the application.

The following image shows an example of usage of the application.

![](https://github.com/MatteoOrlandini/COVID19/blob/master/APP_Screen.png)

You can choose nine types of charts for all the nations around the world.

![](https://github.com/MatteoOrlandini/COVID19/blob/master/Chart_type.png)
