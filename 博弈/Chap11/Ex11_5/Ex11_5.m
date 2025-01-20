% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
clc, clear
rng default 
nvars = 2;
opts = optimoptions(@gamultiobj,'UseVectorized',true,'PlotFcn','gaplotpareto'); 
[xga,fvalga,~,gaoutput] = gamultiobj(@(x)mymulti3(x),nvars,[],[],[],[],[],[],[],opts);

%% 
optsp = optimoptions('paretosearch','UseVectorized',true,'PlotFcn',{'psplotparetof' 'psplotparetox'}); 
[xp,fvalp,~,psoutput] = paretosearch(@(x)mymulti3(x),nvars,[],[],[],[],[],[],[],optsp);

%% 
a = [fzero(@(t)mymulti4([t,-3.15]),[2,3]),-3.15]; 
for jj = linspace(-3.125,-1.89,50) 
    a = [a;[fzero(@(t)mymulti4([t,jj]),[2,3]),jj]];
end
figure 
plot(fvalp(:,1),fvalp(:,2),'bo'); 
hold on 
fs = mymulti3(a); 
plot(fvalga(:,1),fvalga(:,2),'r*'); 
plot(fs(:,1),fs(:,2),'k.') 
legend('Paretosearch','Gamultiobj','True') 
xlabel('目标1') 
ylabel('目标2') 
hold off