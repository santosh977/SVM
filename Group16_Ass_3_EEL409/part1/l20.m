clear all;
clc;
filename1 = 'test1.txt';
filename = 'test20.txt';
P = dlmread(filename);
P1 = dlmread(filename1);
I = P(:,1);
O = P(:,2);
I1 = P1(:,1);
O1 = P1(:,2);
m = 9;
n = 20;
Q(1:n,1:m+1) = 1;
Q1(1:100,1:m+1) = 1;
for i = 1:n;
    for j = 1:m;
    Q(i,j+1) = (I(i))^j;
    end
end
for i = 1:100;
    for j = 1:m;
    Q1(i,j+1) = (I1(i))^j;
    end
end
W(1:m+1,1:1) = 0;
Y(1:m+1,1:1) = 0;
X(1:m+1,1:m+1) = 0;
Z(1:(2*m+1),1:1) = 0;
for k = 1:(2*m+1);
    Z(k) = sum(I.^(k-1));
end
b = 0;
for i = 1:m+1;
    for j = 1:m+1; 
        b=b+1;
        X(i,j) = Z(b);
    end
    b = b -m;
end
for l = 1:m+1; 
    Y(l) = sum((I.^(l-1)).*O);
end

lambda = 1.2;
%W0 = (inv(lambda*eye(m+1) + (Y)'*Y))*(Y')*O;
W = inv(lambda*eye(m+1) + X)*Y;

for i = 1:100;
    for j = 1:m;
    H(i,j+1) = (I1(i))^j;
    end
end
b1 = O1 - H*W;
b2 = (1/100)*sum(b1);
noise_variance = 1/b2;

R1 = Q1*W;
E1 = O1 - R1;
R = Q*W;
E = O - R;
cnt1 = 0;
for l = 1:100; 
    if(abs(E1(l)) <= 1)
        cnt1 = cnt1 + 1;
    end
end
cnt = 0;
for l = 1:n; 
    if(abs(E(l)) <= 1)
        cnt = cnt + 1;
    end
end
disp('training');
disp(cnt*5);
disp('testing');
disp(cnt1);
disp(noise_variance);

plot(I1,O1,'--go');
hold on
plot(I1,R1,':ro');
