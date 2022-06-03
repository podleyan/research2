function agent = merging(agent, adviser, data, weight, j)
                                                            % predpovidaci model poradce
V_t = agent.V_t;                                                                   % pocet posloupnosti s-> a -> s1 agenta

a = data.action(data.t);                                                       % aktualni akce
s = data.state(data.t);                                                        % predchozi stav


adviser.merged_stat(j, :, a, s) = V_t(:, a, s) + weight*adviser.model(:, a, s);                                    % aktualizace V_t agenta pomoci modelu poradce
                                                  