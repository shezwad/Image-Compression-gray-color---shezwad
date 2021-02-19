function I_DCT_coef = Inv_DCT(I_Quantization)
%% This is the function to do DCT for each macro blocks
%%
N = 8;
[temp1, temp2] = size(I_Quantization);
for i = 1:1:temp1
    for j = 1:1:temp2
        x1 = idct2(cell2mat(I_Quantization(i,j)));
        x2 = mat2cell(x1,N,N);
        I_DCT_coef(i,j) = x2;
    end
end
end