x0=0; es=1.2; n=0; Nmax=100;
xkeski=x0;
while (n<Nmax)
    n=n+1;
    xkyeni=xkeski-((exp(-xkeski)-xkeski)/(-exp(-xkeski)-1)) %bu satiri yazdik öncekinin yerine.
    if xkyeni~=0
        ea=abs((xkyeni-xkeski)/xkyeni)*100
        if ea<es
            disp('Kök='); disp(xkyeni);
            disp('Tekrar Sayisi='); disp(n);
            disp('Yüzde bagil Hata='); disp(ea);
            n=Nmax;
        end
    else disp('Sifira bolme hatasi');
    end
    xkeski=xkyeni;
end

        