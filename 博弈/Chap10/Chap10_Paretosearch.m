%% ��10��
% ��MATLAB �˳�ѧ�����׳����廪��ѧ������, ׿���� ����ɺ ������ ����. 
%% Eg10-4
rng default % For reproducibility
fun = @(x)[norm(x-[1,2])^2;norm(x+[2,1])^2];
lb = [-1.1,-1.1];
ub = [1.1,1.1];
options = optimoptions('paretosearch','ParetoSetSize',200);
x = paretosearch(fun,2,[],[],[],[],lb,ub,@circlecons,options);

%���ӻ���
figure
plot(x(:,1),x(:,2),'k*')
xlabel('x(1)')
ylabel('x(2)')
hold on
rectangle('Position',[-1.2 -1.2 2.4 2.4],'Curvature',1,'EdgeColor','r')
xlim([-1.2,0.5])
ylim([-0.5,1.2])
axis square
hold off
