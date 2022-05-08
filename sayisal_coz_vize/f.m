function[y]=f(x)

y=2*sin(sqrt(x))-x;

xa=1; xu=3; ea=0.02; xr=0; xreski=0; n=0;

while es>ea
    xr=xu-(f(xu)*(xa-xu))/(f(xa)-f(xu));
    if (f(xa)*f(xr))<0
        xu=xr;
    else
        xa=xr;
    end
    es=(abs((xr-xreski)/xr))*100;
    xreski=xr;
    n=n+1;
end

n;
    
