

% Determine if we are adjusting Attacker kills (Ka) or Defender kills (Kd)

if     contains(attacker, '_att')       % Attacker kill adjustments
    
    % kills by Inf_att

    Ka(1,1) = min(troop_size_final(2,1), Ka(1,1));
    Ka(2,1) = min(troop_size_final(2,2), Ka(2,1));
    Ka(3,1) = min(troop_size_final(2,3), Ka(3,1));
    
    % kills by Cav_att
    
    Ka(1,2) = min(troop_size_final(2,1) - Ka(1,1), Ka(1,2));
    Ka(2,2) = min(troop_size_final(2,2) - Ka(2,1), Ka(2,2));
    Ka(3,2) = min(troop_size_final(2,3) - Ka(3,1), Ka(3,2));

    % kills by Arch_att
    
    Ka(1,3) = min(troop_size_final(2,1) - Ka(1,1) - Ka(1,2), Ka(1,3));
    Ka(2,3) = min(troop_size_final(2,2) - Ka(2,1) - Ka(2,2), Ka(2,3));
    Ka(3,3) = min(troop_size_final(2,3) - Ka(3,1) - Ka(3,2), Ka(3,3));

    Ka;
    
elseif contains(attacker, '_def')       % Defender kill adjustments

    % kills by Inf_def

    Kd(1,1) = min(troop_size_final(1,1), Kd(1,1));
    Kd(2,1) = min(troop_size_final(1,2), Kd(2,1));
    Kd(3,1) = min(troop_size_final(2,3), Kd(3,1));
        
    % kills by Cav_def

    Kd(1,2) = min(troop_size_final(1,1) - Kd(1,1), Kd(1,2));
    Kd(2,2) = min(troop_size_final(1,2) - Kd(2,1), Kd(2,2));
    Kd(3,2) = min(troop_size_final(2,3) - Kd(3,1), Kd(3,2));
    
    % kills by Arch_def
    
    Kd(1,3) = min(troop_size_final(1,1) - Kd(1,1) - Kd(1,2), Kd(1,3));
    Kd(2,3) = min(troop_size_final(1,2) - Kd(2,1) - Kd(2,2), Kd(2,3));
    Kd(3,3) = min(troop_size_final(2,3) - Kd(3,1) - Kd(3,2), Kd(3,3));

    Kd;
end













