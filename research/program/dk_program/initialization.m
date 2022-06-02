function [system, agent, adviser, data,save_last_pred_up,w_up,w_cur,m,...
    savepred_agent_max,savepred_total_max,savepred_system_states,...
    save_vaha_w,savepred_fix_vaha_states,savepred_flex_vaha_states,...
    save_clever_pred] ...
    = initialization(dur_sim, l_w,num_adviser,num_states,num_actions,seed)
%   Initialization is function which initialize basic structures etc. system,
%   agent models or data
%%  INPUTS/OUTPUTS:
%   num_states      = number of states
%   num_actions     = number of actions
%   num_adviser     = number of forms of adviser
%   dur_sim         = duration of simulation
%   l_w             = number of used trust weight parameters
%
%   system          = primary unknown structure, representing transition 
%   from one state to next one. Intern relations we want to know and predict 
%   agent           = l_w basic models which each uses different fixed w(i) 
%   par_past        = combined model
%   adviser         = model providing his information from extern
%   data            = structure for storing states and actions 
%
%   author    = Daniel Karlik
%   updated   = 29.12.20
%%  Code
%%  Initialization of system and data
    rng(seed,'twister'); % generated according to chosen seed

    nu  = 1;         % value given to adviser reflecting his quality
    
    system  = init_system(num_states, num_actions);   % Generating system
    pom     = init_agent(num_states, num_actions, 0); % auxiliary structure for generating agents
    data    = init_data(dur_sim,num_states,num_actions); % creating data structure with apriory information
    %   data starts with data.t = 2

    %%  Initialization of models
    for i=1:l_w
        agent(i)    = pom; 
    end    
    %%  Initialization of advisers
    for i=1:num_adviser
        adviser(i) = init_adviser(num_states, num_actions, i, nu);
    end
    rng shuffle

    [save_last_pred_up,w_up,w_cur,m,savepred_agent_max,savepred_total_max,...
    savepred_system_states,save_vaha_w,savepred_fix_vaha_states,...
    savepred_flex_vaha_states,save_clever_pred] ...
    = init_storing_arrays(l_w,dur_sim,agent(1).num_state);
end

