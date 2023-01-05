close all;
clear;
clc;

data_file = './data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');


%% Compute Aspect Ratio
aRatios = zeros((size(train_C1_images,1)+ size(train_C2_images,1)+size(test_C1_images,1)+size(test_C2_images,1)), 1);

%The aspect ratio of image of digit 1 for train set
for k = 1:size(train_C1_images)
image = reshape(train_C1_images(k,:,:),28,28);
[aRatio,BoundingBox] = computeAspectRatio(image);

if(k == 3000)
    figure(1);
    imshow(image)
    rectangle('Position',BoundingBox,'EdgeColor','r');
   
end

aRatios(k,1) = aRatio;
end




%The aspect ratio of image of digit 2  for train set
for j = 1:size(train_C2_images)
image = reshape(train_C2_images(j,:,:),28,28);
[aRatio,BoundingBox] = computeAspectRatio(image);
aRatios(j + k ,1) = aRatio;
end

figure(2);
imshow(image)
rectangle('Position',BoundingBox,'EdgeColor','r');

%The aspect ratio of image of digit 1 for test set
for i = 1:size(test_C1_images)
image = reshape(test_C1_images(i,:,:),28,28);
[aRatio,BoundingBox] = computeAspectRatio(image);
aRatios(i+j+k,1) = aRatio;
end



%The aspect ratio of image of digit 2  for test set
for m = 1:size(test_C2_images)
image = reshape(test_C2_images(m,:,:),28,28);
[aRatio,BoundingBox] = computeAspectRatio(image);
aRatios(m+i+j + k ,1) = aRatio;
end

% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)

minAspectRatio = min(aRatios)
maxAspectRatio = max(aRatios)

% Prior Probabilities

C1_train_set_size =size(train_C1_images,1);
C1_test_set_size =size(test_C1_images,1);
C2_train_set_size =size(train_C2_images,1);
C2_test_set_size =size(test_C2_images,1);

N = C1_train_set_size + C2_train_set_size;

PC1 = (C1_train_set_size)/N;
PC2 = (C2_train_set_size)/N;

% Bayesian Classifier

%Computation of the mean values of the training sets and their' s
%covariance values

m1 = (1/C1_train_set_size)*sum(aRatios(1:C1_train_set_size));
s1 = sqrt((1/C1_train_set_size)*sum((aRatios(1:C1_train_set_size) - m1).^(2)));
offset = C1_train_set_size + C2_train_set_size;
m2 = (1/C2_train_set_size)*sum(aRatios(C1_train_set_size+1:offset,1));
s2 = sqrt((1/C2_train_set_size)*sum((aRatios(C1_train_set_size+1:offset) - m2).^(2)));

index_test = [C1_train_set_size + C2_train_set_size+1: C1_train_set_size + C2_train_set_size+C1_test_set_size+C2_test_set_size];
index_train = [1:C1_train_set_size + C2_train_set_size];
% Likelihoods
P_given_C1 = 1/sqrt(2*pi*(s1.^2)) * exp((-(aRatios(index_test,1)-m1).^2)/(2*(s1.^2)));
P_given_C2 = 1/sqrt(2*pi*(s2.^2)) * exp((-(aRatios(index_test,1)-m2).^2)/(2*(s2.^2)));

% Posterior Probabilities
P_x = P_given_C1.*PC1 + P_given_C2.*PC2;
P_C1_given = (P_given_C1*PC1)./(P_x);
P_C2_given = (P_given_C2*PC2)./(P_x);

% Classification result

for i = 1:size(P_C1_given)
    
    if( P_C1_given(i) > P_C2_given(i))
    
        BayesClass(i) = 1;
    else
        BayesClass(i) = 2;
    end
    
end

% Count misclassified digits
Test_indices = [test_C1_indices test_C2_indices];
Bayes_indices_C1 = find(BayesClass == 1);
Bayes_indices_C2 = find(BayesClass == 2);
Bayes_indices = [Bayes_indices_C1 , Bayes_indices_C2];

count_errors = 0;

for i = 1:length(BayesClass)
    
    if(data.testY(Test_indices(i)) ~= BayesClass(i))
        count_errors = count_errors + 1;
    end
    
end


% Total Classification Error (percentage)
Error = (count_errors/size(BayesClass,2))*100;


