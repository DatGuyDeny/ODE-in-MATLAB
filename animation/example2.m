clear

t = linspace(0,2*pi,1000);

R = 5;
r = 0.5;
x = R*sin(t);
y = R*cos(t);

x_s = sin(t);
y_s = (R + 2*r) + cos(t);

F = figure;
A = axes(F);
P = plot(A,x,y,'.');
hold on
Ps = plot(A,x_s,y_s, '.');
axis equal
ylim([-10 10])
xlim([-10 10])

R_0 = 5;
clock = 0;
i = 0;

for j = 1:150
   pause(0.01);
   
   i = i+1;
   M(i) = getframe(F);
   
   P.XData = R*sin(t);
   P.YData = R*cos(t);
   
   Ps.XData = (R + 2*r)*sin(clock*2) + sin(t);
   Ps.YData = (R + 2*r)*cos(clock*2) + cos(t);
   R = R_0 + 2*sin(clock);
   
   drawnow
   clock = clock + 0.02;
   
end

v = VideoWriter('VIDEO1');
v.FrameRate = 40;
open(v);
for j = 1:length(M)
   writeVideo(v,M(j)); 
end

close(v);




