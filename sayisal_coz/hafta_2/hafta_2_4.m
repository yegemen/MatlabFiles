function hafta_2_4(n);

x=-10*n*pi:pi/100:10*n*pi;
y=sin(x)./(n*x);
plot(x,y)
grid