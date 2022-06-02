function data = generate_action(agent, data)
%% Funkce generate_action
%
% Vygeneruje dalsi akci  
%
% data = generate_action(agent, data)
%% Vystup 
%  data = struktura pro ukladani stavu a akci  s nove ulozenou akci
%         state  = pole na ukladani stavu
%         action = pole na ukladani akci s nove ulozenou akci
%              t = minuly cas
%      
%% Vstup: 
%  agent = struktura popisujici agenta generujiciho akci 
%                 V_0 = pocatecni pocet posloupnosti s' -> a -> s, s' je stav, na kterem je zavisly agent
%                V_t  = pole pro vkladani poctu posloupnosti s' -> a -> s
%               model = predpovidaci model 
%            des_rule = rozhodovaci pravidlo, podle ktereho agent generuje akci a 
%        num_state    = pocet stavu
%        num_action   = pocet akci 
%        dependence   = zavislost agenta na stavu 
%        dur_simulace = delka simulace 
% degrees_of_freedom  = pocet myslenych pozorovani tvoricich statistiku V_0
%  data = struktura pro ukladani stavu a akci
%         state  = pole na ukladani stavu
%         action = pole na ukladani akci 
%              t = minuly cas          

%% Posledni aktualizace:
% autor     =  YP
% upraveno  =  22.4.20 YP
%               1.5.20 MK
% teorie    =  Bc prace YP
% poznamky  =  Upravil jsem jenom formalni popisy, aby bylo jednoznacne
%              na cem se operuje 

%% Kod
%
s1 = data.state(data.t);                                                   % aktualni stav
des_rule = agent.des_rule;                                                 % rozhodovaci pravidlo 
m = des_rule(:,s1);                                                        % rozhodovaci pravidlo pro aktualni stav
a1 = dnoise(m);                                                            % dalsi akce vybrana pomoci rozhodovaciho pravidla v aktualnim stavu
data.action(data.t +1) = a1;                                               % ulozim akci do data.action 
end
