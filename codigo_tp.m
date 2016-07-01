%Desarrollo grupo Mixto_3


%%%%%%%%%%%%

%Declaro variables a usar
syms s Fs tiempo x L  z t num den

%Lectura de señal  de audio
[s Fs] = wavread('Audio-TPMatSup.wav');

%Comprobación
sound(s, Fs);

% la variable s está formada por 2 columnas, canal L y canal R
% Fs frecuencia de muestreo es de 44100
% tenemos un total de 1358208 muestras
% con canal_R logramos que se traigan todas las muestras de la columna1
% con canal_L logramos que se traigan todas las muestras de la columna2
canal_R = s(:,1);
canal_L = s(:,2);

%Tiempo de la señal 30,7984 seg
tiempo = size(s,1)/Fs;

%Ploteo de señal
% la longitud de x es 1358209, si tomamos n muestras, x es n+1
x = 0:1/Fs:tiempo;

%grafico hasta el tiempo de duración del audio
figure(1)
plot(x(2:end),canal_L);
xlim([0 tiempo]);
%xlim establece el intervalo de las muestras en x (desde 0 hasta la
%duración total del audio)
title('Grafico de x[n]');
xlabel('Entrada Temporal x[n]');





L = length(s);
% Calculamos el número de muestras que contiene el audio
% L = 1358208

NFFT = 2^nextpow2(L);
% la función fft es más eficiente cuando calcula la transformada de Fourier
% de una función cuya longitud es potencia de 2 (2,4,8,...).
% por eso calculamos cuál es la potencia de 2 más cercana al número de
% muestras que contiene el audio.
% Si el archivo tiene 6 muestras, el número que se le pasara a la fft es 8,
% para que sea más eficiente. Dicho número lo llamamos NFFT, este número
% variará de acuerdo al número de muestras del archivo. Pero esto no
% afectará el resultado, dado que las muestras que faltan son interpretadas
% como 0, NO añadiendo ningún contenido frecuencial al archivo original.

G = fft(s, NFFT) / L;
% Calculamos la FFT (transformada de fourier) con la función fft() cuyos argumentos son el audio
% que queremos transformar (audio), y el número de muestras sobre
%la que queremos que haga la transformada (NFFT).
%Dividimos entre L el resultado para normalizar los valores.
% La transformada la tendremos en la variable G.

ft = (Fs/2*linspace(0,1,NFFT/2+1));
%Construimos el eje de coordenadas.
% Las frecuencia que devuelve la FFt van de la frecuencia 0 hasta
% la frecuencia mitad de la frecuencia de muestreo
% solo queremos visualizar la mitad, dado que por DFT
% (Discrete Fourier Transform) hace un efecto espejo

% el comando pretty permite mostrar la función de mejor manera
pretty(ft);
figure(2)
plot(ft, 2*abs(G(1:NFFT/2+1)))
xlim([0 end])
title('Grafico de f(t)');
xlabel('Tiempo');
ylabel('f(t)');


%generamos la gráfica cuyo eje de coordenadas está contenido
% en la variable f y cuyo eje de ordenadas es 2 veces el valor absoluto
%(para mostrar solo la magnitud y no la parte real e imaginaria)
% de la mitad del espectro.
%obtengo la función en el dominio de t, de x[n]
%L número de muestras, tiempo es duración del audio

%Aplicamos la transformada z a la función ft
Fz = ztrans(ft);

% dibujamos la función obtenida
pretty(Fz);
figure(3)
ezplot(Fz)
title('Grafico de F[z]');
xlabel('Dominio en z');

%Aplicamos el filtro especificado
num = [1 1.1];
den = [1 0 -0.1];

Fz = ((1 + 1.1 * z^-1) / (1 - 0.1 * z^-2));

% resultando Fz después de aplicar filtro
%>>Fz =-(11/(10*z) + 1)/(1/(10*z^2) - 1)

% calculamos la función de transferencia, obteniendo Hs
Hs = tf(num, den);
%>> ((s - 1.1s) / (s^2 - 0.1s))

%  Aplicamos transformada Z para que se encuentre en el mismo dominio que Fz
Hz = tf(‘z’, Hs);

% Encontramos la respuesta pedida (Y(z))
Yz = Fz * Hz;

%graficamos la respuesta
ezplot(Yz);


%Antitransformamos la respuesta para trasladarla al dominio n (y(n))
yt= iztrans(Yz);

%graficamos lo obtenido
ezplot(yt);
