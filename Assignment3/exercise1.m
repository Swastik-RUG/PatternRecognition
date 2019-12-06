%plotting the normal distribution graphs

mean1 = 5;
mean2 = 7;
std = 2;

val1 = mean1 -4*std:1:mean1+4*std;
val2 = mean2 -4*std:1:mean2+4*std;

res = normpdf(val1,mean1,std);