SNR_dB = -10:8;

%Alpha = 0 with Symbol Rate = 2W and SCO = 10%
Rs = 2 * 1e6;
alpha = 0;
BER_Numerically_4_0 = ComputeBER_Numerically_4(SNR_dB, alpha, Rs, 0.1); 

%Alpha = 0.5 with Symbol Rate = 4 / 3 * W and SCO = 10%
Rs = (4/3) * 1e6;
alpha = 0.5;
BER_Numerically_4_05 = ComputeBER_Numerically_4(SNR_dB, alpha, Rs, 0.1); 

%Alpha = 1 with Symbol Rate = W and SCO = 10%
Rs = 1e6;
alpha = 1;
BER_Numerically_4_1 = ComputeBER_Numerically_4(SNR_dB, alpha, Rs, 0.1); 

figure;
semilogy(SNR_dB, BER_Numerically_4_0);
grid on;
title('Req. G');
xlabel('SNR in dB');
ylabel('BER');
hold on;
semilogy(SNR_dB, BER_Numerically_4_05);
hold on;
semilogy(SNR_dB, BER_Numerically_4_1);
legend('Numerical BER, alpha = 0', 'Numerical BER, alpha = 0.5', 'Numerical BER, alpha = 1');