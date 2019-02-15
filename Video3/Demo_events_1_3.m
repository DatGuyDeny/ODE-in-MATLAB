clear

% Event с остановкой

t_interval = [0 6];
Start_cond = [0; 10; 12; 20];
refine = odeset('Refine', 100);

crossing1 = odeset(refine, 'Events', @zero_crossing);

[t1, X1, te1, Xe1] = ode45(@shot, t_interval, Start_cond, crossing1 );
plot(X1(:,1),X1(:,2),'--')
hold on
scatter(Xe1(:,1),Xe1(:,2),'SizeData',100)
grid on
ylim([-20 16])

hold off

function [position,isterminal,direction] = zero_crossing(t,X)
    position = [X(4); X(2)];   % Координата по вертикали обнуляется
    isterminal = [0; 1];       % рассчет не останавливаем
    direction = [0; 1];        % направление - без разницы
end

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