% A function that takes the various required values and plots them in order
% to inspect. I removed the first collumns of the outputs as this is
% corresponds to the time
function plotter(tau_scope,actual_theta_scope,actual_theta_d_scope,actual_theta_dd_scope,actual_X,actual_Y,actual_Z,desired_X,desired_Y,desired_Z)

tau_scope = tau_scope(:,2:7);
actual_theta_scope = actual_theta_scope(:,2:7);
actual_theta_d_scope = actual_theta_d_scope(:,2:7);
actual_theta_dd_scope = actual_theta_dd_scope(:,2:7);

figure;
plot(tau_scope)
title('tau Plot from Simulink Scope')
xlabel('Time')
ylabel('tau')
pause;
figure;
plot(actual_theta_scope)
title('Actual Theta Plot from Simulink Scope')
xlabel('Time')
ylabel('Theta')
pause;
plot(actual_theta_d_scope)
title('Actual Theta-d Plot from Simulink Scope')
xlabel('Time')
ylabel('Angular Velocity')
pause;
figure;
plot(actual_theta_dd_scope)
title('Actual Theta-dd Plot from Simulink Scope')
xlabel('Time')
ylabel('Angular Acceleration')
pause;
figure;
plot3(actual_X,actual_Y,actual_Z, '.', 'color', 'r')
title('Actual vs Desired X,Y and Z Values from Simulink Scope')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(desired_X,desired_Y,desired_Z, '*', 'color', 'b')
end