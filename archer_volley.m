

if    attacker == "Arch_att"
    if max(Arch_att(2, :)) > 6 && calculateChance(10) == 1

        %fprintf("\natt_arch volley triggered\n");
        volley_a = volley_a + 1;

        volley_1 = Ka(idx_def, idx_atk);                         % assign first attack

        battle_calcs                                            % runs battle again

        volley_2 = round(z,4);                                            % assign output from battle_calcs script
        
        Ka(idx_def, idx_atk) = volley_1 + volley_2;
    end

elseif attacker == "Arch_def"
    if max(Arch_def(2, :)) > 6 && calculateChance(10) == 1


        %fprintf("\ndef_arch volley triggered\n");
        volley_d = volley_d + 1;

        volley_1 = Kd(idx_def, idx_atk);                         % assign first attack

        battle_calcs                                            % runs battle again

        volley_2 = round(z,4);                                            % assign output from battle_calcs script
        
        Kd(idx_def, idx_atk) = volley_1 + volley_2;
    end

end
