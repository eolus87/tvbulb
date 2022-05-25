% Developed by Nicolas Gutierrez as a personal project.
% Seville, Sept 2013

%% Environment cleaning
close all;

%% User constants

% Screen related constants
nof_horizontal_regions = 12;
nof_vertical_regions = 6;
submuestreox = 30;
submuestreoy = 5;
xres = 3440;
yres = 1440;

% Code related constants
iterations = 500;

% Extra hardware constants
nof_leds = 90;

%% Initialization

% Variables
nof_horizontal_regionszone = zeros(nof_horizontal_regions,3);
nof_vertical_regionszonel = zeros(nof_vertical_regions-1,3);
nof_vertical_regionszoner = zeros(nof_vertical_regions-1,3);

numbnof_horizontal_regions = zeros(nof_horizontal_regions,1);
numbnof_vertical_regionsl = zeros(nof_vertical_regions-1,1);
numbnof_vertical_regionsr = zeros(nof_vertical_regions-1,1);

ledstrip = zeros(nof_leds,1);

xdiv = floor(xres/nof_horizontal_regions);
ydiv = floor(yres/nof_vertical_regions);

% Launching figure
figure(1);
hold on;
for i = 1:nof_horizontal_regions
    
    plot([(i-1)*xdiv i*xdiv i*xdiv (i-1)*xdiv (i-1)*xdiv],[yres-ydiv yres-ydiv yres yres yres-ydiv],'k','LineWidth',2); 
    
    if i < nof_vertical_regions
        plot([0  xdiv xdiv 0 0],[(i-1)*ydiv (i-1)*ydiv i*ydiv i*ydiv (i-1)*ydiv],'k','LineWidth',2);
        plot([xres-xdiv xres xres xres-xdiv xres-xdiv],[(i-1)*ydiv (i-1)*ydiv i*ydiv i*ydiv (i-1)*ydiv],'k','LineWidth',2);
    end

end
axis([0 xres 0 yres]);
axis manual;
drawnow;

%% Iterations of screencaptures and operations

for k=1:iterations
    % Capture and calculations
    tic;
    im = getScreenCaptureImageData([0 0 xres yres]);
    for i=1:submuestreox:xres-1
        for j=1:submuestreoy:yres-1
            if i<=xdiv && j<=(yres-ydiv) && (floor(j/ydiv)+1)<nof_vertical_regions
                nof_vertical_regionszonel(floor(j/ydiv)+1,1) = nof_vertical_regionszonel(floor(j/ydiv)+1,1) + cast(im(yres-j,i,1),'double');
                nof_vertical_regionszonel(floor(j/ydiv)+1,2) = nof_vertical_regionszonel(floor(j/ydiv)+1,2) + cast(im(yres-j,i,2),'double');
                nof_vertical_regionszonel(floor(j/ydiv)+1,3) = nof_vertical_regionszonel(floor(j/ydiv)+1,3) + cast(im(yres-j,i,3),'double');
                numbnof_vertical_regionsl(floor(j/ydiv)+1) = numbnof_vertical_regionsl(floor(j/ydiv)+1) + 1;
            elseif i>=(xres-xdiv) && j<=(yres-ydiv) && (floor(j/ydiv)+1)<nof_vertical_regions
                nof_vertical_regionszoner(floor(j/ydiv)+1,1) = nof_vertical_regionszoner(floor(j/ydiv)+1,1) + cast(im(yres-j,i,1),'double');
                nof_vertical_regionszoner(floor(j/ydiv)+1,2) = nof_vertical_regionszoner(floor(j/ydiv)+1,2) + cast(im(yres-j,i,2),'double');
                nof_vertical_regionszoner(floor(j/ydiv)+1,3) = nof_vertical_regionszoner(floor(j/ydiv)+1,3) + cast(im(yres-j,i,3),'double');
                numbnof_vertical_regionsr(floor(j/ydiv)+1) = numbnof_vertical_regionsr(floor(j/ydiv)+1) + 1;
            elseif j>(yres-ydiv)
                nof_horizontal_regionszone(floor(i/xdiv)+1,1) = nof_horizontal_regionszone(floor(i/xdiv)+1,1) + cast(im(yres-j,i,1),'double');
                nof_horizontal_regionszone(floor(i/xdiv)+1,2) = nof_horizontal_regionszone(floor(i/xdiv)+1,2) + cast(im(yres-j,i,2),'double');
                nof_horizontal_regionszone(floor(i/xdiv)+1,3) = nof_horizontal_regionszone(floor(i/xdiv)+1,3) + cast(im(yres-j,i,3),'double');
                numbnof_horizontal_regions(floor(i/xdiv)+1) = numbnof_horizontal_regions(floor(i/xdiv)+1) + 1;
            end  
        end
    end
    
    % Plotting
    for i = 1:nof_horizontal_regions
        nof_horizontal_regionszone(i,:) = nof_horizontal_regionszone(i,:)./(numbnof_horizontal_regions(i)*255);
        fill([(i-1)*xdiv i*xdiv i*xdiv (i-1)*xdiv],[yres-ydiv yres-ydiv yres yres],nof_horizontal_regionszone(i,:)); 
        if i < nof_vertical_regions
             nof_vertical_regionszonel(i,:) = nof_vertical_regionszonel(i,:)./(numbnof_vertical_regionsl(i)*255);
             nof_vertical_regionszoner(i,:) = nof_vertical_regionszoner(i,:)./(numbnof_vertical_regionsr(i)*255);
            
            fill([0 xdiv xdiv 0],[(i-1)*ydiv (i-1)*ydiv i*ydiv i*ydiv],nof_vertical_regionszonel(i,:));
            fill([xres-xdiv xres xres xres-xdiv],[(i-1)*ydiv (i-1)*ydiv i*ydiv i*ydiv ],nof_vertical_regionszoner(i,:));
        end
    end
    T = toc;
    title(sprintf('Iter number: %i Time: %i Hz',k,1/T));
    drawnow;
    
    % Output
    ledstrip = [nof_vertical_regionszonel(1,:) nof_vertical_regionszonel(2,:) ...
        nof_vertical_regionszonel(3,:) nof_vertical_regionszonel(4,:) ...
        nof_vertical_regionszonel(5,:) ...
        nof_horizontal_regionszone(1,:) nof_horizontal_regionszone(2,:) ...
        nof_horizontal_regionszone(3,:) nof_horizontal_regionszone(4,:) ...
        nof_horizontal_regionszone(5,:) ...
        nof_horizontal_regionszone(6,:) nof_horizontal_regionszone(7,:) ...
        nof_horizontal_regionszone(8,:) nof_horizontal_regionszone(9,:) ...
        nof_horizontal_regionszone(10,:) ...
        nof_horizontal_regionszone(11,:) nof_horizontal_regionszone(12,:) ...
        nof_vertical_regionszoner(1,:) nof_vertical_regionszoner(2,:) ...
        nof_vertical_regionszoner(3,:) nof_vertical_regionszoner(4,:) ...
        nof_vertical_regionszoner(5,:)...
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    
    ledstrip = round(ledstrip*255);
    
    %% Interface
    % Any interface would use ledstrip variable
    
    % jTcpObj = jtcp('request',ipserver,puerto,'timeout',10000);
    % jtcp('write',jTcpObj,int8(ledstrip));
    
%     clc;
%     for i=1:length(ledstrip)/3-1
%         fprintf('Led nº%i: Rojo:%i Verde:%i Azul:%i Hz',i-1,ledstrip(3*i),ledstrip(3*i+1),ledstrip(3*i+2))
%     end

    %% Reinitialization of values
    nof_horizontal_regionszone = zeros(nof_horizontal_regions,3);
    nof_vertical_regionszonel = zeros(nof_vertical_regions-1,3);
    nof_vertical_regionszoner = zeros(nof_vertical_regions-1,3);

    numbnof_horizontal_regions = zeros(nof_horizontal_regions,1);
    numbnof_vertical_regionsl = zeros(nof_vertical_regions-1,1);
    numbnof_vertical_regionsr = zeros(nof_vertical_regions-1,1);

    ledstrip = zeros(nof_leds,1);
end
