function data = generate_action(agent, data)
s1 = data.state(data.t);                                                   % aktualni stav
des_rule = agent.des_rule;                                                 % rozhodovaci pravidlo 
m = des_rule(:,s1);                                                        % rozhodovaci pravidlo pro aktualni stav
a1 = dnoise(m);                                                            % dalsi akce vybrana pomoci rozhodovaciho pravidla v aktualnim stavu
data.action(data.t) = a1;                                               % ulozim akci do data.action 
end