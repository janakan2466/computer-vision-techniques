% Population growth model

data = [1900 75.995;
        1910 91.972;
        1920 105.711;
        1930 123.203;
        1940 131.669;
        1950 150.697;
        1960 179.323;
        1970 203.212;
        1980 226.505;
        1990 249.633;
        2000 281.422;
        2010 308.748;];

years = data(:, 1);
population = data(:, 2);

% Fit linear model
linearCoeff = polyfit(years, population, 1);

% Fit quadratic model
quadraticCoeff = polyfit(years, population, 2);

yearsModel = min(years):0.01:max(years);
populationLinearModel = polyval(linearCoeff, yearsModel);
populationQuadraticModel = polyval(quadraticCoeff, yearsModel);

% Evaluate both models
figure, plot(yearsModel, populationLinearModel, 'b-', 'LineWidth', 2);
hold on, plot(yearsModel, populationQuadraticModel, 'r-', 'LineWidth', 2);
plot(years, population, 'kx', 'MarkerSize', 10);
legend('Fitted Linear', 'Fitted Quadratic', 'Input Data', 'Location', 'NorthWest');