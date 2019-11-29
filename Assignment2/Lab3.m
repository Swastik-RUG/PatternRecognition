meanVec = [3,4];
covariance = [1,0;0,2];
x1 = -10:1:10;
x2 = -10:1:10;
[x, y] = meshgrid(-10:1:10);
pdf = mvnpdf([x(:) y(:)], meanVec, covariance);
rpdf = reshape(pdf, length(y), length(x));
%surf(x,y,rpdf );
mesh(x, y, rpdf )
meanPdf = mean(pdf)';
testPoint = [10, 10];
npdf = normpdf(pdf, meanVec, covariance);
md = mahal(testPoint, pdf);
%md;

