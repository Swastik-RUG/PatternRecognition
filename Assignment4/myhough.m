function [accum, theta, rho] =myhough(E)
theta = -90:90;
[x, y] = size(E);

%boundary conditions
pmax =0;
for i =1:x
    for j=1:y
        if E(i,j) ==1
            for t = 1:length(theta)
                p = floor(i*cos(theta(t)) + j*sin(theta(t)));
                if abs(p) >pmax
                    pmax = abs(p);
                end
            end
        end
    end
end

accum = zeros(2*pmax,length(theta));
for i = 1:x
    for j = 1:y
        if E(i,j) ==1
            for t = 1:length(theta)
                angle = degtorad(theta(t));
                p = floor(pmax+1 + i*cos(angle) + j*sin(angle));
                accum(p,t) = accum(p,t) +1;
            end
        end
    end
end
rho = -pmax:pmax;
end