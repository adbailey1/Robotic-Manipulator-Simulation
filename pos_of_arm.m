% A simple function to calculate the position of the arm vector
function pos = pos_of_arm(T0_6,a_xyz,d)

pos_of_hand = T0_6(1:3,4); 
pos_of_wrist = d(6)*a_xyz;
pos = pos_of_hand - pos_of_wrist;

end