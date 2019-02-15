clear
%BallInBox  ������ ������������ ������� ��������� ode45.
%   ������ ���������: ���� �����, ������� ���������, ��������� ��� ����
%   ���� ������� � ���� ������������� �������. �� ������� � �������, ��
%   ������ ������� �� ����� ��� ������ ������� �������������. ����� ���������, � ���
%   ���������� ����� ������������ ������� �����. � ������� �����
%   ������������������ ��������� �������� � MATLAB.

%   �������� �������, 2019�.
%   ���� "����������"


tg = [];
Xg = [];
Xbc = [];

% ��������� ������� � ��������� �������� 
t_interval = [0 6];
Start_cond = [-19; -19; 12; 35];

% ������� ������������ �������� zero_crossing (� ����� �������)
crossing = odeset('Events', @zero_crossing);

% ���� �������� ����������
% ������ �������� ��� �������� �� ������ �� ������
 for i=1:1:20
    % ������� ������� 
    Solution = ode45(@shot, t_interval, Start_cond, crossing );
    
    % ����������� ���������� �������� � �������
    tg = [tg; (t_interval(1):0.01:Solution.xe(end))'];
    Xg = [Xg; (deval(Solution,(t_interval(1):0.01:Solution.xe(end))))'];
    Xbc = [Xbc; (Solution.ye(:,end))', length(tg)];

    % ��������� ��������� ������� � ���������� ��������� ��� ����������
    % ��������
    [~,border_crossing_case] = min(abs(Solution.ye(1:2,end)) - [20;20])  ;
    switch border_crossing_case
        case 1
            Start_cond = Solution.ye(:,end).*[1; 1; 1; -1];
        case 2
            Start_cond = Solution.ye(:,end).*[1; 1; -1; 1];
    end

    t_interval = [Solution.xe(end) Solution.xe(end)+6];

end

% ��������� �������
F1 = figure('Color','white');
A1 = axes;
        A1.XGrid = 'off';
        A1.YGrid = 'off';
        A1.XTick = [];
        A1.YTick = [];
        A1.XColor = 'none';
        A1.YColor = 'none';
        A1.XLim = [-21 21];
        A1.YLim = [-21 21];

% ��������� ������ � ������
r = 0.7;
d = 20+r;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + Xg(1,1);
yunit = r * sin(th) + Xg(1,2);
hold on
axis equal

% ��������� ������
Ball = plot(xunit, yunit);
        Ball.LineWidth = 0.7;
        Ball.LineStyle = '-';
        Ball.Color = 'black';
        Ball.XDataSource = 'xunit';
        Ball.YDataSource = 'yunit';
% ��������� ������        
Borders = plot([-d d d -d -d], [d d -d -d d]);
        Borders.LineWidth = 1;
        Borders.LineStyle = '-';
        Borders.Color = 'black';
% ���������� - ������������� �����        
Traj = animatedline;
        Traj.LineWidth = 1;
        Traj.LineStyle = ':';
        Traj.Color = [0 0.45 0.74];
% ������� ��������� - ������������� �������
BorderCrossing = animatedline;
        BorderCrossing.LineStyle = 'none';
        BorderCrossing.Marker = '*';
        BorderCrossing.Color = [0.85 0.33 0.1];
        BorderCrossing.MarkerSize = 4;
        
cross = 01;

% ���� �������������� �������� ������
for i=1:1:length(Xg(:,1))    
    
    % ����� ��������� ������
    xunit = r * cos(th) + Xg(i,1);
    yunit = r * sin(th) + Xg(i,2);
    
    % ���������� ����� � ����������
    addpoints(Traj,Xg(i,1),Xg(i,2))
    
    % ���������� ����� ���������
    if i==Xbc(cross,5)
        addpoints(BorderCrossing, Xbc(cross,1), Xbc(cross,2) )
        cross = cross + 1;
    end
    
    pause(1e-03)
    refreshdata(Ball)

end

hold off       

% �������, ������������ �������. � ������� 4 ������� - ������ ��������� 4
% �������, ��������������� ��������������
function [position,isterminal,direction] = zero_crossing(t,X)
    position = [X(1)-20; X(1)+20; X(2)-20; X(2)+20];        % �������
    isterminal = [1; 1; 1; 1];         % ������� �� �������������
    direction  = [0; 0; 0; 0];         % ����������� - ��� �������
end

% �������, ���������� ������� �������� ������
function dXdt = shot(t,X)
    g = 9.8;
    m = 5;
    lambda = 0.01;
 
    dx1 = X(3);
    dx2 = X(4);
    dx3 = - (lambda*X(3)*(X(3)^2 + X(4)^2)^(1/2))/m;
    dx4 = - (lambda*X(4)*(X(3)^2 + X(4)^2)^(1/2))/m - g;
    
    dXdt = [dx1; dx2; dx3; dx4]; 
   
end 