clear 

t_interval = [0 15];    

Start_cond = [1; -1.2; 0; 0]; 

g = 9.8;
m1 = 5;
m2 = 7;
k1 = 150;
k2 = 50;
l_0 = 1;
lambda = 1;
    
[t1, X1] = ode45(@(t,X) pendulum_n(t,X,g,m1,k1,l_0,lambda), t_interval, Start_cond );
[t2, X2] = ode45(@(t,X) pendulum_n(t,X,g,m2,k2,l_0,lambda), t_interval, Start_cond );

plot(t1,X1(:,1))
hold on
plot(t1,X1(:,2))
plot(t2,X2(:,1))
plot(t2,X2(:,2))
hold off

function dXdt = pendulum_n(t,X,g,m,k,l_0,lambda)
   
 
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
