SNR_dB = -10:8;

BER_Numerically_3 = ComputeBER_Numerically_3(SNR_dB);

%Alpha = 0 with Symbol Rate = 2W
Rs = 2 * 1e6;
alpha = 0;
BER_Numerically_4_0 = ComputeBER_Numerically_4(SNR_dB, alpha, Rs, 0); 

%Alpha = 0.5 with Symbol Rate = 4 / 3 * W
Rs = 4/3 * 1e6;
alpha = 0.5;
BER_Numerically_4_05 = ComputeBER_Numerically_4(SNR_dB, alpha, Rs, 0); 

%Alpha = 1 with Symbol Rate = W
Rs = 1e6;
alpha = 1;
BER_Numerically_4_1 = ComputeBER_Numerically_4(SNR_dB, alpha, Rs, 0); 

figure;
semilogy(SNR_dB, BER_Numerically_3);
grid on;
title('Req. F');
xlabel('SNR in dB');
ylabel('BER');
hold on;
semilogy(SNR_dB, BER_Numerically_4_0);
hold on;
semilogy(SNR_dB, BER_Numerically_4_05);
hold on;
semilogy(SNR_dB, BER_Numerically_4_1);

legend('Numerical BER, System 3', 'Numerical BER, System 4, alpha = 0', 'Numerical BER, System 4, alpha = 0.5', 'Numerical BER, System 4, alpha = 1');