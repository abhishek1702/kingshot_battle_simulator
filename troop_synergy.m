

% troop synergy identifier


if contains(attacker, 'Inf') && contains(defender, 'Cav')
    troop_syn = [ 0    0 ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                  0    0 ;      % leth    +     leth    -
                  10   0 ;      % damage  +     damage  -
                  0    0 ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                  0    0 ];     % defense -     defense +        lowers the kills by attacker
elseif contains(attacker, 'Cav') && contains(defender, 'Arch')
    troop_syn = [ 0    0 ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                  0    0 ;      % leth    +     leth    -
                  10   0 ;      % damage  +     damage  -
                  0    0 ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                  0    0 ];     % defense -     defense +        lowers the kills by attacker
elseif contains(attacker, 'Arch') && contains(defender, 'Inf')
    troop_syn = [ 0    0 ;      % attack  +     attack  -        first columns attacker buffs, 2nd columns attacker debuff
                  0    0 ;      % leth    +     leth    -
                  10   0 ;      % damage  +     damage  -
                  0    0 ;      % health  -     health  +        reverse for defense and health cause enemy buffs lowers the kills by attacker
                  0    0 ];     % defense -     defense +        lowers the kills by attacker
else
    troop_syn = zeros(5,2);
end

