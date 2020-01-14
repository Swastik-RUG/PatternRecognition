clc;
clear;
id = "S4035593";
data = load("data/kmeans1.mat");
data = cell2mat(struct2cell(data));
max_epochs = 1000;
rng(100)
centroid_colors = rand(1,8);
K = [2,4,8];
% Q2
legends = ["Centroid-1","Centroid-2","Centroid-3","Centroid-4","Centroid-5","Centroid-6","Centroid-7","Centroid-8"];
colors = [[1 0 0]; [0 1 0]; [0 0 1]; [0 1 1]; [1 0 1]; [0.4940 0.1840 0.5560]; [0 0 0]; [0 0.4470 0.7410]];
figure
for i=1:length(K)
    k = K(i);
    subplot(2,2,i);
    [centroid, cluster_labels] = kmeans(data,k,max_epochs,0);
    for j=1:size(centroid,1)
        p = plot(centroid(j,1), centroid(j,2), '^','MarkerSize',12, 'MarkerFaceColor', colors(j,:),'Color',colors(j,:));
        %p.MarkerFaceColor = p.Color;
        hold on;
        s = scatter(data(cluster_labels == j,1), data(cluster_labels == j,2),'filled');
        s.MarkerFaceAlpha = 0.3;
        hold on;
        title("K = "+j+" ["+id+"]")
    end
end

%Q3

plots = [];
figure

for i=1:length(K)
    k = K(i);
    ax = subplot(2,2,i);
    [centroid, cluster_labels, init_centroid] = kmeans(data,k,max_epochs,0);
    for j=1:size(centroid,1)
        p = plot(centroid(j,1), centroid(j,2), '^','MarkerSize',12, 'MarkerFaceColor', colors(j,:),'Color',colors(j,:));
        plots(j) = p;
        %legend(legends(j));
        %p.MarkerFaceColor = p.Color;
        hold on;
        s = scatter(data(cluster_labels == j,1), data(cluster_labels == j,2),'filled');
        s.MarkerFaceAlpha = 0.3;
        hold on;
        plot_arrow(init_centroid(j,1), init_centroid(j,2), centroid(j,1), centroid(j,2));
        hold on;
        title("K = "+j+" ["+id+"]")
        %legend(legends(1,k))
    end
    legend(plots, legends)
end
