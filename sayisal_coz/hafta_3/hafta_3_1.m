% Mc Laurin Serisi Programi
%ilk De�erlerin Atanmasi
a1=0; a0=0; Terim=0; x=0.5; n=0; es=5e-4; ea=5e-3;

%burada ea mutlak y�zde yaklasim hatasidir!

%D�ng� baslangici
while ea > es
    Terim=(x^n)/factorial(n)
    a1=a0+Terim
    ea=100*abs((a1-a0)/a1)
    a0=a1; %swapping
    n=n+1;
end