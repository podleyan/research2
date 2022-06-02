function [err1,err2,err3] = cum_errors_pred(data,savepred_fix_vaha_states,...
    savepred_flex_vaha_states,savepred_system_states)
%   Cum_errors_pred takes predicted states of agent models, their flexible
%   combination and unknown system. These predictions are compared with
%   observed states. If prediction matches with observed realisation error
%   is 0, if not it is 1. Errors are at the end cumulated using cumsum. 
%%  INPUT/OUTPUT:
%   chyba1      = errors of agents with fixed trust
%   chyba2      = errors of confidence combination of agents with fixed trust
%   chyba3      = errors of unknown system 
%   data        = structure of stored data = {state,action,dur_simulation,t}
%   savepred_fix_vaha_states    = predicted values of agents with fixed trust
%   savepred_flex_vaha_states   = predicted values of combination of agents
%   savepred_system_states      = predicted values of system
%
%%  Code
l_w             = size(savepred_fix_vaha_states,1);
dur_simulation  = size(savepred_fix_vaha_states,2);

%   Fields for storing errors in prediction of model and realization 
chyba1      = zeros(l_w,dur_simulation);    % errors in prediction of model with fixed weight
chyba2      = zeros(1,dur_simulation);      % errors in prediction of combined model 
chyba3      = zeros(1,dur_simulation);      % errors in prediction of system

for k = 1:l_w                                             
   for t = 1:dur_simulation
      if data.state(t+1) == savepred_fix_vaha_states(k,t) % comparison of predicted state and generated state
        chyba1(k,t) = 0;    % when predicted state is matching generated state 
      else   
        chyba1(k,t) = 1;    % when predicted state differs from generated state 
      end
   end
   
   chyba1(k,:) = cumsum(chyba1(k,:));   % number of mispredictions while using fixed weight model
end

for t = 1:dur_simulation
    if data.state(t+1) == savepred_flex_vaha_states(1,t)
        chyba2(1,t) = 0; % when predicted state is matching generated state 
    else   
        chyba2(1,t) = 1; % when predicted state differs from generated state 
    end
  
    if data.state(t+1) == savepred_system_states(t)
        chyba3(1,t) = 0;      %  when system prediction is matching generated state
    else   
        chyba3(1,t) = 1;      %  when system prediction fiffers from generated state 
    end
end
chyba2(1,:) = cumsum(chyba2(1,:));  % number of mispredictions while using flexible model 
chyba3(1,:) = cumsum(chyba3(1,:));  % number of mispredictions while knowing system 

err1 = chyba1;
err2 = chyba2;
err3 = chyba3;
end