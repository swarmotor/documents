function y = two_min(x)
if x <= 100
    y = -exp(-(x/100).^2);
else
    y = -exp(-1) + (x-100)*(x-102);
end