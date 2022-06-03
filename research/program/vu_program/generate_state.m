function data = generate_state(data,system)
%% Funkce generate_state


%% Kod
% 
a  = data.action(data.t-1);                                                   % aktualni akce                                           
s1 = data.state(data.t-1);                                                % predchozi stav
m  = system.P_0(:, a, s1);                                              % pravdepodobnosti prechodu k dalsimu stavu pri aktualnich a, s1, s2
s  = dnoise(m);                                                             % dostanu dalsi stav
data.state(1, data.t) = s;                                                  % ulozim si stav do data.state
end