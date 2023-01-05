
clear all;
close all;

P1 = [0.1 0.25 0.5 0.75 0.9];
P2 = 1 - P1;

S1 = [1.2 -0.4;-0.4 1.2];
S2 = [1.2 0.4;0.4 1.2];

Determinan_S1 = 1.28;
Determinan_S2 = 1.28;

mu1 = [3 3];
mu2 = [6 6];

DT = 0.01;
x1 = [-6:DT:10];
x2 = [-6:DT:10];
[X1,X2]=meshgrid(x1,x2);


X =[X1(:) X2(:)];

p_x_given_w1 = mvnpdf(X,mu1,S1);
p_x_given_w2 = mvnpdf(X,mu2,S2);


P_x_given_w1 = reshape(p_x_given_w1,length(x1),length(x2));
P_x_given_w2 = reshape(p_x_given_w2,length(x1),length(x2));

figure(1)
contour(X1,X2,P_x_given_w1,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);
hold on;
contour(X1,X2,P_x_given_w2,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);


color (1) = 'g';
color (2) = 'b';
color (3) = 'r';
color (4) = 'k';
color (5) = 'm';
i = 1;
for P1 = [0.1 0.25 0.5 0.75 0.9]
    P2 =  1 - P1;
    
    hold on;
    syms x_1 x_2 y;
    
    y = x_1*x_2 - (18 + 1.6*log(P1/P2));
    
    ez = ezplot(y,[-6 10]);
    title(['Decision Boundary for different covariance matrices'])
    set (ez , 'Color',color(i));
    i = i +1;
    legend('P_{x given \omega_{1} }','P_{x given \omega_{2}}','P\omega_{1} = 0.1','P\omega_{1} = 0.25','P\omega_{1} = 0.5','P\omega_{1} = 0.75','P\omega_{1} = 0.9','Location','northwest');
end

hold off;


clear all;

S2 = [1.2 0.4;0.4 1.2];
S1 = [1.2 0.4;0.4 1.2];

Determinan_S1 = 1.28;
Determinan_S2 = 1.28;

mu1 = [3 3];
mu2 = [6 6];

DT = 0.01;
x1 = [-6:DT:10];
x2 = [-6:DT:10];
[X1,X2]=meshgrid(x1,x2);


X =[X1(:) X2(:)];

p_x_given_w1 = mvnpdf(X,mu1,S1);
p_x_given_w2 = mvnpdf(X,mu2,S2);


P_x_given_w1 = reshape(p_x_given_w1,length(x1),length(x2));
P_x_given_w2 = reshape(p_x_given_w2,length(x1),length(x2));

figure(2)
contour(X1,X2,P_x_given_w1,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);
hold on;
contour(X1,X2,P_x_given_w2,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);



color (1) = 'g';
color (2) = 'b';
color (3) = 'r';
color (4) = 'k';
color (5) = 'm';
i = 1;
for P1 = [0.1 0.25 0.5 0.75 0.9]
    P2 =  1 - P1;
    
    hold on;
    syms x_1 x_2 y;
    
    y = x_1 + x_2 - (9 + 0.533*log(P1/P2));
    
    ez = ezplot(y,[-6 10]);
    title(['Decision Boundary for same covariance matrices'])
    set (ez , 'Color',color(i));
    i = i +1;
    legend('P_{x given \omega_{1} }','P_{x given \omega_{2}}','P\omega_{1} = 0.1','P\omega_{1} = 0.25','P\omega_{1} = 0.5','P\omega_{1} = 0.75','P\omega_{1} = 0.9','Location','northwest');
end

hold off;

