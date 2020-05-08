%https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases

clc;
clear all;
close all;
format shortG
saving_enabled = true;
Gompertz_enabled = false;

%% save csv from url
confirmed_global_file = websave('Dataset/time_series_covid19_confirmed_global.csv','https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv&filename=time_series_covid19_confirmed_global.csv');
deaths_global_file = websave('Dataset/time_series_covid19_deaths_global.csv','https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv&filename=time_series_covid19_deaths_global.csv');
recovered_global_file = websave('Dataset/time_series_covid19_recovered_global.csv','https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_recovered_global.csv&filename=time_series_covid19_recovered_global.csv');

%% load csv
confirmed_global = readtable('Dataset/time_series_covid19_confirmed_global.csv');
deaths_global = readtable('Dataset/time_series_covid19_deaths_global.csv');
recovered_global = readtable('Dataset/time_series_covid19_recovered_global.csv');
nation = 'Italy';
date = table2cell(confirmed_global(1, 5:end));
nations_list = confirmed_global.Var2(2:end);   
for i = 2:height(recovered_global)
    if (strcmp(confirmed_global{i,2},nation))
        index_confirmed_global = i;
    end
    if (strcmp(deaths_global{i,2},nation))
        index_deaths_global = i;
    end
    if (strcmp(recovered_global{i,2},nation))
        index_recovered_global = i;
    end
end
nation_confirmed_tab = confirmed_global(index_confirmed_global,:);
nation_deaths_tab = deaths_global(index_deaths_global,:);
nation_recovered_tab = recovered_global(index_recovered_global,:);

%italy_confirmed = zeros(height(italy_confirmed_tab),width(italy_confirmed_tab));
%italy_deaths = zeros(height(italy_deaths_tab),width(italy_deaths_tab));
%italy_recovered = zeros(height(italy_recovered_tab),width(italy_recovered_tab));
j = 0;
for i = 5: width(nation_confirmed_tab) 
    if (str2double(nation_confirmed_tab{1,i}) > 0)
        j = j+1;
        nation_confirmed (j) = str2double(nation_confirmed_tab{1,i});
        nation_deaths (j) = str2double(nation_deaths_tab{1,i});
        nation_recovered (j) = str2double(nation_recovered_tab{1,i});
    end
end


%delete zero entries in deaths array
nation_deaths_no_zero = deleteZeroEntries(nation_deaths);

%delete zero entries in recovered array
nation_recovered_no_zero = deleteZeroEntries(nation_recovered);

%create date time array
%{
date = NaT(100,1);
for i = 1 : 100
    date(i) = datetime('now')-length(nation_deaths)+i-1;
end
%}

%% start plot
fig_confirmed = figure('Name',strcat(nation,' confirmed'),'NumberTitle','off');
plot (nation_confirmed);
xticks([1: 15: length(nation_confirmed)]);
xticklabels(date(end-length(nation_confirmed)+1 : 15: end));
xlabel('Days since first confirmed case');
ylabel('Confirmed');
fig_deaths = figure('Name',strcat(nation,' deaths'),'NumberTitle','off');
plot (nation_deaths);
xticks([1: 15: length(nation_confirmed)]);
xticklabels(date(end-length(nation_confirmed)+1 : 15: end));
xlabel('Days since first confirmed case');
ylabel('Deaths');
fig_recovered = figure('Name',strcat(nation,' recovered'),'NumberTitle','off');
plot (nation_recovered);
xticks([1: 15: length(nation_confirmed)]);
xticklabels(date(end-length(nation_confirmed)+1 : 15: end));
xlabel('Days since first confirmed case');
ylabel('Recovered');

%daily confirmed
daily_confirmed_growth = [0 diff(nation_confirmed)];
[fitresult, xData, yData] = createFit(daily_confirmed_growth);
% Plot fit with data.
fig_daily_confirmed = figure('Name',strcat(nation,' daily confirmed growth'),'NumberTitle','off');
plot( fitresult, xData, yData );
xticks([1: 15: length(yData)]);
xticklabels(date(end-length(yData)+1 : 15: end));
legend('Daily confirmed growth', 'Fit', 'Location', 'NorthWest', 'Interpreter', 'none' );
xlabel('Days since first confirmed case');
ylabel('Daily confirmed growth');
grid on
%plot daily % confirmed
daily_perc_confirmed_growth = daily_confirmed_growth./nation_confirmed*100;
fig_daily_perc_confirmed_growth = figure('Name',strcat(nation,' daily % confirmed growth'),'NumberTitle','off');
plot (daily_perc_confirmed_growth);
xticks([1: 15: length(daily_perc_confirmed_growth)]);
xticklabels(date(end-length(daily_perc_confirmed_growth)+1 : 15: end));
xlabel('Days since first confirmed case');
ylabel('Daily % confirmed growth');

%daily deaths
daily_deaths_growth = [0 diff(nation_deaths_no_zero)];
[fitresult, xData, yData] = createFit(daily_deaths_growth);
% Plot fit with data.
fig_daily_deaths = figure('Name',strcat(nation,' daily deaths growth'),'NumberTitle','off');
plot( fitresult, xData, yData );
xticks([1: 15: length(yData)]);
xticklabels(date(end-length(yData)+1 : 15: end));
legend('Daily death growth', 'Fit', 'Location', 'NorthWest', 'Interpreter', 'none' );
xlabel('Days since first death case');
ylabel('Daily death growth');
grid on
%plot daily % deaths
daily_perc_deaths_growth = daily_deaths_growth./nation_deaths_no_zero*100;
fig_daily_perc_deaths_growth = figure('Name',strcat(nation," daily % deaths growth"),'NumberTitle','off');
plot (daily_perc_deaths_growth);
xticks([1: 15: length(daily_perc_deaths_growth)]);
xticklabels(date(end-length(daily_perc_deaths_growth)+1 : 15: end));
xlabel('Days since first death case');
ylabel('Daily % deaths growth');

%daily recovered
daily_recovered_growth = [0 diff(nation_recovered_no_zero)];
[fitresult, xData, yData] = createFit(daily_recovered_growth);
% Plot fit with data.
fig_daily_recovered = figure('Name',strcat(nation,' daily recovered growth'),'NumberTitle','off');
plot( fitresult, xData, yData );
xticks([1: 15: length(yData)]);
xticklabels(date(end-length(yData)+1 : 15: end));
legend('Daily recovered growth', 'Fit', 'Location', 'NorthWest', 'Interpreter', 'none' );
xlabel('Days since first recovered case');
ylabel('Daily recovered growth');
grid on
%plot daily % recovered
daily_perc_recovered_growth = daily_recovered_growth./nation_recovered_no_zero*100;
fig_daily_perc_recovered_growth = figure('Name',strcat(nation," daily % recovered growth"),'NumberTitle','off');
plot (daily_perc_recovered_growth);
xticks([1: 15: length(daily_perc_recovered_growth)]);
xticklabels(date(end-length(daily_perc_recovered_growth)+1 : 15: end));
xlabel('Days since first recovered case');
ylabel('Daily % recovered growth');


%% save all the figures
if (saving_enabled)
    saveas(fig_confirmed,strcat("Charts/EPS/",nation," confirmed"),'epsc');
    saveas(fig_confirmed,strcat("Charts/PNG/",nation," confirmed.png"),'png');
    saveas(fig_deaths,strcat("Charts/EPS/",nation," deaths"),'epsc');
    saveas(fig_deaths,strcat("Charts/PNG/",nation," deaths.png"),'png');
    saveas(fig_recovered,strcat("Charts/EPS/",nation," recovered"),'epsc');
    saveas(fig_recovered,strcat("Charts/PNG/",nation," recovered.png"),'png');
    saveas(fig_daily_confirmed,strcat("Charts/EPS/",nation," daily confirmed growth"),'epsc');
    saveas(fig_daily_confirmed,strcat("Charts/PNG/",nation," daily confirmed growth.png"),'png');
    saveas(fig_daily_perc_confirmed_growth,strcat("Charts/EPS/",nation," daily % confirmed growth"),'epsc');
    saveas(fig_daily_perc_confirmed_growth,strcat("Charts/PNG/",nation," daily % confirmed growth.png"),'png');
    saveas(fig_daily_deaths,strcat("Charts/EPS/",nation," daily deaths growth"),'epsc');
    saveas(fig_daily_deaths,strcat("Charts/PNG/",nation," daily deaths growth.png"),'png');
    saveas(fig_daily_perc_deaths_growth,strcat("Charts/EPS/",nation," daily % deaths growth"),'epsc');
    saveas(fig_daily_perc_deaths_growth,strcat("Charts/PNG/",nation," daily % deaths growth.png"),'png');
    saveas(fig_daily_recovered,strcat("Charts/EPS/",nation," daily recovered growth"),'epsc');
    saveas(fig_daily_recovered,strcat("Charts/PNG/",nation," daily recovered growth.png"),'png');
    saveas(fig_daily_perc_recovered_growth,strcat("Charts/EPS/",nation," daily % recovered growth"),'epsc');
    saveas(fig_daily_perc_recovered_growth,strcat("Charts/PNG/",nation," daily % recovered growth.png"),'png');
end

%% start plot Gompertz relation
if (strcmp(nation, 'Italy') == 1 && Gompertz_enabled == true)
    t = [1: 100];
    y_31mar = 42571.667  * exp(-exp( 2.588065  - .05992132  * t)); %31 marzo https://twitter.com/SignorErnesto/status/1245026447162593282
    t1 = [-5:100];
    y_1apr = 35401.207 * exp(-exp( 2.265412   - .0652634 * t1)); %1 aprile https://twitter.com/SignorErnesto/status/1245427172350853121
    y_4apr = 31734.275  * exp(-exp( 2.3070999   - .06947949   * t1)); %4 aprile https://twitter.com/SignorErnesto/status/1246481265668304897
    y_7apr = 28588.156 * exp(-exp( 2.3707892 - .07466436 * t1)); %7 aprile https://twitter.com/SignorErnesto/status/1247563618901729281
    %delete last array elements  
    for i = length(y_1apr) : -1 : length(y_31mar)+1
        y_1apr(i) = [];
        y_4apr(i) = [];
        y_7apr(i) = [];
    end
    %delete nation_deaths elements equals to zero
    for i = length(nation_deaths) : -1 : 1
        if (nation_deaths (i) == 0)
            nation_deaths (i) = [];
        end
    end
    
    %plot
    fig_gompertz = figure('Name',strcat('Gompertz relation_', nation),'NumberTitle','off');
    scatter (date(1:length(nation_deaths)),nation_deaths);
    hold on;
    %adjust date array for Gompertz relation
    plot (date, y_31mar);
    hold on;
    plot (date, y_1apr);
    hold on;
    plot (date, y_4apr);
    hold on;
    plot (date, y_7apr);
    xlim([date(1), date(end)]);
    xlabel('Days');
    ylabel('Deaths');
    legend('Deaths','fit 31 mar', 'fit 1 apr', 'fit 4 apr', 'fit 7 apr', 'Location', 'northwest');
    if (saving_enabled)
        saveas(fig_gompertz,strcat("Charts/EPS/Gompertz relation ",nation),'epsc');
        saveas(fig_gompertz,strcat("Charts/PNG/Gompertz relation ",nation,'.png'),'png');
    end
    %% matlab fit
    %fitobject = fit([1:length(nation_deaths)]',nation_deaths','exp1');
    %matlab_fit =  fitobject.a*exp(fitobject.b*[1:length(nation_deaths)]);
    %hold on
    %plot (matlab_fit);
    
    %% https://it.mathworks.com/matlabcentral/answers/425171-how-to-solve-the-modified-gompertz-equation
    %gompertz = @(b,t) b(1) .* exp(-exp((b(2) .* exp(1))./b(1)) .* (b(3)-t) + 1);
    %[B,resnorm] = fminsearch(@(b) norm(nation_deaths - gompertz(b,[1:length(nation_deaths)])),[1.4; -0.7; 37; 7]);
    %hold on
    %plot(date, gompertz(B,[1:length(y_31mar)]));
    
    %% Nonlinear Data-Fitting
    %https://it.mathworks.com/help/optim/examples/nonlinear-data-fitting.html
    %y_31marz = 42571.667  * exp(-exp( 2.588065  - .05992132  * t))
    
end

%http://www.robertopancrazi.com/
%https://github.com/ioconto/covid19


%% nn
%{
%https://it.mathworks.com/help/thingspeak/create-and-train-a-feedforward-neural-network.html
net = feedforwardnet(20);
%net.trainParam.showWindow = 0;   %disable popup of training windows for neural network
[net,tr] = train(net,1:length(nation_confirmed),nation_confirmed);
output = net(1:length(date));
figure;
plot (date, output);
hold on;
plot (nation_confirmed);
hold on;
xlim([date(1), date(end)]);
legend('Trained data', 'Confirmed cases','Location','northwest');
%}
