function  ANT()
clc;clear;
load wsn.mat

s(1).Ecur=180;


for r=1:50
r



figure(1)
hold off

deads=0;
dis=[];
for i=1:n
    %checking if there is a DeadSensors node
    if S(i).Ecur<=0 
        plot(S(i).x,S(i).y,'k.');
        S(i).Ecur=0;
        deads=deads+1;
        S(i).type='d';
        hold on;
    else
        S(i).type='p';
        S(i).C=[];
        plot(S(i).x,S(i).y,'mo');
        hold on;
        dist_to_Bs=sqrt( (S(i).x-sink.x)^2 + (S(i).y-sink.y)^2 );
        S(i).Dist=dist_to_Bs;
        if dist_to_Bs<Rc
            plot([S(i).x sink.x],[S(i).y sink.y],'k');
            S(i).type='D';
            
        end
        
        for j=1:n
            %%  broadcasts a Node_Msg,
            S(i).Ecur=S(i).Ecur-Esen;
            dist=sqrt((S(i).x-S(j).x)^2+(S(i).y-S(j).y)^2);
            if  strcmp(S(i).type ,'D')==0 && i~=j && dist<rc && S(i).Ecur>0
                dis(i,j)=dist;
                S(i).C=[S(i).C j];
                %messages Node_Msgs received from other nodes
                S(j).Ecur=S(j).Ecur-Esen;
            else
                dis(i,j)=inf;
            end
        end
        
    end
end
plot(sink.x,sink.y,'ro','markersize',10,'markerfacecolor','g');
title('PSO','fontsize',20);
% if sink.y>Yground
%     axis([0 Xground 0 sink.y+5])
% end


DeadSensors(r)=deads;
t=deads;
%% RC
        t=0:0.1:20;
        a=sink.x;
        b=sink.y;
       
        x=Rc.*sin(t)+a;
        y=Rc.*cos(t)+b;
        plot(x,y,'k');axis equal
%% Clp
for i=1:n
   c= length(S(i).C);
   uc=S(i).C;
   o=0;
   if c>1
       for j=1:c
           tt=sum(S(i).C(c)==[S(:).C]);
           uc=[uc S(S(i).C(c)).C];
           if tt>1
               o=o+1;
           end
       end
   end
  S(i).Clp=(c-o)/length(unique(uc));
  S(i).Cla=1/c;
  S(i).Eave=sum([S([S(3).C]).Ecur])/c;
end
ClusterHeads=[];
for i=1:n
    if strcmp(S(i).type ,'D')==1 || strcmp(S(i).type ,'d')==1 ||strcmp(S(i).type ,'N')==1
         continue;
    end
    if length(S(i).C)==0
        plot(S(i).x,S(i).y,'bo','markersize',6,'markerfacecolor','b');
        ClusterHeads=[ClusterHeads i];
        S(i).type='c';
        continue;
    end
   [m,ind]=max([S(S(i).C).Clp]);
   %% send to number of neighbor nodes
   S(i).Ecur=S(i).Ecur-Esen;
   if S(i).Clp>m 
       plot(S(i).x,S(i).y,'bo','markersize',6,'markerfacecolor','b');
       ClusterHeads=[ClusterHeads i];
        S(i).type='c';
       for k=S(i).C
       S(k).type='N';
       S(k).Dist=sqrt((S(i).x-S(k).x)^2+(S(i).y-S(k).y)^2);
       end
   else
        plot(S(S(i).C(ind)).x,S(S(i).C(ind)).y,'bo','markersize',6,'markerfacecolor','b');
        ClusterHeads=[ClusterHeads S(i).C(ind)];
        S(S(i).C(ind)).type='c';
   end
end
%% creat Cluster
u=length(ClusterHeads);
for j=1:u
    k=ClusterHeads(j);
    t=0:0.1:20;
    x=rc.*sin(t)+S(k).x;
    y=rc.*cos(t)+S(k).y;
    plot(x,y,'k');axis equal
    %% send to number of Cluster nodes
   S(k).Ecur=S(k).Ecur-Esen;
    dist_tp_Bs=sqrt( (S(k).x-sink.x)^2 + (S(k).y-sink.y)^2 );
        if dist_tp_Bs<2*Rc
            plot([S(k).x sink.x],[S(k).y sink.y],'m');
            indc=[S(:).type]=='C';
        else
%             indc=[S(:).type]=='C'
%             t=find(indc==1);
%             cc=S(t);
%             targ=aco(j,cc);
%             relay=inf;
%             ind=0;
%             for tr=1:u
%                 tt=ClusterHeads(tr);
%                 trely=(beta*S(tt).Ecur/S(tt).Emax)+(1-beta)*S(k).Cl;
%                 dis=sqrt( (S(k).x-S(tt).x)^2 + (S(k).y-S(tt).y)^2 );
%                 if trely<relay && tt~=k && dis<2*Rc
%                     relay=trely;
%                     ind=tt;
%                 end
%             end
%             plot([S(k).x S(ind).x],[S(k).y S(ind).y],'m');
        end
    
end
indc=[S(:).type]=='c';
            t=find(indc==1);
            if length(t)>1
            cc=S(t);
           % targ=aco(1,cc);
          % targ=pso(1,cc);
   PSO();
   
     cc=target;
    % targ=target(1,cc);
%for u=1:length(cc)-1
   % plot([cc(targ(u)).x cc(targ(u+1)).x],[cc(targ(u)).y cc(targ(u+1)).y],'m');
%end
            end
%% send Date
 for i=1:100
    if   S(i).Ecur>0 
        min_dis=S(i).Dist;
        %% Send  Data
             if (min_dis>d0)
                S(i).Ecur=S(i).Ecur - (Esen*min_dis^4); 
            else
                S(i).Ecur=S(i).Ecur - (Esen*min_dis^2); 
            end

    end
    if   S(i).Ecur>0 && (strcmp(S(i).type,'C')==1 )
        S(i).Ecur=S(i).Ecur-Esen;
    end
    
 end

for i=1:n
    if S(i).Ecur<0
        S(i).Ecur=0;
    end
end

e=[S(:).Ecur];
energy(r)=sum(e);

% if deads>=StopAlgorithm*n
%     break
% end

 end

Energy3=energy;

Alive3=n-DeadSensors;

close all
save ANT.mat Energy3 Alive3
plot(Energy3,'m')
%end

