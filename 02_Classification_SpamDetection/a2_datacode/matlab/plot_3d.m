p3cost=reshape(repmat(cost,1,8),7,8);
p3model=reshape(model_polynomial,8,7);
surf(p3cost,p3degree,model_polynomial);

