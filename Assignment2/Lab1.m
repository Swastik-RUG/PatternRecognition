feature1 = [4, 6, 8, 7, 4];
feature2 = [5, 3, 7, 4, 6];
feature3 = [ 6, 9, 3, 8, 5];

fprintf("The mean of Feature1 = %f \n", mean(feature1));
fprintf("The mean of Feature2 = %f \n", mean(feature2));
fprintf("The mean of Feature2 = %f \n", mean(feature3));
meanVector = [mean(feature1); mean(feature2); mean(feature3)]';

featureset = [feature1; feature2; feature3]';
covFeatureSet = cov(featureset);
%covFeatureSet
pd556 = mvnpdf([5,5,6], meanVector, covFeatureSet);
fprintf("The pdf for the point [5,5,6] is %f \n", pd556);
pd357 = mvnpdf([3,5,7], meanVector, covFeatureSet);
fprintf("The pdf for the point [3,5,7] is %f \n", pd357);
pf46_61 = mvnpdf([4,6.5,1], meanVector, covFeatureSet);
fprintf("The pdf for the point [4,6.5,1] is %f \n", pf46_61);
