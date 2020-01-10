function quantization_error = calc_quantization_error(data, centroids, labels)
    outer_sigma = 0;
    for i=1:size(centroids,1)
        centroid_related_data_points = data(find(labels == i),:);
        for j=1:size(centroid_related_data_points,1)
            inner_sigma = pow2(norm(centroids(i,:)-centroid_related_data_points(j,:)));
            outer_sigma = outer_sigma + inner_sigma;
        end
    end
    quantization_error = outer_sigma/2;
end