require_relative 'player'
require_relative 'receiver'

# reassign puts to stderr
$stdout = STDERR # remap puts

player = Player.new
receiver = Receiver.new STDIN, STDOUT, player
loop do
  receiver.tick
  STDOUT.flush
end until player.game_over
