%Filtro pasabajos

clear all
A=4;
fs=8000;    %frecuencia de muestreo en Hz
fc=200;    %frecuencia de corte
wc=2*pi*fc/fs; %frecuencia normalizada
N=66;   %orden del filtro=66. L=67 muestras
k=1:N/2;
h=sin(wc*k)./(pi*k); %N/2 coeficientes positivos

hneg=h(N/2:-1:1);   %los espejo
h=[hneg wc/pi h];
figure(1)
stem(h);
title('respuesta al impulso del filtro. L=67')


figure(2)
H=fft(h,512);
f = fs/2*linspace(0,1,512/2);
plot(f,2*abs(H(1:512/2)))


%genero distintos tonos de 1 segundo de duraci?n
t=0:1/fs:1;
largot=length(t);
figure(3)

f1=A*sin(2*pi*100*t); %100Hz

subplot(4,2,1)
plot(t,f1(1:largot));
xlabel('100');

f2=A*sin(2*pi*200*t); %200Hz
subplot(4,2,2)
plot(t,f2(1:largot));
xlabel('200');

f3=A*sin(2*pi*300*t); %300Hz
subplot(4,2,3)
plot(t,f3(1:largot));
xlabel('300');

f4=A*sin(2*pi*400*t); %400Hz
subplot(4,2,4)
plot(t,f4(1:largot));
xlabel('400');

f5=A*sin(2*pi*500*t); %500Hz
subplot(4,2,5)
plot(t,f5(1:largot));
xlabel('500');

f6=A*sin(2*pi*600*t); %600Hz
subplot(4,2,6)
plot(t,f6(1:largot));
xlabel('600');

f7=A*sin(2*pi*700*t); %700Hz
subplot(4,2,7)
plot(t,f7(1:largot));
xlabel('700');

f8=A*sin(2*pi*800*t); %800Hz
subplot(4,2,8)
plot(t,f8(1:largot));
xlabel('800');

player=audioplayer(f1,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f2,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f3,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f4,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f5,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f6,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f7,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(f8,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono

%filtro las se?ales por convoluci?n
y1=conv(f1,h);
y2=conv(f2,h);
y3=conv(f3,h);
y4=conv(f4,h);
y5=conv(f5,h);
y6=conv(f6,h);
y7=conv(f7,h);
y8=conv(f8,h);

figure(4)
H=fft(y1,512);
H = H + fft(y2,512);
H = H + fft(y3,512);
H = H + fft(y4,512);
H = H + fft(y5,512);
H = H + fft(y6,512);
H = H + fft(y7,512);
H = H + fft(y8,512);
f = fs/2*linspace(0,1,512/2);
plot(f,2*abs(H(1:512/2)))



player=audioplayer(y1,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y2,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y3,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y4,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y5,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y6,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y7,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono
player=audioplayer(y8,fs);  %inicializo el audioplayer
playblocking(player)      %reproducir el tono

%dibujo las se?ales resultantes para ver el efecto del filtrado
largot=length(t);
figure(5)
subplot(4,2,1)
plot(t,y1(1:largot));
xlabel('100');
subplot(4,2,2)
plot(t,y2(1:largot));
xlabel('200');
subplot(4,2,3)
plot(t,y3(1:largot));
xlabel('300');
subplot(4,2,4)
plot(t,y4(1:largot));
xlabel('400');
subplot(4,2,5)
plot(t,y5(1:largot));
xlabel('500');
subplot(4,2,6)
plot(t,y6(1:largot));
xlabel('600');
subplot(4,2,7)
plot(t,y7(1:largot));
xlabel('700');
subplot(4,2,8)
plot(t,y8(1:largot));
xlabel('800');
