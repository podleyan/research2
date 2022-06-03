function adviser = optimal_model(agent, adviser, data)

a = data.action(data.t);                                                       % aktualni akce
s = data.state(data.t);
for i=1:adviser.num_weight
    adviser.opt_stat(:, a, s) = adviser.opt_stat(:,a,s) + belief(i)*adviser.merged_stat(i, :, a, s);
end

adviser.opt_model(:,a,s)= adviser.opt_stat(:, a, s)/sum(adviser.opt_stat(:, a, s));      