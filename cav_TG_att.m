tg_cav = 1;

if attacker == "Cav_att"

    if     (max(Cav_att(3, :)) >= 3) && (max(Cav_att(3, :)) <= 4) && calculateChance(10) == 1
        
        Assault_lance_count_att = Assault_lance_count_att + 1;
        %fprintf('\nAssault_lance_count_att 1 activated\n');

        tg_cav = 2;
     
    elseif (max(Cav_att(3, :)) >= 5) && calculateChance(15) == 1
        
        Assault_lance_count_att = Assault_lance_count_att + 1;
        %fprintf('\nAssault_lance_count_att 2 activated\n');

        tg_cav = 2;
    
    end

    Ka(idx_def, idx_atk) = Ka(idx_def, idx_atk) * tg_cav;

elseif attacker == "Cav_def"
    
    if     (max(Cav_def(3, :)) >= 3) && (max(Cav_def(3, :)) <= 4) && calculateChance(10) == 1
        
        Assault_lance_count_def = Assault_lance_count_def + 1;
        %fprintf('\nAssault_lance_count_def 1 activated\n');

        tg_cav = 2;
     
    elseif (max(Cav_def(3, :)) >= 5) && calculateChance(15) == 1
        
        Assault_lance_count_def = Assault_lance_count_def + 1;
        %fprintf('\nAssault_lance_count_def 2 activated\n');

        tg_cav = 2;
    
    end
    Kd(idx_def, idx_atk) = Kd(idx_def, idx_atk) * tg_cav;
    
end