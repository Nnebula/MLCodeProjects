close all
clear
clc

N_train = 100;
s = 2;
[t,X] = loadData(); %load the autoMPG file and randomize the rows.

t = (normalizeData(t));
X_n = (normalizeData(X));

X_train = X_n(1:N_train,:);
t_train = t(1:N_train);
X_test = X_n(N_train+1:end,:);
t_test = t(N_train+1:end,:);

total_basis = (5:10:95);
for i = 1:length(total_basis)
    
    Mu_index = randperm(N_train,total_basis(i));
    Mu = X_train(Mu_index,:);
    Phi = designMatrix(X_train,'gaussian',Mu,s);
    Phi_dagger = pinv(Phi); %Moore-Penrose pseudo-inverse of Phi (Phi^-1)
    w_ML = Phi_dagger*t_train;
    
    y_train = Phi*w_ML;
    RMS_train(i) =sqrt((y_train - t_train)'*(y_train - t_train)/length(t_train));
    
    Phi = designMatrix(X_test,'gaussian',Mu,s);
    y_test = Phi*w_ML;
    
    %calculating the RMS error of the test set:
    RMS_test(i) = sqrt((y_test - t_test)'*(y_test - t_test)/length(t_test));
end

%plot the RMSE:
plot(total_basis,RMS_test,'-ro',total_basis,RMS_train,'-*b')
set(gca,'FontSize',17, 'Xtick', [5:10:100]);
xlabel('# of Gaussian terms in Regression');
ylabel('RMS Error');
legend('Test Set', 'Training Set','Location', 'NorthWest');
% figure;
% % Make the fonts larger, good for reports.
% set(gca,'FontSize',17);
% % plot(x_ev,y_ev,'r.-');
% hold on;
% plot(X_test(:,3), y_test,'r*');
% plot(X_test(:,3),t_test,'bo');
% hold off;
% title(sprintf('Fit with degree %d polynomial',M));
% xlabel('Normalized Horse Power');
% ylabel('Normalized MPG');

[y I] = min(RMS_test)
