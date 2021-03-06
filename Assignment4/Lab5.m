clear all;
close all;
ID = "S4151968";
info = audioinfo('corrupted_voice.wav');
[y, Fs] = audioread('corrupted_voice.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
figure('NumberTitle', 'off', 'Name', "RAW AUDIO PLOT");
plot(t,y)
xlabel('Time')
ylabel('Audio Signal')
title(["RAW AUDIO SIGNAL PLOT ["+ID+"]"])

%figure
%plot(y);
signal = y;
N = size(signal,1);
Fn = Fs/2;
FFTsignal = fft(signal)/N;
frequencyVec = linspace(0, 1, fix(N/2)+1)*Fn;                                     
Iv = 1:length(frequencyVec);                                                      
[pks,frqs] = findpeaks(abs(FFTsignal(Iv))*2, frequencyVec, 'MinPeakHeight',0.1);

figure('NumberTitle', 'off', 'Name', "AUDIO SIGNAL PEAKS");
plot(frequencyVec, abs(FFTsignal(Iv))*2)
hold on
labs = {};
for i=1:length(frqs)
    labs = [labs,sprintf(' (%f)',frqs(i))];
end
plot(frqs, pks, '*r')
xlabel("Frequency")
ylabel("Amplitude")
text(frqs,pks,labs)
title(["AUDIO SIGNAL PEAKS ["+ID+"]"])
hold off
grid

fcutlow = frqs(1);
fcuthigh = frqs(2);
order = 4;
[b,a]=butter(order,[0.010 fcuthigh/10.^5],'bandpass');
fOut = filter(b, a, y);
p = audioplayer(fOut, Fs);
p.play;
audiowrite('lab5_output_voice.wav', fOut, Fs)

%figure
%plot(y);
signal = fOut;
N = size(signal,1);
Fn = Fs/2;
FFTsignal = fft(signal)/N;
frequencyVec = linspace(0, 1, fix(N/2)+1)*Fn;                                     
Iv = 1:length(frequencyVec);                                                      
[pks,frqs] = findpeaks(abs(FFTsignal(Iv))*2, frequencyVec, 'MinPeakHeight',0.1);

figure('NumberTitle', 'off', 'Name', "AUDIO SIGNAL PEAKS AFTER FILTER");
plot(frequencyVec, abs(FFTsignal(Iv))*2)
hold on
labs = {};
for i=1:length(frqs)
    labs = [labs,sprintf(' (%f)',frqs(i))];
end
plot(frqs, pks, '*r')
xlabel("Frequency")
ylabel("Amplitude")
text(frqs,pks,labs)
title(["AUDIO SIGNAL PEAKS AFTER FILTER ["+ID+"]"])
hold off
grid

