function F=fitness(x)
F=0;
for i=1:1:length(x)
    F=F+x(i)^2+cos(x(i));
end
fvmin=inf;
for i=1:1:20
    [xm,fv]=PSO(@fitness,200,1.5,2,0.35,100,10);
    if fv<fvmin
        fvmin=fv;
    end
end
disp(fvmin)
