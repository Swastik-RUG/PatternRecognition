clc;
clear;
rng(100);
ID = "S4035593";
data = load('cluster_data.mat');
data = cell2mat(struct2cell(data));
t = 0.1;
x = data(:,1);
y = data(:,2);
alpha = 0.8;

figure
Y = pdist(data);
Z = linkage(Y,'complete');
T2 = clusterdata(Z,'Maxclust',4);
x = find_centroids(Z, T2);
hold on;
for p=1:length(x)
    center = x{p};
    scatter3(center(1), center(2), center(3),300, 'filled', 'r*', 'MarkerEdgeColor','k')
    hold on;
end
scatter3(Z(:,1),Z(:,2),Z(:,3),100,T2,'filled','MarkerEdgeAlpha', alpha, 'MarkerFaceAlpha', alpha)
hold off;
title("["+ID + " ] Hierarchical Cluster (Max)")

figure
Y = pdist(data);
Z = linkage(Y,'single');
T2 = clusterdata(Z,'Maxclust',4);
x = find_centroids(Z, T2);
hold on;
for p=1:length(x)
    center = x{p};
    scatter3(center(1), center(2), center(3),300, 'filled', 'r*', 'MarkerEdgeColor','k')
    hold on;
end
scatter3(Z(:,1),Z(:,2),Z(:,3),100,T2,'filled','MarkerEdgeAlpha', alpha, 'MarkerFaceAlpha', alpha)
hold off;
title("["+ID + " ] Hierarchical Cluster (Min)")


figure
Y = pdist(data);
Z = linkage(Y,'average');
T2 = clusterdata(Z,'Maxclust',4);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title("["+ID + " ]Hierarchical Cluster (average)")

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