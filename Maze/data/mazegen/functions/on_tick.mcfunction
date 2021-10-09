# If new markers have been placed, kill the old ones
execute if entity @e[tag=maze_seed,tag=maze_tracked] if entity @e[tag=maze_seed,tag=!maze_tracked] run kill @e[tag=maze_seed,tag=maze_tracked]

# Check for Start/Reset potions
execute if entity @e[type=potion,nbt={Item:{tag:{MazeCreate:1b}}}] run function mazegen:start
execute if entity @e[type=potion,nbt={Item:{tag:{MazeReset:1b}}}] run function mazegen:clear

kill @e[type=potion,nbt={Item:{tag:{MazeCreate:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{MazeReset:1b}}}]

# Get the positions of relevant entities
tag @e[tag=maze_seed] add maze_tracked

# If there are entities to flood, do so
execute if data storage maze running run scoreboard players operation MazeVars maze_speed = MazeConst maze_speed
execute if data storage maze running run execute if entity @e[tag=maze_flood_new] run function mazegen:flood_entities

# Handle switching from flooding to generating
execute unless entity @e[tag=maze_flood_new] run kill @e[type=marker,tag=maze_marker]
execute if data storage maze running unless entity @e[tag=maze_flood_new] unless data storage maze stack_pos[0] run data modify storage maze stack_pos append from entity @e[tag=maze_seed,limit=1] Pos

# Generate the maze
scoreboard players operation MazeVars maze_speed = MazeConst maze_speed
execute if data storage maze running unless entity @e[tag=maze_flood_new] if data storage maze stack_pos[0] as @e[tag=maze_seed,limit=1] at @s run function mazegen:low_entity_stack

execute if data storage maze running unless entity @e[tag=maze_flood_new] unless data storage maze stack_pos[0] run data remove storage maze running