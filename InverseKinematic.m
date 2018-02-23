function [theta1,theta2,theta3,theta4,theta5,theta6] = InverseKinematic(T)

% Set the variable to be used in the following calculations
n_xyz = T(1:3,1);
s_xyz = T(1:3,2);
a_xyz = T(1:3,3);
a = [0;0.5;0;0;0;0];
d = [0;0.25;0;1;0;0.5];

pos = pos_of_arm(T,a_xyz,d);

% Call the positive and negative theta functions to calculate the first 3
% positive and negative theta values
[theta1p,theta2p,theta3p] = thetaPos1_3(pos,a,d);

% Combine the results of the above functions to create 3 variables
% containing the values for theta 1, 2 and 3
theta1 = theta1p;
theta2 = theta2p(1:1);
theta3 = theta3p(1:1);

% Call the function to calculate the values for theta 4, 5 and 6
[theta4,theta5,theta6] = theta4_6(n_xyz,s_xyz,a_xyz,theta1,theta2,theta3);

end