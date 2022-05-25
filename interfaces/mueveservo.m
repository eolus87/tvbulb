pserial = serial('COM16','Baudrate',9600);
set(pserial,'Databits',8,'Parity','none','StopBits',1,'FlowControl','none');
fopen(pserial);
fprintf(pserial,'%i\n',600);
pause(0.5);
for z=600:50:2400
    fprintf(pserial,'%i\n',z);
    % salida = fread(pserial);
    pause(0.1);
    z
end
fclose(pserial);
