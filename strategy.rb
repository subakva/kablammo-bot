module Defensive
  def dance
    first_possible_move %w(n s e w).shuffle
  end

  def dodge(enemy)
    toward = moves_toward enemy
    d1 = enemy.distance_to robot.target_for(toward[1])
    d2 = enemy.distance_to robot.target_for(toward[2])
    if d1 > d2
      moves = [ toward[1], toward[2], toward[3], toward[0] ]
    else
      moves = [ toward[2], toward[1], toward[3], toward[0] ]
    end
    first_possible_move moves
  end

  def act_defensively
    enemy = opponents.first
    return dance unless enemy
    return dodge enemy if enemy.can_fire_at? me
    return rest unless my.ammo_full?
    move_away_from! enemy
  end
end

module Aggressive
  def hunt
    x, y = robot.x, robot.y
    return first_possible_move 'nesw' if x == 0
    return first_possible_move 'eswn' if y == @battle.board.height - 1
    return first_possible_move 'swne' if x == @battle.board.width - 1
    return first_possible_move 'wnes' if y == 0
    first_possible_move 'wsen'
  end

  def fire_at!(enemy, compensate = 0)
    direction = robot.direction_to(enemy).round
    skew = direction - robot.rotation
    distance = robot.distance_to(enemy)
    max_distance = Math.sqrt(board.height * board.height + board.width * board.width)
    compensation = ( 10 - ( (10 - 3) * (distance / max_distance) ) ).round
    compensation *= -1 if rand(0..1) == 0
    skew += compensation if compensate > rand
    fire! skew
  end

  def act_aggressively
    enemy = opponents.first
    return hunt unless enemy
    return rest if my.ammo == 0
    return move_towards! enemy if obscured? enemy
    return fire_at! enemy, 0.75 if can_fire_at? enemy
    return aim_at! enemy unless aiming_at? enemy
    move_towards! enemy
  end
end

include Aggressive
include Defensive

def closest_enemy
  smallest_distance = 10000000
  closest = nil
  opponents.each do |enemy|
    puts "closest = #{closest}"
    puts "smallest_distance = #{smallest_distance}"
    distance = robot.distance_to(enemy)
    puts "distance = #{distance}"
    if distance < smallest_distance
      smallest_distance = distance
      closest = enemy
    end
  end
  closest
end

@current_target = nil
on_turn do
  act_defensively
  # if @current_target.nil? || @current_target.dead?
  #   @current_target = closest_enemy
  # end

  # if my.ammo == 0
  #   rest
  # elsif @current_target.nil?
  #   act_aggressively
  # elsif can_fire_at?(@current_target)
  #   if aiming_at?(@current_target)
  #     fire_at!(@current_target, 0.75)
  #   else
  #     aim_at!(@current_target)
  #   end
  # else
  #   move_towards!(@current_target)
  # end
end
