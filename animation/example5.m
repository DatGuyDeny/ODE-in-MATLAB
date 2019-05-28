clear

F = figure;
ax = axes(F,'XLim',[-7 7],'YLim',[-7 7],'ZLim',[-0.5 5]);

view(3) 
grid on


interval = 2;
height = 3;

legs{1} = rect(1,1, height, interval, interval, 0);
legs{2} = rect(1,1, height, interval, -interval-1, 0);
legs{3} = rect(1,1, height, -1-interval, interval, 0);
legs{4} = rect(1,1, height, -1-interval, -1-interval, 0);

[x, y, z] = ellipsoid(0, 0, 0, 4.2, 4.2, 1, 30);
h(1) = surface(x, y, z+height, 'FaceColor', [0.85 0.325 0.098]);

for i = 1:4
   h(i+1) = surface(ax, legs{i}.x, legs{i}.y, legs{i}.z, 'FaceColor', [0 0.45 0.74]) ;
end

t = hgtransform('Parent', ax);
set(h, 'Parent',t)

clock = 0;

while isvalid(F)
   Rz = makehgtform('zrotate',clock);
   T  = makehgtform('translate', [2 0 0]);
   Sxy = makehgtform('scale', 1 + 0.1*sin(clock));
   
   t.Matrix = Rz*T*Sxy;
   
   pause(0.01)
   drawnow
   clock = clock + 0.02;
end

function r = rect(ax, ay, az, tx, ty, tz)
    x = [0  0  ax ax 0  0  0  0  ax ax ax 0 ; 
         0  0  ax ax 0  0  0  0  ax ax ax 0 ];
  
    y = [0  ay ay 0  0  0  0  0  0  ay ay ay;
         0  ay ay 0  0  0  0  ay ay ay 0  0 ];
 
    z = [0  0  0  0  0  0  0  0  0  0  az az;
         az az az az az az 0  0  0  az az az];
     
    r.x = x + tx;
    r.y = y + ty;
    r.z = z + tz;
end