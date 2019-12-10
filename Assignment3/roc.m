mean1 =5;
sigma =2;
mean2 =7;

hitrates =[];
falsealarms=[];
for i =0:0.1:10
    hitrates = [hitrates 1 - normcdf(i,mean2,sigma)];
    falsealarms = [falsealarms 1 - normcdf(i,mean1,sigma)];
end
hitrates(102)=0;
falsealarms(102)=0;
scatter(0.2903, 0.5207)
plot(falsealarms,hitrates);
title('ROC');
ylabel('True Positive rate');
xlabel('False Positive rate');