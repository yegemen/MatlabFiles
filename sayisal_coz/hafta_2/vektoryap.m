function[y]=vektoryap(a,min,max)

for i=1:a
    y(i)=min+(rand*(max-min));
end
