fun = @(x)x(1)*exp(-norm(x)^2);
lb = [-10,-15];
ub = [15,20];
options = optimoptions('particleswarm','SwarmSize',100,'HybridFcn',@fmincon);
nvars = 2;
x=particleswarm(fun,nvars,lb,ub,options)
