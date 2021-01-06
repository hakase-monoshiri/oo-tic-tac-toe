require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], #top row
        [3,4,5], #middle row
        [6,7,8], #bottom row
        [0,3,6], #left column
        [1,4,7], #middle column
        [2,5,8], #right column
        [0,4,8], #back diagonal
        [2,4,6] #front diagonal

    ]

    def initialize
        @board = []
        9.times {@board << " "}
    end

    def display_board
        print " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        print "-----------"
        print " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        print "-----------"
        print " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    def input_to_index(input)
        index = input.to_i - 1
        index
    end

    def move(index, token = x)
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(index)
        position_taken?(index) == false && index >= 0 && index <= 8 
    end
    
    def turn_count
        @board.count("X") + @board.count("O")
    end

    def current_player
        c = turn_count
        if c.even?
            "X"
        else
            "O"
        end
    end

    def previous_player
        c = turn_count
        if c.even?
            "O"
        else
            "X"
        end
    end


    def turn
      puts "Please enter your position 1-9"
      position = gets.chomp
      index = input_to_index(position)
      if valid_move?(index)
        @board[index] = current_player
        display_board
      else
        turn
      end
    end

    def won?
        winning_combo = nil
      WIN_COMBINATIONS.each do |combination|
           if  combination.all?{|position| @board[position] == previous_player}
            winning_combo = combination
            end
        end
        winning_combo
    end

    def full?
        if @board.any?(" ")
            false
        else
            true
        end
    end
                
    def draw?
        if full? == true && won? == nil
            true
        else
            false
        end
    end

    def over?
        draw? || won?
    end

    def winner 
        if won?
            previous_player
        else
            nil
        end
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end


end
