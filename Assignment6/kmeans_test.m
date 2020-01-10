data = load("data/kmeans1.mat");
data = cell2mat(struct2cell(data));
max_epochs = 1000;
x = kmeans(data,2,max_epochs);
x