function ce = cross_entropy(Y, Y_predicted)
    % your code here
    
    B = length(Y);
    ce = (1/B)*sum(-Y.*log(Y_predicted)-(1-Y).*log(1-Y_predicted));
