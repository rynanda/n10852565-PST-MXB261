
function Sample_Experimental_Data(bins, Data0)

figure
subplot(1,2,1);
h = histogram(Data0, bins, 'Normalization', 'probability'); % Plot probability distribution for Data0
title("Data0")
xlabel("Values")
ylabel("Probability")

probabilities = h.Values;
cdf = cumsum(probabilities); % Cumulative distribution function F(x) for Data0

DataNew = []; % Initialise empty array to create DataNew
rng(30); % Set seed = 30

for i = 1:1000 % Generate 1000 random variables
    u = rand;
    for j = 1:length(cdf) % Based on # of bins
        if u <= cdf(j) % Find appropriate value to sample from Data0 based on rand
            DataNew(i) = ((h.BinEdges(j+1))-(h.BinEdges(j)))*rand+(h.BinEdges(j)); % Generate a random number between the appropriate BinEdges (values) based on rand and cdf ((b-a)*rand+a), then add to DataNew array at the i'th index
            break
        end
    end
end

subplot(1,2,2);
h_new = histogram(DataNew, bins, 'Normalization', 'probability'); % Plot probability distribution for DataNew
title("DataNew")
xlabel("Values")
ylabel("Probability")
sgtitle(sprintf("Probability Distributions for %d bins", bins))

x = 1:1:bins; % Numbers from 1-20 inclusive
p = h.Values; % Get probability values from Data0 probability distribution histogram
q = h_new.Values; % Get probability values from DataNew probability distribution histogram
figure
bar(x,p, 'FaceColor', 'blue', 'FaceAlpha', 0.5) % Bar graph for Data0
hold on
bar(x,q, 'FaceColor', 'red', 'FaceAlpha', 0.5) % Bar graph for DataNew on the same figure
title(sprintf("Data0 (blue) vs. DataNew (red) for %d bins", bins))
xlabel("Bin")
ylabel("Probability")

dkl_Mat  = []; % Initialise empty array to sum for Kullback-Leibler measurement
for i = 1:length(x)
    dkl_Mat(i) = (p(i))*(log(p(i)/q(i))); % Calculate Kullback-Leibler measurement at i, how q (DataNew) differs from p (Data0)
end
dkl_Val = sum(dkl_Mat); % Sum Kullback-Leibler array to get final measurement then print to command window

print = ['KULLBACK-LEIBLER MEASUREMENT - How DataNew differs from Data0 for ', num2str(bins), ' bins: ', num2str(dkl_Val)];
disp(print)

dkl_Mat  = [];
for i = 1:length(x)
    dkl_Mat(i) = (q(i))*(log(q(i)/p(i))); % How p (Data0) differs from q (DataNew)
end
dkl_Val = sum(dkl_Mat); % Sum Kullback-Leibler array to get final measurement then print to command window

print2 = ['KULLBACK-LEIBLER MEASUREMENT - How Data0 differs from DataNew for ', num2str(bins), ' bins: ', num2str(dkl_Val)];
disp(print2);
disp(' ') % Print new line
