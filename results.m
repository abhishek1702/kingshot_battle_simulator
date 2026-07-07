fprintf("\nFinal troop count \n");
troop_size_final;
fprintf("Total rounds=%d \n",rounds);

if troop_size_final(2,4) <= 0 || (troop_size_final(1,4) > 0 && troop_size_final(2,4) < troop_size_final(1,4))
                %fix above line if needed
    fprintf("Attacker won\n");
    attacker_win = 1;
else 
    fprintf("Attacker lost\n");
    attacker_win = 0;
end

if form_checker_status == 0

    % Round survivors up
    troop_size_final(:,1:3) = ceil(troop_size_final(:,1:3));
    % Recalculate total survivors
    troop_size_final(:,4) = sum(troop_size_final(:,1:3), 2);
    
    total_kills = troop_size(:,1:3) - troop_size_final(:,1:3);
    total_kills(:,4) = sum(total_kills(:,1:3),2);
    total_injured = ceil(total_kills .* Injury_rate);
    total_injured(:,4) = sum(total_injured(:,1:3),2);
    
    
    Kak(4,:) = sum(Kak(1:3,:),1);
    Kak(4,:) = ceil(Kak(4,:));
    Kak(5,:) = ceil(Kak(4,:) .* Injury_rate);
    Kak(5,3) = total_injured(2,4) - Kak(5,1) - Kak(5,2);         %final kills row 5
    
    Kdk(4,:) = sum(Kdk(1:3,:),1);
    Kdk(4,:) = ceil(Kdk(4,:));
    Kdk(5,:) = ceil(Kdk(4,:) .* Injury_rate);
    Kdk(5,3) = total_injured(1,4) - Kdk(5,1) - Kdk(5,2);         %final kills row 5
    
    %Attacker stats table
    fprintf("\nAttacker stats\n")
    % 1. Your data matrix (3 rows x 5 columns)
    % Row 1: Inf, Row 2: Cav, Row 3: Arch
    % Col 1: Kills, Col 2: Losses, Col 3: Injured, Col 4: Lightly Injured, Col 5: Residents
    BattleData = [Kak(5,1), 0, total_injured(1,1), total_kills(1,1) - total_injured(1,1), troop_size(1,1) - total_kills(1,1);   % Infantry stats
                  Kak(5,2), 0, total_injured(1,2), total_kills(1,2) - total_injured(1,2), troop_size(1,2) - total_kills(1,2);   % Cavalry stats
                  Kak(5,3), 0, total_injured(1,3), total_kills(1,3) - total_injured(1,3), troop_size(1,3) - total_kills(1,3)];  % Archer stats
    
    % 2. Convert to a MATLAB Table
    StatsTable = array2table(BattleData, ...
        'VariableNames', {'Kills', 'Losses', 'Injured', 'Lightly_Injured', 'Residents'}, ...
        'RowNames', {'Infantry', 'Cavalry', 'Archers'});
    
    % 3. Display the table
    disp(StatsTable);
    Attackers_alive = troop_size_final(1,4);
    fprintf("Attackers_alive = %d\n",Attackers_alive);
    
    
    %Defender stats table
    fprintf("\nDefender stats\n")
    % 1. Your data matrix (3 rows x 5 columns)
    % Row 1: Inf, Row 2: Cav, Row 3: Arch
    % Col 1: Kills, Col 2: Losses, Col 3: Injured, Col 4: Lightly Injured, Col 5: Residents
    BattleData = [Kdk(5,1), 0, total_injured(2,1), total_kills(2,1) - total_injured(2,1), troop_size(2,1) - total_kills(2,1);   % Infantry stats
                  Kdk(5,2), 0, total_injured(2,2), total_kills(2,2) - total_injured(2,2), troop_size(2,2) - total_kills(2,2);   % Cavalry stats
                  Kdk(5,3), 0, total_injured(2,3), total_kills(2,3) - total_injured(2,3), troop_size(2,3) - total_kills(2,3)];  % Archer stats
    
    % 2. Convert to a MATLAB Table
    StatsTable = array2table(BattleData, ...
        'VariableNames', {'Kills', 'Losses', 'Injured', 'Lightly_Injured', 'Residents'}, ...
        'RowNames', {'Infantry', 'Cavalry', 'Archers'});
    
    % 3. Display the table
    disp(StatsTable);
    Defenders_alive = troop_size_final(2,4);
    fprintf("Defenders_alive = %d\n\n",Defenders_alive);
    
    fprintf("Ambusher_a = %d\t\t\t",Ambusher_a);
    fprintf("Ambusher_d = %d\t\t\t",Ambusher_d);
    
    fprintf("volley_a   = %d\t\t\t",volley_a);          fprintf("volley_d   = %d\n",volley_d);
    
    
    fprintf("Unyielding_shield_count_att = %d\t\t\t", Unyielding_shield_count_att);
    fprintf("Unyielding_shield_count_def = %d\n", Unyielding_shield_count_def);
    fprintf("Assault_lance_count_att     = %d\t\t\t", Assault_lance_count_att);
    fprintf("Assault_lance_count_def     = %d\n", Assault_lance_count_def);
    fprintf("Howling_wind_count_att      = %d\t\t\t", Howling_wind_count_att);
    fprintf("Howling_wind_count_def      = %d\n", Howling_wind_count_def);
    fprintf("Howling_wind_count_att_k    = %d\t\t", Howling_wind_count_att_k);
    fprintf("Howling_wind_count_def_k    = %d\n", Howling_wind_count_def_k);

end