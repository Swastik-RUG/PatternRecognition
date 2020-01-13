clc;
clear;
rng(100);

data = load('cluster_data.mat');
data = cell2mat(struct2cell(data));
t = 0.1;
x = data(:,1);
y = data(:,2);
K = 1:1:10;
itr = 10;
% Special case K=1 to get J error for first iteration
total_q_error = 0;
max_epochs = 1000;
rng(100)
collated_error_list = [];
centroid_colors = rand(1,8);
for p=1:itr
    [centroid, cluster_labels] = kmeans(data,1,max_epochs, 0);
    quantization_error = calc_quantization_error(data, centroid, cluster_labels);
    total_q_error = total_q_error + quantization_error;
end

first_J_error = total_q_error/itr;
first_R_error = calc_R_error(first_J_error, size(data,2), 1);
first_D_error = first_R_error/first_J_error;
collated_error_list = [collated_error_list; [1, first_D_error, first_R_error, first_J_error]];

for k=2:length(K)
    total_q_error = 0;
    for p=1:itr
        [centroid, cluster_labels] = kmeans(data,k,max_epochs, 0);
        quantization_error = calc_quantization_error(data, centroid, cluster_labels);
        total_q_error = total_q_error + quantization_error;
    end
    j_error = total_q_error/itr;
    r_error = calc_R_error(first_J_error, size(data,2),k);
    d_error = r_error/j_error;
    collated_error_list = [collated_error_list; [k, d_error, r_error, j_error]];
end

[~, max_error_indx] = max(collated_error_list(:,2));
figure
plot(collated_error_list(:,1),collated_error_list(:,2))
text(collated_error_list(max_error_indx,1),collated_error_list(max_error_indx,2),"kOptimum");
title("D-Error values for different K values");
legend("D-Error");

figure
plot(collated_error_list(:,1),collated_error_list(:,3))
hold on;
plot(collated_error_list(:,1),collated_error_list(:,4))
text(collated_error_list(max_error_indx,1),collated_error_list(max_error_indx,3),"K-optimum");
text(collated_error_list(max_error_indx,1),collated_error_list(max_error_indx,4),"K-optimum");
line([4 4], get(gca, 'ylim'));
title("R-Error & J-Error values for different K values");
legend("R-Error","J-Error");
text(3,5000,'Optimal K value is = 4');

function r_error = calc_R_error(j_error, dimension, k)
    r_error = j_error*k^(-2/dimension);
end