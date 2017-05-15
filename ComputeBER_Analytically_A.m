function BER = ComputeBER_Analyically_A(SNR_dB)
	% Analytically.
	Eb = 1;                                    %Bit energy
	a = 1;                                     %Decay factor
	Es = a^2 * Eb;                             %Received energy signal
	SNR_dim = 10.^(SNR_dB/10);
	BER = qfunc(sqrt(2 * SNR_dim));
end