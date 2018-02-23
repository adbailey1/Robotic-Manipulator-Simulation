function [theta4,theta5,theta6] = theta4_6(n_xyz,s_xyz,a_xyz,theta1,theta2,theta3)

% In order to make the code more readable, set x, y and z to numerical
% vaules
x=1;y=2;z=3;

% Calculate the values for theta 4, 5 and 6 using the equations below
theta4 = atan2(-sin(theta1)*a_xyz(x)+cos(theta1)*a_xyz(y),...
c23(theta2,theta3).*(cos(theta1)*a_xyz(x)+sin(theta1)*a_xyz(y))-s23(theta2,theta3)*a_xyz(z));
    
theta5 = atan2(sqrt((cos(theta1).*c23(theta2,theta3)*a_xyz(x)+sin(theta1).*c23(theta2,theta3)*...
a_xyz(y)-s23(theta2,theta3)*a_xyz(z)).^2+(-sin(theta1)*a_xyz(x)+cos(theta2)*a_xyz(y)).^2),...
s23(theta2,theta3).*(cos(theta1)*a_xyz(x)+sin(theta1)*a_xyz(y))+c23(theta2,theta3)*a_xyz(z));

theta6 = atan2(s23(theta2,theta3).*(cos(theta1)*s_xyz(x)+sin(theta1)*s_xyz(y))+c23(theta2,theta3).*s_xyz(z),...
-(s23(theta2,theta3).*(cos(theta1)*n_xyz(x)+sin(theta1)*n_xyz(y))+c23(theta2,theta3)*n_xyz(z)));
end