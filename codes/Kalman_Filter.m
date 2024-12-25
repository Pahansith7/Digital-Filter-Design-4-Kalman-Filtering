clearvars;
close all;
clc;

% load data
load("ECG_rec.mat");
load("idealECG.mat");

idealECG = resample(idealECG, 500, 128); % resample to match the sampling frequencies
% idealECG signal is resampled to 500Hz

fs = 500; % new sampling rate of both noisy and ideal ECGs.
N = length(nECG);

% System Model
a = 1; 
sigma_u = 0.32; % State Transition Noise - obtained using trial and error
sigma_n = 2; % Measurement Noise  - obtained using trial and error

s = zeros(N,1); % estimation / estimated state / estimated signal / denoised signal
M = zeros(N,1); % MMSE
x = nECG - mean(nECG); %Measurement

for i= (2:N)
    
    % prediction
    s_pred = a*s(i-1); % signal prediction for n
    M_pred = (a^2)*M(i-1) + sigma_u^2; % MMSE prediction for n
    
    % estimation
    k = M_pred /(sigma_n^2 + M_pred); % Kalman Gain
    s(i) = s_pred + k*(x(i)- s_pred); % state estimation for n using the measurement and prediction
    M(i) = (1-k)*M_pred; % MMSE estimation
    
end
    
% PLoting ECG signals
filteredECG = s;

figure();

subplot(3, 1, 1);        
plot(idealECG(1:2000));
title('Ideal ECG');

subplot(3, 1, 2);        
plot(nECG(1:2000));
title('Noisy ECG');

subplot(3, 1, 3);  
plot(filteredECG(1:2000));
title('Kalman Filtered ECG');

% Frequency Domain Analysis
[psd_noisy, f_noisy] = pwelch(nECG, [], [], [], fs);
[psd_denoised, f_denoised] = pwelch(filteredECG, [], [], [], fs);

figure();
plot(f_noisy, 10*log10(psd_noisy), f_denoised, 10*log10(psd_denoised));
title("Frequency Domain Analysis");
legend('Noisy ECG', 'Denoised ECG')
xlabel('Frequency (Hz)');
ylabel('PSD (dB/Hz)');

