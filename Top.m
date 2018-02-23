% Module - Space Robotics and Autonomy - EEEM029
% URN - 6504854
close all;
clear all;

% Set up variables to be used throughout this programme
T0_6 = [-1/sqrt(2),0,1/sqrt(2),1;0,-1,0,1;1/sqrt(2),0,1/sqrt(2),0;0,0,0,1];
n_xyz = T0_6(1:3,1);
s_xyz = T0_6(1:3,2);
a_xyz = T0_6(1:3,3);
a = [0;0.5;0;0;0;0];
d = [0;0.25;0;1;0;0.5];
alpha = [-90;0;90;-90;90;0]*(pi/180);

% Call the function to calculate the position of the arm
pos = pos_of_arm(T0_6,a_xyz,d);
fprintf('The position of the arm vector is:\n [%.3f, %.3f, %.3f]\n', pos)
pause;

% Call the Inverse Kinematic function to calculate the joint angles
jointAngles = InvKinematic(pos,a,d,n_xyz,s_xyz,a_xyz);

% Transfer the values for theta back into degrees and print them out
fprintf('\nThe joint angles are: \n\n')
pause(1);
Names = {'Theta','Group1','Group2','Group3','Group4'};
Title = {'Theta 1';'Theta 2';'Theta 3';'Theta 4';'Theta 5';'Theta 6';};

% Split the values of theta into 4 separate groups
Group1 = jointAngles(:,1)*(180/pi);
Group2 = jointAngles(:,2)*(180/pi);
Group3 = jointAngles(:,3)*(180/pi);
Group4 = jointAngles(:,4)*(180/pi);

table(Title,Group1,Group2,Group3,Group4,'VariableNames',Names,'RowNames',{'1','2','3','4','5','6'})
pause;

% Call the function to calculate the A Matrix using the first group of
% theta values
fprintf('\nGroup 1 A Matrices')
pause(1);
DH_one = FwdKinematic(jointAngles(:,1),alpha,a,d,1);
pause;
% Call the function to calculate the DH Matrix using the second group of
% theta values
fprintf('\nGroup 2 A Matrices')
pause(1);
DH_two = FwdKinematic(jointAngles(:,2),alpha,a,d,2);
pause;
% Call the function to calculate the DH Matrix using the third group of
% theta values
fprintf('\nGroup 3 A Matrices')
pause(1);
DH_three = FwdKinematic(jointAngles(:,3),alpha,a,d,3);
pause;
% Call the function to calculate the DH Matrix using the fourth group of
% theta values
fprintf('\nGroup 4 A Matrices')
pause(1);
DH_four = FwdKinematic(jointAngles(:,4),alpha,a,d,4);
pause;

% Print out the DH matrix for the first set of theta values from the A 
% matrices
fprintf('\nDH Matric for the first group is: \n\n')
pause(1);
table(DH_one(:,1),DH_one(:,2),DH_one(:,3),DH_one(:,4))
pause;
% Print out the DH matrix for the second set of theta values from the A 
% matrices
fprintf('\nDH for the second group is: \n\n')
pause(1);
table(DH_two(:,1),DH_two(:,2),DH_two(:,3),DH_two(:,4))
pause;
% Print out the DH matrix for the third set of theta values from the A 
% matrices
fprintf('\nDH for the third group is: \n\n')
pause(1);
table(DH_three(:,1),DH_three(:,2),DH_three(:,3),DH_three(:,4))
pause;
% Print out the DH matrix for the fourth set of theta values from the A 
% the matrices
fprintf('\nDH for the fourth group is: \n\n')
pause(1);
table(DH_four(:,1),DH_four(:,2),DH_four(:,3),DH_four(:,4))
pause;

% Put the I_F_matrices in the workspace
I_F_matrices;
fprintf('\nRunning the Simulink section\n')

% Run the simulink simulation - I have set the gain values to Kp = 1, Ki =
% 0 and Kd = 10
SimOut = sim('PID_Controller.slx');

% Call the plotter function to plot the various outputs of the scope from
% the simulation
plotter(tau_scope,actual_theta_scope,actual_theta_d_scope,actual_theta_dd_scope,actual_X,actual_Y,actual_Z,desired_X,desired_Y,desired_Z)
pause;
close all;
% Use the mean squared error function to calculate the error
% between the desired values of X, Y and Z and the actual
% values.
error_X = immse(desired_X,actual_X);
error_Y = immse(desired_Y,actual_Y);
error_Z = immse(desired_Z,actual_Z);
            
% Add these error values together in order to make a judement of the
% values of the p, i and d gain values. This was a much more sophisticated
% method than that described in the simulink file in the tau_prime sub-system 
% however it was still not as effective as the find_optimal_gain_values
% function below.
Optimal_Value_error = error_X+error_Y+error_Z

% Change the value of the variable "optimiser" to 1 to run the gain value optimiser function.
% !!!Warning!!! Running this next section of code will take a considerable
% amount of time, please allow 15 minutes.
% The delete and add line functions are in order to make the 
% find_optimal_gain_values function work
%--------------------------------------------------------------------------%
optimiser = 0;
if (optimiser == 1)
    fprintf('\n The optimser function is now running! Please allow 15 minutes\n')
    delete_line('PID_Controller','Trajectory/1','Demux1/1')
    SimOut = find_optimal_gain_values(desired_X,desired_Y,desired_Z);
    add_line('PID_Controller','Trajectory/1','Demux1/1')
    plotter(tau_scope,actual_theta_scope,actual_theta_d_scope,actual_theta_dd_scope,actual_X,actual_Y,actual_Z,desired_X,desired_Y,desired_Z)
    pause;
    close all;
end