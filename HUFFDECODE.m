function DECODE = HUFFDECODE(text,CODEBOOK,Prob)
    
f = fopen(text); % open the text
data = textscan(f,'%s');% scan the text file for stings and store them in data 
fclose(f);% closing teh opened text file  
bits = char(data{:});% converting data elements to characters 
temp1 = []; % assigning matrix for temp1 and DECODE 
DECODE = [];
for j = 1:length(bits)
    temp1 = strcat(temp1,bits(j));%concatenate temp1 and bits and storing them in the temp1 to search along for codewords 
    for i = 1:length(Prob)
        temp(i) = isequal(CODEBOOK{i,2},temp1);
    end
    if sum(temp) == 1
        DECODE = [DECODE,CODEBOOK{find(temp,1),1}];
        temp1 = [];
    end
end
