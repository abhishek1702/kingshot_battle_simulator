% Automatically maps text names to your matrix rows and columns for


% ===================================================================
% 1. FIND THE ROWS (Troop Type: 1=Inf, 2=Cav, 3=Arch)
% ===================================================================
if contains(attacker, 'Inf')
    stat_att_row = 1;
elseif contains(attacker, 'Cav')
    stat_att_row = 2;
elseif contains(attacker, 'Arch')
    stat_att_row = 3;
end

if contains(defender, 'Inf')
    stat_def_row = 1;
elseif contains(defender, 'Cav')
    stat_def_row = 2;
elseif contains(defender, 'Arch')
    stat_def_row = 3;
end

% ===================================================================
% 2. CHOOSE THE RIGHT MATRIX AND EXTRACT STATS
% ===================================================================
% Column 1 is ALWAYS Attack. Column 2 is ALWAYS Defense.

if contains(attacker, '_att')
    % Phase A: Attacker Team is attacking, Defender Team is defending
    attacker_stat = stats_att(stat_att_row, 1); % Row of troop, Col 1 (Attack)
    defender_stat = stats_def(stat_def_row, 2); % Row of troop, Col 2 (Defense)
else
    % Phase B: Defender Team is counter-attacking!
    % Pull Attack from stats_def and Defense from stats_att
    attacker_stat = stats_def(stat_att_row, 1); % Row of troop, Col 1 (Attack)
    defender_stat = stats_att(stat_def_row, 2); % Row of troop, Col 2 (Defense)
end