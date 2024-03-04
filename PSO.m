
clc
%clear
close all
format shortG

%%  Insert Data

data=InsertData();


%% Parameters Setting

nvar=data.N;           % Number of  Variables

lb.x=0*ones(1,nvar);    % Lower Bound
ub.x=1*ones(1,nvar);    % Upper Bound



lb.v=-0.8;             % Lower Bound of Velocity
ub.v= 0.8;             % Upper Bound of Velocity


W=1;                % Inertia Weight
W_RF=0.97;          % Inertia Weight Reduction factor
C1=2;               % Personal Best Learning Coefficient
C2=2;               % Global Best Learning Coefficient

Npar=20;       % Population Size
Maxiter=50;   % Max Iteration




data.Npar=Npar;
data.lb=lb;
data.ub=ub;

%% Initial Population

tic
[par,emp]=CreateInitialPopulation(data);


bpar=par; % Best Particle

[~,ind]=min([par.fit]);
gpar=par(ind); % Global Particle


%% Main Loop 

BEST=zeros(Maxiter,1);
MEAN=zeros(Maxiter,1);


for iter=1:Maxiter
    
    
    for i=1:Npar
        
        % Update Velocity
        par(i).v=W*par(i).v+...
            C1*rand(1,nvar).*(bpar(i).x-par(i).x)+...
            C2*rand(1,nvar).*(gpar.x-par(i).x);
        
        
        par(i).v=CB(par(i).v,lb.v,ub.v); % Check Bound
        
        
        
        
        % Update Position
        par(i).x=par(i).x+par(i).v;
        
        
        
        % Cal Fitness
        par(i)=fitness(par(i),data);
        
        
        % Update gpar and bpar
        
        if par(i).fit<bpar(i).fit
            bpar(i)=par(i);
            
            if par(i).fit<gpar.fit
                gpar=par(i);
            end
        end
        
        
        
    end
    
    
    
    
    BEST(iter)=gpar.fit;
    MEAN(iter)=mean([bpar.fit]);
    target=gpar.x;
    
    
    disp([ 'Iter = ' num2str(iter) ' BEST = ' num2str(BEST(iter))])
    
    
    W=W*W_RF;
    
    
  % Plot Best Solution
  PlotBestSol(gpar,data,iter)   
    
end
%% Results
%x=gpar.x;
%[~,x]=sort(x);
%x=[x x(1)];
%disp([ ' Best Solution = ' num2str(x) ])
%disp([ ' Best Fitness = ' num2str(gpar.fit) ])
%disp([ ' Time = ' num2str(toc) ])


%figure(1)
%plot(x,'r')
%hold on
%semilogy(MEAN,'b')

%xlabel('Iteration ')
%ylabel(' Fitness ')
%legend('BEST')
%title('PSO')


