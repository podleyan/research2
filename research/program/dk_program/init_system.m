function system = init_system(num_states, num_actions)
%   Init_system randomly generates 3D array of probabilities with dimension
%   num_state x num_action x num_state
%%  INPUTS/OUTPUTS:
%   num_state   = number of states
%   num_action  = number of actions
%   system      = probability array 
%   P_0, B      = auxiliary variables 
%           
%   author    = Daniel Karlik
%   update    = 29.12.20
%   theory    = Bc thesis Daniel Karlik
%%  Code
    P_0 = ones(num_states, num_actions, num_states);
    norm_P_0 = P_0;
    for i = 1:num_states
        P_0(i,:,:) = rand(1,num_actions, num_states);
    end
    for i = 1:num_actions
        for j = 1:num_states
            norm_P_0(:,i,j) = P_0(:,i,j)./sum(P_0(:,i,j));
        end
    end
    system = norm_P_0;
end