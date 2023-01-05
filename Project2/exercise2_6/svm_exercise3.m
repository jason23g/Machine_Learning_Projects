clear all;
close all;


 C = 100; % Choose C = 0.01, 0.1, 1, 10, 100, 1000, 10000

load('./twofeature2.txt');
n = size(twofeature2, 1); 
y = twofeature2(1:n, 1);
X = twofeature2(1:n, 2:3);

% Form the augmented dataset. 
Xa = X(:,1).^2 + X(:,2).^2;
Xa = [X Xa];

Xpos = Xa(y==1, :); % positive examples
Xneg = Xa(y==-1, :); % negative examples

%  Visualize the example dataset
hold on
plot(Xpos(:, 1), Xpos(:, 2), 'b.');
plot(Xneg(:, 1), Xneg(:, 2), 'r.');
hold off
axis square;

% Form the matrices for the quadratic optimization. See the matlab manual for "quadprog"
K = Xa*Xa';

H = (y*y').*K;

f = -ones(n,1);

A = -eye(n);

b = zeros(n,1);

Aeq = y';

beq = 0;

LB = zeros(n,1);

UB = C*ones(n,1);

lambda = quadprog(H,f,A,b,Aeq,beq,LB,UB); % Find the Lagrange multipliers

indices = find(lambda > 0.0001); % Find the support vectors
Xsup = Xa(indices,:,:);% The support vectors only 
ysup = y(indices,:);
lambdasup = lambda(indices);

% Find the weights
w = sum(lambdasup.*ysup.*Xsup);

% Find the bias term w0
m = length(indices);
w0 = -(max(w*Xsup(ysup==-1, :).')+min(w*Xsup(ysup==1, :).'))/2;

% Plot support vectors
Xsup_pos = Xsup(ysup==1, :);
Xsup_neg = Xsup(ysup==-1, :);

hold on
plot(Xsup_pos(:, 1), Xsup_pos(:, 2), 'bo');
plot(Xsup_neg(:, 1), Xsup_neg(:, 2), 'ro');
hold off
title(['C = ',num2str(C)])

% Plot decision boundary
hold on
for x1 = -1:0.01:1
    for x2 = -1:0.01:1
        if (abs(w*[x1, x2, x1^2+x2^2]' + w0) < 0.01) % fill the 3rd coordinate
           plot(x1, x2, 'k.')
        end
    end
end
hold off

