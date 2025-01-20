fun = @(x)x(1)*exp(-norm(x)^2);
nvars = 2;
x = particleswarm(fun,nvars)
fun = @(x)x(1)*exp(-norm(x)^2);
nvars = 2;
lb = [-10,-15];
ub = [15,20];
x = particleswarm(fun,nvars,lb,ub)
