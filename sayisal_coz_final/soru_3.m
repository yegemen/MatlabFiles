% YUSUF EGEMEN CICEK

% Trapez Yontemi ile Cozum, h=0.1

x=-pi; h=0.1; tplm1=0; sonuc1=0;

f0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

while x<pi
x=x+h;
f=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
tplm1=tplm1+f;
end

x=pi;
f1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

sonuc1=(h/2)*(f0+f1+(2*tplm1));

disp('Trapez Yontemi, h=0.1');
disp(sonuc1)

%------------------------------------

% Trapez Yontemi ile Cozum, h=0.5

x=-pi; h=0.5; tplm1=0; sonuc2=0;

f0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

while x<pi
x=x+h;
f=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
tplm1=tplm1+f;
end

x=pi;
f1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

sonuc2=(h/2)*(f0+f1+(2*tplm1));

disp('Trapez Yontemi, h=0.5');
disp(sonuc2)

%------------------------------------
%------------------------------------

% Simpson 1/3 Yontemi ile Cozum, h=0,1

x=-pi; h=0.1; n=0; tplm1=0; tplm2=0; sonuc3=0;

while x<pi
    x=x+h;
    n=n+1; % kac adim olacagini buluyorum.
end

x=-pi;
x=-pi+h;

for i=1:n/2
    f2i1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    tplm1=tplm1+f2i1;
    x=x+(2*h);
end

x=-pi;

for i=1:(n-2)/2
    f2i=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    tplm2=tplm2+f2i;
    x=x+(2*h);
end

x=-pi;
f0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

x=pi;
fn=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

sonuc3=(x-(-x))*(f0+fn+(4*(tplm1))+(2*(tplm2)))/(3*n);

disp('Simpson 1/3 Yontemi, h=0.1');
disp(sonuc3)

%------------------------------------

% Simpson 1/3 Yontemi ile Cozum, h=0,5

x=-pi; h=0.5; n=0; tplm1=0; tplm2=0; sonuc4=0;

while x<pi
    x=x+h;
    n=n+1; % kac adim olacagini buluyorum.
end

x=-pi;
x=-pi+h;

for i=1:n/2
    f2i1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    tplm1=tplm1+f2i1;
    x=x+(2*h);
end

x=-pi;

for i=1:(n-2)/2
    f2i=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    tplm2=tplm2+f2i;
    x=x+(2*h);
end

x=-pi;
f0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

x=pi;
fn=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

sonuc4=(x-(-x))*(f0+fn+(4*(tplm1))+(2*(tplm2)))/(3*n);

disp('Simpson 1/3 Yontemi, h=0.5');
disp(sonuc4)

%------------------------------------

% Simpson 3/8 Yontemi ile Cozum, h=0,1

x=-pi; h=0.1; n=0; tplm1=0; tplm2=0; sonuc5=0;

while x<pi
    x=x+h;
    n=n+1; % kac adim olacagini buluyorum.
end

x=-pi;
x=x+h;

for i=1:n/3
    f3i2=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+h;
    f3i1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+(2*h);
    tplm1=tplm1+f3i2+f3i1;
end

x=-pi;

for i=1:(n-3)/3
    f3i=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    tplm2=tplm2+f2i;
    x=x+(3*h);
end

x=-pi;
f0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

x=pi;
fn=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

sonuc5=3*(x-(-x))*(f0+fn+(3*(tplm1))+(2*(tplm2)))/(3*n);

disp('Simpson 3/8 Yontemi, h=0.1');
disp(sonuc5)

%------------------------------------

% Simpson 3/8 Yontemi ile Cozum, h=0,5

x=-pi; h=0.5; n=0; tplm1=0; tplm2=0; sonuc6=0;

while x<pi
    x=x+h;
    n=n+1; % kac adim olacagini buluyorum.
end

x=-pi;
x=x+h;

for i=1:n/3
    f3i2=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+h;
    f3i1=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    x=x+(2*h);
    tplm1=tplm1+f3i2+f3i1;
end

x=-pi;

for i=1:(n-3)/3
    f3i=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);
    tplm2=tplm2+f2i;
    x=x+(3*h);
end

x=-pi;
f0=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

x=pi;
fn=(2+cos(1+x^1.5))/sqrt(1+0.5*sin(x))*exp(0.5*x);

sonuc6=3*(x-(-x))*(f0+fn+(3*(tplm1))+(2*(tplm2)))/(3*n);

disp('Simpson 3/8 Yontemi, h=0.5');
disp(sonuc6)