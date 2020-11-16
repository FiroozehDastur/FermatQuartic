# import Pkg;
# Pkg.add("Hecke")

using Printf
using Hecke

K, w= cyclotomic_field(8::Int);
Kx, (x0, x1, x2, x3) = PolynomialRing(K, ["x0", "x1", "x2", "x3"]);

for j in [1, 3, 5, 7]
    for k in [1, 3, 5, 7]
        # Li[j,k] are matrices with specific entries from the coefficient of the defining polynomial equations
        # M = matrix(ZZ, BigInt[3 1 2; 2 0 1])
        # rank (M)
        # m = nrows(M)
        # n = ncols(M)
        # L1[j, k] = V(x0 + w^j * x1 , x2 + w^k * x3);
        L1 = matrix(K, [1 w^j 0 0; 0 0 1 w^k]);
        #println(L1);
        #L2[j, k] = V(x0 + w^j * x2, x1 + w^k * x3);
        L2 = matrix(K, [1 0 w^j 0; 0 1 0 w^k]);
        #println(L2);
        #L3[j, k] = V(x0 + w^j * x3, x1 + w^k * x2);
        L3 = matrix(K, [1 0 0 w^j; 0 1 w^k 0]);
        #println(L3);
    end
end
# Write a multi-dimensional array A collecting all these matrices as entries
A= [L1, L2, L3];
# Generate matrices of the form (Lm | Ln)
# Q = vcat(M, N)
n = length(A); #size of the array A
for i in 1:n
    for j in 1:n
        M = vcat(A[i], A[j]);
    end
end 
# Compute rank of each of these matrices
# rank (M)
# if the rank of the matrix is 2 then save -2 as the (m,n)-th entry of a matrix M
# if the rank of the matrix is 3 then save 1 as the (m,n)-th entry of a matrix M
# if the rank of the matrix is 4 then save 0 as the (m,n)-th entry of a matrix M

m = length (M); # size of matrix array M
for i in 1:m
    r = rank(M[i]);
    if r == 2
        IM[i,j] = -2;
    elseif r == 3
        IM[i,j] = 1;
    else 
        IM[i,j] = 0;
    end
end
# Compute the rank of the 48x48 matrix IM
# rank (IM)
println(rank(IM));
