clc;
clear;
rng(100);

X = importdata('provinces.mat');
X = zscore(X);
Y = pdist(X,'Euclidean');
D = squareform(Y);
%v = D(tril(true(size(D)), -1))';
linkage_matrix = linkage(D, 'single');
labels = ["South Holland", "North Holland", "Utrecht", "Limburg", "North Brabant", "Gelderland", "Overijssel", "Flevoland", "Groningen", "Zeeland", "Friesland", "Drenthe"];

t = sort(D(9,:));
[similar, similar_indx] = find(D(9,:)==t(2));
[dissimilar, dissimilar_indx] = max(D(9,:));
fprintf("The province similar to Groningen with a dissimilarity of %f is %s \n", D(9, similar_indx), labels(similar_indx))
fprintf("The province dissimilar to Groningen with a dissimilarity of %f is %s \n", D(9, dissimilar_indx), labels(dissimilar_indx))



