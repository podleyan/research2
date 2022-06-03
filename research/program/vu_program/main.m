%% Main: testovaci program pro michani jednoduchych modelu
%
% autor     =  YP
% upraveno  =  6.2.22
% teorie    =  Vyzkumny ukol YP
% poznamky  = 
%             
%% Kod
%
%% Uklid
clc;
close all;
clear all; 

%% Inicialisace
dur_simulation = 1000; 


[system, agent, adviser, data, num_adviser] = initialization(dur_simulation); 
data.t = 2;
data = generate_state(data,system);
agent = learning(agent, data);

while data.t < dur_simulation 
data = generate_action(agent, data); 
for i = 1:num_adviser
    for j = 1:adviser.num_weight 
    agent = merging(adviser, agent, data, weight(j), j);
    end 
    adviser = optimal_statistic(agent, adviser, data);
    data = prediction(agent, data, system);
end
data = generate_state(data,system);
agent = learning(agent, data);
data.t = data.t + 1;
end