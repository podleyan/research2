function system = init_system(num_state, num_action, memory, dur_simulation)
%% Funkce init_system
%
% Inicializace systemu vytvori strukturu system, ktera odpovida realnemu systemu. 
%
% system = init_system(num_state, num_action, memory, dur_simulation)
%
%% Vystup 
%  system = struktura popisujici simulovany system obsahujici
%           P_0 = pole pravdepodobnosti prechodu   (zvoleno pevne) a 
%% Vstupy: 
%           num_state = pocet stavu 
%            num_akce = pocet akci
%              memory = pamet systemu 
%        dur_simulace = delka simulace 
%
%% Posledni aktualizace:
% autor     =  YP
% upraveno  =  29.4.20 YP
%              15.5.20 MK
% teorie    =  Bc prace YP
% poznamky  =  Bylo by dobre v budoucnu moci zadavat ruzne systemy (hlavne P_0),
%              napr ctene z pripraveneho souboru
%              jiz nyni memory musi byt provazbeno se skutecnou pameti
%              systemu MK; okomentujte si jaky system to vlastne simulujete
%% Kod
% 
%
% %%  ADDED SYSTEM WITH STRONG DEPENDENCES
% P_0 = zeros(3,3,3,3);
% for i4 = 1:3
%     for i3 = 1:3
%          for i2 = 1:3
%              for i1 = 1:3
%                  P_0(i1,i2,i3,i4)=exp(-abs(i1-i2-i3-i4-6)); 
%              end    
%                 P_0(:,i2,i3,i4)= P_0(:,i2,i3,i4)/sum(P_0(:,i2,i3,i4));
%          end
%     end
% end

%% System zavisly na s_t-2, s_t-2, a_t, s_t
P_0 = zeros(3,3,3,3);
alpha = 0.7;
beta = 0.5; 
gamma = 0.9; 
delta = 1; 
omega = 1; 


for i4 = 1:3
    for i3 = 1:3
         for i2 = 1:3
             m = alpha*i2 + beta*i3 + gamma*i4; 
             for i1 = 1:3
                 P_0(i1,i2,i3,i4)=exp(-abs(i1-m))^delta*omega; 
             end    
                P_0(:,i2,i3,i4)= P_0(:,i2,i3,i4)/sum(P_0(:,i2,i3,i4));
         end
    end
end


system = struct('P_0', P_0, 'num_state', num_state, 'num_action', num_action, 'memory', memory, 'dur_simulation', dur_simulation);
end