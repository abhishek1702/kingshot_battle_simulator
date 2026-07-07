tg_inf = zeros(5,2);

if defender == "Inf_att"

    if     (max(Inf_att(3, :)) >= 3) && (max(Inf_att(3, :)) <= 4) && calculateChance(25) == 1
        
        Unyielding_shield_count_att = Unyielding_shield_count_att + 1;
        fprintf('\nUnyielding_shield_att 1 activated\n');

        tg_inf = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                   0    0  ;      % leth    +     leth    -
                   0    36 ;      % damage  +     damage  -
                   0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                   0    0  ];
     
    elseif (max(Inf_att(3, :)) >= 5) && calculateChance(37.5) == 1
        
        Unyielding_shield_count_att = Unyielding_shield_count_att + 1;
        fprintf('\nUnyielding_shield_att 2 activated\n');

        tg_inf = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                   0    0  ;      % leth    +     leth    -
                   0    36 ;      % damage  +     damage  -
                   0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                   0    0  ];
    
    end

elseif defender == "Inf_def"

    if     (max(Inf_def(3, :)) >= 3) && (max(Inf_def(3, :)) <= 4) && calculateChance(25) == 1
        
        Unyielding_shield_count_def = Unyielding_shield_count_def + 1;
        fprintf('\nUnyielding_shield_def 1 activated\n');

        tg_inf = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                   0    0  ;      % leth    +     leth    -
                   0    36 ;      % damage  +     damage  -
                   0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                   0    0  ];
     
    elseif (max(Inf_def(3, :)) >= 5) && calculateChance(37.5) == 1
        
        Unyielding_shield_count_def = Unyielding_shield_count_def + 1;
        fprintf('\nUnyielding_shield_def 2 activated\n');

        tg_inf = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                   0    0  ;      % leth    +     leth    -
                   0    36 ;      % damage  +     damage  -
                   0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                   0    0  ];
    
    end
end