function [par,emp]=CreateInitialPopulation(data)

Npar=data.Npar;
lb=data.lb;
ub=data.ub;

emp.x=[];
emp.v=[];
emp.fit=[];
par=repmat(emp,Npar,1);


for i=1:Npar
par(i).x=unifrnd(lb.x,ub.x);
par(i).v=0;
par(i)=fitness(par(i),data);
end


end