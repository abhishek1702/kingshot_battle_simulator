function result = calculateChance(percent)

%   chance calculator calculates percent chance given in the bracket
a = percent/100;

result = (rand() < a) * 1;

end