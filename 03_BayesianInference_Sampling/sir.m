% SIR sampling algorithm
func_select = 2; %choose between 1(Gaussian dist.) and 2(complex dist.)
L = 2000; %number of random samples

%proposal dist. function parameters:
mu_q = 0;
sigma_q = 8;

%main dist. function parameters:
mu_p = 4;
sigma_p = 3;

sir_out = [];

%proposal distribution: Gaussian

z = mu_q+sigma_q*randn(1,L); %vector of L normal random numbers

q = normpdf(z, mu_q, sigma_q); %values of z @ proposal function (Gaussian)

if func_select == 1
    p = normpdf(z, mu_p, sigma_p); %values of z @ main dist. function (Gaussian)

elseif func_select ==2
    p = complex_dist(z);
else
    error('for variable func_select please choose number 1 for normal distribution or 2 for complex distribution')
end
nume_w = p./q;
denum_w = sum(nume_w);

w = nume_w/denum_w; %weight vector

intervals = cumsum(w);

for i = 1:L
    rand_sample = rand();
    indx = find(intervals>rand_sample);
    sir_out(i) = z(indx(1));   
end

hist(sir_out);
xlim([-40,40])
set(gca,'fontsize',18)
xlabel('Sample Value');
xlabel('Sample Value');
ylabel('Sample Histogram')
    
    
