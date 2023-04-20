
module Consecutive

    def consecutive_test(arr)
        if block_given?
            arr = yield
        end
        counter = 1
        arr.each_with_index do |item, idx|
            break if counter == 4 || idx == arr.length-1
            if arr[idx+1] == item+1
                counter += 1 
            else 
                counter = 1
            end
        end
        counter == 4? true : false
    end

    def get_consecutive_objects(arr)
        result = []
        block_given? ? modified_arr = yield : modified_arr = arr
        modified_arr.each_with_index do |item, idx|
            break if idx == modified_arr.length - 1
            if modified_arr[idx+1] == item + 1
                result.concat([arr[idx], arr[idx + 1]])
                result.uniq!
            else 
                break if result.length >= 4
                result = []
            end
        end
        result
    end
end
class Dummy 
    extend Consecutive
end

