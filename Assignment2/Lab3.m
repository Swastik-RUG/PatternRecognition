meanVec = [3, 4];
covariance = [1,0;0,2];
x1 = -10:1:10;
x2 = -10:1:10;
[x, y] = meshgrid(-10:1:10);
pdf = mvnpdf([x(:) y(:)], meanVec, covariance);
rpdf = reshape(pdf, length(y), length(x));
%surf(x,y,rpdf );
mesh(x, y, rpdf )
meanPdf = mean(pdf)';
% Calculating Mahalanobis distance
meanV = [3;4];
r10_10 = calcMahal(meanV, covariance, [10;10]);
fprintf("The Mahalnobis distance for point (10,10) is = %f \n", r10_10);
r0_0 = calcMahal(meanV, covariance, [0;0]);
fprintf("The Mahalnobis distance for point (0,0) is = %f \n", r0_0);
r3_4 = calcMahal(meanV, covariance, [3;4]);
fprintf("The Mahalnobis distance for point (3,4) is = %f \n", r3_4);
r6_8 = calcMahal(meanV, covariance, [6;8]);
fprintf("The Mahalnobis distance for point (6,8) is = %f \n", r6_8);

function md = calcMahal(meanVector, covariance, point)
    stdPoint = (point - meanVector);
    md = stdPoint'*inv(covariance)*stdPoint;
end

