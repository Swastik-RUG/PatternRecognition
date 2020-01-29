clc;
clear;
rng(100);

x1 = [0,0];
x2 = [2,3];
x3 = [1,4];
x4 = [4,2];
x5 = [3,0];
X = [x1;x2;x3;x4;x5];

%Q1
labels = [1,1,1,2,2];
centroids = [mean([x1;x2;x3]); mean([x4;x5])];
q1_je = calcJerror(X,labels,centroids);
fprintf("The Jerror for clusters {x1,x2,x3} and {x4,x5} = "+ q1_je + "\n")

%Q2
labels = [1,1,1,2,2];
centroids = [mean([x2;x3;x5]); mean([x1;x4])];
q1_je = calcJerror(X,labels,centroids);
fprintf("The Jerror for clusters {x2,x3,x5} and {x1,x4} = "+ q1_je + "\n")

%Q3
labels = [1,1,1,2,2];
centroids = [x4; mean([x1;x2;x3;x5])];
q1_je = calcJerror(X,labels,centroids);
fprintf("The Jerror for clusters {x4} and {x1,x2,x3,x5} = "+ q1_je + "\n")

%Q4
labels = [1,1,1,2,2];
centroids = [mean([x3;x5]); mean([x1;x2;x4])];
q1_je = calcJerror(X,labels,centroids);
fprintf("The Jerror for clusters {x3,x5} and {x1,x2,x4} = "+ q1_je + "\n")


function je = calcJerror(data, labels, centroid)
je = 0;
for i = 1:length(centroid)
    centroid_related_data_points = data(find(labels == i),:);
    for j=1:size(centroid_related_data_points,1)
        sse = (data(j,1) - centroid(i,1)).^2 + (data(j,2) - centroid(i,2)).^2;
        je = je + sse;
    end
end
end