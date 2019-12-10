mean1 =2.75;
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
scatter(0.1, 0.8)
hold on
plot(falsealarms,hitrates);
title('ROC');
ylabel('True Positive rate');
xlabel('False Positive rate');