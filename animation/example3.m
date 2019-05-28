clear

[X, Y] = meshgrid(linspace(-20,20,200), linspace(-20,20,200));
Z = sin(0.3.*(X.^2 + Y.^2).^(1/2)) .^2.*exp(-0.05*((X.^2 + Y.^2).^(1/2))) ;

F = figure('Color', 'w');
A = axes(F);
S = surf(X,Y,Z, 'EdgeColor', 'none');

zlim([0 1])
clock = 0;
while isvalid(F)
    S.ZData = sin(0.3.*(X.^2 + Y.^2).^(1/2) - 2*clock) .^2.*exp(-0.05*((X.^2 + Y.^2).^(1/2))) ;
    drawnow
    clock = clock + 0.02;
end