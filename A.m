% A simple function to calculate the A matrix to be used with the simulink
% versions of the forward and inverse kinematic functions
function A_out = A(theta,a,d,alpha)

A_out = [cos(theta),-cos(alpha)*sin(theta),sin(alpha)*sin(theta),a*cos(theta);...
        sin(theta),cos(alpha)*cos(theta),-sin(alpha)*cos(theta),a*sin(theta);...
        0,sin(alpha),cos(alpha),d;...
        0,0,0,1];
end