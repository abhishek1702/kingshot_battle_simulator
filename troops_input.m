function [Inf, Cav, Arch, squad, stats] = troops_input(Inf, Cav, Arch, S)


stats = [];
squad = [];

%inf calcs
[Inf, weighted_att, weighted_def, current_size] = calculate_troop_stats(Inf, S);

stats(1,1) = weighted_att;
stats(1,2) = weighted_def;

Inf;         % This will now print with the 5th row appended
squad(1,1) = current_size;


%cav calcs
[Cav, weighted_att, weighted_def, current_size] = calculate_troop_stats(Cav, S);

stats(2,1) = weighted_att;
stats(2,2) = weighted_def;

Cav;         % This will now print with the 5th row appended
squad(1,2) = current_size;


%arch calcs
[Arch, weighted_att, weighted_def, current_size] = calculate_troop_stats(Arch, S);

stats(3,1) = weighted_att;
stats(3,2) = weighted_def;

Arch;         % This will now print with the 5th row appended
squad(1,3) = current_size;

stats;
squad;