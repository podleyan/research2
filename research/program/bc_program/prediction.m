function data = prediction(agent, data, system) 
%% Funkce prediction
%
% Vycisluje a uklada predpoved agenta
%
% data = prediction(agent, data) 
%
%% Popis
%% Vystup 
%   data = struktura s doplnenou predpovedi
%         state                     % state course      [s_{1-memory},s_{1-memory+1},...,s_{1},s_{2} ,...,s_{dur_simulation} ] 
%         pred_state                % prediction course [s_{1-memory},s_{1-memory+1},...,s_{1},sp_{2},...,sp_{dur_simulation}] 
%         action                    % action course     [0           ,a_{1-memory+1},...,a_{1},a_{2} ,...,a_{dur_simulation} ]   
%% Vstup: 
%       agent = struktura agenta obsahujici
%                 V_0 = pocatecni pocet posloupnosti s' -> a -> s, s' je stav, na kterem je zavisly agent
%                V_t  = pole pro vkladani poctu posloupnosti s' -> a -> s
%               model = predpovidaci model 
%            des_rule = rozhodovaci pravidlo, podle ktereho agent generuje
%            akci a 
%       data = struktura obsahujici akci, ktera teprve bude vedena do systemu 
%% Posledni aktualizace:
% autor     =  YP
% upraveno  =  22.4.20 YP
%               15.5.20 MK
% teorie    =  Bc prace YP
% poznamky  =  Upravil jsem formalni popisy a udelal zmeny plynouci z toho,
%              ze predpovedi se nyni ukladaji do struktury data a ze model se opravuje ve funkcich learning 
%              a merging 
%% Kod
% 

model = agent.model;                                                       % predpovidaci model
a = data.action(data.t + 1);                                               % aktualni akce
s = data.state(data.t);                                                    % predchozi stav
s1 = data.state(data.t -1); 
m = model(:,a,s); 
[v,i] = max(m);
%i = dnoise(model(:,a,s));                                                 % nahodna predpoved
data.pred_state(data.t + 1) = i;                                           % ulozeni predpovedi

P_0 = system.P_0(:, a, s, s1);
[v, k] = max(P_0);
data.pred_sstate(data.t + 1) = k; 
end

