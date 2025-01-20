%% ��10��
% ��MATLAB �˳�ѧ�����׳����廪��ѧ������, ׿���� ����ɺ ������ ����. 
%% Eg 10-5
%Gamultiobj�㷨��
rng default
nvars = 2;
opts = optimoptions(@gamultiobj,'UseVectorized',true,'PlotFcn','gaplotpareto');
[xga,fvalga,~,gaoutput] = gamultiobj(@(x)mymulti3(x),nvars,[],[],[],[],[],[],[],opts);

%Paretosearch�㷨��
optsp = optimoptions('paretosearch','UseVectorized',true,'PlotFcn',{'psplotparetof' 'psplotparetox'});
[xp,fvalp,~,psoutput] = paretosearch(@(x)mymulti3(x),nvars,[],[],[],[],[],[],[],optsp);

%��ȷֵ��ʵ��ֵ
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
xlabel('Objective 1')
ylabel('Objective 2')
hold off

%�ھ��߱����ռ��л��ƽ⣬�Լ���������Pareto���ߺ�����Ŀ�꺯���ĵ�ֵͼ
[x,y] = meshgrid(1.9:.01:3.1,-3.2:.01:-1.8);
mydata = mymulti3([x(:),y(:)]);
myff = sqrt(mydata(:,1) + 39);% Spaces the contours better
mygg = sqrt(mydata(:,2) + 28);% Spaces the contours better
myff = reshape(myff,size(x));
mygg = reshape(mygg,size(x));

figure;
hold on
contour(x,y,mygg,50)
contour(x,y,myff,50)
plot(xp(:,1),xp(:,2),'bo')
plot(xga(:,1),xga(:,2),'r*')
plot(a(:,1),a(:,2),'-k')
xlabel('x(1)')
ylabel('x(2)')
hold off

