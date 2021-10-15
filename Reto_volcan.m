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

% Construir condición inicial
g = -9.81;  % m/seg^2

v_xi = v_0.*cosd(theta);
v_yi = v_0.*sind(theta);


% Aplicación del método de Euler para las velocidades
% v_f = v_i + gt 

v_x = v_xi; % Es constante
v_y = @(t, v_i) v_yi + g.*t; 
