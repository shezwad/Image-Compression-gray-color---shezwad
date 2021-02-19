function [Quantization,Q_L] = quant(DCT_coef,m,com)
%% This is the function to do quantization for each macro blocks
%% m is the quality in %
%% com takes either 1 or 2. if com = 1 it refers to Luma 2 for chroma

Defalut_Lum = [16  11  10  16  24  40  51  61; 
               12  12  14  19  26  58  60  55; 
               14  13  16  24  40  57  69  56;  
               14  17  22  29  51  87  80  62; 
               18  22  37  56  68  109 103 77;  
               24  35  55  64  81  104 113 92; 
               49  64  78  87  103 121 120 101; 
               72  92  95  98  112 100 103 99]; 
           
Default_Chr = [17  18  24  47  99  99  99  99;
               18  21  26  66  99  99  99  99;
               24  26  56  99  99  99  99  99;
               47  66  99  99  99  99  99  99;
               99  99  99  99  99  99  99  99;
               99  99  99  99  99  99  99  99;
               99  99  99  99  99  99  99  99;
               99  99  99  99  99  99  99  99];
if (m < 50)
    q = 5000/m;
else
    q = 200 - 2*m;
end

Q_L = floor((q*Defalut_Lum + 50) / 100);
Q_L(Q_L == 0) = 1; % Prevent divide by 0 error

Q_C = floor((q*Default_Chr + 50) / 100);
Q_C(Q_C == 0) = 1; % Prevent divide by 0 error

[temp1, temp2] = size(DCT_coef);
N = 8;
if com == 1
    for i = 1:1:temp1
       for j = 1:1:temp2
           x1 = round((cell2mat(DCT_coef(i,j)))./Q_L);
           x2 = mat2cell(x1,N,N);
          Quantization(i,j) = x2;
       end    
    end
elseif com == 2 
      for i = 1:1:temp1
       for j = 1:1:temp2
           x1 = round((cell2mat(DCT_coef(i,j)))./Q_C);
           x2 = mat2cell(x1,N,N);
          Quantization(i,j) = x2;
       end    
      end      
end
end

