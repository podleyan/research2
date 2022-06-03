function system = init_system(num_state, num_action, memory)

%% System zavisly na s_t-2, s_t-2, a_t, s_t
P_0 = zeros(3,3,3);
m = 0;
alpha = 0.7;
beta = 0.5;  
delta = 1; 
omega = 1; 

for i3 = 1:3
    for i2 = 1:3
         m = alpha*i2 + beta*i3;
         for i1 = 1:3
             P_0(i1,i2,i3)=exp(-abs(i1-m))^delta*omega; 
         end    
             P_0(:,i2,i3)= P_0(:,i2,i3)/sum(P_0(:,i2,i3));
    end
end



system = struct('P_0', P_0, 'num_state', num_state, 'num_action', num_action, 'memory', memory);
end