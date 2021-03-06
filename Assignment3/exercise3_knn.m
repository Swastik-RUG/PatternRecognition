function exKn = exercise3_knn()
w1 = load('lab3_3_cat1.mat').x_w1;
w2 = load('lab3_3_cat2.mat').x_w2;
w3 = load('lab3_3_cat3.mat').x_w3;
u = [0.5, 1.0, 0.0];
v = [0.31, 1.51, -0.50];
w = [-1.7, -1.7, -1.7];
nr_of_classes = 3;
train = [w1;w2;w3];
class_labels = floor( (0:length(train)-1) * nr_of_classes / length(train));
KNN_U_k1 = KNN(u, 1, train, class_labels);
KNN_V_k1 = KNN(v, 1, train, class_labels);
KNN_W_k1 = KNN(w, 1, train, class_labels);
KNN_U_k5 = KNN(u, 5, train, class_labels);
KNN_V_k5 = KNN(v, 5, train, class_labels);
KNN_W_k5 = KNN(w, 5, train, class_labels);
fprintf("----------------------------KNN EXERCISE 3--------------------------------------\n");
fprintf("The vector u = [0.5, 1.0, 0.0] for K = 1 belongs to Class W%d \n", KNN_U_k1+1);
fprintf("The vector v = [0.31, 1.51, -0.50] for K = 1 belongs to Class W%d \n", KNN_V_k1+1);
fprintf("The vector w = [-1.7, -1.7, -1.7] for K = 1 belongs to Class W%d \n", KNN_W_k1+1);
fprintf("The vector u = [0.5, 1.0, 0.0] for K = 5 belongs to Class W%d \n", KNN_U_k5+1);
fprintf("The vector v = [0.31, 1.51, -0.50] for K = 5 belongs to Class W%d \n", KNN_V_k5+1);
fprintf("The vector w = [-1.7, -1.7, -1.7] for K = 5 belongs to Class W%d \n", KNN_W_k5+1);
fprintf("----------------------------------------------------------------------------\n");
end
