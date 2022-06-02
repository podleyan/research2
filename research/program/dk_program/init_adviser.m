function adviser = init_adviser(num_state, num_action, t_use, nu) 
%   Init_adviser creates blank structure similar to agent but for our use
%   prepared for providing information about model
%%  INPUT/OUTPUT: 
%   adviser = structure mathematical model of adviser with variables 
%   = {model, num_state, num_action, nu, t_use} 
%   num_state       = number of states
%   num_action      = number of actions
%   model           = is probabilities from extern 
%   t_use           = time we getthis adviser
%   nu              = value given to adviser reflecting from how large
%   observation is made
%
%   author    = Daniel Karlik
%   updated   = 10.5.21
%
%% Code
model = ones(num_state, num_action, num_state)/num_state; 

adviser = struct('model', model, 'num_state', num_state, 'num_action', num_action, 'nu', nu, 't_use', t_use);
end
