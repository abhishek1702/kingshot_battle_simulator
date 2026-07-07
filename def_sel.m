%check for Inf and Arch         attacker

if strcmp(attacker, 'Inf_att') || strcmp(attacker, 'Arch_att')

    if strcmp(defender, 'Inf_def') 
        
        if         troop_size_final(2,1) > 0
            defender = 'Inf_def';
        elseif     troop_size_final(2,2) > 0
            defender = 'Cav_def';
        elseif     troop_size_final(2,3) > 0
            defender = 'Arch_def';
        end
    
    %fprintf('\t\t%s attacking %s\n',attacker,defender);
    end
end

%check for Inf and Arch         defender

if strcmp(attacker, 'Inf_def') || strcmp(attacker, 'Arch_def')

    if strcmp(defender, 'Inf_att') 
        
        if         troop_size_final(1,1) > 0
            defender = 'Inf_att';
        elseif     troop_size_final(1,2) > 0
            defender = 'Cav_att';
        elseif     troop_size_final(1,3) > 0
            defender = 'Arch_att';
        end
    
    %fprintf('\t\t%s attacking %s\n',attacker,defender);
    end
end





% --- CHECK FOR CAVALRY ATTACKER ---
if strcmp(attacker, 'Cav_att')
    
    % Core Game Rule: Cavalry targets Infantry first if they are alive
    if troop_size_final(2,1) > 0 
        
        % Your exact idea: If hitting infantry, check for the 20% flank skill
        if troop_size_final(1,2) > 0 && max(Cav_att(2, :)) > 6 && troop_size_final(2,3) > 0 && calculateChance(20) == 1
            defender = 'Arch_def';  % Skill procs -> Flank to Archers
            Ambusher_a = Ambusher_a + 1;
        else
            defender = 'Inf_def';  % Skill fails -> Attack Infantry normally
        end
        
    % TARGET SHIFT: If Infantry is dead, check who else is on the board
    elseif troop_size_final(2,2) > 0
        defender = 'Cav_def';       % Infantry dead -> Target Cavalry
        
    elseif troop_size_final(2,3) > 0
        defender = 'Arch_def';      % Infantry & Cavalry dead -> Target Archers
    end
    
    %fprintf('\n%s attacking %s\n', attacker, defender);
end



% --- CHECK FOR CAVALRY DEFENDER (RETALIATING) ---
if strcmp(attacker, 'Cav_def')
    
    % Core Game Rule: Enemy Cavalry targets your Infantry first if they are alive
    if troop_size_final(1,1) > 0 
        
        % Check for the 20% flank skill proc on the defender's side
        % Needs: Surviving enemy Cav, enemy Cav tier > 6, and your Archers present
        if troop_size_final(2,2) > 0 && max(Cav_def(2, :)) > 6 && troop_size_final(1,3) > 0 && calculateChance(20) == 1
            defender = 'Arch_att';  % Skill procs -> Flank directly to your Archers
            Ambusher_d = Ambusher_d + 1;
        else
            defender = 'Inf_att';  % Skill fails -> Attack your Infantry normally
        end
        
    % TARGET SHIFT: If your Infantry is completely dead, enemy Cav shifts down your line
    elseif troop_size_final(1,2) > 0
        defender = 'Cav_att';       % Your Infantry dead -> Target your Cavalry
        
    elseif troop_size_final(1,3) > 0
        defender = 'Arch_att';      % Your Infantry & Cavalry dead -> Target your Archers
    end
    
    % Print the final confirmed match-up for this retaliation tick
    %fprintf('\n%s attacking %s\n', attacker, defender);
end