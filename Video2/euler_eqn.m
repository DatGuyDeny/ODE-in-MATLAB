function dXdt = euler_eqn(t,X)

x  = X(1);
dx = X(2);
d2x = -dx/t - (100*x)/t;

dXdt = [X(2); d2x];

end

