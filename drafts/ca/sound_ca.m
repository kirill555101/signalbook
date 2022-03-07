%
% ���������� ������� ������� ������������ ����������
clear all; % ������� ������
close all; % �������� ���� ���� � ���������
clc; % ������� ���� ������ � ���������
fontSize = 10; % ������ ������ ��������
tColor = 'b'; % ���� �������� �� ��������� �������
fColor = [1 0.4 0]; % ���� �������� � ��������� �������
rColor = [0.2 0.7 0.3]; % ���� �������� ���������������� �������
volume = 0.15; % ��������� ��������� �������
f0 = 440; % ������� �������, ��
fd = 16000; % ������� �������������, ��
mean = 0; % �������������� �������� ����
std = 0.3; % ����������� ����������
nK = 100; % ���������� ����������
nT = 20; % ���������� �������� ���������������� �������
dt0 = nT/f0; % ������������ ���������������� �������, �
N0 = nT*round(fd/f0); % ���������� �������� ���������������� �������
dt = nK*dt0; % ������������ ����������� �������, �
N = N0*nK; % ����� ���������� �������� �������
gT = 3; % ���������� �������� ��� ������������

t = linspace(0,dt,N); % ������������ ������� ����������� �� ��������� �������
data = volume*cos(2*pi*f0*t); % ������������ ���������� �������
% ������ ��������� ����� � �������� ��������
audiowrite('sound.wav', data, fd);
figure; plot(t(1:gT*round(fd/f0)), data(1:gT*round(fd/f0)), 'Color', tColor);
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm �������� ������ �� ��������� �������'); % ���������
xlabel('�����,\it nT_�\rm, �'); % ������� ��� �������
ylabel('������,\it x(nT_� )\rm, �'); % ������� ��� �������

f = linspace(0, fd, N0); % ������������ ������� ����������� � ��������� �������
% ������ �������� ������� ��������� �������
fdata = abs(fft(data(1:N0))/N0);
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fdata),...
    'Color', fColor, 'LineWidth', 3);
axis([-fd/2 fd/2 0 volume*0.6]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm �������� ������ � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������

ny = normrnd(mean, std, [1,N]); % ������ �������� ���� �� ����. �������������
ndata = data + ny; % ���������� ���� � ��������� �������
% ������ ��������� ����� � ���������� ��������
audiowrite('noise.wav', ndata, fd);
mdata = reshape(ndata, [N0,nK]).'; % ���������� ������� �� nK ����������
figure; plot(t(1:gT*round(fd/f0)), mdata(1,1:gT*round(fd/f0)), 'Color', tColor);
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ���������� ������ �� ��������� �������'); % ���������
xlabel('�����,\it nT_�\rm, �'); % ������� ��� �������
ylabel('������,\it x(nT_� )\rm, �'); % ������� ��� �������

% ������ �������� ������� ����������� �������
fmdata = abs(fft(mdata(1,:))/N0);
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fmdata),...
    'Color', fColor, 'LineWidth', 3);
axis([-fd/2 fd/2 0 volume*0.6]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ���������� ������ � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������

% ���������� ������� ������������ ����������
sdata = sum(mdata)./nK;
% ������ ��������� ����� � ��������������� ��������
audiowrite('filter.wav', sdata, fd);
figure; plot(t(1:gT*round(fd/f0)), mdata(1,1:gT*round(fd/f0)), 'Color', tColor); hold on;
plot(t(1:gT*round(fd/f0)), sdata(1:gT*round(fd/f0)), 'Color', rColor, 'LineWidth', 2);
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ��������������� ������ �� ��������� �������'); % ���������
xlabel('�����,\it nT_�\rm, �'); % ������� ��� �������
ylabel('������,\it x(nT_� )\rm, �'); % ������� ��� �������

% ������ �������� ������� ���������������� �������
fsdata = abs(fft(sdata)/N0); % ������������ ��������
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fmdata),...
    'Color', fColor, 'LineWidth', 3); hold on;
plot([-fliplr(f(1:end/2)) f(1:end/2)], fftshift(fsdata),...
    'Color', rColor, 'LineWidth', 2);
axis([-fd/2 fd/2 0 volume*0.6]); % �������� �������� ����
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % ��������� ������
title('\rm ��������������� ������ � ��������� �������'); % ���������
xlabel('�������,\it f\rm, ��'); % ������� ��� �������
ylabel('���������,\it A(f)\rm, �'); % ������� ��� �������
