
%Derive the model from svmtrain:
% model = svmtrain(training_label_vector, training_instance_matrix [, 'libsvm_options']);
%
%         -training_label_vector:
%             An m by 1 vector of training labels (type must be double).
%         -training_instance_matrix:
%             An m by n matrix of m training instances with n features.
%             It can be dense or sparse (type must be double).
%         -libsvm_options:
%             A string of training options in the same format as that of LIBSVM.

% svmtrain output:
% The 'svmtrain' function returns a model which can be used for future
% prediction.  It is a structure and is organized as [Parameters, nr_class,
% totalSV, rho, Label, ProbA, ProbB, nSV, sv_coef, SVs]:
%
%         -Parameters: parameters
%         -nr_class: number of classes; = 2 for regression/one-class svm
%         -totalSV: total #SV
%         -rho: -b of the decision function(s) wx+b
%         -Label: label of each class; empty for regression/one-class SVM
%         -ProbA: pairwise probability information; empty if -b 0 or in one-class SVM
%         -ProbB: pairwise probability information; empty if -b 0 or in one-class SVM
%         -nSV: number of SVs for each class; empty for regression/one-class SVM
%         -sv_coef: coefficients for SVs in decision functions
%         -SVs: support vectors
%
% If you do not use the option '-b 1', ProbA and ProbB are empty
% matrices. If the '-v' option is specified, cross validation is
% conducted and the returned model is just a scalar: cross-validation
% accuracy for classification and mean-squared error for regression.
%-------------------------------------------------------

%Predict labels for test data set:
% [predicted_label, accuracy, decision_values/prob_estimates] = svmpredict(testing_label_vector, testing_instance_matrix, model [, 'libsvm_options']);
% matlab> [predicted_label] = svmpredict(testing_label_vector, testing_instance_matrix, model [, 'libsvm_options']);
%
%         -testing_label_vector:
%             An m by 1 vector of prediction labels. If labels of test
%             data are unknown, simply use any random values. (type must be double)
%         -testing_instance_matrix:
%             An m by n matrix of m testing instances with n features.
%             It can be dense or sparse. (type must be double)
%         -model:
%             The output of svmtrain.
%         -libsvm_options:
%             A string of testing options in the same format as that of LIBSVM.

%
load('easy_ham_features.mat');
non_spam=V;
load('spam_features.mat');
spam=V;
load('test_data.mat');
test_data = V;
% load('dictionary.mat');
% dictionary = D;

%concatenate and label the training set:
train = [non_spam ; spam ];
label = [ones(size(non_spam,1),1); -ones(size(spam,1),1)]; %spam -1 & non_spam +1

%shuffling the data:
rp = randperm(size(label,1));

for i=1:size(label,1)
    train_data(i,:) = train(rp(i),:);
    train_label(i,:) = label(rp(i),:);
end

% % polynomial svm:
cost = [1e-2 1e-1 1 10 1e2 1e3 1e4];
degree = [1:8];


for k=1:size(cost,2)
    for j=1:size(degree,2)

        deg = sprintf('%f' , degree(j));
        C = sprintf('%f' , cost(k));
        
        opt = '-s 0 -t 0 -d ';
        opt = [opt  deg ' -c ' C ' -v 10'];
        
        display(opt);
        model_polynomial(k,j)=svmtrain(train_label, train_data, opt);

    end
end

% %gaussian svm:
% cost = [1e-2 1e-1 1 10 1e2 1e3 1e4 1e5 1e6];
% 
% for k=1:size(cost,2)
% 
%         C = sprintf('%f' , cost(k));
%         
%         opt = '-s 0 -t 2 ';
%         opt = [opt ' -c ' C ' -v 10'];
%         
%         display(opt);
%         model_gaussian(k)=svmtrain(train_label, train_data, opt);
% end

% %sigmoid svm:
% cost = [1e-2 1e-1 1 10 1e2 1e3 1e4 1e5 1e6];
% 
% for k=1:size(cost,2)
% 
%         C = sprintf('%f' , cost(k));
%         
%         opt = '-s 0 -t 3 ';
%         opt = [opt ' -c ' C ' -v 10'];
%         
%         display(opt);
%         model_sigmoid(k)=svmtrain(train_label, train_data, opt);
% end






