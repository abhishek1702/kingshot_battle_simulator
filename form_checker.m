rally = 0;
test = 0;
Kak = zeros(3,3);     %attacker total kills
Kdk = zeros(3,3);     %defender total kills

if rally == 0                           % just to make sure there are no more than 1 troop type for now
    form_checker_status = 1;            % active to make sure all the matrix calcs in results doesnt run
    
    total_attacker = troop_size(1,4);    % gets total attacker count
    %total_attacker = 169710            % override
    sparsity = 0.06;                     % for total time t which is set to 100 before in script

    inf_range = .30  : sparsity : .7;
    cav_range = .03  : sparsity : .3;
    
    inf_max = round((0.7 - 0.3) /sparsity, 0) + 1;
    cav_max = round((0.3 - 0.03)/sparsity, 0) + 1;
    test_case = zeros( inf_max * cav_max , 4);
                        
    % Loop through every infantry and cavalry combination
for inf_frac = inf_range 

    inf_count = ceil(inf_frac * total_attacker);

    for cav_frac = cav_range

        cav_count = round(cav_frac * total_attacker);
        
        % Calculate the remaining archer fraction
        arch_count = total_attacker - inf_count - cav_count;
        
        % Math Guardrail: Skip combinations that exceed 100% total troops
        if arch_count < 0
            continue; % Immediately skips to the next iteration
        end
        

        test = test + 1;
        troop_size(1, 1:4) = [inf_count, cav_count, arch_count, total_attacker];
        
        %adjust the main file for troop_stat_maker input

        Inf_att(1,1)  = troop_size(1,1);
        Cav_att(1,1)  = troop_size(1,2);
        Arch_att(1,1) = troop_size(1,3);

        troops_stat_maker

        win_rate

        test_case(test, :) = [ test inf_frac*100 cav_frac*100 attacker_win_rate];

    end
end

test_case(test+1:end, :) = []; 
test_case
    
    
end