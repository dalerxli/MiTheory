clc
clear all;

n = 2; % ������� �������
r = 70e-9; % ������ �����
I = 1.3e-3; % ������������� ��������� ���������
lambda = 3e-7 : 2e-9 : 8e-7; % ����� �����
f = 3e8./lambda; % �������
mu = 1; % ��������� ������������� �����
mu1 = 1; % ��������� ������������� ����
N = 1; % ���������� ����������� ����� 
k = 2*pi*N./lambda; % �������� ������

%{
EPS = dlmread('Si_eps.txt'); % ��������������� ������������� ����
lambdaeps = 3e8 ./ (EPS(:,1) .* 1e12);
Eps = EPS(:,2) + 1i .* EPS(:,3);
eps = spline(lambdaeps,Eps, lambda);
N1 = sqrt( (real(eps) + abs(eps))./2 ); % ���������� ����������� ����
%}
eps = 16;
N1 = sqrt(eps);

%  An(n,mu,mu1,N,N1,r,lambda);
%  Bn(n,mu,mu1,N,N1,r,lambda);

% ������� ���������
Csca = 0;
for i=1:1:n
Csca = Csca + 2*pi./k.^2 .* (2.*i+1) .* ...
    (abs(An(i,mu,mu1,N,N1,r,lambda)).^2 + ...
    abs(Bn(i,mu,mu1,N,N1,r,lambda)).^2);
end

% ������� ����������
Cext = 0;
for i=1:1:n
Cext = Cext + 2*pi./k.^2 .* (2.*i+1) .* real(An(i,mu,mu1,N,N1,r,lambda) + Bn(i,mu,mu1,N,N1,r,lambda));
end

% ����� ������������� An
an = 0;
for i=1:1:n
an = an + An(i,mu,mu1,N,N1,r,lambda);
end

% ����� ������������� Bn
bn = 0;
for i=1:1:n
bn = bn + Bn(i,mu,mu1,N,N1,r,lambda);
end

figure(1);
plot(f,abs(an),f,abs(bn));
    legend('sum an','sum bn');
    xlabel('�������, ��');

%������� ��������� COMSOL
SCA = dlmread('scat.txt');
Scax = SCA(:,1);
Scay = SCA(:,3) ./ I;

%���������� COMSOL
%{
%ABS = dlmread('absCS.txt');
%Absx = ABS(:,1);
%Absy = ABS(:,3) ./ I;
%}

figure(2);
%subplot(2,1,1)
plot(f,Csca, Scax,Scay)
    legend('����','������');
    xlabel('�������, ��');
    ylabel('������� ���������');
%{
subplot(2,1,2)
plot(3e8./lambda,Cext, Scax, Scay+Absy)
plot(3e8./lambda,Cext, Scax, Scay)
   legend('����','������');
   xlabel('�������, ��');
   ylabel('������� ����������');

figure(3);
plot(f, N1)
xlabel('�������, ��');
ylabel('����������� �����������');

figure(4);
subplot(2,1,1);
plot(lambdaeps,real(Eps),'k', lambdaeps,imag(Eps),'b');
subplot(2,1,2);
plot(lambda, real(eps),'k.', lambda, imag(eps),'b.');
%}