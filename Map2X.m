function Output = Map2X( Chromosomes,~,~ )
%Map2X Maps the input to the corresponding X
    
    StaticWeights=[23	31	29	44	53	38	63	85	89	82];
    
	Out=Chromosomes*StaticWeights';
    
    Output=Out;
    
end