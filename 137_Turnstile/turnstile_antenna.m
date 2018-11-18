close all
clear variables

freq    = 137e6;
lambda  = 3e8/freq;
offset  = lambda/50;
spacing = lambda/2;
length  = lambda/2.1;
width   = lambda/50;
anglevar= 0:10:180;
freqrange = 100e6:2e6:200e6;
gndspacing = lambda/4;

d1 = dipole('Length', length, 'Width', width, 'Tilt', [-90,-45], 'TiltAxis', ['Y', 'Z']);
d2 = dipole('Length', length, 'Width', width, 'Tilt', [-90,45], 'TiltAxis', ['Y', 'Z']);
ant = conformalArray;
ant.Element = [d1 d2];
ant.ElementPosition(1,:) = [0 0 0];
ant.ElementPosition(2,:) = [0 0 offset];
ant.PhaseShift = [0 90];

figure;
show(ant);

figure;
returnLoss(ant, freqrange, 75);

figure;
pattern(ant, freq);

figure;
patternElevation(ant, freq);

AR1 = axialRatio(ant, freq, 0, anglevar);
AR2 = axialRatio(ant, freq, 90, anglevar);

figure;
plot(anglevar, AR1, 'r*-', anglevar, AR2, 'ro-');
axis([0 180 0 5]);
grid on;
xlabel('elevation (deg)')
legend('az = 0', 'az = 90')
ylabel('Axial ratio (dB)');
title('turnstile antenna')