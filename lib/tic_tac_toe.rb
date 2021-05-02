class TicTacToe

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end 

    def current_player
        turn_count % 2 == 0 ? "X" : "O" 
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}  
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end 

    def input_to_index(input)
        if input =~ /[^1-9]/
          index = -1
        elsif input.class == "Fixnum" && input > 0 && input < 10
          index = input - 1
        else
          index = input.to_i - 1
        end
    end

    def move(coordinate, symbol)
        @board[coordinate] = symbol
    end

    def turn
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(index)
          move(index, current_player)
          display_board
        else
          puts "Not a valid entry."
          turn
        end
    end

    def position_taken?(index)
        !(@board[index].nil? || @board[index] == " " || @board[index] == "")
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end
      
    def won?      
        WIN_COMBINATIONS.any? do |win_combination|
            if position_taken?(win_combination[0]) && @board[win_combination[0]] == @board[win_combination[1]] && @board[win_combination[1]] == @board[win_combination[2]]
                return win_combination
            end                               
        end
    end
      
    def full?
        @board.none? do |space|
          space == " "
        end
    end
      
    def draw?
        if full? && !won?
          true
        else
          false
        end
    end
      
    def over?
        if won? || draw?
          true
        end
    end
      
    def winner
        win_combination = won?
        if won?
          @board[win_combination[0]]
        else
          nil
        end
    end
      
    def play
        until over? do
          turn
        end
      
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat\'s Game!"
        end
    end

end