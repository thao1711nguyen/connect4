require_relative "player.rb"
require_relative "board.rb"
require_relative "consecutive.rb"
class Game 
    include Consecutive
    attr_reader :player1, :player2, :board
    attr_accessor :count
    def initialize
        @player1 = Player.new('1')
        @player2 = Player.new('2')
        @board = Board.new
        @count = 1
    end
    
    def play 
        loop do 
            @board.display 
            player = count.odd? ? @player1 : @player2
            drop_pieces(player)
            result = win?(player) if @count >= 6
            if game_over?(result)
                @board.display
                announce(result, player.name)
                break
            end
            @count += 1
        end
    end
    def announce(result, name)
        if result
            puts "Congratulation player #{name}! You won!"
        else 
            puts "It was a draw!"
        end
    end
    def drop_pieces(player)
        loop do 
            puts "Player #{player.name}, where do you want to drop your piece?"
            column = gets.chomp.strip.downcase
            if @board.check_valid?(column)
                piece = @board.get_piece(column)
                player.add(column, piece)
                board.change_displayed_board(player, column, piece)
                break
            end
            puts "Error! please drop your piece in a valid place!"
        end
    end
    
    def win?(player)
        
        return check_each_column(player) if check_each_column(player) #check each column first

        #check consecutive columns
        columns_names = player.pieces.keys.sort
        return false unless consecutive_test(columns_names) { columns_names.map {|name| name.ord} }
        consecutive_columns = get_consecutive_columns(player)
        return check_rows(consecutive_columns) if check_rows(consecutive_columns)
        check_diagonal(consecutive_columns)
    end
    def get_consecutive_columns(player)
        columns_names = player.pieces.keys.sort
        consecutive_columns_name = get_consecutive_objects(columns_names) { columns_names.map {|name| name.ord} }
        consecutive_columns_name.inject(Array.new) do |arr, name|
            arr << player.pieces[name]
            arr
        end        
    end
    def check_each_column(player)
        player.pieces.values.each do |column|
            return consecutive_test(column.sort) if consecutive_test(column.sort)
        end
        false
    end
    def check_diagonal(consecutive_columns)
        combination_columns = consecutive_columns[0].product(*consecutive_columns[1..-1])
        combination_columns.each do |combination|
            return consecutive_test(combination) if consecutive_test(combination)
            return consecutive_test(combination.reverse) if consecutive_test(combination.reverse)
        end
        false
    end
    def check_rows(consecutive_columns)
        result = consecutive_columns[0].intersection(*consecutive_columns[1..-1])
        result.empty? ? false : true
    end
    
    def game_over?(result)
        result || @board.board.values.flatten.empty?
    end  
end

new_game = Game.new
new_game.play
