
clc
clear 
close all

N_train = 100;
M =10;
[t,X] = loadData(); %load the autoMPG file and randomize the rows.
t = (normalizeData(t));
X_n = (normalizeData(X));

X_train = X_n(1:N_train,:);
t_train = t(1:N_train);
X_test = X_n(N_train+1:end,:);
t_test = t(N_train+1:end,:);

for i = 1:M
    
    %calculating the polynomial coeffecients that maximize likelihood(w_ML):
    Phi = designMatrix(X_train,'polynomial',i);
    Phi_dagger = pinv(Phi); %Moore-Penrose pseudo-inverse of Phi (Phi^-1)
    w_ML = Phi_dagger*t(1:N_train,:);
    
    %calculating the RMS error of the training set:
    y_train = Phi*w_ML;
    RMS_train(i) =  sqrt((y_train - t_train)'*(y_train - t_train)/length(t_train));
    
    %calculating the polynomial value for the test set:
    Phi = designMatrix(X_test,'polynomial',i);
    y_test = Phi*w_ML;
    
    %calculating the RMS error of the test set:
    RMS_test(i) = sqrt((y_test - t_test)'*(y_test - t_test)/length(t_test));
end

%plotting the results:
poly_degree = 1:M;
plot(poly_degree, RMS_train, 'b-o', poly_degree, RMS_test,'r-o')
set(gca,'FontSize',19);
xlabel('Polynomial Degree');
ylabel('RMS Error');
legend('Training Set', 'Test Set', 'Location', 'NorthWest');

[Y I] = min(RMS_test)