% YUSUF EGEMEN CICEK

%ileri fark yontemi, h=0.1

h=0.1; x=-pi; n=0;

while x<=pi
    a0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+h;
    a1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+h;
    a2=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    a=(1/2*h)*(-3*a0+4*a1-a2);
    n=n+1;
    dizi1(n)=a;
end

%ileri fark yontemi, h=0.5

h=0.5; x=-pi; n=0;

while x<=pi
    b0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+h;
    b1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+h;
    b2=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    b=(1/2*h)*(-3*b0+4*b1-b2);
    n=n+1;
    dizi2(n)=b;
end

%geri fark yontemi, h=0.1

h=0.1; x=pi;

while x>=-pi
    c0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x-h;
    c1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x-h;
    c2=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    c=(1/2*h)*(3*c0-4*c1+c2);
    n=n+1;
    dizi3(n)=c;
end

%geri fark yontemi, h=0.5

h=0.5; x=pi;

while x>=-pi
    d0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x-h;
    d1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x-h;
    d2=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    d=(1/2*h)*(3*d0-4*d1+d2);
    n=n+1;
    dizi4(n)=d;
end

plot(dizi1,'b')
hold on
plot(dizi2,'r')
hold on
plot(dizi3,'y')
hold on
plot(dizi4,'g')