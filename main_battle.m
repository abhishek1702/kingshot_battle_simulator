Kak = zeros(3,3);     %attacker total kills
Kdk = zeros(3,3);     %defender total kills
Ka = zeros(3,3);     %attacker kills
Kd = zeros(3,3);     %defender kills 


rounds = 0;

troop_size_final = troop_size;
while troop_size_final(1,4) > 0 && troop_size_final(2,4) > 0
    rounds = rounds + 1;
    %fprintf("\n******************* rounds = %d *******************\n",rounds);
    

    Ka = zeros(3,3);     %attacker kills
    Kd = zeros(3,3);     %defender kills 
    

    %  miniround #1
    %fprintf("\n%d.1",rounds);

    attacker = 'Inf_att';
    defender = 'Inf_def';
    
    def_sel;                        %choses the defender troop type
    
    attacker_size
    attacker_stats
    
    battle_calcs                    % battle math, stat battle

    troop_map                       % figures out the K(x,x) matrix

    kill_adjustment;



    %  miniround #2
    %fprintf("\n%d.2",rounds);

    attacker = 'Cav_att';
    defender = 'Inf_def';
    
    def_sel;                        %choses the defender troop type

    attacker_size
    attacker_stats
    
    battle_calcs                    % battle math, stat battle

    troop_map                       % figures out the K(x,x) matrix

    cav_TG_att                      %nothing to do with att/def just att change name

    kill_adjustment

    %  miniround #3
    %fprintf("\n%d.3",rounds);

    attacker = 'Arch_att';
    defender = 'Inf_def';
    
    def_sel;                        %choses the defender troop type
    
    attacker_size
    attacker_stats
    
    battle_calcs                    % battle math, stat battle

    troop_map                       % figures out the K(x,x) matrix

    archer_volley                   % archer twice attack detector

    kill_adjustment

    %  miniround #4
    %fprintf("\n%d.4",rounds);

    attacker = 'Inf_def';
    defender = 'Inf_att';
    
    def_sel;                        %choses the defender troop type

    attacker_size
    attacker_stats
    
    battle_calcs                    % battle math, stat battle

    troop_map                       % figures out the K(x,x) matrix

    kill_adjustment

    %  miniround #5
    %fprintf("\n%d.5",rounds);

    attacker = 'Cav_def';
    defender = 'Inf_att';
    
    def_sel;                        %choses the defender troop type

    attacker_size
    attacker_stats
    
    battle_calcs                    % battle math, stat battle

    troop_map                       % figures out the K(x,x) matrix

    cav_TG_att                      %nothing to do with att/def just att change name

    kill_adjustment

    %  miniround #6
    %fprintf("\n%d.6",rounds);

    attacker = 'Arch_def';
    defender = 'Inf_att';
    
    def_sel;                        %choses the defender troop type

    attacker_size
    attacker_stats
    
    battle_calcs                    % battle math, stat battle

    troop_map                       % figures out the K(x,x) matrix

    archer_volley                   % archer twice attack detector

    kill_adjustment
    

        
    % kills sum and total update
    %fprintf('\nCorrected values\n');
    Ka;
    Kak = Kak + Ka;
    Kd;
    Kdk = Kdk + Kd;
    %kills sum and update
    troop_size_final(2,1) = max(0,troop_size_final(2,1) - sum(Ka(1,:)));
    troop_size_final(2,2) = max(0,troop_size_final(2,2) - sum(Ka(2,:)));
    troop_size_final(2,3) = max(0,troop_size_final(2,3) - sum(Ka(3,:)));
    
    troop_size_final(1,1) = max(0,troop_size_final(1,1) - sum(Kd(1,:))); 
    troop_size_final(1,2) = max(0,troop_size_final(1,2) - sum(Kd(2,:)));
    troop_size_final(1,3) = max(0,troop_size_final(1,3) - sum(Kd(3,:)));
    
    troop_size_final(:,4) = troop_size_final(:,4) .* 0;
    troop_size_final(:,4) = sum(troop_size_final,2);
    troop_size_final = round(troop_size_final, 4);

    % controlling the rounds for testing
    if rounds == 50
        fprintf("\nTotal rounds = %d",rounds);
        break;
    end
end

results