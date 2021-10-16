% ---------------------------------------------------------------
% Reto: Volcan en erupción
% ---------------------------------------------------------------

% Borramos memoria y limpiamos información del intérprete
clear all; clc

% Pedir datos al usuario
r = input('Radio (m): ');
m = input('Masa (kg): ');
v_0 = input('Velocidad inicial (m/seg): ');
theta = input('Ángulo (grados): ');
h = input('Longitud de paso: ');

f = input('Factor de forma: ');
p = input('Densidad del proyectil (kg/m^3): ');
rho = input('Densidad del aire (kg/m^3):');

As = 4.*pi().*r.^2; % Área superficial
k = f.*As.*rho; % Coeficiente de resistencia del aire


% Construir condición inicial
v_xi = v_0.*cosd(theta);
v_yi = v_0.*sind(theta);

a_xi = 0;      % m/seg^2
a_yi = -9.81;  % m/seg^2 (Valor de la aceleración de la gravedad)

% Aplicación del método de Euler para las velocidades
% v_f = v_i + gt 

v_x = 1; % Es constante
v_y = @(t, v_i) v_i + g.*t;

% ax = @(t) k/m a_xi;
