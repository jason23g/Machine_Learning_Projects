function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA
    
	[NumSamples NumFeatures] = size(Samples);
    
    A=zeros(NumFeatures,NewDim);
   
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes); %The number of classes

%     Sw = zeros(NumClasses); % Initialization of Within Class Scatter Matrix
%     m0 = 0;
    %For  each class i
	%Find the necessary statistics
    Sw = zeros(NumFeatures);
    m0 = zeros(NumClasses,NumFeatures);
    Sb = zeros(NumFeatures);
    
    for i=1:NumClasses
        
    class = (Labels == i - 1);
    SamplesOfClass =Samples(class,:);
    
    %Calculate the Class Prior Probability
	P(i)= (size(class,1))/NumSamples;
    %Calculate the Class Mean 
	mu(i,:) = mean(SamplesOfClass);
    Z  = SamplesOfClass;
   
    Cov_class = (((Z-mu(i,:)).')* (Z-mu(i,:)))*(1/size(class,1));
    
    Sw =Sw + P(i).*Cov_class;
    
    m0= m0 + P(i).*mu(i,:);
    
    Sb = Sb + P(i).*(((mu(i,:)-m0).')*(mu(i,:)-m0));
    
    end
    
  
    EigMat = inv(Sw)*Sb;
    
    %Perform Eigendecomposition
    [V,D] = eig(EigMat);
    V
    D
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	A=V(:,1:NewDim) % Return the LDA projection vectors
end