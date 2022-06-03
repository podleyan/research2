function [system, agent, adviser, data, num_adviser] = initialization(dur_simulation)
num_state = 3;                                                             % pocet stavu
num_action = 3;                                                            % pocet akci
p = 1;                                                                % pamet systemu 
num_adviser = 1;                                                           % pocet poradcu 
num_weight = 2; 

seed  = 1;                                                                 % reset of the seed
s = zeros(1, p);                                                  % priprava pole pro zacatecni stavy 
a = zeros(1, p);                                                  % priprava pole pro zacatecni akce                      
rand('seed',seed);                                                        % inicialisace nahodneho generatoru 
%rng(seed,'twister');                                                        % NEPRACUJE VE STAREM MATLABU

for i = 1:p                                                             % generovani pocatecnich stavu a akci
  s(i)  = dnoise(ones(1,num_state));                                         % generovani pocatecniho stavu
  a(i)  = dnoise(ones(1,num_action));                                        % generovanu pocatecnich akci
end

system = init_system(num_state, num_action, p);         % inicializace systemu 
agent = init_agent(num_state, num_action, 0);           % inicializace agenta
data = init_data(dur_simulation, s, a, p);

% adviser it's just some kind of model + it's belifs 

for i=1:num_adviser                                                          % inicializace vsech poradcu
    adviser(i) = init_adviser(num_state, num_action, num_weight);       
end 