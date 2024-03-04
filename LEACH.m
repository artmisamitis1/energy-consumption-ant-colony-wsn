function LEACH()

load('wsn.mat');

for r=1:50
r

%Operation for epoch
if(mod(r, round(1/p))==0)
    for i=1:n
        S(i).G=0;
    end
end

figure(1)
hold off

deads=0;
for i=1:n
    %checking if there is a DeadSensors node
    if (S(i).Ecur<=0)
        plot(S(i).x,S(i).y,'k.');
        S(i).Ecur=0;
        deads=deads+1;
        hold on;
    else
        S(i).type='N';
        plot(S(i).x,S(i).y,'mo');
        S(i).Ecur=S(i).Ecur - (Esen+Ecom);
        hold on;
    end
end
plot(sink.x,sink.y,'ro','markersize',10,'markerfacecolor','g');
title('LEACH','fontsize',20);
if sink.y>Yground
    axis([0 Xground 0 sink.y+5])
end


DeadSensors(r)=deads;

ClusterHeads=[];

for i=1:n
   if(S(i).Ecur>0 && S(i).G==0)
     if rand <= (p/(1-p*mod(r,round(1/p))))
         
        ClusterHeads=[ClusterHeads i];
         
        S(i).type='C';
        S(i).G=1;
        plot(S(i).x,S(i).y,'bo','markersize',6,'markerfacecolor','b');
        plot([S(i).x sink.x],[S(i).y sink.y],'g');
        
        min_dis=sqrt((S(i).x-sink.x)^2 + (S(i).y-sink.y)^2);
        
        if (min_dis>d0)
             S(i).Ecur=S(i).Ecur - ((Esen+Ecom)*min_dis^4); 
            else
             S(i).Ecur=S(i).Ecur - ((Esen+Ecom)*min_dis^2); 
        end
     end
    end 
end

for i=1:n
    if ( S(i).type=='N' && S(i).Ecur>0 )
        dis=[];
        for j=ClusterHeads
            dis=[dis sqrt((S(i).x-S(j).x)^2 + (S(i).y-S(j).y)^2)];
        end
        [min_dis,ind]=min(dis);
        
        if ~isempty(dis)
            
            if (min_dis>d0)
                S(i).Ecur=S(i).Ecur - (Esen*min_dis^4); 
            else
             S(i).Ecur=S(i).Ecur - (Esen*min_dis^2); 
            end
            
            S(ClusterHeads(ind)).Ecur = S(ClusterHeads(ind)).Ecur - ( (Esen + Ecom)*4000 ); 
            
            plot([S(i).x S(ClusterHeads(ind)).x],[S(i).y S(ClusterHeads(ind)).y],'c');
        else
            min_dis=sqrt((S(i).x-sink.x)^2 + (S(i).y-sink.y)^2);
            
            if (min_dis>d0)
                 S(i).Ecur=S(i).Ecur - ((Esen+Ecom)*min_dis^4); 
            else
             S(i).Ecur=S(i).Ecur - ((Esen+Ecom)*min_dis^2); 
                
            plot([S(i).x sink.x],[S(i).y sink.y],'g');
        end
   end
end

for i=1:n
    if S(i).Ecur<0
        S(i).Ecur=0;
    end
end

e=[S.Ecur];
energy(r)=sum(e);

if deads>=StopAlgorithm*n
    break
end

end
end
Energy1=energy;
Alive1=n-DeadSensors;

close all
save LEACH.mat Energy1 Alive1

