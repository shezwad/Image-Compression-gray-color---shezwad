
I = imread('shehan.jpg');
% figure;imshow(I);

m = 50;
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