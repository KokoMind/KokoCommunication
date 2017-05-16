function BER = ComputeBER_Numerically_E(SNR_dB, alpha, Rs_symbol)
	%Numerically.
	Eb = 1;                                    
	a = 1;
	Es = a^2 * Eb;  
	Ts_symbol = 1 / Rs_symbol;
	signal_length = 1000;

	%Sampling parameters
	Fs = 20e6;
	Ts = 1 / Fs;

	%According to Relative Frequency Theorem, Many trials are required in order to converge to the real probabilty of error.
	num_iterations = 50;         
	BER = zeros(size(SNR_dB));
	SNR_dim = 10.^(SNR_dB/10);  
		
	%SRRC Pulse with its matched pulse gives RRC
    p = rcosdesign(alpha, 100, Fs / Rs_symbol, 'sqrt');
    p_matched = rcosdesign(alpha, 100, Fs / Rs_symbol, 'sqrt');

    %LPF
    channel_f = 1e6;
    t=-0.000025:1/Fs:0.000025;
    LPF = 2 * channel_f * sinc (2 * channel_f * t);  %Limited channel frequency response to 1MHZ, this is in time domain.
    
    for i = 1 : length(SNR_dB)
	 accumulated_BER = 0;                            %Required for averaging.
	 No = Es / SNR_dim(i);                           %WTF                  

		 for j = 1 : num_iterations
			 num_bit_errors = 0;

			 %Delta Stream
			 t = 0 : Ts : Ts_symbol * (signal_length - 1);
			 deltas = zeros(size(t));
			 deltas(1 : Fs * Ts_symbol : end) = randi([1 2], 1, signal_length);
			 deltas(deltas == 2) = -1;
             
			 %PROCESS OF TRANSIMITION AND RECEPTION
			 
			 %Pulse Convolution
             s = conv(deltas, p, 'same');

			 %LPF Convolution
             s_LPF = conv(s, LPF, 'same') / Fs;
             
             %Matched Pulse Convolution
             r = conv(s_LPF, p_matched, 'same');

			 %Noise Addition
			 N = sqrt(No/2) * randn(1,length(s_LPF));   %Generate AWGN
			 X = r + N;                           %Received Signal
             
			 %Decision Making
			 sampling_deltas = zeros(size(t));
			 sampling_deltas(1 : Fs * Ts_symbol : end) = 1;
			 X_sampled = sampling_deltas .* X;

			 for k=1:length(X_sampled)
				 if ((X_sampled(k) > 0 && deltas(k) < 0)||(X_sampled(k) < 0 && deltas(k) > 0))
					 num_bit_errors=num_bit_errors+1;
				 end
			 end
			 avg_bit_error = num_bit_errors / signal_length;             
			 accumulated_BER = accumulated_BER + avg_bit_error;  
		 end                                 
	 BER(i) = accumulated_BER / num_iterations;                        
    end
end