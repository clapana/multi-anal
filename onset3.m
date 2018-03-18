% onset detection
function O = onset3(x)
	%calcolo le differenze di energia tra finestre successive di tot campioni, avanzando di campione in camp
	win = 4000;
	onsets = zeros(size(x));
	h = hanning(win);

	dim = size(x, 1) - win*2;
	for i = 1 : dim
		value = sum((x(i+win:i-1+win*2).^2).*h) - sum((x(i:i-1 + win).^2).*h);
		%value = 10*log10(sum(x(i+win:i-1+win*2).^2)) - 10*log10(sum(x(i:i-1 + win).^2));

		%rectification
		if (value > 0)
			onsets(i) = value;
		endif
		printf("%.2f %%\n", i*100/dim)
		fflush(stdout);
	end

	O = onsets;
end