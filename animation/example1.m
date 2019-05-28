clear

x = linspace(0,3,100);
y = sin(x);

F = figure;
A = axes(F);
P = plot(A,x,y,'.');

ylim([-0.4 1.5])

hold on
P_c = plot(A,x,y);

while isvalid(F)
   pause(0.01);
   P.YData = P.YData + 0.01*randn(1,length(P.YData));
   drawnow
end