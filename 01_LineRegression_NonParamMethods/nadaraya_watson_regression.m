
clear
close all
clc

% configs:
N_train = 100;
feature = 3;
h = [0.01 0.1 0.25 1 2 3 4];
S = 10;

[t,X] = loadData(); %load the autoMPG file and randomize the rows.
t = normalizeData(t);
X_n = normalizeData(X);

X_train = (X_n(1:N_train,feature));
t_train = (t(1:N_train));

idx = 1:N_train;
error_h = zeros(length(h),1);
expectation = zeros(S,1);
error = zeros(S,1);

% %TO DO:: delete NG test
% S = 1;
for k=1:length(h) %different values of kernel width
    
    for j=0:S-1 %cross-validation loop
        
        start = S*j;
        range = (idx<=start | idx>start+S);
        
        X_validation = X_train(start+1:start+S);
        t_validation = t_train(start+1:start+S);
        X_subtrain = X_train(range);
        t_subtrain = t_train(range);      
        
        x = X_validation;
        
        for i=1:length(X_validation) %
            
            numerator = 0.0;
            denominator = 0.0;
            
            for n = 1:length(X_subtrain) %training points
                
                u = x(i)-X_subtrain(n);
                
                if abs(u/h(k))<=1
                    g = 0.75*(1-(u/h(k))^2);
                else
                    g = 0;
                end
                
                numerator = numerator+(t_subtrain(n)*g);
                denominator = denominator+g;
            end
            
            if abs(denominator) <eps
                denominator = denominator+eps;
            end
            
            expectation(i,1) = numerator/denominator;           
        end
        
        error(j+1,1) = sqrt(((expectation - t_validation)'*(expectation - t_validation))/length(t_validation));
    end

    error_h(k) = mean(error);
end

[Y I] = min(error_h)
plot(h,error_h,'-O')
set(gca,'FontSize',19);
xlabel('h');
ylabel('Mean Squared Error');