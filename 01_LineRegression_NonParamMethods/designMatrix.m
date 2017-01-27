function Phi = designMatrix(X,basis,varargin)
% Phi = designMatrix(X,basis)
% Phi = designMatrix(X,'polynomial',degree)
% Phi = designMatrix(X,'gaussian',Mu,s)
%
% Compute the design matrix for input data X
% X is n-by-d
% Mu is k-by-d
%
% TO DO:: You need to fill in foo2

if strcmp(basis,'polynomial') %compare strings with case sensetivity
  k = varargin{1};
  Phi = ones(size(X,1),1);
  
  % TO DO:: try to get rid of for
  for i=1:k
      Phi = cat(2,Phi,X.^i); 
  end
  
elseif strcmp(basis,'gaussian')
  Mu = varargin{1};
  s = varargin{2};
  
  exp_arg = dist2(X,Mu);
  exp_arg = -exp_arg./(2*(s^2));
  Phi = exp(exp_arg);
  Phi = cat(2,ones(size(X,1),1),Phi);
  
else
  error('Unknown basis type');
end
