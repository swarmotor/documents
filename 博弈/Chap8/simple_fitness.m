function y = simple_fitness(x)
y = 100 * (x(1)^2 - x(2)) ^2 + (1 - x(1))^2;

FitnessFunction = @simple_fitness;
numberOfVariables = 2;
lb = [-3,-3];
ub = [3,3];
[x,fval] = ga(FitnessFunction,numberOfVariables,[],[],[],[],lb,ub)