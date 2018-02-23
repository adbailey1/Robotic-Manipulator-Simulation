function [t1p,t2p,t3p] = thetaPos1_3(pos,a,d)

% In order to make the code more readable, set x, y and z to numerical
% vaules
x=1; y=2; z=3;

% Calculate the first angle using the positive iteration
t1p = atan2(pos(y),pos(x)) - atan2(d(2),sqrt(pos(x)^2+pos(y)^2-d(2)^2));

% Calculate the A and B equations to be used to calculate theta 2
A = cos(t1p)*pos(x) + sin(t1p)*pos(y);
B = (A^2+(pos(z))^2+a(2)^2-d(4)^2)/(2*a(2));

% Calculate the values for theta 2 seperately as there is a positive and
% negative component to the equation
jointAnglePos = atan2(A,pos(z)) - atan2(B,sqrt(A^2+pos(z)^2-B^2));
jointAngleNeg = atan2(A,pos(z)) - atan2(B,-(sqrt(A^2+pos(z)^2-B^2)));

t2p = [jointAnglePos,jointAngleNeg];

% Calculate the value of theta3
t3p = (atan2(A-a(2)*cos(t2p),pos(z)+a(2)*sin(t2p)))-t2p;

end