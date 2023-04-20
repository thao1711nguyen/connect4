require_relative "../lib/player.rb"
describe Player do
  describe '#add' do
    context "when player add a piece" do 
        subject(:player_add) { described_class.new('T') }
        it "send push message" do 
            pieces = player_add.instance_variable_get(:@pieces)
            column = 'A'
            piece = 1
            before_length = pieces[column].length
            player_add.add(column, piece)
            after_length = pieces[column].length
            expect(after_length-before_length).to eq(1)
        end
    end
  end
end
