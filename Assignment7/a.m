clear all;
    X = importdata('cluster_data.mat');
    Y = pdist(X,'Euclidean');
    D = squareform(Y);

figure(1)
Z = linkage(Y,'complete')
T2 = clusterdata(Z,'Maxclust',4);
scatter3(Z(:,1),Z(:,2),Z(:,3),100,T2,'filled')
title('Result of Complete Clustering');

figure(2)
dendrogram(Z)

figure(3)
Z = linkage(Y,'single')
T2 = clusterdata(Z,'Maxclust',4);
scatter3(Z(:,1),Z(:,2),Z(:,3),100,T2,'filled')
title('Result of Single Clustering');

figure(4)
Z = linkage(Y,'single');
T2 = clusterdata(Z,'Maxclust',4);
scatter3(Z(:,1),Z(:,2),Z(:,3),100,T2,'filled')
title('Result of average Clustering');
Z = linkage(Y,'average');
T2 = clusterdata(Z,'Maxclust',4);
scatter3(Z(:,1),Z(:,2),Z(:,3),100,T2,'filled')
title('Result of average Clustering dendogram');
figure(6)
dendrogram(Z)

function centroids = find_centroids(data, cluster)
    centroids = {};
    n_centroid = length(unique(cluster));
    for i=1:n_centroid
        indx = find(cluster == i);
        if length(indx)>1
            centroids = [centroids; {mean(data(indx,:))}];
        else
            centroids = [centroids; {data(indx,:)}];
        end
    end
end