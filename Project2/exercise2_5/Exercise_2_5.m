clear all;
close all;

%% Exercise2_5 Part A
X_w1 = [3 3 5 5;1 -1 1 -1];
X_w2 = [1 0 0 -1;0 1 -1 0];

scatter(X_w1(1,:),X_w1(2,:),200,'r.');
hold on;
scatter(X_w2(1,:),X_w2(2,:),200,'b.');
hold on;
x_line = [2,2];
y_line = [-3,4];
plot(x_line,y_line,'k','LineWidth',1);
hold on;
x_line = [3,1];
y_line = [4,-3];
plot(x_line,y_line,'g','LineWidth',1);
xlim([-3 6]);
ylim([-3 4]);

%% Exercise2_5 Part B
X_w1 = [2 2 -2 -2;2 -2 -2 2];
X_w2 = [1 1 -1 -1;1 -1 -1 1];

figure();
scatter(X_w1(1,:),X_w1(2,:),200,'r.');
hold on;
scatter(X_w2(1,:),X_w2(2,:),200,'b.');
xlim([-3 6]);
ylim([-3 4]);


% After the transformation of the data

phi_w1 = X_w1 - (X_w1(1,:).^2+X_w1(2,:).^2) - 4;
phi_w2 = X_w2 - (X_w2(1,:).^2+X_w2(2,:).^2) - 4;

figure();
scatter(phi_w1(1,:),phi_w1(2,:),200,'r.');
hold on;
scatter(phi_w2(1,:),phi_w2(2,:),200,'b.');
hold on;
x_line = [-9,-9];
y_line = [-14,4];
plot(x_line,y_line,'k','LineWidth',1);
hold on;
x_line = [-14,-6];
y_line = [4,-14];
plot(x_line,y_line,'g','LineWidth',1);
