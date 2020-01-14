clc;
clear;
rng(100);
id = "S4151968";
centroid_data = load('data/clusterCentroids.mat');
centroid_data = cell2mat(struct2cell(centroid_data));
data = load('data/checkerboard.mat');
data = cell2mat(struct2cell(data));

epochs = [20, 100, 200, 500 ];
K = 100;
subplot_splits = length(epochs)/2;
figure
for i=1:length(epochs)
    subplot(2,subplot_splits,i);
    epoch = epochs(i);
    prototypes = kmeans(data,K,epoch,3,centroid_data);
    plot(data(:,1), data(:,2), 'bo', 'markersize',4)
    hold on;
    plot(prototypes(:,1), prototypes(:,2),'r+', 'markersize',8, 'linewidth',2);
    voronoi(prototypes(:,1), prototypes(:,2));
    title("Epoch = "+ epoch +" ["+id+"]")
end

