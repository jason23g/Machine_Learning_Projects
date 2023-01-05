function [d_CE_d_W, d_CE_d_b] = backward(X, Y, Y_predicted)
    % your code here
    m = length(Y);
    d_CE_d_W = (1/m)*(sum((-Y+Y_predicted).*X))';
    d_CE_d_b = (1/m)*sum(-Y+Y_predicted);
