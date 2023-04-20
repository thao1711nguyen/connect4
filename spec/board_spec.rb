require_relative '../lib/board.rb'
describe Board do 
    describe "#intialize" do 
        context "when a new board is created" do 
            subject(:new_board) { described_class.new }
            it "makes a board that has 7 columns " do
                expect(new_board.board.keys.length).to eq(7)
            end
            it "makes a board that has  6 rows " do
                column_name = new_board.board.keys[0]
                expect(new_board.board[column_name].length).to eq(6)
            end
            it "makes a displayed board" do 
                origin = new_board.board
                expect(new_board.displayed_board).to eq(origin) 
            end
            it "displayed board is different from board" do 
                origin = new_board.board
                expect(new_board.displayed_board).not_to be(origin)
            end
        end
    end
    describe "#change_displayed_board" do 
        let(:player_changed_board) { instance_double(Player, symbol: '1')}
        subject(:board_change) { described_class.new }
        
        it "gets the index of the piece" do 
            displayed_board = board_change.instance_variable_get(:@displayed_board)
            piece = 1
            column = 'a'
            expect(displayed_board[column]).to receive(:index).with(piece).and_return(0)
            board_change.change_displayed_board(player_changed_board, column, piece)
        end
        it "replace the piece with player's symbol" do 
            displayed_board = board_change.instance_variable_get(:@displayed_board)
            piece = 2
            column = 'a'
            board_change.change_displayed_board(player_changed_board, column, piece)
            expect(displayed_board[column][1]).to eql('1')
        end
    end
    describe "#get_piece" do 
        subject(:board_piece) { described_class.new }
        it "returns piece 1" do 
            column = 'a'
            expect(board_piece.get_piece('a')).to eql(1)
        end
    end
    
end