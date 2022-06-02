%% Main: testovaci program pro michani jednoduchych modelu
%
% autor     =  YP
% upraveno  =  15.5.20
% teorie    =  Bc prace YP
% poznamky  = upravila jsem casovani podle toho jak to je v poznamkach YP : 
%             upravil jsem to, ze pole na predikce je nyni cast struktury data, coz mimo jine pozmenilo volani prediction 
%             
%% Kod
%
%% Uklid
clc;
close all;
clear all; 

%% Inicialisace
dur_simulation = 1000;                                                      % delka simulace
dia = 0;                                                                    % indikator dialogu [0/1] = [neni/je] 
vg  = [0:0.05:1];                                                           % sit pro overovani vlivu ruznych vah      
n   =  length(vg);                                                          % pocet bodu site
%%
mem = 2;
    save_states = zeros(n, dur_simulation+mem);                             % pomocne pole pro ukladani stavu 
savepred_states = zeros(n, dur_simulation+mem);                             % pomocne pole pro ukladani predpovedi stavu
savepred_sstates = zeros(n, dur_simulation+mem);
   save_actions = zeros(n, dur_simulation+mem);                             % pomocne pole pro ukladani akci  
%% Cyklus pres ruzne vahy
for k=1:n                                                                  
  v = vg(k);                                                                % uzita vaha    
  [system, agent, adviser, data, num_adviser]...
      = initialization(dur_simulation,dia);                                 % inicializace vsech promennych
  while data.t < dur_simulation                                             % simulace v case 
    data = generate_state(data,system);                                     % simulace dalsiho stavu systemu: z a_{t}, s_{t-1}, s_{t-2} generuje s_{t} 
    agent = learning(agent, data);                                          % krok uceni agenta: opravi statistiku agenta na V_{t}  
    for i = 1:num_adviser
        adviser(i) = learning(adviser(i), data);                            % cyklus pres vsechny poradce, uceni poradcu ziskate V_{i;t} statistiky poradcu 
    end
     data = generate_action(agent, data);                                   % generovani dalsi akci pomoci rozhodovaciho pravidla; generujete akci a_{t+1}  
    for i = 1:num_adviser                                                   % cyklus pres vsechny poradce                  
           agent = merging(agent, adviser(i), data, v);                     % oprava modelu agenta pomoci modelu poradce a vahy: V_{opravene t;s|a_{t+1},s_{t}}                                                                        %     = V_{t;s|a_{t+1},s_{t}} + v*F_{i}(s|a_{t+1},s_{t})
    end  
      data = prediction(agent, data, system);                               % predpovidani agenta: P_{agenta|t}(s_{t+1}|a_{t+1},s_{t}) 
    data.t = data.t + 1;                                                    % prechod k dalsimu casu   
  end
  save_states(k,:) = data.state;                                            % ukladani stavu, ktere probehly pro danou vahu
  save_actions(k,:)= data.action;                                           % ukladani akci, ktere probehly pro danou vahu
  savepred_states(k,:) = data.pred_state;                                   % ukladani predpovedi agenta pro danou vahu
  savepred_sstates(k,:) = data.pred_sstate; 
end
%% Vyhodnoceni kvality predpovedi
chyba = zeros(n,dur_simulation);                                            % pole pro vyhodnoceni kvality predpovedi pro ruzne vahy
chyba2 = zeros(n,dur_simulation);                                           % pole pro vyhodnoceni rozdilu mezi predpovedi systemu a agentu
pocet = zeros(1,n); 
pocet2 = zeros(1,n);                                                         % pocet chyb pres casovy cyklus pro vsechny vahy                                                        
for k=1:n                                                                    %pocet rozdilu predpovedi mezi agentem a systemem
   for t= system.memory + 1:dur_simulation
      if save_states(k,t) == savepred_states(k,t)
         chyba(k,t) = 0;                                                    % tam, kde se stav   rovna predpovedi chyba je nula 
      else   
        chyba(k,t) = 1;                                                     % tam, kde se stav nerovna predpovedi chyba je jedna 
      end
   end
   for t= system.memory + 1:dur_simulation
      if savepred_states(k,t) == savepred_sstates(k,t)
         chyba2(k,t) = 0;                                                    % tam, kde se stav predpovedi agenta rovna predpovedi systemu chyba je nula 
      else   
        chyba2(k,t) = 1;                                                     % tam, kde se stav predpovedi agentu nerovna predpovedi systemu chyba je jedna 
      end
   end
   pocet(1,k) = sum(chyba(k,:));                                              % pocet chyb v jednom casovem cyklu s danou vahou                                     
   pocet2(1,k) = sum(chyba2(k,:));                                            % pocet rozdilu v jednom casovem cyklu s danou vahou 
end
%% Vystupy
chyby_zavisle_na_vaze = pocet
fig = 1;
figure(fig)
plot(vg,pocet)
xlabel('VAHA')
ylabel('POCET CHYB')
grid on
fig = fig+1;
figure(fig)
plot(data.state,'.')
xlabel('CAS')
ylabel('STAV')
grid on
fig= fig+1;
figure(fig)
plot(data.action,'.')
xlabel('CAS')
ylabel('AKCE')
grid on
fig = fig+1;
figure(fig)
hist(data.state)
xlabel('HODNOTY STAVU')
ylabel('POCTY')
grid on
fig= fig+1;
figure(fig)
hist(data.pred_state)
xlabel('HODNOTY STAVU')
ylabel('POCTY PREDPOVEDI')
grid on
fig= fig+1;
figure(fig)
hist(data.pred_state-data.state)
xlabel('HODNOTY STAVU')
ylabel('POCTY ODCHYLEK PREDPOVEDI')
grid on
