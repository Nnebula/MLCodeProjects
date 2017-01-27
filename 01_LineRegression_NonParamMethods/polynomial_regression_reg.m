close all
clear
clc

%configs:
N_train = 100;
feature = 3;
M = 8; %degree M polynomial
lambda = [0 0.01 0.1 1 10 100 1000]';
S = 10; %fold cross-validation

[t,X] = loadData(); %load the autoMPG file and randomize the rows.
t = normalizeData(t);
X_n = normalizeData(X);

X_train = X_n(1:N_train,feature);
t_train = t(1:N_train);

idx = 1:N_train; %data point index for defining range
RMSE =zeros(length(lambda),1); %RMSE for different lamda values
error = zeros(S,1);
for i=1:length(lambda)
    
    for j=0:S-1
        start = S*j;
        range = (idx<=start | idx>start+S);
        
        X_subtest = X_train(start+1:start+S);
        t_subtest = t_train(start+1:start+S);
        X_subtrain = X_train(range);
        t_subtrain = t_train(range);
        
        Phi = designMatrix(X_subtrain,'polynomial',M);
        P = Phi'*Phi;
        unit_mat = eye(size(P));
        regularizer = lambda(i)*unit_mat;
        w_ML =(inv(regularizer+P))*Phi'*t_subtrain;
        Y_subtrain = Phi*w_ML;
        
        Phi = designMatrix(X_subtest,'polynomial',M);
        Y_subtest = Phi*w_ML;
        
        error(j+1,1) = sqrt(((Y_subtest - t_subtest)'*(Y_subtest - t_subtest))/length(X_subtest));
        %error(j+1,1) = sum((Y_subtest - t_subtest).^2);
    end
    
    RMSE(i,1) = mean(error);
end

figure;
semilogx(lambda, RMSE, 'b-o')
set(gca,'FontSize',17, 'XTick', lambda);
xlabel('L_2 regularizer');
ylabel('RMS Error of the validation set');