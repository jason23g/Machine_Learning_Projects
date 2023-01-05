function v = fisherLinearDiscriminant(X1, X2)

    m1 = size(X1, 1);
    m2 = size(X2, 1);

    mu1 = mean(X1);% mean value of X1
    mu2 = mean(X2);% mean value of X2

   S1 = ((X1-mu1).')*(X1-mu1);% scatter matrix of X1
   S2 = ((X2-mu2).')*(X2-mu2);% scatter matrix of X2

    
    P1 = m1./(m1+m2);% Probability of X1
    P2 = m2./(m1+m2);% Probability of X2

    Sw = (P1.*S1+P2.*S2);% Within class scatter matrix

    v = (inv(Sw))*((mu1-mu2).');% optimal direction for maximum class separation 

    v = (v)./(norm(v));% return a vector of unit norm

end