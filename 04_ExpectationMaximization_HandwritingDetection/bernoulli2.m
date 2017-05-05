function p = bernoulli2(x,mu)
% Evaluate bernoulli distribution p(x|mu)
% x and mu are 2-D (e.g. images)

x1 = find(x==1);
x0 = find(x==0);

p = prod(mu(x1))*prod(1-mu(x0));
