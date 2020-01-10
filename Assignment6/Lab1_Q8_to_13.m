clc;
clear;

data = load("data/checkerboard.mat");
data = cell2mat(struct2cell(data));
rng(100);

k = 100;
itr = 20;
% Confused about this number, point 7 says its 20 questions say it is 10.
epoch = 10;
max_epochs = 100;
collated_kmeans_q_errors = [];
collated_kmeans_PP_q_errors = [];
for i=1:epoch
    kmeans_q_error = [];
    kmeans_PP_q_error = [];    
    parfor j=1:itr
       [centroid, cluster_labels] = kmeans(data,k,max_epochs, 0);
       quantization_error_kmeans = calc_quantization_error(data, centroid, cluster_labels);
       kmeans_q_error = [kmeans_q_error; quantization_error_kmeans];
       
       [centroid_pp, cluster_labels_pp] = kmeans(data,k,max_epochs, 1);
       quantization_error_kmeans_pp = calc_quantization_error(data, centroid_pp, cluster_labels_pp);
       kmeans_PP_q_error = [kmeans_PP_q_error; quantization_error_kmeans_pp];
    end
    collated_kmeans_q_errors = [collated_kmeans_q_errors; min(kmeans_q_error)];
    collated_kmeans_PP_q_errors = [collated_kmeans_PP_q_errors; min(kmeans_PP_q_error)];

end

fprintf("The mean of Kmeans error = %f \n", mean(collated_kmeans_q_errors))
fprintf("The standard deviation of Kmeans error = %f \n", std(collated_kmeans_q_errors))

fprintf("The mean of Kmeans++ error = %f \n", mean(collated_kmeans_PP_q_errors))
fprintf("The standard deviation of Kmeans++ error = %f \n", std(collated_kmeans_PP_q_errors))

% Welch's t-test
[h,p] = ttest2(collated_kmeans_q_errors, collated_kmeans_PP_q_errors, 'Tail', 'right')

fprintf("The P value = %f \n", p);