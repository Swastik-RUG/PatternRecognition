%plotting the normal distribution graphs

mean1 = 5;
mean2 = 7;
std = 2;

val1 = mean1 -4*std:1:mean1+4*std;
val2 = mean2 -4*std:1:mean2+4*std;

res1 = normpdf(val1,mean1,std);
res2 = normpdf(val2,mean2,std);
figure
plot(val1,res1,'-',val2,res2,'-.',10,res1,'*')
area1 = trapz(val1(val1>=10),val1(val1>=10));
area2 = trapz(val2(val2>=10),val2(val2>=10));
