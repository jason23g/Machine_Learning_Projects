clear all;
close all;

load('digits');

%A = zeros(500,28,28);
B = zeros(28,28);
Y = ones(748,1);
Y = find(Y);
for i = 1:500
    A = reshape(train9(i,:),28,28);
    for j =1:28
        for k=1:28
           
            B(k,j) = A(j,k)+B(k,j);
        end
    end
end

B = B/500;
imagesc(B);
colorbar

%% Training Models for every Digit using ML Estimator Based on training Set


train = {train0,train1,train2,train3,train4,train5,train6,train7,train8,train9};
train_probability = zeros(10,784);

for index = 1:numel(train)
    tr = train{index};
    train_probability(index,:) = mean(tr);
    subplot(2,5,index);
    imagesc(reshape(mean(tr),28,28)');
    colorbar
end
%% Naive Bayes Classifier
e = 0.0000001;

confusion_matrix = zeros(10,10);

for i = 1:10
    for j = 1:784
        
        if(train_probability(i,j) == 0)
            train_probability(i,j) = e;
        end
    end
end

test = {test0,test1,test2,test3,test4,test5,test6,test7,test8,test9};
classification_accuracy = 0;

 for index = 1:numel(test)
    
     for i = 1:500
    
        test_data = test{index};
       
        Digit0_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(1,:))) + sum((1-test_data(i,:)).*log(1-train_probability(1,:))));
        Digit1_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(2,:))) + sum((1-test_data(i,:)).*log(1-train_probability(2,:))));
        Digit2_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(3,:))) + sum((1-test_data(i,:)).*log(1-train_probability(3,:))));
        Digit3_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(4,:))) + sum((1-test_data(i,:)).*log(1-train_probability(4,:))));
        Digit4_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(5,:))) + sum((1-test_data(i,:)).*log(1-train_probability(5,:))));
        Digit5_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(6,:))) + sum((1-test_data(i,:)).*log(1-train_probability(6,:))));
        Digit6_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(7,:))) + sum((1-test_data(i,:)).*log(1-train_probability(7,:))));
        Digit7_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(8,:))) + sum((1-test_data(i,:)).*log(1-train_probability(8,:))));
        Digit8_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(9,:))) + sum((1-test_data(i,:)).*log(1-train_probability(9,:))));
        Digit9_prob = (1/10)*(sum(test_data(i,:).*log(train_probability(10,:))) + sum((1-test_data(i,:)).*log(1-train_probability(10,:))));
        
       Digits_prob = [Digit0_prob Digit1_prob Digit2_prob Digit3_prob Digit4_prob Digit5_prob Digit6_prob Digit7_prob Digit8_prob Digit9_prob];
                           
       predict_digit = max(Digits_prob);
       digit = find(predict_digit == Digits_prob);                   
        
        if(digit == index)
            classification_accuracy = classification_accuracy +1;
        end
       
          confusion_matrix(index, digit) =  confusion_matrix(index, digit) +1;
    end

 end

classifier_accuracy = classification_accuracy/5000;
