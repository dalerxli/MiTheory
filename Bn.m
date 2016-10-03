function [ bn ] = Bn( n, mu, mu1, N, N1, r, lambda)
% n - ������� ������������ ���������
% mu - ��������� ������������� �����
% mu1 - ��������� ������������� ����
% N - ���������� ����������� �����
% N1 - ���������� ����������� ����
% r - ������ �����
% lambfa - ����� ����� ���������

m = N1./N; % ������������� ���������� �����������
x = 2.*pi.*N.*r./lambda; % �������� ���������

b1 = mu1 .* sphbes(n,m.*x,'j') .* (sphbes(n,x,'j') + x .* dsphbes(n,x,'j'));
b2 = mu .* sphbes(n,x,'j') .* (sphbes(n,m.*x,'j') + x.*m.*dsphbes(n,m.*x,'j'));
b3 = mu1 .* sphbes(n,m.*x,'j') .* (sphbes(n,x,'h') + x .* dsphbes(n,x,'h'));
b4 = mu .* sphbes(n,x,'h') .* (sphbes(n,m.*x,'j') + x.*m.*dsphbes(n,m.*x,'j'));

bn = (b1-b2)./(b3-b4);

end

