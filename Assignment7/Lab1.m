clc;
clear;
rng(100);

data = load('cluster_data.mat');
data = cell2mat(struct2cell(data));
t = 0.1;
x = data(:,1);
y = data(:,2);

figure
Z = linkage(data); 
T = cluster(Z,'maxclust',4);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
ID = "S4151968";
figure
subplot_splits = length(T)/2;
T = [0.05, 0.1, 0.15, 0.2, 0.25];
for i=1:length(T)
    t = T(i);
    subplot(2,3,i);
    plot(data(:,1), data(:,2), '.'); 
    pairwisedist = hypot(x - x', y - y'); 
    [p1, p2] = find(tril(pairwisedist <= t & pairwisedist > 0));
    hold on;
    indexpairs = [p1, p2]';
    plot(x(indexpairs), y(indexpairs), '-b')
    title("["+ID+"] Threshold = "+t+ "")
end

figure
% Optimal T = 0.15
t = 0.15;
plot(data(:,1), data(:,2), '.'); 
pairwisedist2 = pdist2(data, data); 
[p1, p2] = find(tril(pairwisedist <= t & pairwisedist > 0));
hold on;
indexpairs = [p1, p2]';
plot(x(indexpairs), y(indexpairs), '-b')
title("["+ID+"] Optimal Threshold = "+t+ "")