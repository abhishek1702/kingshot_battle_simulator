function [troop_type, weighted_att, weighted_def, squad] = calculate_troop_stats(troop_type, S)


Ts =   [63  94  132 172 206 243 287  339  400  472  658;             
        189 283 397 516 619 730 862  1017 1200 1416 1973; 	 
       	189 283 397 516 619 730 862  1017 1200 1416 1973;      
        63  94  132 172 206 243 287  339  400  472  658;
		252 378 529 688 825 974 1149 1356 1600 1888 2632;       
        47  71  99  129 155 183 215  254  300  354  494];           % original values


%Ts =   [63  94  1     172 206 1.84      287  339  400  472  658;             
%        189 283 3     516 619 5.52      862  1017 1200 1416 1973; 	 
%       	189 283 3     516 619 5.52      862  1017 1200 1416 1973;      
%        63  94  1     172 206 1.84      287  339  400  472  658;
%		252 378 4     688 825 7.36      1149 1356 1600 1888 2632;       
%        47  71  0.75  129 155 1.38    215  254  300  354  494];           % test values



Tg = [ 1     1.144      1.203   1.263       1.326       1.394 ];   %starts with 0, +1 needed later to adjust the input


a = troop_type;
n = 1;
squad = 1;

Size_troops = size(a,2);
Att_factor = zeros(1, Size_troops);
Def_factor = zeros(1, Size_troops);


for i = 1 : Size_troops

    if     a(4,i) == 1 
        n = 1;
    elseif a(4,i) == 5
        n = 3;
    elseif a(4,i) == 9
        n = 5;
    end

    Att_factor(1,i) = Ts(n,  a(2,i)) * (1 + S (a(4,i)     ,1) /100) * (1 + S((a(4,i)+2) ,1) /100) * Tg(1, a(3,i)+1);
    Def_factor(1,i) = Ts(n+1,a(2,i)) * (1 + S((a(4,i)+1)  ,1) /100) * (1 + S((a(4,i)+3) ,1) /100) * Tg(1, a(3,i)+1);
end

Att_factor;
Def_factor;
attack_power  = ones(1, Size_troops);
defence_power = ones(1, Size_troops);
for i = 1 : Size_troops
    attack_power(1,i)  = Att_factor(1,i) * a(1,i);
    defence_power(1,i) = Def_factor(1,i) * a(1,i);
end

tot_att_power = 0;
tot_def_power = 0;
for i = 1 : Size_troops
    tot_att_power = attack_power(1,i)  + tot_att_power;
    tot_def_power = defence_power(1,i) + tot_def_power;
end

%fprintf('tot_att_power = %0.4f \n'  ,tot_att_power);
%fprintf('tot_def_power = %0.4f \n\n',tot_def_power);

weight = ones(1, Size_troops);
for i = 1 : Size_troops
    weight(1,i) = Att_factor(1,i) * a(1,i) / tot_att_power;
    weight(1,i) = round(weight(1,i),4);

end
weight;

for i = 1:Size_troops
    a(5,i) = weight(1,i);    % row 5 is for the kill weight for each troop ratio
end


weighted_att  = 1;
weighted_def = 1;
for i = 1 : Size_troops
    weighted_att = (Att_factor(1,i) ^ (weight(1,i)) )* weighted_att;
    weighted_att = round(weighted_att,4);

    weighted_def = (Def_factor(1,i) ^ (weight(1,i)) )* weighted_def;
    weighted_def = round(weighted_def,4);
end
weighted_att;
weighted_def;

troop_type = a;
squad = sum(a(1,:));
end