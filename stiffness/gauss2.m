function gauss2
% A = [2 6 28;
%     3 4 27;
%     4 14 60];
% 
% b = [34 66 68]';

A = [1 -2 3
3 1 -5
-2 6 -9]
b = [1 -4 -2]'

ans = solveLinearEquation(A,b);
ans

    function x = solveLinearEquation(A,b)
        [A,b] = forward_elimination(A,b);        
        x = backward_substitution(A,b);
        
        function [A,b]=forward_elimination(A,b)
            n=length(A);
            for i=1:n
                pivot = A(i,i);
                for j=1:n
                    A(i,j) = A(i,j)/pivot;
                end
                b(i) = b(i) / pivot;
                for k=i+1:n
                    pivot2 = A(k,i);
                    for j=i:n
                        A(k,j) = A(k,j) - A(i,j)*pivot2;
                    end
                    b(k) = b(k) - b(i)*pivot2;
                end
            end
        end
        
        function x=backward_substitution(A,b)
            n=length(A);
            x(n) = b(n);
            for i=n-1:-1:1
                res = 0;
                for j=i+1:n
                    res = res + A(i,j) * x(j);
                end
                x(i) = b(i) - res;
            end
        end         
    end
end