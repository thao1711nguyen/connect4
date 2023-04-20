require_relative "../lib/consecutive.rb"
describe Consecutive do 
    let(:dummy_class) { Class.new { extend Consecutive } }
    describe "#consecutive_test" do 
        context "when the array contains 4-consecutive items" do 
            it "returns true" do 
                arr = [-2,-33,1,2,3,4,5,13,54,67]
                expect(dummy_class.consecutive_test(arr)).to eq(true)
            end
        end
        
        context "when the array does not contain 4-consecutive items" do 
            it "returns false" do 
                arr = [1,2,3,7,9,34,65]
                expect(dummy_class.consecutive_test(arr)).to eq(false)
            end
        end 
        context "when the array contains duplicates" do 
            it "returns false" do 
                arr = [1,2,2,3,4] 
                expect(dummy_class.consecutive_test(arr)).to eq(false)
            end
        end
    end
    describe "#get_consecutive_objects" do 
        context "when the origin array contains 4-consecutive items" do 
            it "returns an array of 4 consecutive items" do 
                arr = [1,2,3,4,7,9,13]
                expect(dummy_class.get_consecutive_objects(arr)).to eq([1,2,3,4])
            end
        end
        context "when the origin array contains 6-consecutive items" do 
            it "returns an array of 6 consecutive items" do 
                arr = [34,11,1,2,3,4,5,6,13,54,67]
                expect(dummy_class.get_consecutive_objects(arr)).to eq([1,2,3,4,5,6])
            end
        end
    end
end 