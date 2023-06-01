clc
clear variables
close all

num = [-0.5351 -2.794 -3.268];
den = [1 2.462 6.14 11.45];

T0 = 1;
T1 = 2;
T2 = 4;

Gp_continuous = tf(num, den);

for Ts = [T0, T1, T2]
    Gp_discrete = c2d(Gp_continuous, Ts);

    [b, a] = tfdata(Gp_discrete);
    b = cell2mat(b);
    a = cell2mat(a);

    q0 = 1 / sum(b);
    for i = 2 : length(a)
        q(i - 1) = a(i) * q0;
        p(i - 1) = b(i) * q0;
    end

    Gr_normal = tf([q0, q], [1, -p], Ts);
    Gw_normal = Gr_normal * Gp_discrete / (1 + Gr_normal * Gp_discrete);

    q0 = 0.5;
    for i = 1 : length(a) - 1
        q1(i) = q0 * (a(i + 1) - a(i)) + a(i) / sum(b);
        p1(i) = q0 * (b(i + 1) - b(i)) + b(i) / sum(b);
    end
    q1(i + 1) = a(i + 1) * (-q0 + 1 / sum(b));
    p1(i + 1) = -b(i + 1) * (q0 - 1 / sum(b));

    Gr_increased = tf([q0, q1], [1, -p1], Ts);
    Gw_increased = Gr_increased * Gp_discrete / (1 + Gr_increased * Gp_discrete);

    ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, Gw_normal);
    ltiview({'step'; 'pzmap'; 'bode'; 'nyquist'}, Gw_increased);
end
