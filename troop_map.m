% 1. Map base troop types cleanly using the full names
troopMap = containers.Map({'Inf', 'Cav', 'Arch'}, {1, 2, 3});

% 2. Split by underscore to isolate the names perfectly
parts_atk = strsplit(attacker, '_');
parts_def = strsplit(defender, '_');

idx_atk = troopMap(parts_atk{1}); % Numeric ID for attacker troop
idx_def = troopMap(parts_def{1}); % Numeric ID for defender troop

% 3. Rout 'z' to your exact grid layout: Rows = Defender, Cols = Attacker
if contains(attacker, '_att')
    Ka(idx_def, idx_atk) = round(z,4);
    %fprintf("Ka(%d, %d) = %d\n", idx_def, idx_atk, z);
    
else
    Kd(idx_def, idx_atk) = round(z,4);
    %fprintf("Kd(%d, %d) = %d\n", idx_def, idx_atk, z);
end