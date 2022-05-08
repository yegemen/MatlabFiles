function R = tuzbiber(m,n,a,b)
if nargin<=2
    a = 0.05;
    b = 0.05;
end
if (a+b) > 1
    error('Pa ve Pb toplamı 1 den buyuk olamaz');
end
R(1:m,1:n) = 0.5;
X = rand(m,n);

R(X<=a) = 0;
R(X>a & X<=a+b)= 1;