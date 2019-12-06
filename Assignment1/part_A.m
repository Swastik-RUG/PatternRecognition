%loading data
load('lab1_1.mat');
lab1_1;
correlation = corrcoef(lab1_1);
sprintf("Correaltion between the features:")
correlation
%Getting list of all height
height = lab1_1(:,1:1);
%Getting list of all weight
weight = lab1_1(:,3:3);
%Getting list of all age
age =lab1_1(:,2:2);
%Plotting the largest correlation Coefficient
figure('Name','Largest Correlation Coefficient')
scatter(height,weight,'r');
title('Largest');
xlabel('feature 1: Height in centimeter');
ylabel('feature 3: Weight in kilograms');
%Plotting the second largest correlation Coefficient
figure('Name','Second Largest Correlation Coefficient')
scatter(age,weight,'s','g');
title('Second Largest');
xlabel('feature 2: Age in years');
ylabel('feature 3: Weight in kilograms');
%%Scatter plot of weight and age after age of 40
figure('Name', 'Scatter Plot for Weight and age when age > 40')
list1 = lab1_1(8:24,2:2);
list2 = lab1_1(8:24,3:3);
scatter(list1,list2);
% Determine correlation between weight and age for age > 40
correlationAgeGT40 = corrcoef(lab1_1(8:24,2:3));
fprintf("--------------------------------------------------------------------------------------\n") 
fprintf("Correlation Between weight and age for age > 40 = %f\n", correlationAgeGT40(2,1))
% Determine correlation between weight and age for age <= 40
correlationAgeLT40 = corrcoef(lab1_1(1:7,2:3));
fprintf("Correlation Between weight and age for age <= 40 = %f\n", correlationAgeLT40(2,1))
fprintf("--------------------------------------------------------------------------------------\n") 
