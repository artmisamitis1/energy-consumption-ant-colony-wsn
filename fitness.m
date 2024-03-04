function sol=fitness(sol,data)
load wsn.mat
%x=sol.x;
%Dis=data.Dis;
N=data.N;
for i=1:n
    x(i)=S(i).Ecur;
[~,x]=sort(x);
end;
x=[x x(1)];
Z=0;

    
for k=1:N-1
    i=x(k);
    j=x(k+1);
    Dis=i/j;
    Z=Z+Dis;
end
   
   



sol.fit=Z;



end
