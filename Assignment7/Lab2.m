clc;
clear;
rng(100);
data = load('cluster_data.mat');
data = cell2mat(struct2cell(data));
t = 0.1;
x = data(:,1);
y = data(:,2);
figure
plot(data(:,1), data(:,2), '.'); 
pairwisedist2 = pdist2(data, data); 
[p1, p2] = find(tril(pairwisedist2 <= t & pairwisedist2 > 0));
hold on;
indexpairs = [p1, p2]';
plot(x(indexpairs), y(indexpairs), '-b')
title("Lab 2 pdist?")

figure
Z = linkage(data); 
T = cluster(Z,'maxclust',4);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title("Dengogram")