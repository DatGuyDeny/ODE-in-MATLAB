clear
t_interval = [0 6];
Start_cond = [0; 10; 12; 20];
refine = odeset('Refine', 100);

[t1, X1] = ode45(@shot, t_interval, Start_cond, refine );

plot(X1(:,1),X1(:,2),'--')
grid on
ylim([-20 16])

function dXdt = shot(t,X)
    g = 9.8;
    m = 5;
    lambda = 1;
 
    dx1 = X(3);
    dx2 = X(4);
    dx3 = - (lambda*X(3)*(X(3)^2 + X(4)^2)^(1/2))/m;
    dx4 = - (lambda*X(4)*(X(3)^2 + X(4)^2)^(1/2))/m - g;
    
    dXdt = [dx1; dx2; dx3; dx4];    
end 