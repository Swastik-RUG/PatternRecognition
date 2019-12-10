clear all;
close all;
w1 = load('lab3_3_cat1.mat').x_w1;
w2 = load('lab3_3_cat2.mat').x_w2;
w3 = load('lab3_3_cat3.mat').x_w3;
u = [0.5, 1.0, 0.0];
v = [0.31, 1.51, -0.50];
w = [-1.7, -1.7, -1.7];
j = 10;
i = 3;
h = 1;

figure(1)
scatter3(w1(:,1), w1(:,2), w1(:,3), 'r', 'filled')
hold on
scatter3(w2(:,1), w2(:,2), w2(:,3), 'm', 'filled')
hold on
scatter3(w3(:,1), w3(:,2), w3(:,3), 'g', 'filled')
hold on
scatter3(0.5, 1.0, 0.0, 'filled');
hold on
scatter3(0.31, 1.51, -0.50, 'filled');
hold on
scatter3(-1.7, -1.7, -1.7, 'filled');
grid on

u_w1 = computeDensity2(0.5, 1.0, 0.0, w1, 1);
v_w1 = computeDensity2(0.31, 1.51, -0.50, w1, 1);
w_w1 = computeDensity2(-1.7, -1.7, -1.7, w1, 1);

u_w2 = computeDensity2(0.5, 1.0, 0.0, w2, 1);
v_w2 = computeDensity2(0.31, 1.51, -0.50, w2, 1);
w_w2 = computeDensity2(-1.7, -1.7, -1.7, w2, 1);

u_w3 = computeDensity2(0.5, 1.0, 0.0, w3, 1);
v_w3 = computeDensity2(0.31, 1.51, -0.50, w3, 1);
w_w3 = computeDensity2(-1.7, -1.7, -1.7, w3, 1);

fprintf("--------------------------CLASS W1-------------------------- \n");
fprintf("U = [0.5, 1.0, 0.0] = %f \n", u_w1);
fprintf("V = [0.31, 1.51, -0.50] = %f \n", v_w1);
fprintf("W = [0.5, 1.0, 0.0] = %f \n", w_w1);
fprintf("--------------------------CLASS W2-------------------------- \n");
fprintf("U = [0.5, 1.0, 0.0] = %f \n", u_w2);
fprintf("V = [0.31, 1.51, -0.50] = %f \n", v_w2);
fprintf("W = [0.5, 1.0, 0.0] = %f \n", w_w2);
fprintf("--------------------------CLASS W3-------------------------- \n");
fprintf("U = [0.5, 1.0, 0.0] = %f \n", u_w3);
fprintf("V = [0.31, 1.51, -0.50] = %f \n", v_w3);
fprintf("W = [-1.7, -1.7, -1.7] = %f \n", w_w3);

w1_count = length(w1);
w2_count = length(w2);
w3_count = length(w3);
totalClassElements = w1_count + w2_count + w3_count;
p_w1 = w1_count/totalClassElements;
p_w2 = w2_count/totalClassElements;
p_w3 = w3_count/totalClassElements;
fprintf("--------------------------PRIOR PROBABILITIES-------------------------- \n");
fprintf("Prior Probabiltiy of W1 = %f \n", p_w1);
fprintf("Prior Probabiltiy of W2 = %f \n", p_w2);
fprintf("Prior Probabiltiy of W3 = %f \n", p_w3);

fprintf("--------------------------POSTERIOR PROBABILITIES-------------------------- \n");
[~, p_u_res] = max([p_w1*u_w1, p_w2*u_w2, p_w3*u_w3]);
[~, p_v_res] = max([p_w1*v_w1, p_w2*v_w2, p_w3*v_w3]);
[~, p_w_res] = max([p_w1*w_w1, p_w2*w_w2, p_w3*w_w3]);

fprintf("Posterior Probabiltiy of U with W1 = %f \n", p_w1*u_w1);
fprintf("Posterior Probabiltiy of U with W2 = %f \n", p_w2*u_w2);
fprintf("Posterior Probabiltiy of U with W3 = %f \n", p_w3*u_w3);

fprintf("Posterior Probabiltiy of V with W1 = %f \n", p_w1*v_w1);
fprintf("Posterior Probabiltiy of V with W2 = %f \n", p_w2*v_w2);
fprintf("Posterior Probabiltiy of V with W3 = %f \n", p_w3*v_w3);

fprintf("Posterior Probabiltiy of W with W1 = %f \n", p_w1*w_w1);
fprintf("Posterior Probabiltiy of W with W2 = %f \n", p_w2*w_w2);
fprintf("Posterior Probabiltiy of W with W3 = %f \n", p_w3*w_w3);

fprintf("--------------------------CLASSIFICATION-------------------------- \n");
fprintf("The Vector U belongs to class W%d\n", p_u_res);
fprintf("The Vector V belongs to class W%d\n", p_v_res);
fprintf("The Vector W belongs to class W%d\n", p_w_res);

fprintf("--------------------------CLASSIFICATION H=2-------------------------- \n");

u_w1_h2 = computeDensity(0.5, 1.0, 0.0, w1, 2);
v_w1_h2 = computeDensity(0.31, 1.51, -0.50, w1, 2);
w_w1_h2 = computeDensity(-1.7, -1.7, -1.7, w1, 2);

u_w2_h2 = computeDensity(0.5, 1.0, 0.0, w2, 2);
v_w2_h2 = computeDensity(0.31, 1.51, -0.50, w2, 2);
w_w2_h2 = computeDensity(-1.7, -1.7, -1.7, w2, 2);

u_w3_h2 = computeDensity(0.5, 1.0, 0.0, w3, 2);
v_w3_h2 = computeDensity(0.31, 1.51, -0.50, w3, 2);
w_w3_h2 = computeDensity(-1.7, -1.7, -1.7, w3, 2);

fprintf("--------------------------POSTERIOR PROBABILITIES-------------------------- \n");
[~, p_u_res_h2] = max([p_w1*u_w1_h2, p_w2*u_w2_h2, p_w3*u_w3_h2]);
[~, p_v_res_h2] = max([p_w1*v_w1_h2, p_w2*v_w2_h2, p_w3*v_w3_h2]);
[~, p_w_res_h2] = max([p_w1*w_w1_h2, p_w2*w_w2_h2, p_w3*w_w3_h2]);

fprintf("Posterior Probabiltiy of U with W1 = %f \n", p_w1*u_w1_h2);
fprintf("Posterior Probabiltiy of U with W2 = %f \n", p_w2*u_w2_h2);
fprintf("Posterior Probabiltiy of U with W3 = %f \n", p_w3*u_w3_h2);

fprintf("Posterior Probabiltiy of V with W1 = %f \n", p_w1*v_w1_h2);
fprintf("Posterior Probabiltiy of V with W2 = %f \n", p_w2*v_w2_h2);
fprintf("Posterior Probabiltiy of V with W3 = %f \n", p_w3*v_w3_h2);

fprintf("Posterior Probabiltiy of W with W1 = %f \n", p_w1*w_w1_h2);
fprintf("Posterior Probabiltiy of W with W2 = %f \n", p_w2*w_w2_h2);
fprintf("Posterior Probabiltiy of W with W3 = %f \n", p_w3*w_w3_h2);

fprintf("--------------------------CLASSIFICATION-------------------------- \n");
fprintf("The Vector U belongs to class W%d\n", p_u_res_h2);
fprintf("The Vector V belongs to class W%d\n", p_v_res_h2);
fprintf("The Vector W belongs to class W%d\n", p_w_res_h2);

exercise3_knn();

function res = computeDensity(u, v, w, X, h)
    tmpRes = 0;
    normalizationFactor = (h*sqrt(2*pi)).^3;
    for j = 1:10
        ux = (u-X(j,1)).^2;
        vx = (v-X(j,2)).^2;
        wx = (w-X(j,3)).^2;
        tmpRes = tmpRes + exp(-0.5*((ux+vx+wx)/(h.^2)));
    end
    tmpRes = tmpRes/normalizationFactor;
    res = tmpRes/10;
end

function res = computeDensity2(u, v, w, X, h)
    tmpRes = 0;
    normalizationFactor = (h*sqrt(2*pi)).^3;
    for j = 1:length(X)
        ux = (u-X(j,1)).^2;
        vx = (v-X(j,2)).^2;
        wx = (w-X(j,3)).^2;
        tmpRes = tmpRes + exp(-1*((ux+vx+wx)/(2*(h.^2))));
    end
    tmpRes = tmpRes/normalizationFactor;
    res = tmpRes/length(X);
end

