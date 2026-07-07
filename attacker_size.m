% Automatically maps text names to your matrix rows and columns

% 1. Find Row (1 = Attacker Team, 2 = Defender Team)
if contains(attacker, '_att')
    att_row = 1;
else
    att_row = 2;
end

if contains(defender, '_def')
    def_row = 2;
else
    def_row = 1;
end

% 2. Find Column (1 = Infantry, 2 = Cavalry, 3 = Archer)
if contains(attacker, 'Inf')
    att_col = 1;
elseif contains(attacker, 'Cav')
    att_col = 2;
elseif contains(attacker, 'Arch')
    att_col = 3;
end

if contains(defender, 'Inf')
    def_col = 1;
elseif contains(defender, 'Cav')
    def_col = 2;
elseif contains(defender, 'Arch')
    def_col = 3;
end

% 3. Automatically pull the exact troop counts from your table
attacker_count = troop_size_final(att_row, att_col);
defender_count = troop_size_final(def_row, def_col);            %not really needed

