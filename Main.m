clc;clear;close all

LEACH();
ECDC();
ANT();
ANT1();
load LEACH.mat;
load ECDC.mat;
load ANT.mat;
load ANT1.mat
close all
plot(Energy1,'m');
hold on
plot(Energy2,'r');
hold on
plot(Energy3,'g');
hold on
plot(Energy4,'b');
legend('LEACH','ECDC','psos','pso proposed')
xlabel('Rounds');
ylabel('Remaining Energy(J)');

figure
plot(Alive1,'m');
hold on
plot(Alive2,'r');
hold on
plot(Alive3,'g');
hold on
plot(Alive4,'b');
legend('LEACH','ECDC','psos','pso proposed')
xlabel('Rounds');
ylabel('Number Of Alive Nodes');










