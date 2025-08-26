# frozen_string_literal: true

# This class is needed to add a Human Player in the game
class HumanPlayer < Player
  def make_guess!
    round = "This is round #{@game.current_round} of #{@game.number_of_rounds}. "
    print "#{round}Choose #{@game.number_of_colours} colours: "
    gets.chomp.split(',').join(' ')
    # @game.display_board
  end

  def to_s
    'Humanoid'
  end
end
