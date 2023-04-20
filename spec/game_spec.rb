require_relative '../lib/game.rb'
describe Game do 
    describe "#drop_pieces" do 
        subject(:game_piece) { described_class.new }
        let(:player_piece) { instance_double(Player, name: '1') }
        let(:board_piece) { instance_double(Board) }
        context "inputs a valid piece" do 
            before do 
                valid_piece = 1
                column = "a"
                game_piece.instance_variable_set(:@board, board_piece)
                allow(board_piece).to receive(:check_valid?).and_return(true)
                allow(game_piece).to receive(:gets).and_return(column)
                allow(board_piece).to receive(:get_piece).with(column).and_return(valid_piece)
                allow(player_piece).to receive(:add)
                allow(board_piece).to receive(:change_displayed_board)
            end
            it "do not receive puts with error message" do 
                error_message = "Error! please drop your piece in proper place!"
                expect(game_piece).not_to receive(:puts).with(error_message)
                game_piece.drop_pieces(player_piece)
            end
        end
        
        context "inputs an invalid piece and then a valid one" do 
            before do 
                valid_input = 'a'
                invalid_input = '5'
                piece = 1
                game_piece.instance_variable_set(:@board, board_piece)
                allow(game_piece).to receive(:puts).with("Player 1, where do you want to drop your piece?").twice
                allow(game_piece).to receive(:gets).and_return(invalid_input, valid_input)
                allow(board_piece).to receive(:check_valid?).and_return(false, true)
                allow(board_piece).to receive(:get_piece).and_return(piece)
                allow(player_piece).to receive(:add)
                allow(board_piece).to receive(:change_displayed_board)
            end
            it "completes loops and displays error message once" do 
                error_message = "Error! please drop your piece in proper place!"
                expect(game_piece).to receive(:puts).with(error_message).once
                game_piece.drop_pieces(player_piece)
            end
        end
    end
    
    describe "game_over?" do 
        subject(:game_over) { described_class.new }
        let(:board_over) { instance_double(Board) }
        context "when there is a winner" do 
            it "returns true" do 
                result = true
                expect(game_over.game_over?(result)).to eq(true)
            end
        end
        context "when no move can be made" do
            before do 
                game_over.instance_variable_set(:@board, board_over)
                allow(board_over).to receive_message_chain(:board, :values, :flatten, :empty?).and_return(true)
            end 
            it "returns true" do 
                result = false
                expect(game_over.game_over?(result)).to eq(true)
            end
        end
        context "when there is no winner and players can make move" do 
            before do 
                game_over.instance_variable_set(:@board, board_over)
                allow(board_over).to receive_message_chain(:board, :values, :flatten, :empty?).and_return(false)
            end
            it "returns false" do 
                result = false
                expect(game_over.game_over?(result)).to eq(false)
            end 
        end
    end
    describe "#check_each_column" do 
        subject(:game_check_column) { described_class.new }
        let(:player_check_column) { instance_double(Player) }
        context "when there are 4 consecutive pieces in a column" do 
            before do 
                allow(player_check_column).to receive(:pieces).and_return({'a' => [1,2,3,4]})
            end
            it "returns true" do 
                expect(game_check_column.check_each_column(player_check_column)).to eq(true)
            end
        end
        context "when there are no 4 consecutive pieces in a column" do
            before do 
                allow(player_check_column).to receive(:pieces).and_return({'a' => [1,2,3]})
            end
            it "returns false" do 
                expect(game_check_column.check_each_column(player_check_column)).to eq(false)
            end 
        end
    end
    
end