% YUSUF EGEMEN CICEK

% Adim kucultme yontemi ile :
 
id=3; h=0.1; es=0.00003; ea=1; ideski=0; n=0;
 
while ea>=es & id<4
    f=10*id+log(150*id+1)-40;
    fh=10*(id+h)+log(150*(id+h)+1)-40;
    if f*fh<0
        h=h*0.1;
    else
        id=id+h;
    end
    ea=(abs((id-ideski)/id))*100;
    ideski=id;
    n=n+1;
    dizi1(n)=id;
end

disp('Adim Kucultme Yontemi Sonucu: ')
disp(id)

% Sekant yontemi ile :

ida=3; idb=3.3; idc=0; es=0.00003; ea=1; n=0;

while ea>=es
    fa=10*ida+log(150*ida+1)-40;
    fb=10*(idb)+log(150*(idb)+1)-40;
    idc=idb-((fb*(ida-idb))/(fa-fb));
    ea=(abs((idb-ida)/idb))*100;
    ida=idb;
    idb=idc;
    n=n+1;
    dizi2(n)=idb;
end

disp('Sekant Yontemi Sonucu: ')
disp(idb)

disp('Adim Kucultme Dizi Degerleri: ')
disp(dizi1)

disp('Sekant Dizi Degerleri: ')
disp(dizi2)

plot(dizi1,'r')
hold on
plot(dizi2,'b')
grid