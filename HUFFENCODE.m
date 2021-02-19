function A = HUFFENCODE(img,CODEBOOK,text)

size1 = size(img); %Giving the size of the image that is going to encode
A = [];% declaring A as a matrix

for i = 1:size1(1) % Going along the Y axis
    for j = 1:size1(2) % while going along the X axis --cosidering each X pixels in a single Y coloumn 
        A = [A,CODEBOOK{find(cell2mat(CODEBOOK(:,1)) == img(i,j)),2}];% gong along the pixels and finding the codeword from the codebook and storing it in A as a 1*size char array
    end
end
A = (A');%convering to a size*1 char array
fid = fopen(text,'w');
fprintf(fid,num2str(A));
fclose(fid);

