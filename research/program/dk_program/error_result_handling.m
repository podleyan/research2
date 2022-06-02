function [all_er_type,all_conf_w,conf_w_mc,er_model_mc,est_w] ...
    = error_result_handling(data,savepred_fix_vaha_states, ...
    savepred_flex_vaha_states, savepred_system_states, dur_sim, ...
    save_vaha_w, w)
%   error_result_handling deals with evaluating misspredictions(errors) made
%   in simulation, also stores and deals with confidence of w, evaluates estimation of w
%%  INPUT/OUTPUT:
%   dur_sim     = duration of simulation              
%   w           = trust parameter
%   dur_sim     = duration of simulation
%   conf_w_mc   = array for storing confidence given to w 
%   er_model_mc = array for storing mispredictions(errors) in one
%                 simulation
%
%   savepred_system_states  = states predicted by system
%   save_vaha_w             = current believe given to certain trust parameter w(i)
%   savepred_fix_vaha_states    = predicted states made by model using fixed weight
%   savepred_flex_vaha_states   = predicted states made by combined model
%
% author = Daniel Karlik
% update = 18.5.21
% theory = Bc project Daniel Karlik
%
%%  Code
[error1,error2,~]   = cum_errors_pred(data,savepred_fix_vaha_states,savepred_flex_vaha_states,savepred_system_states);
%   error3 would be mispredictions while using perfect knowledge about
%   system, we dont use later
all_er_type         = [error1(:,dur_sim); error2(1,dur_sim)];
conf_w_mc           = save_vaha_w;
all_conf_w(:)       = conf_w_mc(:,dur_sim);
er_model_mc         = [error1;error2];
est_w               = sum(all_conf_w(:).*w(:));
