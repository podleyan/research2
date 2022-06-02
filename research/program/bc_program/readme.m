%% upraveny a okomentovany soubory
% main, generate_action, main, generate_state, init_agent, init_system,
% initialisation, 
%% neupraveny init_data, prediction, merging

%% obecne: 
%1) zmeny navadeji na osvedceny popis; 2) nikde by nemela byt ve
% funkci schovana konstanta (MAtlab Vam jiste na mnoha mistech uvolnoval pole a vytvarel nove; 3) stale je podezreni, ze mate chybu v
% casovem posuvu: doufejme, ze jenom ve vyhodnocovani kvality predpovedi:
% stavajici vysledky urcite nejsou dobre, ale sance je  


%% YP: 
% upravila jsem casovani: merging opravuje model(s_t, a_t, s_t-1, s_t-2). Nechala jsem opravu modelu v learning, coz asi potreba neni 
% doplnila jsem init_system: pridala system zavisly na s_t-2, s_t-2, a_t, s_t. Musim jeste rozhodnout o rozumnych parametrech, jinak to podle me vypada dobre 
% pridala jsem pred_sstav do struktury data, kam ukladam predpoved systemu.
% v mainu jsem pridala stejny vypocet chyb mezi predpovidanim systemu a
% agentu. 
% Predelam to na funkci, aby to vypadalo lip 
