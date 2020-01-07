clear;
close all;
rng(100)
% Read the input data as a matrix
data_a = load('data_lvq_A(1).mat');
data_b = load('data_lvq_B(1).mat');
data_a_mat = cell2mat(struct2cell(data_a));
data_b_mat = cell2mat(struct2cell(data_b));

% Determine the prototypes for the respective data at random
prototype1 = mean(data_a_mat) + randn(size(mean(data_a_mat)));
prototype2 = mean(data_a_mat) + randn(size(mean(data_a_mat)));
prototype3 = mean(data_b_mat) + randn(size(mean(data_b_mat)));
prototypes = [prototype1 0; prototype2 0; prototype3 1];

% Create samples of training and testing data for LOOCV.
[training_a, testing_a ]= training_testing_data_split(data_a_mat, 0.9, 10);
[training_b, testing_b ]= training_testing_data_split(data_b_mat, 0.9, 10);

% List to store the classification errors that occurr during LOOCV
classification_error_list = [];

for i=1:10
    % Find the size of the datasets
    size_training_a = size(cell2mat(training_a(i)),1);
    size_training_b = size(cell2mat(training_b(i)),1);
    size_testing_a = size(cell2mat(testing_a(i)),1);
    size_testing_b = size(cell2mat(testing_b(i)),1);
    
    % Combine the training and testing set of class A and class B at index 'i'
    % This is the data that was generated by training_testing_data_split
    % for LOOCV.
    train_set = [cell2mat(training_a(i)); cell2mat(training_b(i))];
    test_set = [cell2mat(testing_a(i)); cell2mat(testing_b(i))];
    
    % Set the class labels for Class A and Class B training and testing
    % sets generated
    training_class_labels = [zeros(size_training_a,1); ones(size_training_b,1)];
    testing_class_labels = [zeros(size_testing_a,1); ones(size_testing_b,1)];
    
    % Run the LVQ algorithm to train the model and retrive the new trained prototypes
    [prototypeList,~, ~] = myLVQ1(train_set,prototypes,training_class_labels,0.01);
    prototypes = prototypeList;
    
    % Using the trained prototypes predict the labels for the testing data
    [~,~,predictedLabels] = myLVQ1(test_set,prototypes, [], 0);
    
    % Check if the predicted labels match with the expected testing labels
    % Determine the classification error based on the missmatches and store
    % the result in classification_error_list.
    matching_class_labels = find(testing_class_labels == predictedLabels);
    classification_error = 1-size(matching_class_labels,1)/size(test_set,1);
    classification_error_list = [classification_error_list;classification_error];
end

mean_classification_error = mean(classification_error_list);
% Plot the classification errors for the 10-CV and display the mean
% classification error
figure
bar(classification_error_list);
text(1,0.5,sprintf('mean classification error value is = %f', mean_classification_error),'Color','red','FontSize',14)
hold on
xlabel("cross-validation fold");
ylabel("classification error on test sets");
title("LVQ classification error for LOOCV");
plot(xlim,[mean_classification_error mean_classification_error], 'r')
ylim([0 1])

% Splits the data into n random training and testing data at the ratio p
function [training, testing] = training_testing_data_split(data, p, n)
training = {};
testing = {};
    for i=1:n
        [m,~] = size(data) ;
        idx = randperm(m)  ;
        training = [training; data(idx(1:round(p*m)),:)] ; 
        testing = [testing; data(idx(round(p*m)+1:end),:)] ;
    end
end