function agent = merging(agent, adviser, data, w)
%   Merging agents updates the agents variable V_t with external prediction 
%   provided by adviser
%%  INPUT/OUTPUT:
%   agent           = structure representing mathematical model of agent 
%   with variables  = {V_0, V_t, model, num_state, num_action, dependence}
%   V_t             = number of observed sequencies s1 -> a -> s in time t
%   adviser         = structure representing mathematical model of adviser 
%   with variables  = {model, num_state, num_action, nu, cas_uziti}
%   cas_uziti   = time we can use adviser
%   data        = structure with variables {state,action,dur_simulation,t}
%   t           = time
%   w           = trust weight parameter   
%
%   s1      = previous state
%   a       = current action
%   s       = current state
%
%% Code
    model = adviser.model ; 
    V_t = agent.V_t; 
    a = data.action(data.t + 1);
    s = data.state(data.t);

    V_t(:, a, s) = V_t(:, a, s) + w*model(:, a, s); % Adding external predictor
    agent.V_t = V_t; 
end