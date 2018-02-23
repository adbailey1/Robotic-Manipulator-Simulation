function [t1n,t2n,t3n] = thetaNeg1_3(pos,a,d)

% In order to make the code more readable, set x, y and z to numerical
% vaules
x=1; y=2; z=3;

% Calculate the first angle using the negative iteration
t1n = atan2(pos(y),pos(x)) - atan2(d(2),-sqrt(pos(x)^2+pos(y)^2-d(2)^2));

% Calculate the A and B equations to be used to calculate theta 2
A = cos(t1n)*pos(x) + sin(t1n)*pos(y);
B = (A^2+pos(z)^2+a(2)^2-d(4)^2)/(2*a(2));

% Calculate the values for theta 2 seperately as there is a positive and
% negative component to the equation
jointAnglePos = atan2(A,pos(z)) - atan2(B,sqrt(A^2+pos(z)^2-B^2));
jointAngleNeg = atan2(A,pos(z)) - atan2(B,-(sqrt(A^2+pos(z)^2-B^2)));

t2n = [jointAnglePos,jointAngleNeg];

% Calculate the value of theta3
t3n = (atan2(A-a(2)*cos(t2n),pos(z)+a(2)*sin(t2n)))-t2n;

end