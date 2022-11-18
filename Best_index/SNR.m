
function snr=SNR(I,In)
% Calculate signal-to-noise ratio
% I :original signal
% In:noisIn signal(ie. original signal + noise signal)             
sigPower = sum(abs(I).^2)/length(I) ;            %Pure signal power
noisePower=sum(abs(In-I).^2)/length(In-I)  ;     %Noise signal power
snr=10*log10(sigPower/noisePower) ;              %Calculate signal-to-noise ratio  