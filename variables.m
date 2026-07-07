troop_size = [];
stats = [];
squad = [];
rounds = 0;
s = zeros(5,2);
x = 0;

%deaths count
Kia = 0; %attack ini
Kid = 0; %infantry def initial
Kca = 0; %cavs
Kcd = 0;
Kaa = 0; %arch
Kad = 0;


Kak = zeros(3,3);     %attacker total kills
Kdk = zeros(3,3);     %defender total kills 

troop_size_final = troop_size;

Ambusher_a = 0;  % count of cavalry bypassing inf and attacking archers     not counting kills only for damage skills
Ambusher_d = 0;

%archer tier 7+ skill
volley_a = 0;
volley_d = 0;

%TG skills
Unyielding_shield_count_att = 0;
Unyielding_shield_count_def = 0;    % inf
        
Assault_lance_count_att = 0;
Assault_lance_count_def = 0;        % cav

Howling_wind_count_att = 0;
Howling_wind_count_def = 0;         % arch

Howling_wind_count_att_k = 0;
Howling_wind_count_def_k = 0;       % arch kills

troop_syn = 0;

form_checker_status = 1;            %just checking if this helps