function [label]=EncodeLabel(labelstring) 

tf = strcmp(labelstring,'Kitchen');
if(tf==1)
    label=1;
end

tf = strcmp(labelstring,'Store');
if(tf==1) 
    label=2;
    end

tf = strcmp(labelstring,'Bedroom');
if(tf==1)
    label=3;
end

tf = strcmp(labelstring,'LivingRoom');
if(tf==1)
    label=4;
end

tf = strcmp(labelstring,'Office');
if(tf==1)
    label=5;
end

tf = strcmp(labelstring,'Industrial');
if(tf==1)
    label=6;
end


tf = strcmp(labelstring,'Suburb');
if(tf==1)
    label=7;
end

tf = strcmp(labelstring,'InsideCity');
if(tf==1)
    label=8;
end


tf = strcmp(labelstring,'TallBuilding');
if(tf==1)
    label=9;
end

tf = strcmp(labelstring,'Street');
if(tf==1)
    label=10;
end

tf = strcmp(labelstring,'Highway');
if(tf==1)
    label=11;
end

tf = strcmp(labelstring,'OpenCountry');
if(tf==1)
    label=12;
end

tf = strcmp(labelstring,'Coast');
if(tf==1)
    label=13;
end

tf = strcmp(labelstring,'Mountain');
if(tf==1)
    label=14;
end

tf = strcmp(labelstring,'Forest');
if(tf==1)
    label=15;
end

end