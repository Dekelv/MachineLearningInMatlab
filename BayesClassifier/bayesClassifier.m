load('normdist.mat');

%point 1
%plot datasets
figure;
plot(S1,zeros(1,length(S1)),'bo');
hold on;
plot(S2,zeros(1,length(S2)), 'ro');
hold on;
plot(T,zeros(1,length(T)), 'ks');
title('S1 vs S2 vs T');
xlabel('Value');
ylabel('p(x|w)');

%Getting mean and standard deviation:
S1_mean = mean(S1);
S1_sd = sqrt(var(S1));
S2_mean = mean(S2);
S2_sd = sqrt(var(S2));

%generating gaussian plots
figure;
fplot(@(x) ((1/(sqrt(2*pi)*S1_sd))*exp(-1/2*(((x-S1_mean).^2)/(S1_sd^2)))),[-50 100]);
hold on;
fplot(@(x) ((1/(sqrt(2*pi)*S2_sd))*exp(-1/2*(((x-S2_mean).^2)/(S2_sd^2)))),[-50 100]);
plot(S1,zeros(1,length(S1)),'bo');
hold on;
plot(S2,zeros(1,length(S2)), 'ro');
hold on;
plot(T,zeros(1,length(T)), 'ks');
title('Gaussian functions of S1 and S2');
xlabel('Value');
ylabel('Probability');
legend('S1','S2');

%calculating prior probabilities
S1_size=size(S1);
S2_size=size(S2);
S1_prior=S1_size/(S1_size + S2_size);
S2_prior=S2_size/(S1_size + S2_size);

%ploting normalized probabilities
figure;
fplot(@(x) S1_prior*(1/(sqrt(2*pi)*S1_sd))*exp(-1/2*(((x-S1_mean).^2)/(S1_sd^2))),[-50 100]);
hold on;
fplot(@(x) S2_prior*(1/(sqrt(2*pi)*S2_sd))*exp(-1/2*(((x-S2_mean).^2)/(S2_sd^2))),[-50 100]);
hold on;
plot(S1,zeros(1,length(S1)),'bo');
hold on;
plot(S2,zeros(1,length(S2)), 'ro');
title('Data sets vs P(w)p(x|w) products');
xlabel('Value');
ylabel('Probability');
legend('P(w1)p(x|w1)','P(w2)p(x|w2)');

%solve P(w1)p(x|w1)=P(w2)p(x|w2)
%find roots, determine decision criteria

x_1=37.0607;
x_2=85.8952;

%point 6
%plot
figure;
fplot(@(x) S1_prior*(1/(sqrt(2*pi)*S1_sd))*exp(-1/2*(((x-S1_mean).^2)/(S1_sd^2))),[-50 100]);
hold on;
fplot(@(x) S2_prior*(1/(sqrt(2*pi)*S2_sd))*exp(-1/2*(((x-S2_mean).^2)/(S2_sd^2))),[-50 100]);
hold on;
plot(S1,zeros(1,length(S1)),'bo');
line([x_1 x_1],[0 0.01],'LineWidth',0.5)
line([x_2 x_2],[0 0.01],'LineWidth',0.5)
hold on;
plot(S2,zeros(1,length(S2)), 'ro');
hold on;
title('T values classification');
xlabel('Value');
ylabel('Probability');

%classify
for i=1:length(T)
    if(T(i)<x_1 || T(i)>x_2)
        plot(T(i),0, 'bs');
    else
        plot(T(i),0, 'rs');
    end
end

%determining misclassification rate
S1_er=erf(S1);
S2_er=erf(S2);
