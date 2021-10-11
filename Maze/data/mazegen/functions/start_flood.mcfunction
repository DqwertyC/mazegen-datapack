tag @e[tag=maze_seed] add maze_flood_new
tag @e[tag=maze_seed] add maze_marker
tag @e[tag=maze_seed] remove maze_visited

scoreboard players set MazeVars maze_id 1
scoreboard players set @e[tag=maze_seed] maze_id 0

data modify storage maze stack set value [1]
data modify storage maze stack_pos set value []