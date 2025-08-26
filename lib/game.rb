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
    # @current_player_id = 0
    # @players = [player1.new(self, 'X'), player2.new(self, 'O')]
    puts @rounds_played
    display_board
  end

  def game_title
    puts
    puts "#{@current_player} has 12 rounds to guess a combination of #{SOLUTION_SIZE} of these colours:"
    puts COLOURS.join(', ')
    puts
    puts "The Mastermind is #{@current_mastermind}, BEWARE!"
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

    puts 'can play round!'

    guess = @player.make_guess!
    puts "guess: #{guess}, solution: #{@solution}"
    return false if guessed?(guess)

    # @board_matrix[position[0] - 1][position[1] - 1] = player.symbol
    display_board
    true
  end

  def guessed?(guess)
    if guess == @solution
      puts 'GUESSED!!!'
      true
    else
      puts 'NOT GUESSED!!!'
      check(guess)
    end
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
      puts '          +------------------------------------+'
    else
      puts '+---------+------------------------------------+'
    end
  end

  def display_board
    display_border_line('short')
    puts '          |    ?        ?        ?        ?    |'
    display_border_line
    @rounds_played.each_with_index do |row, index|
      puts "| #{index} | #{row.join('  ')}" if index.positive?
      display_border_line
    end
    puts
  end

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
