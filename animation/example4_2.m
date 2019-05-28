clear

F = figure;
ax = axes(F, 'XLim', [-10 10], 'YLim', [-10 10]);

a1 = animatedline(ax, 'Color', [0 0.48 0.74], 'MaximumNumPoints', 200);
addpoints(a1,0,0)

h = hgtransform('Parent',ax);


hold on
p = plot(0,0,'or', 'Parent', h);
hold off

t = text(0,0, "(" + num2str(0) + ",  " + num2str(0) + ")", 'FontSize', 14, 'Parent', h);

clock = 0;

while isvalid(F)
    x = sin(clock)*log(clock + 1)*2;
    y = cos(clock)*log(clock + 1)*2;
    addpoints(a1, x,y);
    
    m = makehgtform('translate', [x y 0]);
    h.Matrix = m;
    
    t.String = "(" + num2str(x) + ",  " + num2str(y) + ")";
    
    clock = clock + 0.02;
    drawnow
end