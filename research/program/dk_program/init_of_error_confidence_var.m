function [conf_w_mc,median_conf_w,er_model_mc,er_model_median,all_conf_w,...
    all_er_type,est_w] = init_of_error_confidence_var(l_w,num_mc,dur_sim)
%   init_of_error_confidence_var creates arrays for storing data about 
%   confidence and errors
%%  INPUT/OUTPUT:
%   dur_sim     = duration of simulation              
%   l_w         = size of w
%   num_mc      = number of performed Monte Carlo cycles
%
%   conf_w_mc       = confidence put into w in time in Monte Carlo cycle
%   median_conf_w   = median of confidence put into w according to type of
%   prediction
%   er_model_mc     = cumulative errors of different predictions
%   er_model_median = median of cumulative errors according to type of
%   prediction
%
%   Checking final errors, confidence put into w
%   all_er_type = final error of model
%   all_conf_w  = final confidence given into w
%   est_w       = estimated w
%
% author = Daniel Karlik
% update = 30.6.21
% theory = Bc project Daniel Karlik
%
%%  Code
    conf_w_mc       = zeros(l_w,num_mc,dur_sim);        
    median_conf_w   = zeros(l_w,dur_sim);     
    er_model_mc     = zeros(l_w+1,num_mc,dur_sim);      
    er_model_median = zeros(l_w+1,dur_sim);   

    all_er_type = zeros(l_w+1,num_mc); 
    all_conf_w  = zeros(l_w,num_mc);  
    est_w       = zeros(1,num_mc);  
end
