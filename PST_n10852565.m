 
%% Part 1 - A Biased Random Walk - 10 Marks
 
% Figure 1 - 2x2 plots for P = 1, N = 100
figure, hold on

subplot(2,2,1);
Simulate_Particle_RW(100, 1, 1/3, 1/3, 1/3) % Case i.
PlotDetails(1); % Add title, xlabel, ylabel, and adjust font size
subplot(2,2,2);
Simulate_Particle_RW(100, 1, 2/3, 1/6, 1/6) % Case ii.
PlotDetails(2);
subplot(2,2,3);
Simulate_Particle_RW(100, 1, 3/5, 1/10, 3/10) % Case iii.
PlotDetails(3);
subplot(2,2,4);
Simulate_Particle_RW(100, 1, 3/5, 3/10, 1/10) % Case iv.
PlotDetails(4);

sgt = sgtitle("Figure 1 - P = 1, N = 100");
sgt.FontSize = 20;
hold off

% Figure 2 - 2x2 plots for P = 1, N = 200
figure, hold on

subplot(2,2,1);
Simulate_Particle_RW(200, 1, 1/3, 1/3, 1/3) % Case i.
PlotDetails(1);
subplot(2,2,2);
Simulate_Particle_RW(200, 1, 2/3, 1/6, 1/6) % Case ii.
PlotDetails(2);
subplot(2,2,3);
Simulate_Particle_RW(200, 1, 3/5, 1/10, 3/10) % Case iii.
PlotDetails(3);
subplot(2,2,4);
Simulate_Particle_RW(200, 1, 3/5, 3/10, 1/10) % Case iv.
PlotDetails(4);

sgt = sgtitle("Figure 2 - P = 1, N = 200");
sgt.FontSize = 20;
hold off

% Figure 3 - 2x2 plots for P = rand, N = 100
figure, hold on
subplot(2,2,1);
Simulate_Particle_RW(100, rand, 1/3, 1/3, 1/3) % Case i.
PlotDetails(1);
subplot(2,2,2);
Simulate_Particle_RW(100, rand, 2/3, 1/6, 1/6) % Case ii.
PlotDetails(2);
subplot(2,2,3);
Simulate_Particle_RW(100, rand, 3/5, 1/10, 3/10) % Case iii.
PlotDetails(3);
subplot(2,2,4);
Simulate_Particle_RW(100, rand, 3/5, 3/10, 1/10) % Case iv.
PlotDetails(4);

sgt = sgtitle("Figure 3 - P = rand, N = 100");
sgt.FontSize = 20;
hold off

% Figure 4 - 2x2 plots for P = rand, N = 200
figure, hold on

subplot(2,2,1);
Simulate_Particle_RW(200, rand, 1/3, 1/3, 1/3)
PlotDetails(1);
subplot(2,2,2);
Simulate_Particle_RW(200, rand, 2/3, 1/6, 1/6)
PlotDetails(2);
subplot(2,2,3);
Simulate_Particle_RW(200, rand, 3/5, 1/10, 3/10)
PlotDetails(3);
subplot(2,2,4);
Simulate_Particle_RW(200, rand, 3/5, 3/10, 1/10)
PlotDetails(4);

sgt = sgtitle("Figure 4 - P = rand, N = 200");
sgt.FontSize = 20;
hold off

%% Part 2 - Sampling from Experimental Data - 5 Marks
load('sampledata2023.mat')

Sample_Experimental_Data(20, Data0);
%%
Sample_Experimental_Data(10, Data0);
%%
Sample_Experimental_Data(40, Data0);


















