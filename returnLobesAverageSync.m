function M = returnLobesAverageSync(A)
%frontalMotorLeft = [1,9,2,3,4];    
%frontalMotorRight = [14, 15, 22, 16, 17]; 
%parietalOccipitalleft = [5, 8, 6, 7];
%parietalOccipitalRight = [18, 21, 19, 20];
%temporalLeft = [10, 11, 12, 13];
%temporalRight = [23, 24, 25, 26];


M = zeros(6);
values = [];

for i=1:6
    switch i
        case 1
            elec1 =   [1,9,2,3,4];
        case 2
            elec1 = [5, 8, 6, 7];
        case 3
            elec1 = [10, 11, 12, 13];
        case 4
            elec1 = [14, 15, 22, 16, 17];
        case 5
            elec1 = [18, 21, 19, 20];
        case 6
            elec1 = [23, 24, 25, 26];
    end
    for j=1:6
        switch j
            case 1
                elec2 =   [1,9,2,3,4];
            case 2
                elec2 = [5, 8, 6, 7];
            case 3
                elec2 = [10, 11, 12, 13];
            case 4
                elec2 = [14, 15, 22, 16, 17];
            case 5
                elec2 = [18, 21, 19, 20];
            case 6
                elec2 = [23, 24, 25, 26];
        end
        for k=1:length(elec1)
            for l=1:length(elec2)
                idx1 = elec1(k);
                idx2 = elec2(l);
                values = [values A(idx1,idx2)];
            end
        end
        M(i,j) = mean(values);
        
        values = [];
        %data1 = [elec1,1:end];
        %data2 = [1:end, e
    end
end

end