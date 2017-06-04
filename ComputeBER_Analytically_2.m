function BER = ComputeBER_Analytically_2(SNR_dB)
	%Analytically
	%At First, we should get p(t) and g(t)
	%Sampling parameters
	Fs = 20e6;
	Ts = 1 / Fs;
	
	Ts_symbol = 1e-6;
	t = 0 : Ts : Ts_symbol;
	p = abs (2 * (t / Ts_symbol - floor ( t / Ts_symbol + 0.5 )));
	p = p ./ sqrt(sum(p.^2) * (1 / Fs));
	g = rectangularPulse(t);
	g = g ./ sqrt(sum(g.^2) * (1 / Fs));
	
	Eb = 1;                                    %Bit energy
	a = 1;                                     %Decay factor
	Es = a^2 * Eb;                             %Received energy signal
	Eg = 1;                                    %Energy of g(t)
	SNR_dim = 10.^(SNR_dB/10);
	No = Es ./ SNR_dim; 
	integral_p = 0.5 * Ts_symbol * max(p);      %Integral of a Triangle is half * base * height
	BER = qfunc(sqrt(2 * (a^2 * max(g)^2 * integral_p^2) ./ (No * Eg)));       %See the derivation of this equation     
end