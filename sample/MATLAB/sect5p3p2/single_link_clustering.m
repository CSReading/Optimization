% "Statistics and Machine Learning Toolbox" is required.
load('data_X.mat');

Z = linkage(X, 'single', 'euclidean');

set(gcf,'defaultAxesFontSize',14);
set(gcf,'defaultAxesFontName','times');
plot(X(:,1), X(:,2), 'b^', 'LineWidth',1);
hold on;
axis equal;
ylim([min(X(:,2))-2.0, max(X(:,2))+2.0]);

figure;
set(gcf,'defaultAxesFontSize',14);
set(gcf,'defaultAxesFontName','times');
H = dendrogram(Z,'Orientation','right');
hold on;
set(H, 'LineWidth',1.5);
