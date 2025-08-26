# frozen_string_literal: true

# first class is the board with 9 editable spaces in a 3x3 matrix layout
# This class should also display the board status to the screen
class Game
  NUMBER_OF_ROUNDS = 12
  COLOURS = %w[white yellow orange red pink blue green purple brown gray black].freeze
  SOLUTION_SIZE = 4
  attr_reader :solution, :current_player_id

  def initialize(mastermind, player)
    @mastermind = mastermind.new(self)
    @player = player.new(self)
    game_title
    @solution = create_random_solution
    puts "The secret combination to guess is: #{@solution}"
    @rounds_played = []
    display_board
  end

  def game_title
    puts
    puts "#{@player} has 12 rounds to guess a combination of #{SOLUTION_SIZE} of these colours. Colours can be repeated!"
    puts COLOURS.join(', ')
    puts
    puts "The Mastermind is #{@mastermind}, BEWARE!"
    puts
  end

  def create_random_solution
    solution = []
    SOLUTION_SIZE.times { solution.push(COLOURS.sample) }
    solution.join(' ')
  end

  def play_game
    loop do
      return false unless can_play_round?

      # switch_players!
    end
  end

  def can_play_round?
    return false if current_round > NUMBER_OF_ROUNDS

    guess = @player.make_guess!
    puts "guess: #{guess}, solution: #{@solution}"
    return false if guessed?(guess)

    # @board_matrix[position[0] - 1][position[1] - 1] = player.symbol
    # display_board
    true
  end

  def guessed?(guess)
    guessed = false
    last_round = []
    puts
    if guess == @solution
      puts "Congratulations #{@player}! #{@player} guessed correctly in #{@rounds_played.size + 1} rounds"
      # puts @rounds_played
      guessed = true
      guess.split.each do |item|
        word_and_result = []
        word_and_result.push(item)
        word_and_result.push('X')
        last_round.push(word_and_result)
      end
    else
      puts "#{@player} has not guessed correctly. #{@player} has #{12 - @rounds_played.size - 1} more rounds to guess the solution"
      last_round = check(guess)
    end
    # puts last_round
    @rounds_played.push(last_round)
    display_board
    guessed
  end

  def check(guess)
    round = []
    checked_solution = @solution.split
    checked_guess = guess.split
    index_size = checked_guess.size
    index = 0
    while index < index_size
      word_and_result = []
      if checked_guess[index] == checked_solution[index]
        word_and_result.push(checked_guess[index])
        word_and_result.push('X')
        checked_guess.delete_at(index)
        checked_solution.delete_at(index)
        index_size -= 1
        round.push(word_and_result)
      end
      index += 1
    end
    checked_guess.each do |item|
      word_and_result = []
      word_and_result.push(item)
      if checked_solution.include?(item)
        word_and_result.push('O')
        checked_solution.delete(item)
      else
        word_and_result.push('-')
      end
      round.push(word_and_result)
    end
    round
  end

  # def current_player
  #   @players[@current_player_id]
  # end

  # def other_player_id
  #   1 - @current_player_id
  # end

  # def switch_players!
  #   @current_player_id = other_player_id
  # end

  # def opponent
  #   @players[@other_player_id]
  # end

  # def top_bottom_row
  #   puts '    1  2  3'
  # end

  def display_result_line
    puts @rounds_played.last.join(' ')
  end

  def display_border_line(size = 'long')
    if size == 'short'
      puts '              +---------------------------------+'
    else
      puts '+-------------+---------------------------------+'
    end
  end

  def display_board
    puts
    display_border_line('short')
    puts '              |    ?       ?       ?       ?    |'
    display_border_line
    @rounds_played.reverse.each_with_index do |words, index|
      print "| #{@rounds_played.size - index} | "
      result = ''
      adjusted_guess = ''
      words.each do |word|
        result += "#{word[1]} "
        adjusted_guess += word[0].center(8)
      end
      puts "#{result}| #{adjusted_guess}|"
      display_border_line
    end
    puts
  end

  # def adjust_string(word, length)
  # end

  # def player_won?(symbol)
  #   WINNING_CONDITIONS.each do |condition|
  #     won = true
  #     condition.each do |index|
  #       won &&= (@board_matrix.flatten[index - 1] == symbol)
  #     end
  #     return true if won == true
  #   end
  #   false
  # end

  # def game_won?(player)
  #   if player_won?(player.symbol)
  #     declare_winner(player)
  #     return true
  #   end
  #   false
  # end

  # def game_tied?
  #   if @board_matrix.flatten.none?(' ')
  #     puts 'The game is tied!'
  #     return true
  #   end
  #   false
  # end

  # def declare_winner(player)
  #   puts "#{player}#{@current_player_id + 1} won!"
  # end

  # def allowed_position?(row, col)
  #   @board_matrix[row][col] == ' '
  # end

  # def invalid_position(row, col)
  #   puts "There is already an #{@board_matrix[row - 1][col - 1]} at position #{row}, #{col}"
  # end
  #
  def current_round
    @rounds_played.size + 1
  end

  def number_of_rounds
    NUMBER_OF_ROUNDS
  end

  def number_of_colours
    SOLUTION_SIZE
  end
end
