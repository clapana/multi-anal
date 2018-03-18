% onset detection
function O = onset2(x)
	%calcolo le differenze di energia tra finestre successive di tot campioni ciascuna
	win = 400;
	dim = floor(size(x, 1)/win);
	onsets = zeros(size(x));
	h = hanning(win);
	found = 0;
	threshold = 1;

	for i = 2 : dim
			%value = sum((x(1 + win*(i-1):win*i).^2).*h) - sum((x(1 + win*(i-2):win*(i-1)).^2).*h);
			value = sum(x(win*(i-1):win*i - 1).^2) - sum(x(1 + win*(i-2):win*(i-1) -1).^2);
			%value = 10*log10(sum((x(1 + win*(i-1):win*i).^2).*h)) - 10*log10(sum((x(1 + win*(i-2):win*(i-1)).^2).*h));

		%rectification
		if (value > threshold && found == 0)
			onsets(1 + (i-2)*win) = 1;
			found = 1;
		endif
		if (value < threshold && found ==1)
			found =0;
		endif
	end

	O = onsets;
end