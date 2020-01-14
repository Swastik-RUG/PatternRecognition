clc;
clear;
id = "S4151968";
data = load("data/kmeans1.mat");
data = cell2mat(struct2cell(data));
max_epochs = 1000;
rng(100)
collated_error_list = [];
centroid_colors = rand(1,8);
K = 1:1:10;
itr = 10;
% Special case K=1 to get J error for first iteration
total_q_error = 0;

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
title("D-Error values for different K values ["+id+"]");
legend("D-Error");

figure
plot(collated_error_list(:,1),collated_error_list(:,3))
hold on;
plot(collated_error_list(:,1),collated_error_list(:,4))
text(collated_error_list(max_error_indx,1),collated_error_list(max_error_indx,3),"K-optimum");
text(collated_error_list(max_error_indx,1),collated_error_list(max_error_indx,4),"K-optimum");
line([2 2], get(gca, 'ylim'));
title("R-Error & J-Error values for different K values ["+id+"]");
legend("R-Error","J-Error");
text(3,5000,'Optimal K value is = 2');


% function quantization_error = calc_quantization_error(data, centroids, labels)
%     outer_sigma = 0;
%     for i=1:size(centroids,1)
%         centroid_related_data_points = data(find(labels == i),:);
%         for j=1:size(centroid_related_data_points,1)
%             inner_sigma = pow2(norm(centroids(i,:)-centroid_related_data_points(j,:)));
%             outer_sigma = outer_sigma + inner_sigma;
%         end
%     end
%     quantization_error = outer_sigma/2;
% end

function r_error = calc_R_error(j_error, dimension, k)
    r_error = j_error*k^(-2/dimension);
end