% Code for fitting a mixture of Bernoulli distributions using EM.

% Load the data X
load('digits.mat');

% X is 28x28x1000
% Each X(:,:,i) is a 28x28 image.
% Code to visualize an image is below.
% figure(1);
% imagesc(X(:,:,2));
% colormap gray;
% axis image;

% Make data binary by thresholding above 0.5.
X = double(X > 0.5);
% Subsample images to be 14x14, Bernoulli with 28x28=784 numbers gives underflow.
X = X(1:2:end,1:2:end,:);

% 14,14,1000.
[nx,ny,ndata] = size(X);

% Number of iterations of EM
niter=10;

% Number of mixture components
K = 5;

% Responsibilities
resp = zeros(ndata,K);

% % Mixing coefficients
% Pi = zeros(1,K);

% Bernoulli distribution parameters
% Mu(:,:,k) is the parameters for mixture component k
% Mu(i,j,k) is the probability that pixel (i,j) is 1 in mixture component k
Mu = zeros(nx,ny,K);

% Initialize randomly.
% Mu drawn uniformly from values in [0.25,0.75]
Mu = 0.5*rand(nx,ny,K) + 0.25;

% Pi initialized to make each mixture component have equal weight.
Pi = ones(1,K)/K;


visualizeMu(Mu,2,'Initialization');
input('Initialization, press return');

for iter=1:niter
    % E-step: set responsibilities given current parameters    
    for n = 1:ndata
        for k = 1:K
            resp(n,k) = Pi(k)*bernoulli2(X(:,:,n),Mu(:,:,k));
        end
    end
    resp = resp./repmat(sum(resp,2),1,K);
    Nk = sum(resp,1);
    
    
    % M-step: update parameters given responsibilities
    Pi = Nk/ndata;
    
    Mu = zeros(nx,ny,K);
    
    for k = 1:K
        for n = 1:ndata
            Mu(:,:,k) = Mu(:,:,k)+resp(n,k)*X(:,:,n);
        end
        Mu(:,:,k) = Mu(:,:,k)/Nk(k);
    end
    
%     %% alternative code
%     X2=reshape(X,14*14,1000);
%     X3=X2*resp./repmat(Nk,196,1);
%     X4=reshape(X3,14,14,5);
%     Mu = X4;
    
    
%     visualizeMu(Mu,2,(sprintf('Iteration %d',iter)));
%     input(sprintf('Iteration %d, press return',iter));
end
visualizeMu(Mu,2,(sprintf('Iteration %d',iter)));
input(sprintf('Iteration %d, press return',iter));

