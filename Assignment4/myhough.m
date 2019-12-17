function [hc, th, rh] =myhough(E)
[x, y] = size(E);
distMax = round(sqrt(x^2+y^2));
theta = -90:1:90;
rho = -distMax:1:distMax;

H = zeros(length(rho),length(theta));
for i =1:x
    for j=1:y
        if E(i,j) ~= 0
            for itheta = 1:length(theta)
                t = theta(itheta)*pi/180;
                dist = j*cos(t)+ i*sin(t);
                [d, irho] = min(abs(rho-dist));
                if d<=1
                    H(irho,itheta) = H(irho,itheta)+1;
                end
            end
        end
    end
end
hc = H;
th = theta;
rh = rho;
end