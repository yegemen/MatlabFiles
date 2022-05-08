function[f]=fad(id)

f=10*id+ln(150*id+1)-40;

id=3; h=0.1; es=0.0001; n=0; ea=0; ideski=0;

while ea>=es & fad(id)~=0  & id<4
    if fad(id)*fad(id+h)<0
        h=h*0.1;
    else
        id=id+h;
    end
    n=n+1;
    ea=(abs((id-ideski)/id))*100;
    ideski=id;
id
end

disp(n)
idd=id