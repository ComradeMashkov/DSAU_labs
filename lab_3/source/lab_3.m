clc
clear variables
close all

A = [-11.4, -16.7, -5.13; 7.5, 9.7, 2.9; -2, -1.6, -0.36];
B = [0.228, -0.127, 0.038]';
C = [7000, 21000, 28000];
D = 0;

W = ss(A, B, C, D);

for Ts = [0.1, 1, 10]
    G = c2d(W, Ts);
    K = ctrb(G)
    det_K = det(K)
end

p_stable = [-1 -2 -3];
p_unstable = [-25 -1 - 2.6094 * 1i -1 + 2.6094 * 1i];

for Ts = [0.1, 1, 10]
    f = figure;

    K_stable = place(A, B, p_stable);
    K_unstable = place(A, B, p_unstable);

    G = c2d(W, Ts);

    K_0_stable = -1 / (C * (A - B * K_stable)^(-1) * B);
    K_0_unstable = -1 / (C * (A - B * K_unstable)^(-1) * B);

    W_stable = ss(A - B * K_stable, B, C, D);
    W_unstable = ss(A - B * K_unstable, B, C, D);

    G_stable = c2d(W_stable, Ts);
    G_unstable = c2d(W_unstable, Ts);

    subplot(2, 1, 1);
    step(G_stable * K_0_stable);
    legend('0% overshoot');
    grid;

    subplot(2, 1, 2);
    step(G_unstable * K_0_unstable);
    legend('30% overshoot');
    grid;
end
