function SimOut = find_optimal_gain_values(desired_X,desired_Y,desired_Z)

step = 1;
number_of_variations = 11*11*11;
Optimal_Values = zeros(3,number_of_variations);
pid = zeros(number_of_variations,3);

% Create a triple nested loop to calculate the gains at all the posible gain values from 0 to 10 
for p = 0:10
    for i = 0:10
        for d = 0:10
            
            % set_param function only takes in a string so the numerical
            % value of p, i and d needs to be converted to a string
            p_gain = num2str(p);
            i_gain = num2str(i);
            d_gain = num2str(d);

            % the set_param function sets the gain of the p, i and d in the
            % simulink file.
            set_param('PID_Controller/tau_prime/Kp','Gain',p_gain) 
            set_param('PID_Controller/tau_prime/Ki','Gain',i_gain) 
            set_param('PID_Controller/tau_prime/Kd','Gain',d_gain)
            
            % run the simulation to obtain the actual values of X, Y and Z
            SimOut = sim('PID_Controller.slx');
            
            % Use the mean squared error function to calculate the error
            % between the desired values of X, Y and Z and the actual
            % values.
            error_in_X = immse(desired_X,actual_X);
            error_in_Y = immse(desired_Y,actual_Y);
            error_in_Z = immse(desired_Z,actual_Z);
            
            % Add these error values to a matrix which will contain all
            % 1331 itterations of the gain.
            Optimal_Values(1,step) = error_in_X;
            Optimal_Values(2,step) = error_in_Y;
            Optimal_Values(3,step) = error_in_Z;
            
            % adds the current value of the p, i and d to a matrix which
            % will be used to reference which set of values will obtain the
            % optimal gain values
            pid(step,1) = p;
            pid(step,2) = i;
            pid(step,3) = d;

            % increment the step variable to correclty assign the gain
            % values and the positions to the respective matricies
            step = step+1
        end
    end
end

% sum the values of the Optimal_Values matrix in order to get a vector and
% then obtain the position of the minimum value
Optimal = sum(Optimal_Values);
[~,find_error] = min(Optimal);

% find the value of the gains for p, i and d by using the above minimum
% value position
Kp = pid(find_error,1)
Ki = pid(find_error,2)
Kd = pid(find_error,3)

% transfer the numerical values to strings in order to use the set_param
% function to set these values to the simulink file
Kp = num2str(Kp);
Ki = num2str(Ki);
Kd = num2str(Kd);

set_param('PID_Controller/tau_prime/Kp','Gain',Kp); 
set_param('PID_Controller/tau_prime/Ki','Gain',Ki); 
set_param('PID_Controller/tau_prime/Kd','Gain',Kd);

% run the simulation and output the results to the top script to be added
% to the workspace
SimOut = sim('PID_Controller.slx');
end