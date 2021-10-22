% -------------------------------------------------------------------------------------------------------
% Reto: Volcán en erupción
% -------------------------------------------------------------------------------------------------------

% Borramos memoria y limpiamos información del intérprete 
clear all; clc
g = 9.81; %aceleración de la gravedad (m/seg^2)

dt = 0.01; %intervalo de tiempo (longitud de paso)

fprintf('Asumimos que el proyectil es una esfera perfecta.\n\n');
m = 0.5; %kg
rho = input('Densidad del aire (kg/m^3): ');
f = input('Factor de forma: ');

b= 2e-3; % Coeficiente de fricción del aire (kg/m)

%Con fricción
t = [0]; %tiempo (s)
x = input('\nPosición horizontal inicial (m): '); %posición inicial en x (m)
y = input('Posición vertical inicial (m): '); %posición inicial en y (m)
v = input('Velocidad inicial (m/seg): '); %magnitud de la velocidasd (m/s)
theta = input('Ángulo de disparo (grados): '); %ángulo inicial
vx(1)=v(1)*cosd(theta(1));
vy(1)=v(1)*sind(theta(1));
ax(1)=-(b/m)*v(1)*vx(1); %aceleración en x (ms/^2)
ay(1)=-g-(b/m)*v(1)*vy(1); %aceleración en y (ms/^2)
%ax(1)=-(b/m)*(v(1))^2*cosd(theta(1)); %aceleración en x (ms/^2)
%ay(1)=-g-(b/m)*(v(1))^2*sind(theta(1)); %ay(1)=-g-(b/m)*v(1)*vy(1); 

%Sin fricción
xs = x; %sin fricción
ys = y; %sin fricción
vs = v; %magnitud de la velocidad (m/s)
thetas = theta; %ángulo inicial 
vxs(1)=vs(1)*cosd(thetas(1));
vys(1)=vs(1)*sind(thetas(1));
axs(1)=0; %aceleración en x (m/s^2)
ays(1)=-g; %aceleración en y (m/s^2)

% Pendiente del volcán   y = -Tan(30º)x
x_rec = [0];
y_rec = y;
% x_rec = linspace(0, 10, 0.1);
% y_rec = - tand(30).*mallax;

k = 1; % Contador

% Uso del método de Euler
while y_rec(k) <= ys(k)
    t(k+1)=t(k)+dt;
    
    % Con fricción
    x(k+1)=x(k)+vx(k)*dt+0.5*ax(k)*dt^2;
    y(k+1)=y(k)+vy(k)*dt+0.5*ay(k)*dt^2;
    vx(k+1)=vx(k)+ax(k)*dt;
    vy(k+1)=vy(k)+ay(k)*dt;
    v(k+1)=sqrt(vx(k+1)^2+vy(k+1)^2);
    theta(k+1)=atand(vy(k+1)/vx(k+1));
    
    ax(k+1)=-(b/m)*(v(k+1))^2*cosd(theta(k+1));
    ay(k+1)=-g-(b/m)*(v(k+1))^2*sind(theta(k+1));

    % Sin fricción
    xs(k+1)= xs(k)+vxs(k)*dt; 
    ys(k+1) =ys (k) +vys(k)*dt-0.5*g*dt^2; 
    vxs(k+1)=vxs(k);
    vys(k+1)=vys(k)-g*dt;
    vs(k+1)=sqrt(vxs(k+1)^2+vys(k+1)^2);
    thetas(k+1)=atand(vys(k+1)/vxs(k+1));
    
    % Pendiente del volcán
    x_rec(k+1) = xs(k+1); 
    y_rec(k+1) = tand(330).*x_rec(k+1) + y(1);

    k=k+1;
end

% Gráficas
figure(1)
plot(x,y,'y.','MarkerSize',10)
title('Tiro parabólico con y sin fricción')
xlabel('x(m)');
ylabel('y(m)');
grid on
hold on

plot(xs,ys,'r.','MarkerSize',10)
hold on 
    
plot(x_rec, y_rec, 'b.', 'MarkerSize', 10)
hold on
legend({'Con fricción','Sin fricción', 'Pendiente del volcán'})
       
hold off 




