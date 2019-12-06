people = 1000000;
n = 100;
x = 1:1:n;
res = {};
scores = {};
parfor k = 1: people
    y = [];
    w = randi([0,1],1,n);
    for i =2:n
        w(i) = w(i) + w(i-1);
    end
    k
    res = [res; w];
    scores = [scores; w(end)];
end
figure(1)
toPlot = cell2mat(res);
plot(1:1:n, toPlot(:,:));
title("Random walk of 1000000 people for 100 runs")
ylabel("scores")
xlabel("runs")
fprintf("The mean of Scores = %f\n", mean(cell2mat(scores)));
fprintf("The variance of scores = %f\n", var(cell2mat(scores)));


