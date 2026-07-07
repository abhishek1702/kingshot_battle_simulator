tg_arch = zeros(5,2);
Howling_wind_chance_att = 0;
Howling_wind_chance_def = 0;


if attacker == "Arch_att"

    if     (max(Arch_att(3, :)) >= 3) && (max(Arch_att(3, :)) <= 4) && calculateChance(20) == 1
        Howling_wind_chance_att = 1;
        x = 1 + 50 / 100;

        Howling_wind_count_att = Howling_wind_count_att + 1;
        fprintf('\nHowling_wind_count_att 1 activated\n');

        tg_arch = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                    0    0  ;      % leth    +     leth    -
                    50   0  ;      % damage  +     damage  -
                    0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                    0    0  ];     % defence  -    defence  +  
     
    elseif (max(Arch_att(3, :)) >= 5) && calculateChance(30) == 1
        Howling_wind_chance_att = 1;
        x = 1 + 50 / 100;
        
        Howling_wind_count_att = Howling_wind_count_att + 1;
        fprintf('\nHowling_wind_count_att 2 activated\n');

        tg_arch = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                    0    0  ;      % leth    +     leth    -
                    50   0  ;      % damage  +     damage  -
                    0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                    0    0  ];
    
    end

elseif attacker == "Arch_def"

    if     (max(Arch_def(3, :)) >= 3) && (max(Arch_def(3, :)) <= 4) && calculateChance(20) == 1
        Howling_wind_chance_def = 1;
        x = 1 + 50 / 100;

        Howling_wind_count_def = Howling_wind_count_def + 1;
        fprintf('\nHowling_wind_count_def 1 activated\n');

        tg_arch = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                    0    0  ;      % leth    +     leth    -
                    50   0  ;      % damage  +     damage  -
                    0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                    0    0  ];
     
    elseif (max(Arch_def(3, :)) >=5) && calculateChance(30) == 1
        Howling_wind_chance_def = 1;
        x = 1 + 50 / 100;

        Howling_wind_count_def = Howling_wind_count_def + 1;
        fprintf('\nHowling_wind_count_def 2 activated\n');

        tg_arch = [ 0    0  ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                    0    0  ;      % leth    +     leth    -
                    50   0  ;      % damage  +     damage  -
                    0    0  ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                    0    0  ];
    
    end
end