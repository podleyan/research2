function [advisers] = generating_advisers(dur_simulation,num_adviser,adviser,system,type)
%   Generating_advisers generates num_adviser advisers with respect to 
%   chosen type. 
%%  INPUT/OUTPUT:
%   dur_simulation  = duration of simulation
%   num_adviser     = number of generated advisers
%   adviser         = structure adviser {model, num_state, num_action, nu, cas_uziti}
%   system          = primary unknown structure, representing transition 
%   from one state to next one. Intern relations we want to know and predict
%   type            = 1 we get ideal advisers; 2 we get half random and half 
%   ideal advisers, randomly mixed together; 3 we start with ideal adviser
%   which getting worse and worse; 4 we start with bad adviser which
%   improves; else we use random adviser
%
%
%% Code

k = floor(dur_simulation/num_adviser);
    
if type == 1
    for i=1:num_adviser
        adviser(i).cas_uziti = k*i+2;
        adviser(i).model = round(system,2);
    end
elseif type == 2

    num_state   = adviser(1).num_state;
    num_action  = adviser(1).num_action;
    adv_model   = init_system(num_state, num_action);

    p = randperm(num_adviser); 
    for j = 1:num_adviser
        if p(j) < floor(num_adviser/2)
            adviser(j).cas_uziti    = k*j+2;
            adviser(j).model        = round(system,2);
        else
            adviser(j).cas_uziti = k*j+2;
            adviser(j).model = round(adv_model,2);
        end
    end
elseif type == 3
    num_state   = adviser(1).num_state;
    num_action  = adviser(1).num_action;
    adv_model   = init_system(num_state, num_action);
    for i=1:num_adviser
        adviser(i).cas_uziti = k*i+2;
        adviser(i).model = ((num_adviser-i)*round(system,2)+i*round(adv_model,2))/num_adviser;
    end
elseif type == 4
    num_state   = adviser(1).num_state;
    num_action  = adviser(1).num_action;
    adv_model   = init_system(num_state, num_action);
    for i=1:num_adviser
        adviser(i).cas_uziti = k*i+2;
        adviser(i).model = (i*round(system,2)+(num_adviser-i)*round(adv_model,2))/num_adviser;
    end
else
    num_state   = adviser(1).num_state;
    num_action  = adviser(1).num_action;
    adv_model   = init_system(num_state, num_action);
    for i=1:num_adviser
        adviser(i).cas_uziti = k*i+2;
        adviser(i).model = round(adv_model,2);
    end
end
advisers = adviser;

end