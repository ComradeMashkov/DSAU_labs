clc
clear variables
close all

A = [-11.4, -16.7, -5.13; 7.5, 9.7, 2.9; -2, -1.6, -0.36];
B = [0.228, -0.127, 0.038]';
C = [7000, 21000, 28000];
D = 0;

Q = ctrb(A, B);
det_K = det(Q);

W = ss(A, B, C, D);

K = [];
p = [0, 0, 0];
K0 = [0.1736, 8.1967e-04, 1.0341e-04];
N = [];
i = 1;

for Ts = [0.1, 1, 10]
    Wz = c2d(W, Ts);

    k = acker(Wz.A, Wz.B, p);
    K(end + 1, :) = k;

    Wz_ext = ss(Wz.A - Wz.B * k, Wz.B, Wz.C, Wz.D, Ts);

    n = acker(Wz.A', Wz.C', p)'
    N(:, end + 1) = n;

    i = i + 1;
end




