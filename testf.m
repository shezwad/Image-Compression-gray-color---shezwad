% function CR = compression_image('shehan.jpg',m)
%% 
%% 
I = imread('G4.PNG');
% figure;imshow(I);

m = 10;
Gray = rgb2gray(I);
Lu_chr = rgb2ycbcr(I);
[Lu,Cr,Cb] = imsplit(Lu_chr);

%figure; montage({ Lu, Cr, Cb,});

[pad_image1, L0, W0] = padding(Lu);
[pad_image2, L0, W0] = padding(Cr);
[pad_image3, L0, W0] = padding(Cb);

[MB1 , L1, W1] = macroblock(pad_image1);
[MB2 , L1, W1] = macroblock(pad_image2);
[MB3 , L1, W1] = macroblock(pad_image3);

DCT_coef1 = DCT(MB1);
DCT_coef2 = DCT(MB2);
DCT_coef3 = DCT(MB3);

[Quantization1,Q_L] = quant(DCT_coef1,m,1);
[Quantization2,Q_C] = quant(DCT_coef2,m,2);
[Quantization3,Q_C] = quant(DCT_coef3,m,2);

[DC_mat1,first1] = DC_extraction(Quantization1);
[DC_mat2,first2] = DC_extraction(Quantization2);
[DC_mat3,first3] = DC_extraction(Quantization3);

Zig_out1 = zigzag(Quantization1);
Zig_out2 = zigzag(Quantization2);
Zig_out3 = zigzag(Quantization3);

[Run_out1] = Run_length(Zig_out1);
[Run_out2] = Run_length(Zig_out2);
[Run_out3] = Run_length(Zig_out3);

[T1,Prob1,Symbol1] = sym_prob(Run_out1);
[T2,Prob2,Symbol2] = sym_prob(Run_out2);
[T3,Prob3,Symbol3] = sym_prob(Run_out3);

[T4,Prob4,Symbol4] = sym_prob(DC_mat1);
[T5,Prob5,Symbol5] = sym_prob(DC_mat2);
[T6,Prob6,Symbol6] = sym_prob(DC_mat3);

[CODE_WORD1,CODEBOOK1] = HUFFMAN(Prob1,Symbol1);
[CODE_WORD2,CODEBOOK2] = HUFFMAN(Prob2,Symbol2);
[CODE_WORD3,CODEBOOK3] = HUFFMAN(Prob3,Symbol3);

[CODE_WORD4,CODEBOOK4] = HUFFMAN(Prob4,Symbol4);
[CODE_WORD5,CODEBOOK5] = HUFFMAN(Prob5,Symbol5);
[CODE_WORD6,CODEBOOK6] = HUFFMAN(Prob6,Symbol6);

text1 = '1.jpg';text2 = '2.jpg';text3 = '3.jpg';text4 = '4.jpg';text5 = '5.jpg';text6 = '6.jpg';

A1 = HUFFENCODE(Run_out1,CODEBOOK1,text1);
A2 = HUFFENCODE(Run_out2,CODEBOOK2,text2);
A3 = HUFFENCODE(Run_out3,CODEBOOK3,text3);

A4 = HUFFENCODE(DC_mat1,CODEBOOK4,text4);
A5 = HUFFENCODE(DC_mat2,CODEBOOK5,text5);
A6 = HUFFENCODE(DC_mat3,CODEBOOK6,text6);

DECODE1 = HUFFDECODE(text1,CODEBOOK1,Prob1);
DECODE2 = HUFFDECODE(text2,CODEBOOK2,Prob2);
DECODE3 = HUFFDECODE(text3,CODEBOOK3,Prob3);

DECODE4 = HUFFDECODE(text4,CODEBOOK4,Prob4);
DECODE5 = HUFFDECODE(text5,CODEBOOK5,Prob5);
DECODE6 = HUFFDECODE(text6,CODEBOOK6,Prob6);

I_Run_out1 = Inv_Run_length(DECODE1);
I_Run_out2 = Inv_Run_length(DECODE2);
I_Run_out3 = Inv_Run_length(DECODE3);

I_DC_mat1 = Inv_DC_extraction(DECODE4,first1);
I_DC_mat2 = Inv_DC_extraction(DECODE5,first2);
I_DC_mat3 = Inv_DC_extraction(DECODE6,first3);

I_Zig_out1 = Inv_zigzag(I_Run_out1,I_DC_mat1,L1,W1);
I_Zig_out2 = Inv_zigzag(I_Run_out2,I_DC_mat2,L1,W1);
I_Zig_out3 = Inv_zigzag(I_Run_out3,I_DC_mat3,L1,W1);

I_Quantization1 = Inv_quant(I_Zig_out1,m,1);
I_Quantization2 = Inv_quant(I_Zig_out2,m,2);
I_Quantization3 = Inv_quant(I_Zig_out3,m,2);

I_DCT_coef1 = Inv_DCT(I_Quantization1);
I_DCT_coef2 = Inv_DCT(I_Quantization2);
I_DCT_coef3 = Inv_DCT(I_Quantization3);

[Comp_img1] = Inv_padding(I_DCT_coef1,L0,W0);
[Comp_img2] = Inv_padding(I_DCT_coef2,L0,W0);
[Comp_img3] = Inv_padding(I_DCT_coef3,L0,W0);

test_img = cat(3,Comp_img1,Comp_img2,Comp_img3);
combined_RGB = ycbcr2rgb(test_img);

 figure; montage({Lu, Cr, Cb,Comp_img1,Comp_img2,Comp_img3},'Size',[2 3]);
 figure;montage({I,combined_RGB},'Size',[1 2]);

%% Rough CR 
XX1 = length(A1)+length(A2)+length(A3)+length(A4)+length(A5)+length(A6);

XX2 = 2*(length(CODEBOOK1)+length(CODEBOOK2)+length(CODEBOOK3)+length(CODEBOOK4)+length(CODEBOOK5)+length(CODEBOOK6));
XX3 = length(L0)+length(W0)+length(L1)+length(W1)+length(first1)+length(first2)+length(first3)+3;
XX4 = length(Prob1)+length(Prob2)+length(Prob3)+length(Prob4)+length(Prob5)+length(Prob6);

XX_f = XX1 + 8*(XX2)*18 + 8*(XX3 + XX4);

CR = (L0*W0*8*3)/XX_f ;
% end 