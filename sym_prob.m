function [T,Prob,Symbol] = sym_prob(Run_out)

[g,~,symbol] = grp2idx(Run_out);
Frequency = accumarray(g,1);
probability = Frequency./sum(Frequency);
T = table(symbol,Frequency,probability);
T(1:length(Frequency),:);

[probability,index]=sort(probability);
symbol =symbol(index);
Prob = (probability)';

for i=1:length(symbol)
I1{i} = symbol(i); 
end

Symbol = (I1)';
end
