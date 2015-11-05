clear all; clc;clf;
global tau1 tau2 nu_1 nu_2 beta0_1 beta0_2 q0 q1 C xi1 xi2;
tau1 = 1;
tau2 = 1;
nu_1 = 0.0094;
nu_2 = 0.0094;
beta0_1 = 0.042;
beta0_2 = 0.042;
q0 = 1;
q1 = 1.7;
C = 200;
xi1 = 0.0006;
xi2 = 0.0006;


k= 0.000001:0.01:1.5;

for i = 1 : length(k)
capitalB1(i) =(k(i)^3*tau2*q1/tau1/q0+k(i)^2*(1-nu_1*C*tau2*q1)+k(i))/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N2overC1(i) =k(i)^2*tau2*q1/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N22(i)=(capitalB1(i)-beta0_1)/xi1;
capitalB2(i) =(k(i)^3*tau2*q1/tau1/q0+k(i)^2*(1-nu_2*C*tau2*q1)+k(i))/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N2overC2(i) =k(i)^2*tau2*q1/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N12(i)=(capitalB2(i)-beta0_2)/xi2;
end

[pwN2,pwBeta]=piecewiseApprox(N2overC2*C,N22);
[pwN21,pwBeta1]=piecewiseApprox(N2overC1*C,N12);

[x0,y0]=intersectionsZ(pwN2,pwBeta,pwBeta1,pwN21);
figure(1)
axes('linewidth',2,'fontsize',12, 'box', 'off','fontname', 'Arial');
%axis([0,C,0,C],'equal');
axis('equal');
xlabel('$N_2^{(2)}$');
ylabel('$N_2^{(1)}$');
hold on;
plot(pwBeta,pwN2,'k','linewidth',2);
plot(pwN21,pwBeta1,'r','linewidth',2);

plot (x0,y0,'o','markersize',5,'linewidth',5);

plot(N22,N2overC2*C,'linewidth',1);
plot(N2overC1*C,N12,'linewidth',1,'color','k', 'linestyle','-.');

%print -depslatexstandalone '-S600,600' 'n2n2.tex'



%S-shape for first system N^(1)_2 from \beta^(0)_1
figure(5)
axes('linewidth',2,'fontsize',12, 'box', 'off','fontname', 'Arial');
%xlabel('$\beta^{(1)}_0$');
%ylabel('$N_2^{(1)}$');
xlabel('$y_1$');
ylabel('$x_1$');
hold on;
beta0_1 = -0.05:0.001:1.25;
k= 0.000001:0.01:5;
for j = 1 : length(beta0_1)
for i = 1 : length(k)
capitalB1(i) =(k(i)^3*tau2*q1/tau1/q0+k(i)^2*(1-nu_1*C*tau2*q1)+k(i))/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N2overC1(i) =k(i)^2*tau2*q1/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N22(i)=(capitalB1(i)-beta0_1(j))/xi1;
capitalB2(i) =(k(i)^3*tau2*q1/tau1/q0+k(i)^2*(1-nu_2*C*tau2*q1)+k(i))/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N2overC2(i) =k(i)^2*tau2*q1/(tau1*q0+k(i)*tau1*q0+k(i)^2*tau2*q1);
N12(i)=(capitalB2(i)-beta0_2)/xi2;
end
[pwN2,pwBeta]=piecewiseApprox(N2overC2*C,N22);
[pwN21,pwBeta1]=piecewiseApprox(N2overC1*C,N12);
[x0,y0]=intersectionsZ(pwN2,pwBeta,pwBeta1,pwN21);
[xS0,yS0]=intersections(N22,N2overC2*C,N2overC1*C,N12);
xx = ones(size(y0))*beta0_1(j);
xSx = ones(size(yS0))*beta0_1(j);
plot (xx,y0,'.','markersize',5,'linewidth',5);
%plot (xSx,yS0,'.','markersize',5,'linewidth',5);
end
print -depslatexstandalone '-S600,500' 'zzzz.tex'

%{
F_0 = [75;100;25;75;100;25];
Tmin = 0;
Tmax = 50;
dT = 0.01;
T = Tmin:dT:Tmax;
%}
%{
F = lsode('model', F_0 , T);
figure(2);
hold on;
plot(T',F(:,1:3),'linewidth',3,'color','black');
figure(3);
hold on;
plot(T',F(:,4:6),'linewidth',3,'color','black');
%}
%print -depslatexstandalone '-S600,450' 'nZ2beta0.tex'


