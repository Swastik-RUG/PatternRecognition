clc;
clear;
rng(100);
ID = "S4035593";
data = load('cluster_data.mat');
data = cell2mat(struct2cell(data));
t = 0.1;
x = data(:,1);
y = data(:,2);

figure
Y = pdist(data);
Z = linkage(Y, 'average'); 
T = cluster(Z,'maxclust',99);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title("["+ID + " ]Dengogram (Average)")

figure
Y = pdist(data);
Z = linkage(Y, 'complete'); 
T = cluster(Z,'maxclust',99);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title("["+ID + " ]Dengogram (Max)")

figure
Y = pdist(data);
Z = linkage(Y, 'single'); 
T = cluster(Z,'maxclust',99);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title("["+ID + " ]Dengogram (min)")