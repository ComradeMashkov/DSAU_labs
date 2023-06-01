clc
clear variables
close all

num = [-0.5351, -2.794, -3.268];
den = [1, 2.462, 6.14, 11.45];

T0 = 0.1;
T1 = 1;
T2 = 2;

Gp_continuous = tf(num, den);
Gp_discrete_0 = c2d(Gp_continuous, T0);
Gp_discrete_1 = c2d(Gp_continuous, T1);
Gp_discrete_2 = c2d(Gp_continuous, T2);

% f1 = figure;
% step(Gp_continuous, Gp_discrete_0);
% legend('Continuous', 'Discrete');
% grid;
% 
% f2 = figure;
% step(Gp_continuous, Gp_discrete_1);
% legend('Continuous', 'Discrete');
% grid;
% 
% f3 = figure;
% step(Gp_continuous, Gp_discrete_2);
% legend('Continuous', 'Discrete');
% grid;

num_R = 1;
den_R = [1 0];
G_ST_R_0 = tf(num_R, den_R, T0);
G_ST_R_1 = tf(num_R, den_R, T1);
G_ST_R_2 = tf(num_R, den_R, T2);

G_ST_0 = (1 / Gp_discrete_0) * G_ST_R_0;
G_ST_1 = (1 / Gp_discrete_1) * G_ST_R_1;
G_ST_2 = (1 / Gp_discrete_2) * G_ST_R_2;

% f4 = figure;
% step(G_ST_0);
% legend('T_0 = 0.1 sec');
% grid;
% 
% f5 = figure;
% step(G_ST_1);
% legend('T_1 = 1 sec');
% grid;
% 
% f6 = figure;
% step(G_ST_2);
% legend('T_2 = 2 sec');
% grid; 


G_R_0 = (1 / Gp_discrete_0) * (G_ST_R_0 / (1 - G_ST_R_0));
G_R_1 = (1 / Gp_discrete_1) * (G_ST_R_1 / (1 - G_ST_R_1));
G_R_2 = (1 / Gp_discrete_2) * (G_ST_R_2 / (1 - G_ST_R_2));

G_W_0 = G_R_0 * Gp_discrete_0 / (1 + G_R_0 * Gp_discrete_0);
G_W_1 = G_R_1 * Gp_discrete_1 / (1 + G_R_1 * Gp_discrete_1);
G_W_2 = G_R_2 * Gp_discrete_2 / (1 + G_R_2 * Gp_discrete_2);

% ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, Gp_discrete_0 * G_ST_0);
% ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, Gp_discrete_1 * G_ST_1);
% ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, Gp_discrete_2 * G_ST_2);

% ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, G_W_0);
% ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, G_W_1);
% ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, G_W_2);

