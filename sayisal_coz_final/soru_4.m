% YUSUF EGEMEN CICEK

x=2; y=0.1; h=0.1; t=0; n=0;

f1t=y;
f2t=-x+(1-x^2)*y;

while t<20
    fx=x+f1t*(0.1);
    fy=y+f2t*(0.1);
    x=fx;
    y=fy;
    t=t+h;
    
    n=n+1;
    dizix(n)=x;
    diziy(n)=y;
end

plot(dizix,'r')
hold on
plot(diziy,'b')
grid