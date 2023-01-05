function y = forward(x, W, b)
    % your code here
    
    f = x*W+b;
    
    y = sigmoid(f);
    
