
x=0; y=2;

XX_kayit=[];
XX_kayit=[XX_kayit; x y];

n=0;
Es=0.0001;
Eax=100; Eay=100;

while(Eax>Es || Eay>Es) 
     n=n+1;  
     x_eski=x;
     y_eski=y; 

     delta=(inv([(2*x+3) -1; 2 -1]))*-[x^2+3*x+2-y ; 2*x+3-y]; 

     x=x_eski+delta(1);
     y=y_eski+delta(2);
     X=[x y];
     XX_kayit=[XX_kayit;X]; 
     
     Eax=100*abs((x-x_eski)/x);
     Eay=100*abs((y-y_eski)/y); 
     Ex=[Eax Eay];  
     disp(n);
     disp([X; Ex]); 
     disp('-----------------------------------------------'); 
       
end

plot(0:n,XX_kayit(:,1),0:n,XX_kayit(:,2));
legend('x',' y');
 