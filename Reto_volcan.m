% ----------------------------------------------------------------
% Reto: Volcán en erupción
% ----------------------------------------------------------------

% Borramos memoria y limpiamos información del intérprete 
clear all; clc

% Declaramos variables
g = 9.81; % aceleración de la gravedad (m/seg^2)
dt = 0.01; % intervalo de tiempo (longitud de paso) h

% Empezamos pidiendo datos al usuario
fprintf('Suponemos que el proyectil es una esfera perfecta.\n\n');
r = input('Radio (m): ');
p_proy = input('Densidad del proyectil (kg/m^3): '); 
rho = input('Densidad del aire (kg/m^3): ');
f = input('Factor de forma: '); % Adimensional

% Sacamos valores de otras variables con los datos dados por el usuario
v = (4./3).*pi().*r.^3; 	% Volumen (m^3)
As = 4.*pi().*r^2;      	% Área superficial (m^2)
m = p_proy .* v;          % Masa (kg)
k = f .* rho .* As;	  % Coeficiente de fricción del aire (kg/m)

% Con fricción
t = [0]; %tiempo inicial (seg)
fprintf('\n');
x = input('Posición horizontal inicial (m):'); 
y = input('Posición vertical inicial (m): '); 
v_i = input('Velocidad inicial (m/seg): '); %magnitud de la velocidad (m/seg)
theta = input('Ángulo de lanzamiento (grados): ');
vx(1) = v_i(1)*cosd(theta(1));
vy(1) = v_i(1)*sind(theta(1));
ax(1)=-(k/m)*v_i(1)*vx(1); %aceleración en x (ms/^2)
ay(1)=-g-(k/m)*v_i(1)*vy(1); %aceleración en y (ms/^2)
%ax(1)=-(k/m)*(v_i(1))^2*cosd(theta(1)); %aceleración en x (ms/^2)
%ay(1)=-g-(k/m)*(v_i(1))^2*sind(theta(1)); %ay(1)=-g-(k/m)*v_i(1)*vy(1); 

% Sin fricción
xs = x; %sin fricción
ys = y; %sin fricción
vs = v; %magnitud de la velocidad (m/s)
thetas = theta; %ángulo inicial 
vxs(1)=vs(1)*cosd(thetas(1));
vys(1)=vs(1)*sind(thetas(1));
axs(1)=0; %aceleración en x (m/s^2)
ays(1)=-g; %aceleración en y (m/s^2)

j=1;  % Contador

while y(j)>0
    t(j+1) = t(j)+dt;

    % Sin fricción
    x(j+1)=x(j)+vx(j)*dt+0.5*ax(j)*dt^2;
    y(j+1)=y(j)+vy(j)*dt+0.5*ay(j)*dt^2;
    vx(j+1)=vx(j)+ax(j)*dt;
    vy(j+1)=vy(j)+ay(j)*dt;
    v_i(j+1)=sqrt(vx(j+1)^2+vy(j+1)^2);
    theta(j+1)=atand(vy(j+1)/vx(j+1));

    ax(j+1)=-(k/m).*((v_i(j+1)).^2).*cosd(theta(j+1));
    ay(j+1)= -g -(k/m).*((v_i(j+1)).^2).*sind(theta(j+1));

    % Con fricción
    xs(j+1)=xs(j)+vxs(j)*dt; 
    ys(j+1)=ys(j)+vys(j)*dt-0.5*g*dt^2; 
    vxs(j+1)=vxs(j);
    vys(j+1)=vys(j)-g*dt;
    vs(j+1)=sqrt(vxs(j+1)^2+vys(j+1)^2);
    thetas(j+1)=atand(vys(j+1)/vxs(j+1));

    j=j+1;
end



for i=1: j
    figure(1)
    plot(x, y, 'b', 'MarkerSize', 10)
    title('Tiro parabólico con y sin fricción')
    xlabel('x(m)');
    ylabel('y(m)');
    grid on
    hold on

    plot(xs, ys, 'b.', 'MarkerSize', 10)
    hold on 

    plot(x(i), y(i), 'y', 'MarkerSize', 15)
    pause(0.01)

    plot(xs(i), ys(i), 'b', 'MarkerSize', 15)
    pause(0.05)
    legend({'Con fricción','Sin fricción'})
    hold off 
end


