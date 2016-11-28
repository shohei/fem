function jacobi

dim = 10;

% A = [1 2 3
%      1 -1 2
%      0 1 1];
% 
% b = [0 3 -1]';

 A = reshape(rand(dim),[dim,dim]);
 b = rand(dim,1);
% A= [10 3 1 2 1
%     1 19 2 -1 5
%     -1 1 30 1 10
%     -2 0 1 20 5
%     -3 5 1 -2 25];
% 
% b = [-22 27 89 -73 22]';
% x = A\b
[L,D,U] = decomposeLDU(A);
% testLDU(L,D,U);

criteria = 1e-8;
 x = zeros(dim,1);
% x = [0 0 0 0 0]';
xprev = x;
for idx=1:1000000
    invD = diag(1./diag(D));
    x = - invD*(L+U)*x + invD*b;
    errs = abs(x-xprev);
    err = min(errs);
    if isnan(err)
       invD
       x
       break;       
    end
    if(err<criteria) 
        idx
        break;
    end
    xprev = x;
end

    function [L,D,U] = decomposeLDU(A)
        D = diag(diag(A));
        LUproto = A-D;
        L = tril(LUproto);
        U = triu(LUproto);
    end

    function testLDU(L,D,U)
        AA = L+D+U;
        if(A==AA)
           disp 'test success'; 
        end
    end


end
