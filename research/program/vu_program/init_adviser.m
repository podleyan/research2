function adviser = init_adviser(num_state, num_action, num_weight)

model = zeros(num_state, num_action, num_state);
belief = ones(1,num_weight + 1);
weight = zeros(1, num_weight + 1);
for i=1:num_weight
    belief(i) = belief(i)/num_weight;
    weight(i) =  i/num_weight; 
end 

merged_stat = zeros(num_weight, num_state, num_action, num_state);
merged_model = zeros(num_weight, num_state, num_action, num_state);
opt_stat = zeros(num_state, num_action, num_state); 
opt_model = zeros(num_state, num_action, num_state); 
adviser = struct('model', model,'weight', weight, 'belief', belief, 'num_weight', num_weight, 'merged_stat', merged_stat, ...
    'merged_model', merged_model, 'opt_stat', opt_stat, 'opt_model', opt_model); 
end 