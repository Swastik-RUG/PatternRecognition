people = 1000000;
n = 100;
x = 1:1:n;
res = {};
scores = {};
for k = 1: people
    y = [];
    y(1) = 0.0;
    s = 0;
    for i =2:n
        flip = randi(2);
        if(flip==1)
           y(i) = y(i-1) + 1.0;
        else
            y(i) = y(i-1);
        end
    end
    res = [res; y];
    %line(x, y, 'color', rand(1,3)); 
    scores = [scores; y(end)];
end
figure(1)
plot(1:1:n, res, 'r');
fprintf("The mean of Scores = %f", mean(cell2mat(scores)));
fprintf("The variance of scores = %f", var(cell2mat(scores)));


