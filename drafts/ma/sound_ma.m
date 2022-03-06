%
% ���������� ������� ������� ����������� ��������
clear all; % ������� ������
close all; % �������� ���� ���� � ���������
clc; % ������� ���� ������ � ���������
fontSize = 10; % ������ ������ ��������
tColor = 'b'; % ���� �������� �� ��������� �������
fColor = [1 0.4 0]; % ���� �������� � ��������� �������
A = 0.006; % ��������� ����
f0 = 5000; fn = 10000; df = 500; % ������� ����, ��
w = 40; % ������ ���� �������

[data,rate] = audioread('sound.wav'); % ������ �������� � ������� �������������
t = linspace(0, length(data)/rate, length(data)); % ������������ ������� �����������
f = linspace(0, rate, length(data)); % �� ��������� � ��������� ��������
figure; plot(t, data, 'Color', tColor);
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm �������� ������ �� ��������� �������'); % ���������
xlabel('�����,\it nT_�\rm, �'); % ������� ��� �������
ylabel('������,\it x(nT_� )\rm, �'); % ������� ��� �������

fdata = abs(fft(data)/length(data)); % ������������ ��������
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fdata),...
    'Color', fColor, 'LineWidth', 3);
axis([-rate/2 rate/2 0 A/2]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm �������� ������ � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������

ny=zeros(length(data),1); % ������ �������� ����
while f0 < fn
    ny=ny+A.*sin(2*pi*f0*t.');
    f0=f0+df;
end
fny = abs(fft(ny)/length(ny)); % ������ �������� ������� ����
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fny),...
    'Color', fColor, 'LineWidth', 3);
axis([-rate/2 rate/2 0 A/2]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ��������������� ��� � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������

ndata = data; % ������ �������� ����������� ������� ������������
ndata(:,1) = data(:,1) + ny; % ���������� ���� � ��������� �������
ndata(:,2) = data(:,2) + ny;
% ������ ��������� ����� � ���������� ��������
audiowrite('noise.wav', ndata, rate);
% ������ �������� ������� ����������� �������
fdata = abs(fft(ndata)/length(ndata));
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fdata),...
    'Color', fColor, 'LineWidth', 3);
axis([-rate/2 rate/2 0 A/2]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ���������� ������ � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������

madata = ndata; % ������ �������� ���������������� ������� ������������
% ���������� ������� ����������� �������� � �������� ���� w
madata(:,1) = cumsum(ndata(:,1));
madata(:,2) = cumsum(ndata(:,2));
madata(w:end) = madata(w:end) - madata(1:end-w+1);
madata(w-1:end) = madata(w-1:end)./w;
% ������ ��������� ����� � ��������������� ��������
audiowrite('filter.wav', madata, rate);
% ������ �������� ������� ���������������� �������
fdata = abs(fft(madata)/length(madata));
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fdata),...
    'Color', fColor, 'LineWidth', 3);
axis([-rate/2 rate/2 0 A/2]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ��������������� ������ � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������
