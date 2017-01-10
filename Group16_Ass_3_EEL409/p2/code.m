[y,x] = libsvmread('train.txt');
acc_max = 0;
c_max = 0;
for c = 1:0.1:5
    %disp(c);
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
        disp(num2str(c));
        q = num2str(c); 
        p = '-s 0 -t 0 -c ';
        %disp(z);
        model = svmtrain(y11,x11,[p q]);
        [label,acc,dec] = svmpredict( y12, x12, model, '');
        avg = avg + acc/5;
    end
    %disp(avg(1));
    %disp(acc_max(1));
    if(avg(1) > acc_max(1))
        acc_max(1) = avg(1);
        c_max = c;
        disp('abc');
    end
    disp(c_max);
    disp(acc_max(1));
end

p1 = '-s 0 -t 0 -c 1';
q1 = num2str(c_max);

final_model = svmtrain(y,x,[p1 q1]);
[y2,x2] = libsvmread('test.txt');
[label_final,acc,dec] = svmpredict(y2,x2,final_model, '');
