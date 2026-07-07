%s = zeros(5,2);         %reset the last modifier just in case if its not modified

inf_TG_def
arch_TG_dam


a = sqrt(attacker_count * Min_troops);
b = attacker_stat;
c = defender_stat;

troop_synergy;

s = troop_syn           + tg_inf + tg_arch ;               
            % master stats matrix
            % troop synergy + TG skills + 

% Offense Multipliers (Buffs increase 'z', Debuffs decrease 'z')
s1  = 1 + s(1,1)/100;  % Total Attack Buff
s2  = 1 + s(1,2)/100;  % Total Attack Debuff on you
s3  = 1 + s(2,1)/100;  % Total Lethality Buff
s4  = 1 + s(2,2)/100;  % Total Lethality Debuff on you
s5  = 1 + s(3,1)/100;  % Total Damage Dealt Buff
s6  = 1 + s(3,2)/100;  % Total Damage Dealt Debuff on you

% Defense Multipliers (Enemy buffs decrease 'z', your pierce debuffs increase 'z')
s7  = 1 + s(4,1)/100;  % Enemy HP Buff (Lowers your kills)
s8  = 1 + s(4,2)/100;  % Your HP Debuff on Enemy (Raises your kills)
s9  = 1 + s(5,1)/100;  % Enemy Def Buff (Lowers your kills)
s10 = 1 + s(5,2)/100;  % Your Def Debuff on Enemy (Raises your kills)



z = a * b * s1 * s3 * s5 * s7 * s9     ...      %attacker buffs
    / ( c *  s2 * s4 * s6 * s8 * s10 ) ...      %attacker debuffs
    / 100;



if      Howling_wind_chance_att == 1
    Howling_wind_count_att_k = Howling_wind_count_att_k + ceil(z*Injury_rate/x); % addded injury rate and chance rate to show
                                                                                   % actual contribution by TG skill
elseif Howling_wind_chance_def == 1
    Howling_wind_count_def_k = Howling_wind_count_def_k + ceil(z*Injury_rate/x);
end