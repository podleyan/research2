function agent = learning(agent, data)
V_t = agent.V_t;                                                             % aktualni pocet posloupnosti s -> a -> s1                                     
s = data.state(data.t-1);                                      % predchozi stav, na kterem zavisi agent
a = data.action(data.t-1);                                                     % aktualni akce 
s1 = data.state(data.t);                                                     % aktualni stav
V_t(s1, a, s) = V_t(s1, a, s) + 1;                                           % aktualizace V_t 
agent.V_t = V_t;                                                             % ulozeni aktualizovaneho V_t
agent.model(:,a,s)= (V_t(:, a, s)+agent.V_0(:,a,s))/sum(V_t(:, a, s)+agent.V_0(:, a, s));% opraveny model
end