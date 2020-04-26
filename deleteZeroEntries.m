function [arrayNoZero] = deleteZeroEntries(array)
    arrayNoZero = array;
    for i = length(arrayNoZero) : -1 : 1
        if (arrayNoZero(i) == 0)
            arrayNoZero(i) = [];
        end
    end
end

