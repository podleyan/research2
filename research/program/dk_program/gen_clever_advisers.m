function [advisers] = gen_clever_advisers(dur_simulation,num_adv,adviser,system,type)
%   Gen_clever_advisers generates num_adv advisers with respect to 
%   chosen type. 
%%  INPUT/OUTPUT:
%   dur_simulation  = duration of simulation
%   num_adv     = number of generated advisers
%   adviser         = structure adviser {model, num_state, num_action, nu, cas_uziti}
%   system          = primary unknown structure, representing transition 
%   from one state to next one. Intern relations we want to know and predict
%   type            = 1 - we get almost ideal advisers with added some white noise;
%   2 - we get half random and half almost ideal advisers, randomly mixed together
%   also with added white noise; 3 - we start with almost ideal adviser
%   which is getting worse and worse with added some white noise; 4 - we start with 
%   bad adviser which improves; else we use random adviser with some white noise
%
%   author    = Daniel Karlik
%   updated   = 30.6.21
%
%%  Code

    % Create and sort random permutation, where we "update" our advisor  
    order = [2,sort(randperm(dur_simulation-3,num_adv-1))+3];
    dim = size(system);
    if type == 1
        for i=1:num_adv
            adviser(i).t_use = order(i);    %  time of use to advisers        
            gen_model = normrnd(system,0.025);  % adding white noise
            gen_model = round(abs(gen_model),2);% rounding
            for k = 1:dim(2)                    % normalization
                for m = 1:dim(3)
                    gen_model(:,k,m)= gen_model(:,k,m)/sum(gen_model(:,k,m));
                end
            end
            adviser(i).model = gen_model;
        end
    elseif type == 2

        num_state   = adviser(1).num_state;
        num_action  = adviser(1).num_action;
        adv_model   = init_system(num_state, num_action);

        p = randperm(num_adv); 
        for j = 1:num_adv
            if p(j) <= floor(num_adv/2)
                adviser(j).t_use   = order(j);
                gen_model = normrnd(system,0.025);  % adding white noise
                gen_model = round(abs(gen_model),2);% rounding
                for k = 1:dim(2)                    % normalization
                    for m = 1:dim(3)
                        gen_model(:,k,m)= gen_model(:,k,m)/sum(gen_model(:,k,m));
                    end
                end
                adviser(j).model = gen_model;
            else
                adviser(j).t_use = order(j);
                gen_model = normrnd(adv_model,0.025);   % adding white noise
                gen_model = round(abs(gen_model),2);    % rounding
                for k = 1:num_action                    % normalization
                    for m = 1:num_state
                        gen_model(:,k,m)= gen_model(:,k,m)/sum(gen_model(:,k,m));
                    end
                end
                adviser(j).model = gen_model;
            end
        end
    elseif type == 3
        num_state   = adviser(1).num_state;
        num_action  = adviser(1).num_action;
        adv_model   = init_system(num_state, num_action);
        for i=1:num_adv
            adviser(i).t_use = order(i);

            gen_model1 = normrnd(system,0.025);  % adding white noise
            gen_model1 = round(abs(gen_model1),2);% rounding
            for k = 1:dim(2)                    % normalization
                for m = 1:dim(3)
                    gen_model1(:,k,m)= gen_model1(:,k,m)/sum(gen_model1(:,k,m));
                end
            end        
            gen_model2 = normrnd(adv_model,0.025);  % adding white noise
            gen_model2 = round(abs(gen_model2),2);  % rounding
            for k = 1:num_action                    % normalization
                for m = 1:num_state
                    gen_model2(:,k,m)= gen_model2(:,k,m)/sum(gen_model2(:,k,m));
                end
            end        
            adviser(i).model = ((num_adv-i)*gen_model1+i*gen_model2)/num_adv;
        end
    elseif type == 4
        num_state   = adviser(1).num_state;
        num_action  = adviser(1).num_action;
        adv_model   = init_system(num_state, num_action);
        for i=1:num_adv
            adviser(i).t_use = order(i);        
            gen_model1 = normrnd(system,0.025);     % adding white noise
            gen_model1 = round(abs(gen_model1),2);  % rounding
            for k = 1:dim(2)                        % normalization
                for m = 1:dim(3)
                    gen_model1(:,k,m)= gen_model1(:,k,m)/sum(gen_model1(:,k,m));
                end
            end       
            gen_model2 = normrnd(adv_model,0.025);  % adding white noise
            gen_model2 = round(abs(gen_model2),2);  % rounding
            for k = 1:num_action                    % normalization
                for m = 1:num_state
                    gen_model2(:,k,m)= gen_model2(:,k,m)/sum(gen_model2(:,k,m));
                end
            end        
            adviser(i).model = (i*gen_model1+(num_adv-i)*gen_model2)/num_adv;
        end
    else
        num_state   = adviser(1).num_state;
        num_action  = adviser(1).num_action;
        adv_model   = init_system(num_state, num_action);
        for i=1:num_adv
            adviser(i).t_use = order(i);       
            gen_model2 = normrnd(adv_model,0.025);  % adding white noise
            gen_model2 = round(abs(gen_model2),2);  % rounding
            for k = 1:num_action                    % normalization
                for m = 1:num_state
                    gen_model2(:,k,m)= gen_model2(:,k,m)/sum(gen_model2(:,k,m));
                end
            end       
            adviser(i).model = gen_model2;
        end
    end
    advisers = adviser;
end