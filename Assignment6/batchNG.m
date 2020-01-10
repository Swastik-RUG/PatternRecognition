function prototypes = batchNG(data, cluster_centroid_data, k, epoch_max)
    sigma_1 = k/2;
    data_size = size(data,1);
    feature_size = size(data,2);
    prototypes = cluster_centroid_data;
    
    for i=1:epoch_max
        numerator = zeros(k,feature_size);
        denominator = zeros(k,1);
        for j=1:data_size
            cur_sample_data = data(j,:);
            point_to_prototype_distance = pdist2(cur_sample_data, prototypes, 'euclidean');
            [~, sorted_dist_indx] = sort(point_to_prototype_distance);
            
            for p=1:size(prototypes,1)
                sigma = sigma_1 * (0.01/sigma_1).^((i-1)/epoch_max);
                numerator(sorted_dist_indx(p),:) = numerator(sorted_dist_indx(p),:) + (exp(-p/sigma) * cur_sample_data);
                denominator(sorted_dist_indx(p),:) =  denominator(sorted_dist_indx(p),:) + exp(-p/sigma);
                % prototypes(p,:) = numerator(sorted_dist_indx(p),:)/denominator(sorted_dist_indx(p));
                % prototypes(p,:) = numerator(p,:)/denominator(p);
            end
        end
        
        for q=1:size(prototypes,1)
            prototypes(q,:) = numerator(q,:)/denominator(q);
        end
    end
end