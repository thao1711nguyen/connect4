require_relative 'consecutive.rb'
require_relative 'player.rb'
class Board 
    include Consecutive
    attr_reader :columns, :rows
    attr_accessor :board, :displayed_board
    def initialize(rows = 6, columns = 7)
        @rows = rows
        @columns = columns
        @board = make_board
        @displayed_board = make_board
    end
    def make_board
        keys = ('a'..'z').to_a[0...columns]
        keys.inject(Hash.new) do |h, key|
            h[key] = (1..rows).to_a
            h 
        end
    end
    def display
        @displayed_board.keys.each do |column|
            print "#{column.upcase}  "
        end    
        puts 
        rows.times do |time|
            row = @displayed_board.values.map { |column| column[time] }
            row.each do |piece|
                if piece.is_a? Integer
                    print ".  "
                else 
                    print "#{piece}  "
                end
            end
            puts
        end    
    end
    def change_displayed_board(player, column, piece)
        idx = @displayed_board[column].index(piece)
        @displayed_board[column][idx] = player.symbol
    end
    def get_piece(column)
        @board[column].pop
    end
    def check_valid?(column)
        @board.keys.any?(column) && !@board[column].empty? 
    end
end