%recuperer_son('Paradis.mp3');

[pks,locs,w,p] = maxima()

function enregistrer_Callback(hObject, eventdata, handles)
  AI = analoginput ('winsound');
  addchannel(AI, 1);
  duree = 2;
  Fs = 8000;
  set(AI,'sampleRate',Fs);
  ActualRate = get(AI,'SampleRate');
  set(AI,'sampleaPerTrigger', duree*ActualRate);
  start (AI)
  wait(AI, duree+1);
  signal = getdata(AI);
  delete(AI)
  clear AI
  N = length(signal);

  axea(handle.axea1);
  hold on
  grid
  gridplot(signal); grid on
  hold off
 end


function recuperer_son(fichier)
  [s_t, fs]=audioread(fichier);
  ts=1/fs;
  T_sec = 1; N=round(T_sec/ts);
  X=s_t(1:N,1);
  Y=s_t(1:N,2);
  t=linspace(0,T_sec,N);
  figure(1);
  subplot(211);plot(t,X,'linewidth',2); grid on;
  ylabel('amplitude(v)'); xlabel('Temps(s)');

  subplot(212);plot(t,Y,'linewidth',2); grid on;
  ylabel('Amplitude(V)'); xlabel('Temps(s)');
end

 function transformee_fourier()
  Fs = 1000;            % Sampling frequency
  T = 1/Fs;             % Sampling period
  L = 1500;             % Length of signal
  t = (0:L-1)*T;        % Time vector
  S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
  X = S + 2*randn(size(t));
  
  subplot(1,3,1);

  plot(1000*t(1:50),X(1:50))
  title("Signal Corrupted with Zero-Mean Random Noise")
  xlabel("t (milliseconds)")
  ylabel("X(t)")

  Y = fft(X);
  P2 = abs(Y/L);
  P1 = P2(1:L/2+1);
  P1(2:end-1) = 2*P1(2:end-1);
  f = Fs*(0:(L/2))/L;

  subplot(1,3,2);
  
  plot(f,P1)
  title("Single-Sided Amplitude Spectrum of X(t)")
  xlabel("f (Hz)")
  ylabel("|P1(f)|")

  Y = fft(S);
  P2 = abs(Y/L);
  P1 = P2(1:L/2+1);
  P1(2:end-1) = 2*P1(2:end-1);
  
  subplot(1,3,3);

  plot(f,P1)
  title("Single-Sided Amplitude Spectrum of S(t)")
  xlabel("f (Hz)")
  ylabel("|P1(f)|")
 end

 function [pks,locs,w,p] = maxima()
 %pks => les maximas
 %locs => les positions dans l'array où ces maximas se trouvent
 %w => "width", épaisseur de ces maximas
 %p => "prominence", proéminence : différence entre le point le plus haut
 %du maxima et la point le plus bas du même "pic"
  data = [25 8 15 5 6 10 10 3 1 20 7];
  plot(data);
  [pks,locs,w,p] = findpeaks(data);
  %pkg load signal --> au prealable
  %findpeaks(data)
  
  
 end
 
 

 




