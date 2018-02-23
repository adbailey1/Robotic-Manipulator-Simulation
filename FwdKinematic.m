function [DH] = FwdKinematic(JA,alpha,a,d,n)

% Set up 2 variables to be used in the calcuation of the A matrices
A0_3 = eye(4);
A3_6 = eye(4);

for i=1:3
    % Calculate the value of the A matrix using the formula below
    B = [cos(JA(i)),-cos(alpha(i))*sin(JA(i)),sin(alpha(i))*sin(JA(i)),a(i)*cos(JA(i));...
        sin(JA(i)),cos(alpha(i))*cos(JA(i)),-sin(alpha(i))*cos(JA(i)),a(i)*sin(JA(i));...
        0,sin(alpha(i)),cos(alpha(i)),d(i);...
        0,0,0,1];
    % Print this formula out
    fprintf('\nA%i for joint angle group %i is: \n\n',i,n)
    table(B(:,1),B(:,2),B(:,3),B(:,4))
    % Calculate the value of the first 3 A matrices
    A0_3 = A0_3*B;
end

for j=4:6
    % Calculate the value of the A matrix using the formula below
    C = [cos(JA(j)),-cos(alpha(j))*sin(JA(j)),sin(alpha(j))*sin(JA(j)),a(j)*cos(JA(j));...
        sin(JA(j)),cos(alpha(j))*cos(JA(j)),-sin(alpha(j))*cos(JA(j)),a(j)*sin(JA(j));...
        0,sin(alpha(j)),cos(alpha(j)),d(j);...
        0,0,0,1];
    % Print this formula out
    fprintf('\nA%i for joint angle group %i is: \n\n',j,n)
    table(C(:,1),C(:,2),C(:,3),C(:,4))
    % Calculate the value of the first 3 A matrices
    A3_6 = A3_6*C;
end

% Calculate the DH matrix by multipling the A0-3 matrix with the A4-6
DH = A0_3*A3_6;

end