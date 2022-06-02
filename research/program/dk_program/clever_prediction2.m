function prediction = clever_prediction2(agent,w_cur,a,s1)
%   Clever_prediction calculates probability of data.state(data.t+1)
%   combining recently calculated save_last_pred from fixed agents
%%  INPUT/OUTPUT:
%   agent.model     = stores current predictions of agent
%   w_cur             = value of believe put into w_{i}
%
%%  Code
    l_w         = size(w_cur,2);
    help_pred   = agent(1).model(:,a,s1) - agent(1).model(:,a,s1);

    for i = 1:l_w
        help_pred   = help_pred + agent(i).model(:,a,s1)*w_cur(i);
    end
    prediction = help_pred;
end