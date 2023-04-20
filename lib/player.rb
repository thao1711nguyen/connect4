class Player 
    attr_reader :name, :symbol, :pieces
    
    def initialize(name, symbol = name)
        @name = name
        @symbol = symbol
        @pieces = Hash.new { |h,k| h[k] = [] }
    end
    def add(column, piece)
        @pieces[column].push(piece)
    end
end
