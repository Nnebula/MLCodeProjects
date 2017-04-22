function p = complex_dist(z)
z=z-6;
lambda1=0.2;
t1 = 15;

mu1=17;
sigma1=1;


lambda2=0.4;
t2 = 23;

mu2=28;
sigma2=1;

pi=0.2;
p1 = pi*exp(-lambda1*(z - t1)) .* exp(-(z-mu1).^2/(2*sigma1^2));
p1(find(z<t1))=0;

p2 = (1-pi)*exp(-lambda2*(z - t2)) .* exp(-(z-mu2).^2/(2*sigma2^2));
p2(find(z<t2))=0;


p = p1 + p2;