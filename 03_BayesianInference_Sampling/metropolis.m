% metropolis sampling algorithm
func_select = 2; %choose between 1(Gaussian dist.) and 2(complex dist.)
L = 20000; %number of random samples

burn_in =300;

%main dist. function parameters:
mu_p = 4;
sigma_p = 3;

sigma_q = 8;

z = [];
z_t = 0;

%proposal distribution: Gaussian

%burn_in first samples:
for i = 1:L+burn_in
    
    z_star = z_t+sigma_q*randn;
    
    if func_select == 1
        p_z_star = normpdf(z_star, mu_p, sigma_p); %values of z @ main dist. function (Gaussian)
        p_z_t = normpdf(z_t, mu_p, sigma_p);
    elseif func_select ==2
        p_z_star = complex_dist(z_star);
        p_z_t = complex_dist(z_t);
    else
        error('for variable func_select please choose number 1 for normal distribution or 2 for complex distribution')
    end
    
    A_accept = min(1,p_z_star/p_z_t);
    
    u = rand;
    
    if u<A_accept
        z(end+1) = z_star;
    elseif u>A_accept
        z(end+1) = z_t;
    end
    z_t = z(end);
end


hist(z(burn_in+1:end));
xlim([-40,40])
set(gca,'fontsize',18)
xlabel('Sample Value');
xlabel('Sample Value');
ylabel('Sample Histogram')


