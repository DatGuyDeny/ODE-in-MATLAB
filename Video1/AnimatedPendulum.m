clear
% AnimatedPendulum  пример анимированного отображения решения ode45.
%   Задача следующая: есть шарик, подвешенный на пружине. Его отпускают в
%   заданном месте с заданной скоростью. Требуется во-первых рассчитать его
%   траекторию, а во-вторых создать анимацию его движения.
%   Ролик доступен по ссылке https://youtu.be/QXXZ0KwZICo
%   Горбачев Георгий, 2019г.
%   ЦИТМ "Экспонента"

Start_cond = [1; -1.2; 0; 0];
t_interval = [0 15]; 

Pendulum_evalution = ode45(@pendulum, t_interval, Start_cond, odeset('MaxStep', 1e-02));

F1 = figure('Color','white');

 A1 = axes;
        A1.XGrid = 'off';
        A1.YGrid = 'off';
        A1.XTick = [];
        A1.YTick = [];
        A1.XColor = 'none';
        A1.YColor = 'none';
        A1.XLim = [-1 1];
        A1.YLim = [-1.7 0];

x = Pendulum_evalution.y(1,1);
y = Pendulum_evalution.y(2,1);
r = 0.05;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + Pendulum_evalution.y(1,1);
yunit = r * sin(th) + Pendulum_evalution.y(2,1);
hold on

P1 = plot(xunit, yunit);
        P1.LineWidth = 1;
        P1.LineStyle = '-';
        P1.Color = 'black';
        P1.XDataSource = 'xunit';
        P1.YDataSource = 'yunit';
        
LineX = [0 Pendulum_evalution.y(1,1)];
LineY = [0 Pendulum_evalution.y(2,1)];
P2 = plot(LineX, LineY);
        P2.LineWidth = 0.7;
        P2.LineStyle = '-';
        P2.Color = 'blue';
        P2.XDataSource = 'LineX';
        P2.YDataSource = 'LineY';
Traj = animatedline;
        Traj.LineWidth = 1;
        Traj.LineStyle = ':';
        Traj.Color = 'red';
        
for i=1:1:length(Pendulum_evalution.y(1,:))
    
    xunit = r * cos(th) + Pendulum_evalution.y(1,i);
    yunit = r * sin(th) + Pendulum_evalution.y(2,i);
    LineX = [0 Pendulum_evalution.y(1,i)];
    LineY = [0 Pendulum_evalution.y(2,i)];
    addpoints(Traj,Pendulum_evalution.y(1,i),Pendulum_evalution.y(2,i))
    
    pause(1e-02)
    refreshdata(P1)
    refreshdata(P2)

end

hold off
function dXdt = pendulum(t,X)


x  = X(1);
y  = X(2);
dx = X(3);
dy = X(4);

g = 9.8;
m = 5;
k = 150;
l_0 = 1;
kapa = 1;

l = (x^2 + y^2)^(1/2);
V = (dx^2 + dy^2)^(1/2);

d2x = -(k*x*(l-l_0))/(m*l) - (kapa*dx*V)/m;
d2y = -(k*y*(l-l_0))/(m*l) - (kapa*dy*V)/m - g;

dXdt = [dx; dy; d2x; d2y];

end
