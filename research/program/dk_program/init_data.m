function data = init_data(dur_simulation,num_state,num_action)
%   Init_data is create structure for storing upcoming observed data
%%  INPUTS/OUTPUTS:
%   dur_simulation  = duration of simulation
%   num_state       = number of states
%   num_action      = number of actions
%   data            = structure for storing observed data, like
%   {state,action,dur_simulation,t}
%   state           = field of observed states
%   action          = field of observed actions
%   t               = time
%
%   author    = Daniel Karlik
%   update    = 29.12.20
%%  Code
    t   = 2;
    ns  = num_state;
    na  = num_action;

    s_0 = randi([1,ns]);
    s_1 = randi([1,ns]);

    a_0 = randi([1,ns]);
    a_1 = randi([1,na]);

    state       = zeros(1, dur_simulation + 2); 
    action      = zeros(1,dur_simulation);  
    state(1)    = s_0; 
    state(2)    = s_1;

    action(1)   = a_0; 
    action(2)   = a_1; 


    data = struct('state',state,'action',action,'dur_simulation',dur_simulation,'t',t);
end
