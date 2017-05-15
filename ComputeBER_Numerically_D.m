function BER = ComputeBER_Numerically_D(SNR_dB)
	%Numerically.
	Eb = 1;                                    
	a = 1;
	Es = a^2 * Eb;  
	Ts_symbol = 1e-6;
	signal_length = 10;

	%Sampling parameters
	Fs = 20e6;
	Ts = 1 / Fs;

	%According to Relative Frequency Theorem, Many trials are required in order to converge to the real probabilty of error.
	num_iterations = 50;         
	BER = zeros(size(SNR_dB));
	SNR_dim = 10.^(SNR_dB/10);  
		
	%Triangular Pulse
	t = 0 : Ts : Ts_symbol;
	p = abs (2 * (t / Ts_symbol - floor ( t / Ts_symbol + 0.5 )));
	p = p ./ sqrt(sum(p.^2) * (1 / Fs));
	%plot(t,p);
	%figure;

	%Matched Pulse: Triangular Pulse
	g = abs (2 * ((Ts_symbol-t) / Ts_symbol - floor ( (Ts_symbol-t) / Ts_symbol + 0.5 )));
	g = g ./ sqrt(sum(g.^2) * (1 / Fs));

	for i = 1 : length(SNR_dB)    
	 accumulated_BER = 0;                            %Required for averaging.
	 No = Fs * Es / SNR_dim(i);                      %WTF                  

		 for j = 1 : num_iterations
			 num_bit_errors = 0;

			 %Delta Stream
			 t = 0 : Ts : Ts_symbol * (signal_length - 1);
			 deltas = zeros(size(t));
			 deltas(1 : Fs * Ts_symbol : end) = randi([1 2], 1, signal_length);
			 deltas(deltas == 2) = -1;
			 %stem(t, deltas);
			 
			 %PROCESS OF TRANSIMITION AND RECEPTION
			 
			 %Pulse Convolution
			 s = conv(deltas, p, 'same');
			 %plot(t, s);
			
			 %LPF Convolution
             channel_f = 1000000;
             channel_sampling_f = 1000000000;
             t=-0.00002:1/channel_sampling_f:0.00002;
             LPF = 2 * channel_f * sinc (2 * channel_f * t);                               %Limited channel frequency response to 1MHZ
			 s_LPF = conv(s, LPF);
			 %figure;
             figure;
			 plot(1:length(s_LPF), s_LPF);
			 
			 %Noise Addition
			 N = sqrt(No/2) * randn(1,length(s_LPF));   %Generate AWGN
			 r = s + N;                           %Received Signal
			 %figure;
			 %plot(t,r);
			 
			 %Matched Filter Convolution
			 X = conv(r, g, 'same');
			 %figure;
			 %plot(t,X);
			 
			 %Decision Making
             size(X)
			 sampling_deltas = zeros(size(t));
             size(t)
			 sampling_deltas(1 : Fs * Ts_symbol : end) = 1;
			 X_sampled = sampling_deltas .* X;
			 %figure;
			 %stem(t,X_sampled);

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