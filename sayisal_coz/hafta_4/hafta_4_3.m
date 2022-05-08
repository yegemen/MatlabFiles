xa=-1; xu=0; es=1e-6;
while abs(xu-xa)/2>es
    xo=(xa+xu)/2;
    fa=xa*exp(-xa)+xa^3+1;
    fo=xo*exp(-xo)+xo^3+1;
    fu=xu*exp(-xu)+xu^3+1; %Ek-1
    
    xx=xa:0.01*abs(xa-xu):xu; %Ek-2
    fxx=xx.*exp(-xx)+xx.^3+1; %Ek-3
    figure(1); %Ek-4
    plot(xx,fxx,'b'); %Ek-5
    hold on; plot(xo,fo,'r*');%Ek8 aralðýn tam ortasýna kýrmýzý
    pause(0.5); %Ek-6
    hold off; %Ek-9
    
    if fa*fo<0
        xu=xo;
    else
        xa=xo;
    end
    
end
