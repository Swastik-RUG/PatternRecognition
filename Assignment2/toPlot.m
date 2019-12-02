
%fig1 = figure(1)
x = load('toPlot').toPlot;
toP = x(:,:);

%a = plot(1:1:100, toP(:,:));
%%title("Random walk of 1000000 people for 100 runs")
%ylabel("scores")
%xlabel("runs")
%saveas(fig1,'plotsave.png')

% Plot the distribution
fig1 = figure('units','normalized','outerposition',[0 0 1 1])
     set(0, 'DefaultFigureRenderer', 'opengl');
set(subplot(1,2,1))
a = plot(1:1:100, toP(:,:));
title("Random walk of 1000000 people for 100 runs")
ylabel("scores")
xlabel("runs")

set(subplot(1,2,2))
hist(toP(:,end));
histfit(toP(:,end));
title("Random walk score distribution")
ylabel("scores occurrence")
xlabel("scores")

saveas(fig1,'plotsave_2.png')