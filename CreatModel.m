function  CreatModel(  )
Xground=200;% X range of ground
Yground=200;% Y range of ground

sink.x=250;% X position of Sink
sink.y=100;% Y position of Sink

n=100;% number of Sensors

%E0= initial energy of sensors 1-3(J)
rc=20;
Rc=100;
%Rc 10 - 200 m
StopAlgorithm=0.99;% percent of sensors to stop algorithm

p=0.05;
%Transmit energy
ETX=50*0.000000001;
%amplifier energy for distance lower than d0
Efs=10*0.000000000001;
%amplifier energy for distance higher than d0
Emp=0.0013*0.000000000001;

Eelec=50;
%Receive energy
ERX=50*0.000000001;
%Data aggregation energy
Datapacketsize=500;
Ecom=0.000000005;
Esen=0.000000001;



%Inner circuits energy
Ecpu=5*0.00000001;
%Threshold distance for computing energy
d0=sqrt(Efs/Emp);

rmax=9999;
betae=0.1;
%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%

for i=1:n
    S(i).x=rand*Xground;
    S(i).y=rand*Yground;
    S(i).G=0;
    S(i).C=[];
    S(i).Clp=0;
    S(i).Cla=0;
    S(i).Cl=0;
    S(i).Eave=0;
    S(i).Emax=randi(3);% E0
    S(i).Ecur=S(i).Emax;
    S(i).Dist=0;
    S(i).type='N';
end

save wsn.mat


end

