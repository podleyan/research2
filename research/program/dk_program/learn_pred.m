function [save_pred,agent,n,w_up] = learn_pred(agent,adviser,data,...
    num_adviser,m,w,i,w_cur,save_last_pred)
%   Learn_pred updates statistics and calculates predictions
%
%%  INPUT/OUTPUT:
%   agent       = structure of mathematical model of agent = {V_0, V_t, model, num_state, num_action, dependence}
%   adviser     = agent, who provides his knowledge about studied system
%   data        = structure of stored data = {state,action,dur_simulation,t}
%   num_adviser = number of advisers
%   m           = index of current adviser 
%   w           = trust parameter
%   i           = index of used w(i), agent(i)
%   w_cur       = current values of confidence given to parameter w 
%   save_last_pred  = probability of last observed state according to our
%   prediction
%
%   save_pred   = prediction calculated from agents model
%   agent   =   updated agent
%   n       =   index of next time used adviser
%   w_up    =   updated value of confidence given to parameter w(i);
%%  Code
    a   = data.action(data.t+1);    % current action
    s1  = data.state(data.t);       % last state   
    l_w = size(w,2);
    if m == 1 && adviser.t_use > data.t                     % before we get first adviser
        agent       = prediction(agent,data);                   
        agent       = learning(agent,data);                          
        save_pred   = agent.model(data.state(data.t+1),a,s1);   
        n = m;
        w_up = w_cur(i);
    elseif num_adviser >= m && adviser.t_use > data.t               % we use current adviser 
        if m >= 2   % we update believe in specific w(i) after using first adviser
            w_up = updating_w(save_last_pred,w_cur,i);  % actualization of believe in w(i)
        end   
        agent       = merging(agent, adviser, data, w(i));      % merging advisers information with agents using w(i)
        agent       = prediction(agent,data);                   % making prediction using updated statistics
        agent       = learning(agent,data);                     % update of agents statistics      
        save_pred   = agent.model(data.state(data.t+1),a,s1);   % Value of probability of state data.state(data.t+1)
        n = m;
    elseif num_adviser >= m && adviser.t_use == data.t           % time we use new adviser 
        if m >= 2   % we update believe in specific w(i) after using first adviser
            w_up = updating_w(save_last_pred,w_cur,i);  % actualization of believe in w(i)
        else
            w_up = w_cur(i);
        end   
        agent       = merging(agent, adviser, data, w(i));              
        agent       = prediction(agent,data);                           
        agent       = learning(agent,data);                                
        save_pred   = agent.model(data.state(data.t+1),a,s1); 
        if i == l_w
            n = m + 1; % when we reach last trust parameter we move to next adviser
        else
            n = m;
        end   
    else    % when we used all known advisers, we repeatedly use latest observed
        if m >= 2   % we update believe in specific w(i) after using first adviser
            w_up = updating_w(save_last_pred,w_cur,i);  % actualization of believe in w(i)
        end   
        agent       = merging(agent, adviser, data, w(i));              
        agent       = prediction(agent,data);   
        agent       = learning(agent,data);     
        save_pred   = agent.model(data.state(data.t+1),a,s1);   
        n = m;
    end
end