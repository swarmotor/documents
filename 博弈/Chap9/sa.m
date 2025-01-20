function [e_end,s_end]=sa(fe,t,s,n,std1,t_end,alpha,trans_s)
%fe为能量函数
%t为初始温度
%s为初始状态
%n为每个温度保留的状态数目
%std1为每个温度下的方差最大值
%t_end为最终温度
%alpha为降温系数
%trans_s为状态转移函数
e_end=inf;
while true
    if t<t_end
        break
    end
%外循环判断温度是否足够低    
e_list=[];
    while true
        e_list=[e_list fe(s)];
        if length(e_list)>=n
            std_now=std(e_list(1,end-n+1:end));
            if std_now<std1
                break
            end
        end
%判断在某一温度下状态是否稳定
        s_next=trans_s(s);
        p=min(1,exp((e_list(end)-fe(s_next))/t));
        if rand(1)<=p
            s=s_next;
        end
%以一定概率更新状态
       if fe(s)<e_end
           s_end=s;
           e_end=fe(s);
       end
    end
    t=alpha*t;
end
end
