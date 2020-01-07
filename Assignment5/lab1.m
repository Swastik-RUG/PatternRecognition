%loading the data
a = load('data_lvq_A(1).mat');
b = load('data_lvq_B(1).mat');
id = "S4151968";
matA = a.matA;
matB = b.matB;
data = matA+matB;
figure(1);
hold on;
scatter(matA(:,1),matA(:,2),'b', 'filled');
scatter(matB(:,1),matB(:,2),'g', 'filled');
legend('class A','class B');
title('Scatter Plot of Data ['+id+']');
% -------------------------------

array1 = zeros(length(matA));
array2 = ones(length(matB));
A = [matA array1];
B = [matB array2];
training_data = [A;B];

rng(100);
training_data = training_data(randperm(length(training_data)),:);

%prototypes for 1-1,1-2,2-1,2-2
prototypes_arr1 = [A(randi(length(A)), :)];
prototypes_arr1 = [prototypes_arr1 ; B(randi(length(B)), :)];
prototypes_arr2 = [A(randi(length(A)), :)];
prototypes_arr2 = [prototypes_arr2 ; B(randi(length(B)), :); B(randi(length(B)), :)];
prototypes_arr3 = [A(randi(length(A)), :); A(randi(length(A)),:)]; 
prototypes_arr3 = [prototypes_arr3 ; B(randi(length(B)), :)];
prototypes_arr4 = [A(randi(length(A)), :); A(randi(length(A)),:)]; 
prototypes_arr4 = [prototypes_arr4 ; B(randi(length(B)), :); B(randi(length(B)), :)];


dispgraph(prototypes_arr1,'1-1',training_data,1);
dispgraph(prototypes_arr2,'1-2',training_data,2);
dispgraph(prototypes_arr3,'2-1',training_data,3);
dispgraph(prototypes_arr4,'2-2',training_data,4);

function dispgraph(prototypes_arr, plot_name, training_data, plot_no)
epochs =25;
learning_rate = 0.01;
id = "S4035593";
wstar_arr = prototypes_arr(:,1:2);
wstar_labels = prototypes_arr(:,3);
error =[];
col =[];

for i=1:epochs
    misclassified = 0;
    for j=1:length(training_data)
        distance =[];
        x = training_data(j,1:2);
        y = training_data(j,3);
        distance = pdist2(x,wstar_arr(:,1:2), 'squaredeuclidean');
        [m,index] = min(distance);
        wstar =wstar_arr(index,:);
        wstar_label = wstar_labels(index);
        wstar_arr(index,:)=wstar + learning_rate *Psi_function(wstar_label,y) *(x-wstar);
        if(Psi_function(wstar_label,y) == -1)
            misclassified = misclassified + 1;
        end
    end
    error = [error; misclassified/length(training_data)];
end
%Displaying the error curve for each prototypes
figure(2);
subplot(2,2,plot_no);
plot(1:epochs,error);
title(strcat('Error curve '+"["+id+"]"',plot_name));
xlabel('Epochs');
ylabel('Error');

for j = 1:length(training_data)
    distances =[];
    x = training_data(j,1:2);
    y = training_data(j,3);
    distances = pdist2(x,wstar_arr(:,1:2), 'squaredeuclidean');
    [m index] = min(distances);
    if(wstar_labels(index)==0)
        col = [col; [0,1,0]];
    else
        col = [col;[0,0,1]];
    end
end
%Scatter curve for each prototypes
 figure(3)
 subplot(2,2,plot_no);
 gscatter(training_data(:,1), training_data(:,2),col);
 hold on;
 for p=1:size(wstar_arr,1)
    plot(wstar_arr(p,1), wstar_arr(p,2), "*",'MarkerSize',16);
    hold on
end
 title(strcat('Scatter Curve '+"["+id+"]"', plot_name));
 legend("Dataset B","Dataset A","Prototype-C1-A", "Prototype-C1-B", "Prototype-C2-A", "Prototype-C2-B");
end


function sign = Psi_function(y_pred, y_true)
if y_pred == y_true
    sign = 1;
else
    sign = -1;
end
end
