clear

Start_cond = [1; 1];   % Начальные условия
t_interval = [1 5];  

options_fcn = odeset('OutputFcn',@odeplot, 'OutputSel', 1);
[t_fcn, X_fcn] = ode23(@euler_eqn, t_interval, Start_cond, options_fcn);