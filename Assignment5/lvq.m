%loading the data
a = load('data_lvq_A(1).mat');
b = load('data_lvq_B(1).mat');
matA = a.matA;
matB = b.matB;

mylvq(matA,matB,25,0.01);


function res = mylvq(data1,data2,epochs,learning_rate)
array1 = zeros(length(data1));
array2 = ones(length(data2));
A = [data1 array1];
B = [data2 array2];
training_data = [A;B];

rng(1);
training_data = training_data(randperm(length(training_data)),:);

%setting the epochs and learning rate
epochs =epochs;
learning_rate = learning_rate;

%creating prototypes
prototypes_arr = [A(randi(length(A)), :); A(randi(length(A)),:)];
prototypes_arr = [prototypes_arr ; B(randi(length(B)), :)];
%wstar is initialized from the data
wstar_arr = prototypes_arr(:,1:2);
wstar_labels = prototypes_arr(:,3);
error =[];

for i=1:epochs
    misclassified = 0;
    for j=1:length(training_data)
        distance =[];
        x = training_data(j,1:2);
        y = training_data(j,3);
        for k = 1:length(wstar_arr)
            distance = [distance ; pdist2(x,wstar_arr(k,:), 'squaredeuclidean')];
        end
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
%displaying the plot
figure(1);
plot(1:epochs,error);
title('Error Curve');
xlabel('Epochs');
ylabel('Error');

end


function sign = Psi_function(y_pred, y_true)
if y_pred == y_true
    sign = 1;
else
    sign = -1;
end
end

