ccc             %calling the clear code
variables       %callign variables to remove clutter\

% --- Add this to the very top of battle_prog.m ---
global Sa Sd Inf_att Cav_att Arch_att Inf_def Cav_def Arch_def rally t;

% Your existing script code continue below...
% troops_stat_maker;



Injury_rate = 0.35;          %add rates change when needed  

%inputs stats and troops size and skills, etc.
%molten_fort                                 %test input files with stats and troop values/tiers
%testno2


troops_stat_maker       %calling the stat analyzer and making att and def stats and troop size

win_rate


form_checker            %formation maker
plot_maker