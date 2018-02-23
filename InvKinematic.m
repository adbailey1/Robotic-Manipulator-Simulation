function [allJointAngles] = InvKinematic(pos,a,d,n_xyz,s_xyz,a_xyz)

% Call the positive and negative theta functions to calculate the first 3
% positive and negative theta values
[theta1p,theta2p,theta3p] = thetaPos1_3(pos,a,d);
[theta1n,theta2n,theta3n] = thetaNeg1_3(pos,a,d);

% Combine the results of the above functions to create 3 variables
% containing the values for theta 1, 2 and 3
theta1 = [theta1p,theta1p,theta1n,theta1n];
theta2 = [theta2p,theta2n];
theta3 = [theta3p,theta3n];

% Call the function to calculate the values for theta 4, 5 and 6
[theta4,theta5,theta6] = theta4_6(n_xyz,s_xyz,a_xyz,theta1,theta2,theta3);

% Combine all the values into one variable
allJointAngles = [theta1;theta2;theta3;theta4;theta5;theta6];
end