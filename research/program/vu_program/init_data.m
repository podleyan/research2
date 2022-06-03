function data = init_data(dur_simulation, s, a, p)

t = p + 1;                                                            % nastavi cas 
    state  = zeros(1,dur_simulation + p);                             % vytvori pole pro vkladani stavu behem simulace
    action = zeros(1,dur_simulation + p);                             % vytvori pole pro vkladani akci  behem simulace
pred_state = zeros(1,dur_simulation + p);                             % pole pro ukladani predpovedi stavu agenta
pred_sstate = zeros(1,dur_simulation + p);                            % pole pro ukladani predpovedi stavu systemu

for i= 1:p                                                            
      state(i)  = s(i);                                                    % ulozi do pole pocatecni stavy
  pred_state(i) = s(i);                                                    % stavy splyvaji s predpovedmi 
    action(i) = a(i);                                                    % ulozi do pole pocatecni akci
end

data = struct('state',state,'action',action,'pred_state',pred_state, 'dur_simulation',dur_simulation,'t',t);
end