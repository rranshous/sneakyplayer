class Player

  attr_reader :game_over

  def initialize
    @game_over = false
  end

  def game_started base_location
    @base_location = base_location
  end

  def round_started player_warriors, enemy_warriors, dead_warriors, enemy_bases
    @current_warriors = player_warriors
    @enemy_warriors = enemy_warriors
    @dead_warriors = dead_warriors
    @enemy_base_locations = enemy_bases
  end

  def die
    @game_over = :LOSE
  end

  def win
    @game_over = :WIN
  end

  def next_moves
    Enumerator.new do |yielder|
      @current_warriors.each do |(id, _)|
        move = [id, [rand(-1..1), rand(-1..1)]]
        yielder << move
      end
    end
  end

  private

  def self.dist l1, l2
    dx, dy = [ l1[0] - l2[0], l1[1] - l2[1] ]
    Math.sqrt(dx*dx + dy*dy)
  end

  def self.toward start_loc, target_loc
    [0,0].tap do |move|
      if start_loc[0] > target_loc[0]
        move[0] = -1
      elsif start_loc[0] < target_loc[0]
        move[0] = 1
      end
      if start_loc[1] > target_loc[1]
        move[1] = -1
      elsif start_loc[1] < target_loc[1]
        move[1] = 1
      end
    end
  end

  def self.away_from start_loc, target_loc
    toward(start_loc, target_loc).map{ |m| m * -1 }
  end
end
