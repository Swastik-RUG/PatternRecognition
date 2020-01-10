clear all;
close all;
load lab3_2.mat;

K=1;
samples=64;
data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );
% Sample the parameter space
result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    result(j,i) = KNN([X Y],K,data,class_labels);
  end;
end;

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');

KNN_wrapper(1, data, class_labels, 2, "K=1;CLASS=2");
KNN_wrapper(3, data, class_labels, 2, "K=3;CLASS=2");
KNN_wrapper(5, data, class_labels, 2, "K=5;CLASS=2");
KNN_wrapper(7, data, class_labels, 2, "K=7;CLASS=2");

LOOCV_k1 = computeLOOCV(data, 1, class_labels);
LOOCV_k3 = computeLOOCV(data, 3, class_labels);
LOOCV_k5 = computeLOOCV(data, 5, class_labels);
LOOCV_k7 = computeLOOCV(data, 7, class_labels);
LOOCV_k8 = computeLOOCV(data, 8, class_labels);
LOOCV_k17 = computeLOOCV(data, 17, class_labels);
fprintf("--------------------------LOOCV-CLASS=2---------------------------------\n");
%fprintf("The LOOCV error rate for K=1 is = %f \n", LOOCV_k1)
fprintf("The LOOCV error rate for K=3 is = %f \n", LOOCV_k3)
%fprintf("The LOOCV error rate for K=5 is = %f \n", LOOCV_k5)
%fprintf("The LOOCV error rate for K=7 is = %f \n", LOOCV_k7)
fprintf("The LOOCV error rate for K=8 is = %f \n", LOOCV_k8)
fprintf("The LOOCV error rate for K=17 is = %f \n", LOOCV_k17)

crossValdRes = [];
for i=1:20
    crossValdRes(i) = computeLOOCV(data, i, class_labels);
end

figure('NumberTitle', 'off', 'Name', 'LOOCV for K=1-to-20; no of Class=2')
plot(1:1:20, crossValdRes, 'b-o');
title("LOOCV Missclassification plot K = 1-to-20; No-of-classes=2");
xlabel("Number of Neighbors K");
ylabel("classification error");
xticks(1:1:20);


fprintf("----------------------------------------------------------------\n");
fprintf("--------------------------4 CLASSES-----------------------------\n");
fprintf("--------------------------4 CLASSES KNN PLOTS-------------------\n");
class_labels_4 = floor( (0:length(data)-1) * 4 / length(data) );
KNN_wrapper(1, data, class_labels_4, 4, "K=1;CLASS=4");
KNN_wrapper(3, data, class_labels_4, 4, "K=3;CLASS=4");
KNN_wrapper(5, data, class_labels_4, 4, "K=5;CLASS=4");
KNN_wrapper(7, data, class_labels_4, 4, "K=7;CLASS=4");
fprintf("--------------------------4 CLASSES LOOCV-------------------\n");
LOOCV_k1_C4 = computeLOOCV(data, 1, class_labels_4);
LOOCV_k3_C4 = computeLOOCV(data, 3, class_labels_4);
LOOCV_k5_C4 = computeLOOCV(data, 5, class_labels_4);
LOOCV_k7_C4 = computeLOOCV(data, 7, class_labels_4);
fprintf("The LOOCV error rate for K=1 is = %f \n", LOOCV_k1_C4)
fprintf("The LOOCV error rate for K=3 is = %f \n", LOOCV_k3_C4)
fprintf("The LOOCV error rate for K=5 is = %f \n", LOOCV_k5_C4)
fprintf("The LOOCV error rate for K=7 is = %f \n", LOOCV_k7_C4)

crossValdRes_C4 = [];
for i=1:20
    crossValdRes_C4(i) = computeLOOCV(data, i, class_labels_4);
end
figure('NumberTitle', 'off', 'Name', 'LOOCV for K=1-to-20; no of Class=4')
plot(1:1:20, crossValdRes_C4, 'r-o');
title("LOOCV Missclassification plot K = 1-to-20; No-of-classes=4");
xlabel("Number of Neighbors K");
ylabel("classification error");
xticks(1:1:20);



function result = KNN_wrapper(K, data, classLabels, nr_of_classes, fig)
    samples=64;
    result=zeros(samples);
    for i=1:samples
      X=(i-1/2)/samples;
      for j=1:samples
        Y=(j-1/2)/samples;
        result(j,i) = KNN([X Y],K,data,classLabels);
      end
    end

    % Show the results in a figure
    figure('NumberTitle', 'off', 'Name', fig);
    imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
    hold on;
    title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

    % this is only correct for the first question
    scaled_data=samples*data;
    if nr_of_classes==4
        plot(scaled_data(  1:50,1),scaled_data(  1:50,2),'go');
        plot(scaled_data(  51:100,1),scaled_data(  51:100,2),'b*');
        plot(scaled_data(  101:150,1),scaled_data(  101:150,2),'r+');
        plot(scaled_data(151:200,1),scaled_data(151:200,2),'cO');
    else
        plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
        plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');
    end
end


function error = computeLOOCV(data, k, labelsOrig)
    errors = [];
    for i=1:length(data)
        test = data(i,:);
        train = data;
        train(i,:) = [];
        labels = labelsOrig;
        labels(i)=[];
        classification = KNN(test, k, train, labels);
        if classification == labelsOrig(i)
            errors(i) = 0;
        else
            errors(i) = 1;
        end
    end
    error = sum(errors)/numel(errors);
end