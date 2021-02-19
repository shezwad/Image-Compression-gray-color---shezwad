function DCT_coef = DCT(MB)
%% This is the function to do DCT for each macro blocks
%%
N = 8;
[temp1 temp2] = size(MB);
for i = 1:1:temp1
    for j = 1:1:temp2
        x1 = dct2(cell2mat(MB(i,j)));
        x2 = mat2cell(x1,N,N);
        DCT_coef(i,j) = x2;
    end
end
end
