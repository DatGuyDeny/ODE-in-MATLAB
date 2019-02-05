clear 

t_interval = [0 15];    

Start_cond = [1; -1.2; 0; 0]; 

[t, X] = ode45(@pendulum_np, t_interval, Start_cond );

plot(t,X(:,1))
hold on
plot(t,X(:,2))
hold off

function dXdt = pendulum_np(t,X)
    g = 9.8;
    m = 5;
    k = 150;
    l_0 = 1;
    lambda = 1;
 
    dx1 = X(3);
    dx2 = X(4);
    dx3 = -(k*X(1)*((X(1)^2 + X(2)^2)^(1/2)-l_0))   ... 
        /(m*(X(1)^2 + X(2)^2)^(1/2))                ...
        - (lambda*X(3)*(X(3)^2 + X(4)^2)^(1/2))/m;
    dx4 = -(k*X(2)*((X(1)^2 + X(2)^2)^(1/2)-l_0))   ...
        /(m*(X(1)^2 + X(2)^2)^(1/2))                ...
    - (lambda*X(4)*(X(3)^2 + X(4)^2)^(1/2))/m - g;
    
    dXdt = [dx1; dx2; dx3; dx4]; 
   
end
