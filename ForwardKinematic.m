function [X,Y,Z] = ForwardKinematic(theta1,theta2,theta3,theta4,theta5,theta6)

% Set the variables for the following calculations
a = [0;0.5;0;0;0;0];
d = [0;0.25;0;1;0;0.5];
alpha = [-90;0;90;-90;90;0]*(pi/180);

% Calculate the different A matrices and then calculate the DH matrix
A_1 = A(theta1,a(1),d(1),alpha(1));
A_2 = A(theta2,a(2),d(2),alpha(2));
A_3 = A(theta3,a(3),d(3),alpha(3));
A_4 = A(theta4,a(4),d(4),alpha(4));
A_5 = A(theta5,a(5),d(5),alpha(5));
A_6 = A(theta6,a(6),d(6),alpha(6));

A0_3 = (A_1*A_2)*A_3;
A4_6 = (A_4*A_5)*A_6;

DH = A0_3*A4_6;

% Take the values fo X, Y and Z from the final collumn of the DH matrix
X = DH(1,4);
Y = DH(2,4);
Z = DH(3,4);

end