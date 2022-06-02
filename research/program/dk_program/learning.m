function agent = learning(agent, data)
%   Learning updates the agents variable V_t with currently observed 
%   sequence of data 
%%  INPUT/OUTPUT:
%   data    = structure with variables {state,action,dur_simulation,t}
%   t       = time
%   V_t     = number of observed sequencies s1 -> a -> s in time t
%   s1      = previous state
%   a       = current action
%   s       = current state
%
%%  Code
    V_t = agent.V_t; 

    dependence = agent.dependence; 
    s1  = data.state(data.t - dependence);  % previous state
    a   = data.action(data.t+1);            % current action 
    s   = data.state(data.t+1);             % current state

    V_t(s, a, s1) = V_t(s, a, s1) + 1;
    agent.V_t = V_t;
end