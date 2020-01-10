clc;
clear;

data = load("data/kmeans1.mat");
data = cell2mat(struct2cell(data));
max_epochs = 1000;
rng(100)
centroid_colors = rand(1,8);
K = [2,4,8];
% Q2
figure
for i=1:length(K)
    k = K(i);
    subplot(2,2,i);
    [centroid, cluster_labels] = kmeans(data,k,max_epochs);
    for j=1:size(centroid,1)
        p = plot(centroid(j,1), centroid(j,2), '^','MarkerSize',12, 'MarkerFaceColor', rand(1,3));
        %p.MarkerFaceColor = p.Color;
        hold on;
        s = scatter(data(cluster_labels == j,1), data(cluster_labels == j,2),'filled');
        s.MarkerFaceAlpha = 0.3;
        hold on;
        title("K = "+j)
    end
end

%Q3
figure
for i=1:length(K)
    k = K(i);
    subplot(2,2,i);
    [centroid, cluster_labels, init_centroid] = kmeans(data,k,max_epochs);
    for j=1:size(centroid,1)
        p = plot(centroid(j,1), centroid(j,2), '^','MarkerSize',12, 'MarkerFaceColor', rand(1,3));
        %p.MarkerFaceColor = p.Color;
        hold on;
        s = scatter(data(cluster_labels == j,1), data(cluster_labels == j,2),'filled');
        s.MarkerFaceAlpha = 0.3;
        hold on;
        plot_arrow(init_centroid(j,1), init_centroid(j,2), centroid(j,1), centroid(j,2));
        hold on;
        title("K = "+j)
    end
end
