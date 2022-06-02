function [save_last_pred_up,w_up,w_cur,m,savepred_agent_max,savepred_total_max,...
    savepred_system_states,save_vaha_w,savepred_fix_vaha_states,...
    savepred_flex_vaha_states,save_clever_pred] ...
    = init_storing_arrays(l_w,dur_sim,num_state)
%   init_storing_arrays creates arrays for storing predictions, confidence 
%   of w, believe of w and number of upcoming adviser
%%  INPUT/OUTPUT:
%   dur_sim     = duration of simulation              
%   l_w         = size of w
%   num_state   = number of states
%
%   save_last_pred_up   = field for predicted probability of upcoming state
%   w_up                = belief given into w updated
%   w_cur               = belief given into w current
%   m                   = index representing number of upcoming adviser
%
%   Initialization of fields for storing studied variables
%   savepred_agent_max      = states with highest probability of model with fixed weight w(i)
%   savepred_total_max      = states with highest probability of combined model
%   savepred_system_states  = states predicted by system
%   save_vaha_w             = current believe given to certain trust parameter w(i)
%   savepred_fix_vaha_states    = predicted states made by model using fixed weight
%   savepred_flex_vaha_states   = predicted states made by combined model
%   save_clever_pred            = cleverly predicted state
%
%   author = Daniel Karlik
%   update = 18.5.21
%   theory = Bc prace Daniel Karlik
%
%%  Code
save_last_pred_up   = zeros(1,l_w);
w_up                = ones(1,l_w)/l_w;
w_cur               = ones(1,l_w)/l_w; 
m                   = 1;            
%% Initialization of fields for storing studied variables
savepred_agent_max      = zeros(l_w, dur_sim);   
savepred_total_max      = zeros(1, dur_sim);     
savepred_system_states  = zeros(1, dur_sim);     
save_vaha_w             = ones(l_w, dur_sim)/l_w;   
savepred_fix_vaha_states    = zeros(l_w, dur_sim);   
savepred_flex_vaha_states   = zeros(1, dur_sim);     
save_clever_pred            = zeros(num_state,dur_sim);