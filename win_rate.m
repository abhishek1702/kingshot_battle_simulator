attacker_wins = 0;
attacker_surviors = 0;
defender_surviors = 0;


for i = 1:t

    main_battle;

    if attacker_win == 1
        attacker_wins = attacker_wins + 1;
    end
    attacker_wins;

    if t >= 20
        if t == 20
            attacker_win_rate = attacker_wins * 100 / 20;
            fprintf('\n\nAttacker Win chance percent = %.2f%%\n\n',attacker_win_rate);
            if attacker_win_rate <= 40
                break;
            end

        end
    end
    
end

attacker_win_rate = attacker_wins * 100 / t;
fprintf('\n\nAttacker Win chance percent = %.2f%%\n\n',attacker_win_rate);