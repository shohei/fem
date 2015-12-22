function gauss_elim


A = [2 6 28;
     3 4 27;
     4 14 60]

b = [34 66 68]'
 
[A,b] = forward_elimination(A,b);

x = backward_substitution(A,b);

x

    function [A,b]=forward_elimination(A,b)
        n=length(A);
        for k=1:n-1 % k=1,2
            b(k)=b(k)/A(k,k);
            for j=k+1:n % j=2,3
                A(k,j)=A(k,j)/A(k,k);
            end
            for i=k+1:n % i=2,3
                for j=k+1:n % j=2,3
                    A(i,j)=A(i,j)-A(i,k)*A(k,j);
                end
                b(i)=b(i)-A(i,k)*b(k);
            end
        end
    end

    function x=backward_substitution(A,b)
        n=length(A);
        for i=1:n
           x(i)=b(i)/A(i,i); 
        end
        for i=n-1:1
            for j=i+1:n
               res = A(i,j)*x(j); 
            end
            x(i) = b(i) - res;
        end        
    end
 
end