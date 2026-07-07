%% --- 1. 2D SCATTER PLOTTING ENGINE (%) ---
% CHANGE THIS LINE to prevent the GUI popup crash:
figure('Name', 'Battle Simulator Results', 'NumberTitle', 'off', 'visible', 'off');

% Keep the rest of your plotting code exactly the same...
inf_pct  = test_case(:, 2);
cav_pct  = test_case(:, 3);
win_rate = test_case(:, 4); 
scatter(inf_pct, cav_pct, 100, win_rate, 'filled');
% ...





%% --- 1. 2D SCATTER PLOTTING ENGINE (%) ---
figure('Name', 'Battle Simulator Results', 'NumberTitle', 'off');

% Use raw percentage values directly from your test_case matrix
inf_pct  = test_case(:, 2);
cav_pct  = test_case(:, 3);
win_rate = test_case(:, 4); 

% Create 2D scatter plot: X = Infantry %, Y = Cavalry %, colored by Win Rate %
scatter(inf_pct, cav_pct, 100, win_rate, 'filled');
hold on;
    
% Label the axes clearly as percentages
xlabel('infantry percentage (%)');
ylabel('cavalry percentage (%)');
title('Battle Simulator - Troop Composition Sweep');

% Add the percentage victory colorbar on the right side
c = colorbar;
ylabel(c, 'chances of victory [%]', 'FontSize', 12);

% Use 'parula' for a built-in blue-to-yellow gradient natively
colormap('parula'); 

%% --- 2. FIND AND PRINT BEST TROOP RATIOS ---
max_win_rate = max(test_case(:, 4));
best_row_indices = find(test_case(:, 4) == max_win_rate);

fprintf('\n========================================================\n');
fprintf('                BEST PERFORMANCE ANALYSIS                \n');
fprintf('========================================================\n');
fprintf('Maximum Achieved Win Rate: %.2f%%\n', max_win_rate);
fprintf('Number of optimal configurations found: %d\n\n', length(best_row_indices));
fprintf('Optimal Compositions (Infantry / Cavalry / Archer):\n');
fprintf('--------------------------------------------------------\n');

for idx = best_row_indices'
    best_inf = test_case(idx, 2);
    best_cav = test_case(idx, 3);
    best_arch = 100 - best_inf - best_cav;
    
    fprintf('  • Ratio Code: Best %.0f/%.0f/%.0f\n', best_inf, best_cav, best_arch);
    
    % Overlay a magenta diamond directly on the raw % coordinates of the best spot
    hBest = plot(best_inf, best_cav, 'md', 'MarkerFaceColor', 'm', 'MarkerSize', 12, 'LineWidth', 2);
end
fprintf('========================================================\n\n');

% Create the legend using the raw percentages layout
legend(hBest, sprintf('Best %.0f/%.0f/%.0f', best_inf, best_cav, best_arch), 'Location', 'northeast');

%% --- 3. FIXED FULL-RANGE VIEWPORT CONFIGURATION ---
% Explicitly forces the scale to show the full 0 to 100% canvas frame context
set(gca, 'XLim', [-5 105], 'YLim', [-5 105]);
grid on;
box on;
hold off;
drawnow;