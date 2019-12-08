clear all;
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

%CV
% Split the training data into 20 splits.
split_data = {};
split_label = {};
for i=1:20
    index = 1+10*(i-1);
    split_data = [split_data; data(index: index+10-1)];
    split_label = [split_label; class_labels(index: index+10-1)];
end

LOOCV_k1 = computeLOOCV(data, 1, class_labels);
LOOCV_k3 = computeLOOCV(data, 3, class_labels);
LOOCV_k5 = computeLOOCV(data, 5, class_labels);
LOOCV_k7 = computeLOOCV(data, 7, class_labels);
fprintf("--------------------------LOOCV---------------------------------\n");
fprintf("The LOOCV error rate for K=1 is = %f \n", LOOCV_k1)
fprintf("The LOOCV error rate for K=3 is = %f \n", LOOCV_k3)
fprintf("The LOOCV error rate for K=5 is = %f \n", LOOCV_k5)
fprintf("The LOOCV error rate for K=7 is = %f \n", LOOCV_k7)
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
    plot(scaled_data(  1:50,1),scaled_data(  1:50,2),'go');
    plot(scaled_data(  51:100,1),scaled_data(  51:100,2),'b*');
    plot(scaled_data(  101:150,1),scaled_data(  101:150,2),'r+');
    plot(scaled_data(151:200,1),scaled_data(151:200,2),'cO');
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


% function res = KNN(t_data, k, data, labels)
%     predicted_labels=zeros(size(t_data,1),1);
%     ed=zeros(size(t_data,1),size(data,1)); %ed: (MxN) euclidean distances
%     ind=zeros(size(t_data,1),size(data,1)); %corresponding indices (MxN)
%     k_nn=zeros(size(t_data,1),k); %k-nearest neighbors for testing sample (Mxk)
%     %calc euclidean distances between each testing data point and the training
%     %data samples
%     for test_point=1:size(t_data,1)
%         for train_point=1:size(data,1)
%             %calc and store sorted euclidean distances with corresponding indices
%             ed(test_point,train_point)=sqrt(sum((t_data(test_point,:)-data(train_point,:)).^2));
%         end
%         [ed(test_point,:),ind(test_point,:)]=sort(ed(test_point,:));
%     end
% 
%     %find the nearest k for each data point of the testing data
%     k_nn=ind(:,1:k);
%     nn_index=k_nn(:,1);
%     %get the majority vote
%     for i=1:size(k_nn,1)
%         options=unique(labels(k_nn(i,:)'));
%         max_count=0;
%         max_label=0;
%         for j=1:length(options)
%             L=length(find(labels(k_nn(i,:)')==options(j)));
%             if L>max_count
%                 max_label=options(j);
%                 max_count=L;
%             end
%         end
%         predicted_labels(i)=max_label;
%     end
%     res = predicted_labels;
% end