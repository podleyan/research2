function agent = init_agent(num_state, num_action, dependence) 
%   Init_agent creates blank structure for agent model with aprior
%   information V_0
%%  INPUT/OUTPUT:
%   agent = structure representing mathematical model of agent 
%   with variables = {V_0, V_t, model, num_state, num_action, dependence} 
%   num_state   = number of states
%   num_action  = number of actions
%   model       = is probabilities calculated by agent using V_0 and V_t 
%   V_0         = aprior information of sequences s -> a -> s' of system,
%   here chosen randomly
%   V_t         = number of observed sequencies state -> action -> prev_state 
%   dependence  = auxiliary variable which represents on which last state is
%   agent dependent on 
%  
%   author    = Daniel Karlik
%   update    = 29.12.20
%
%%  Code
%
V_0     = randi([1,5],num_state, num_action, num_state); 
V_t     = zeros(num_state, num_action, num_state); 
model   = ones(num_state, num_action, num_state)/num_state; 
 
agent = struct('V_0',V_0,'V_t',V_t, 'model', model, 'num_state', num_state, 'num_action', num_action, 'dependence', dependence);
end
