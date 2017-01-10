[y,x] = libsvmread('train.txt');
acc_max = 0;
c_max = 0;
s_max=0;
A1 = zeros(15, 15);
A2 = zeros(15, 15);
A3 = zeros(15, 15);
a1 = 0;
for c = 6.2:0.2:9
    a1 = a1+1;
    %disp(c);
    a2 = 0;
    for s = 0.2:0.2:3
        a2 = a2+1;
        avg = 0;
        for i = 1:5
            k = i*400;
            if i==1
                x11 = x([k+1:end], :);
                x12 = x([1:k], :);
                y11 = y([k+1:end], :);
                y12 = y([1:k], :);
            elseif i==5
                x11 = x([1:k-400], :);
                x12 = x([k-399:k], :);
                y11 = y([1:k-400], :);
                y12 = y([k-399:k], :);
            else
                x11 = x([1:k-400,k+1:end], :);
                x12 = x([k-399:k], :);
                y11 = y([1:k-400,k+1:end], :);
                y12 = y([k-399:k], :);
            end
            %disp(num2str(c)); 
            gamma = 1/(2*s*s);
            p = '-s 0 -t 2 -c ';
            q = num2str(c);
            u = ' -g ';
            v = num2str(gamma);
            %disp(z);
            model = svmtrain(y11,x11,[p q u v]);
            [label,acc,dec] = svmpredict( y12, x12, model, '');
            avg = avg + acc/5;
        end
        A1(a1,a2)=avg(1);
        A2(a1,a2)=c;
        A3(a1,a2)=s;
        %disp('avg');
        %disp(avg(1));
        disp(acc_max(1));
        if(avg(1) > acc_max(1))
            acc_max(1) = avg(1);
            c_max = c;
            s_max = s;
            %disp('abc');
        end
        disp('c_max');
        disp(c_max);
        disp(s_max);
        disp(acc_max(1));
    end
end

p1 = '-s 0 -t 0 -c 1';
q1 = num2str(c_max);

final_model = svmtrain(y,x,[p1 q1]);
[y2,x2] = libsvmread('test.txt');
[label_final,acc,dec] = svmpredict(y2,x2,final_model, '');
