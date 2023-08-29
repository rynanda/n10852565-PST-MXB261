
function Simulate_Particle_RW(n,p,s,e,w)

N = n; % Number of particles
P = p; % Start position

probabilities = [s, e, w]; % Initialise array based on south/east/west probabilities
probabilities = cumsum(probabilities); % CDF of probabilities
final_coords = zeros(N,2); % Initialise an N x 2 array of zeros to store each particle's final stopped position

rng(20); % Set seed = 20

for i = 1:N
    if P == 1
        position_initial = [50 99]; % Start at 50, 99 if P = 1
    else
        position_initial = [round(rand*99), 99]; % Start at [(a random number between 0 and 99), 99] if P is not 1 - must be rand
    end
    position = []; % To keep track of current positions
    position(1,:) = position_initial; % Initial position
    step_counter = 2; % Keep track of steps taken, starts at 2 to account for next position and check previous position
    end_checker = 1; % Check if the particle stops walking, 1 = keep walking, 0 = stop walking
    while end_checker ~= 0
        u = rand;
        if position(step_counter-1,2) > 0 % If my y-coord is not equal to 0
            if u <= probabilities(1) % Try to move south based on CDF
                if ~ismember((position(step_counter-1,:) + [0 -1]),final_coords,"rows") % If south position is unoccupied,
                    position(step_counter,:) = position(step_counter-1,:) + [0 -1]; % Move south
                else
                    end_checker = 0; % If south position is occupied, stop walking
                end
            elseif u <= probabilities(2) % Try to move east
                if ~ismember((position(step_counter-1,:) + [1 0]),final_coords,"rows") % If east position is unoccupied,
                    position(step_counter,:) = position(step_counter-1,:) + [1 0]; % Move east
                    if position(step_counter,1)>99 % If new x-coord is more than 99, then we have moved across the boundary, so
                        position(step_counter,1) = 1; % Move particle over to the left boundary, x = 1
                    end
                else % If east position occupied,
                    u = rand;
                    if u <= 1/2 % Try to move south first
                        if ~ismember((position(step_counter-1,:) + [0 -1]),final_coords,"rows") % If south position is unoccupied,
                            position(step_counter,:) = position(step_counter-1,:) + [0 -1]; % Move south
                        elseif ~ismember((position(step_counter-1,:) + [-1 0]),final_coords,"rows") % Only one way to go, west
                            position(step_counter,:) = position(step_counter-1,:)+[-1 0]; % Move west if unoccupied
                            if position(step_counter,1)<0 % If new x-coord is less than 0, then we have moved across the boundary, so
                                position(step_counter,1) = 99; % Move particle over to the right, x = 99
                            end
                        else
                            end_checker = 0; % Stop walking if both south and west positions are occupied
                        end
                    else % Try to move west first
                        if ~ismember((position(step_counter-1,:) + [-1 0]),final_coords,"rows") % If west position is unoccupied,
                            position(step_counter,:) = position(step_counter-1,:)+[-1 0]; % Move west
                            if position(step_counter,1)<0
                                position(step_counter,1) = 99;
                            end
                        else % West position occupied, must move south
                            if ~ismember((position(step_counter-1,:) + [0 -1]),final_coords,"rows") % If south position is unoccupied,
                                position(step_counter,:) = position(step_counter-1,:) + [0 -1]; % Move south
                            else
                                end_checker = 0; % Stop walking if both west and south positions are occupied
                            end
                        end
                    end
                end
            else % Try to move west, same logic as above
                if ~ismember((position(step_counter-1,:) + [-1 0]),final_coords,"rows")   
                    position(step_counter,:) = position(step_counter-1,:)+[-1 0];
                    if position(step_counter,1)<0
                        position(step_counter,1) = 99;
                    end
                else
                    u = rand;
                    if u <= 1/2
                        if ~ismember((position(step_counter-1,:) + [0 -1]),final_coords,"rows")
                            position(step_counter,:) = position(step_counter-1,:) + [0 -1];
                        elseif ~ismember((position(step_counter-1,:) + [1 0]),final_coords,"rows")
                            position(step_counter,:) = position(step_counter-1,:) + [1 0];
                            if position(step_counter,1)>99
                                position(step_counter,1) = 1;
                            end
                        else
                            end_checker = 0;
                        end
                    else
                        if ~ismember((position(step_counter-1,:) + [1 0]),final_coords,"rows")
                            position(step_counter,:) = position(step_counter-1,:) + [1 0];
                            if position(step_counter,1)>99
                                position(step_counter,1) = 1;
                            end
                        else
                            if ~ismember((position(step_counter-1,:) + [0 -1]),final_coords,"rows")
                                position(step_counter,:) = position(step_counter-1,:) + [0 -1];
                            else
                                end_checker = 0;
                            end
                        end
                    end
                end
            end
        else
            end_checker = 0; % Must be that y-coord is 0 and we've reached the bottom of the domain, stop walking
        end
        step_counter = step_counter + 1; % Increase number of steps
    end
    final_coords(i,1) = position(end,1); % Record final x-coord
    final_coords(i,2) = position(end,2); % Record final y-coord
end

histogram(final_coords(:,1), 99, "BinEdges", 0:100) % Plot histogram of walks, 99 bins for each possible x-coord stopped

if e == 1/3
    probcase = 'i.';
elseif e == 1/6
    probcase = 'ii.';
elseif e == 1/10
    probcase = 'iii.';
else
    probcase = 'iv.';
end

if p == 1
    starting = '1';
else
    starting = 'rand';
end

disp(['For ', num2str(n), ' particles and P = ', starting, ' probability case ', probcase, ':'])
distmean = mean(final_coords(:,1))
distvar = var(final_coords(:,1))
xlim([0, 100])
