% onset detection
function O = onset(x)
	x_max = max(x);
	nu = 0.999;
	b = [1-nu];
	a = [1 -nu];
	env = filter(b, a, abs(x));
	env = env/x_max;
	onsets = zeros(size(x));

	threshold = 10**(-15/20);
	
	dim = size(x, 1);
	found = 0;
	for k = 2 : dim
		if (env(k, 1) - env(k-1, 1) > threshold && found == 0)
			found = 1;
			onsets(k-1) = 1;
			k_temp = k;
		else
			env(k, 1) = 0;
		endif
		if (found == 1 && (k-k_temp)==4410)
			found = 0;
		endif
		printf("%.2f %%\n", k*100/dim)
		fflush(stdout);
	end

	O = onsets;
end