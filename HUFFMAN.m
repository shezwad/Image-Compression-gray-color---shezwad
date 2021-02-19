function [CODE_WORD,CODEBOOK] = HUFFMAN(Prob,Symbol)
    global CODE_WORD;% assigning this to a global varibale enables to approach it by other functions in the script
    
    CODE_WORD = cell(length(Prob),1);%making a cell array with the size of P*1
    if length(Prob)>1
        P_red = REDUCTION(Prob);%calling the REDUCTION function to reduce the P until getting single probability val (=1) 
        MAKECODE(P_red,[]);%If there is no reduction 
    else
        CODE_WORD = {'1'};%when the length of the P is less than one append 1 to the CODE_WORD
    end
CODEBOOK = ([Symbol,(CODE_WORD)]);

function P_red = REDUCTION(Prob)
    P_red = cell(length(Prob),1);%making a cell array with the size of P*1
    
    for i=1:length(Prob)% assingning 1 to length(P) values to the elements of the cell array
        P_red{i} = i;%this will help to track the moving P values 
    end
    
   while numel(P_red)>2 % until the size of the array is greater than 2 
       [Prob,i] = sort(Prob);%this will sort P in ascending order
       Prob(2) = Prob(1) + Prob(2);%making the new Probablity by adding least and the second least and assinging it to second least
       Prob(1) =[];% Removing the least probability
       P_red =P_red(i);
       P_red{2} ={P_red{1},P_red{2}};
       P_red(1)=[];
   end

function MAKECODE(a,code)
    global CODE_WORD;
    if isa(a,'cell') %returns logical 1 (true) if 'a' is of class cell, and logical 0 (false) otherwise. 
        MAKECODE(a{1},[code 1]);
        MAKECODE(a{2},[code 0]);
    else
        CODE_WORD{a} = char('0' + code);
    end
    
   




