function agent = init_agent(num_state, num_action, degrees_of_freedom) 

%% Kod
% 
if nargin < 5, degrees_of_freedom = 5; end
V_0 = degrees_of_freedom*rand([num_state, num_action, num_state]);    % vygeneruje pocatecni pocty probehlych posloupnosti s'-> a -> s
V_t = zeros(num_state, num_action, num_state);                        % pripravi pole pro vkladani dalsich posloupnosti s' -> a -> s
model = V_0/num_state/degrees_of_freedom;                               % vytvori pocatecni predpovidajici model
des_rule = ones(num_action, num_state)/num_action;                         % vytvori rozhodovaci pravidlo 

%% Struktura agent
agent = struct('V_0',V_0,'V_t',V_t,'model', model, 'num_state', num_state,'num_action',num_action,'des_rule',des_rule);
end
