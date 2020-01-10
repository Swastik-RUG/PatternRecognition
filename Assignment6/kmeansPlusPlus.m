% Reference steps: https://www.geeksforgeeks.org/ml-k-means-algorithm/
% Merged with Kmeans 0 - Kmeans  1 - Kmeans Plus plus
function [init_centroid, centroid, cluster_labels] = kmeansPlusPlus(data, k, max_epochs)
    data_size = size(data,1);
    cluster_labels = zeros(data_size,1)-1;
    
    % Create only 1 centroid and compute the rest using this centroid
    init_centroid = [data(randperm(data_size,1),:)];
    
    for c=1:k-1
        distances = [];
        for indx=1:data_size
            cur_data_point = data(indx,:);
            dist = pdist2(cur_data_point, init_centroid, 'squaredeuclidean');
            [min_dist, ~] = min(dist);
            distances = [distances;min_dist];
        end
        new_centroid_indx = randsample(data_size,1, true, distances);
        init_centroid = [init_centroid; data(new_centroid_indx,:)];
    end

    centroid = init_centroid;
    threshold = 1e-3;
    convergence = threshold + 1;
    cur_epoch = 0;
    
    while (convergence > threshold && cur_epoch < max_epochs)      
        for i=1:data_size
            dist = pdist2(data(i,:), centroid, 'euclidean');
            [~, min_indx] = min(dist);
            cluster_labels(i,1) = min_indx;
        end
    
        prev_centroid = centroid;
        % Recompute centroid
        for j=1:k
            cur_centroid_indx = find(cluster_labels==j);
            cur_cluster_points = data(cur_centroid_indx, :);
            new_centroid = mean(cur_cluster_points);
            centroid(j,:) = new_centroid;
        end
        convergence = abs(norm(prev_centroid) - norm(centroid));
        cur_epoch = cur_epoch + 1;        
    end
end