function Matlab_Arduino(numero_muestras)

% Matlab + Arduino Serial Port communication
% Autor: Mario P�rez Esteso
% Blog: www.diarioelectronicohoy.com/arduino
% Facebook Page: www.facebook.com/TutorialesArduino
% Twitter: @_Mario_Perez

close all;
clc;
y=zeros(1,1000); %Vector donde se guardar�n los datos

%Inicializo el puerto serial que utilizar�
delete(instrfind({'Port'},{'COM3'}));
puerto_serial=serial('COM3');
puerto_serial.BaudRate=9600;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Abro el puerto serial
fopen(puerto_serial); 

%Declaro un contador del n�mero de muestras ya tomadas
contador_muestras=1;

%Creo una ventana para la gr�fica
figure('Name','Serial communication: Matlab + Arduino. Mario P�rez Esteso')
title('SERIAL COMMUNICATION MATLAB+ARDUINO');
xlabel('N�mero de muestra');
ylabel('Voltaje (V)');
grid on;
hold on;

%Bucle while para que tome y dibuje las muestras que queremos
while contador_muestras<=numero_muestras
        ylim([0 30]); 
        xlim([contador_muestras-20 contador_muestras+5]);
        valor_potenciometro=fscanf(puerto_serial,'%d')'
        size(puerto_serial)
        y(contador_muestras)=(valor_potenciometro(1));
        %y(contador_muestras)=(valor_potenciometro(1));
        plot(contador_muestras,y(contador_muestras),'X-r','LineWidth',1.5);        
        drawnow
        contador_muestras=contador_muestras+1;
end

%Cierro la conexi�n con el puerto serial y elimino las variables
fclose(puerto_serial); 
delete(puerto_serial);
clear all;

end