function s_new=trans_s(s)
    a1=ceil(rand(1)*length(s));
    a2=ceil(rand(1)*length(s));
    if a1~=a2
        a11=min(a1,a2);
        a22=max(a1,a2);
        l1=s(1,a22:end);
        l2=s(1,1:a11);
        l3=s(1,a11+1:a22-1);
        s_new=[l1 l3 l2];
    else
        s_new=[s(1,a1:end) s(1,1:a1-1)];
    end
end
