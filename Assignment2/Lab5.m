x1 = -10:1:20;
F = -8.81887145067;
y1 = [];
y2 = [];
for i=1:length(x1)
    x = x1(i);
    a = 2*(x*x)-16*x+8*F;
    tmp = sqrt(4 - 12*a)/(2*a);
    y1(i) = 2+tmp;
    y2(i) = 2-tmp;
end
%txt1 = ['x2 = 2+sqrt(4-12*2*(x*x)-16*x+8*-8.8188)/(2*2*(x*x)-16*x+8*-8.8188)'];

figure(1)
subplot(2,1,1)
a = plot(x1, real(y1), 'b.-');
title("x2 = 2+sqrt(4-12*2*(x*x)-16*x+8*-8.8188)/(2*2*(x*x)-16*x+8*-8.8188)")
hold on;
subplot(2,1,2)
b = plot(x1, real(y2), 'r.-');
title("x2 = 2-sqrt(4-12*2*(x*x)-16*x+8*-8.8188)/(2*2*(x*x)-16*x+8*-8.8188)")
