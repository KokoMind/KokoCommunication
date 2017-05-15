SNR_dB = -10:8;
BER_Numerically_D = ComputeBER_Numerically_D(SNR_dB);  
figure;
semilogy(SNR_dB, BER_Numerically_D);
grid on;
title('Req. D');
xlabel('SNR in dB');
ylabel('BER');