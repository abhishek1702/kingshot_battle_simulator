% --- Add this to the very top of troops_stat_maker.m ---
global Sa Sd Inf_att Cav_att Arch_att Inf_def Cav_def Arch_def rally t;

% Your existing script calculations continue here...
% (Line 5 will now natively see 'Inf_att' without crashing!)

troop_size = [];

fprintf("********** Attacker stats ********** \n\n");

[Inf_att, Cav_att, Arch_att, squad, stats_att] = troops_input(Inf_att, Cav_att, Arch_att, Sa);  

troop_size(1,:) = squad;


fprintf("\n\n********** Defender stats ********** \n\n");


[Inf_def, Cav_def, Arch_def, squad, stats_def] = troops_input(Inf_def, Cav_def, Arch_def, Sd);

troop_size(2,:) = squad;

troop_size;
troop_size(:, 4) = sum(troop_size(:, 1:3), 2);
Min_troops = min(troop_size(:,4));
fprintf("\nLowest troops count = %d\n",Min_troops);
