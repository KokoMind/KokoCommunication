SNR_dB = -10:8;

%Alpha = 0 with Symbol Rate = 2W
Rs = 2 * 1e6;
alpha = 0;
BER_Numerically_E_0 = ComputeBER_Numerically_E(SNR_dB, alpha, Rs); 

%Alpha = 0 with Symbol Rate = 2W
Rs = 4/3 * 1e6;
alpha = 0.5;
BER_Numerically_E_05 = ComputeBER_Numerically_E(SNR_dB, alpha, Rs); 

%Alpha = 0 with Symbol Rate = 2W
Rs = 1e6;
alpha = 1;
BER_Numerically_E_1 = ComputeBER_Numerically_E(SNR_dB, alpha, Rs); 

figure;
semilogy(SNR_dB, BER_Numerically_E_0);
grid on;
title('Req. E');
xlabel('SNR in dB');
ylabel('BER');
hold on;
semilogy(SNR_dB, BER_Numerically_E_05);
hold on;
semilogy(SNR_dB, BER_Numerically_E_1);
hold on;
semilogy(SNR_dB, BER_Numerically_A);
legend('Numerical BER, alpha = 0', 'Numerical BER, alpha = 0.5', 'Numerical BER, alpha = 1');