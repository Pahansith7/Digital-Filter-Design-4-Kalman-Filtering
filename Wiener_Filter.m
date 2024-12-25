clearvars;
clc;


load("idealECG.mat");

idealECG = resample(idealECG, 500, 128); % resample to match the sampling frequencies
% idealECG signal is resampled to 500Hz

fs = 500; % new sampling rate of both noisy and ideal ECGs.


y = idealECG(1:500); % ideal signal - A single ECG beat
y = y - mean(y);% make sure mean is zero

figure();
plot(y);

x = nECG(1:length(y)); % noisy ECG - Same length as y-ideal signal
x = x - mean(x);% make sure mean is zero

M = 20; % Number of weights/ filter  coefficients

% compute the autocorrelation Cxx
C_XX = xcorr(x, M-1, 'biased');
C_XX_matrix = toeplitz(C_XX(M:end)); 
% Compute the cross-correlation
C_XY = xcorr(x, y, M-1, 'biased');
C_Xy = C_XY(M:end); 
% Compute the Wiener filter weights
w = C_XX_matrix \ C_Xy.';

filteredECG = filter(w,1,nECG-mean(nECG)); % filter signal using the wiener weights

% plot signals
figure;

subplot(3, 1, 1);        
plot(idealECG(1:2000));
title('Ideal ECG Signal');

subplot(3, 1, 2);        
plot(nECG(1:2000));
title('Noisy ECG Signal');

subplot(3, 1, 3);  
plot(filteredECG(1:2000));
title('Wiener Filtered ECG Signal');

% Frequency Domain Analysis
[psd_noisy, f_noisy] = pwelch(nECG, [], [], [], fs);
[psd_denoised, f_denoised] = pwelch(filteredECG, [], [], [], fs);

figure();
plot(f_noisy, 10*log10(psd_noisy), f_denoised, 10*log10(psd_denoised));
title("Frequency Domain Analysis");
legend('Noisy ECG', 'Denoised ECG')
xlabel('Frequency (Hz)');
ylabel('PSD (dB/Hz)');

