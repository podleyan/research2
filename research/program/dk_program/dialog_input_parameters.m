function [dur_sim,l_w,w,chosen_type,num_adviser,pred_type,num_state,...
    num_action,num_mc,seed] = dialog_input_parameters(dia)
%   dialog_input_parameters generates simulation parameters with respect to
%   input
%%  INPUT/OUTPUT:
%   dia         = indicator of dialog [1/else] = [YES/NO]
%   dur_sim     = duration of simulation              
%   l_w         = size of w
%   w           = trust parameter
%   chosen_type = chosen type of used advisers
%   chosen_type = 1 - ideal advisers with noise;
%   2 - half random and half ideal advisers, randomly mixed together
%   3 - start with ideal adviser gets worse 
%   4 - start bad adviser improves to ideal
%   else - random adviser with noise
%   num_adviser = number of generated advisers
%   pred_type   = chosen type of proposed predictions [0/1] = [stoch,max]
%   num_state   = number of states in simulation
%   num_action  = number of actions in simulation
%   num_mc      = number of performed Monte Carlo cycles
%   seed        = seed used for random generation system and other
%   variables
%
% author = Daniel Karlik
% update = 6.7.21
% theory = Bc project Daniel Karlik
%
%%  Code
    if dia == 1
        prompt          = 'How long should simulation take? ';
        dur_sim         = ceil(input(prompt));
        while ceil(dur_sim) <= 5
            disp('You are required to enter number >= 5 ');
            dur_sim = ceil(input(prompt));
        end
        prompt          = 'What is the dimension of w? ';
        l_w             = ceil(input(prompt));
        while  ceil(l_w) < 2
            disp('You are required to enter number > 1 ');
            l_w = ceil(input(prompt));
        end
        w               = (0:l_w-1)/(l_w-1);
        prompt          = 'What type of adviser do you want to use? \n 1-id, 2-mix, 3-id->bad, 4-bad->id, else-rand \n';
        chosen_type     = input(prompt);
        while  ~isscalar(chosen_type)
            disp('You are required to enter number ');
            chosen_type = round(input(prompt));
        end
        prompt          = 'How many forms of adviser should be generated? ';
        num_adviser     = round(input(prompt));
        while round(num_adviser) > dur_sim-2
            disp('You are required to enter number smaller than dur_sim-2 ');
            num_adviser = ceil(input(prompt));
        end
        prompt          = 'What type of prediction do you want 0-Prob, 1-maxPr? ';
        pred_type       = input(prompt);
        while  ~isscalar(pred_type)
            disp('You are required to enter number ');
            pred_type = input(prompt);
        end
        prompt          = 'How many states can be observed? ';
        num_state       = round(input(prompt));
        while ~isscalar(num_state) || round(num_state) < 1
            disp('You are required to enter number bigger than 1 ');
            num_state = round(input(prompt));
        end
        prompt          = 'How many actions can be used? ';
        num_action      = round(input(prompt));
        while ~isscalar(num_action) || round(num_action) < 1
            disp('You are required to enter number bigger than 1 ');
            num_action = round(input(prompt));
        end
        prompt          = 'How many MC cycles should be performed? ';
        num_mc          = input(prompt);
        while ~isscalar(num_mc) || round(num_mc) < 1
            disp('You are required to enter an integer bigger than 1 ');
            num_mc = ceil(input(prompt));
        end
        prompt          = 'What seed will be used for generating system? ';
        seed            = input(prompt);
        while ~isscalar(seed)
            disp('You are required to enter an integer ');
            seed = input(prompt);
        end
    else % pre-set parameters
        dur_sim         = 200;         
        w               = [0 1/2 1];    
        l_w             = length(w);        
        chosen_type     = 1;            
        num_adviser     = 20;
        pred_type       = 1;
        num_state       = 3;
        num_action      = 3;
        num_mc          = 500;
        seed            = 3;
    end
end