function []=PlotBestSol(sol,data,iter)

Pos=data.Pos;
minpos=data.minpos;
maxpos=data.maxpos;
N=data.N;

%figure(1)
%plot(Pos(1,:),Pos(2,:),'bo','Markersize',10)
%xlim([minpos(1) maxpos(1)])
%ylim([minpos(2) maxpos(2)])
%hold on

x=sol.x;
fit=sol.fit;
[~,x]=sort(x);
x=[x x(1)];

i=x(1);
%plot(Pos(1,i),Pos(2,i),'bo','Markersize',10,'MarkerFaceColor','b')


for k=1:N
    i=x(k);
    j=x(k+1);
    %line(Pos(1,[i j]),Pos(2,[i j]),'LineStyle','-','Color','r')
    %hold on
  
end


%xlabel('X')
%ylabel('Y')
%title(['iter ' num2str(iter) ' Best= ' num2str(fit)]);

%hold off




end