clear 
close all
clc

% configs:
N_train = 100;
feature = 3;
M = 4; %degree M polynomial

[t,X] = loadData(); %load the autoMPG file and randomize the rows.
t = normalizeData(t);
X_n = normalizeData(X);

%calculating the polynomial coeffecients that maximize likelihood(w_ML):
Phi = designMatrix(X_n(1:N_train, feature),'polynomial',M);
Phi_dagger = pinv(Phi); %Moore-Penrose pseudo-inverse of Phi (Phi^-1)
w_ML = Phi_dagger*t(1:N_train,:);

X_train = X_n(1:N_train,feature);
t_train = t(1:N_train,:);

%calculating the polynomial value for the test set:
Phi = designMatrix(X_n(N_train+1:end, feature),'polynomial',M);

X_test = X_n(N_train+1:end,feature);
t_test = t(N_train+1:end,:);

% X_n is 1-d
% X_train, X_test, t_train, t_test should all be 1-d, and need to be defined as well.
% You should modify y_ev

% Plot a curve showing learned function.
x_ev = (min(X_n(:,feature)):0.1:max(X_n(:,feature)))';

% Put your regression estimate here.
y_ev = polyval(fliplr(w_ML'),x_ev);

figure;
% Make the fonts larger, good for reports.
set(gca,'FontSize',17);
plot(x_ev,y_ev,'r.-');
hold on;
plot(X_train,t_train,'k*');
plot(X_test,t_test,'bo');
hold off;
title(sprintf('Fit with degree %d polynomial',M));
xlabel('Normalized Horse Power (3rd feature)');
ylabel('Normalized MPG');
legend('Polynomial Fit','Training','Test');

