clc;
clear;
rng(100);

data = load('provinces.mat');
data = cell2mat(struct2cell(data));
t = 0.1;
x = data(:,1);
y = data(:,2);

figure
Z = linkage(data); 
T = cluster(Z,'maxclust',12);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title("Dengogram")