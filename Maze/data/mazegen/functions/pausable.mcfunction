# If there are entities to flood, do so
execute if data storage maze flooding run scoreboard players operation MazeVars maze_speed = MazeConst maze_speed
execute if data storage maze flooding run execute if entity @e[tag=maze_flood_new] run function mazegen:flood_entities

# Handle switching from flooding to generating
execute if data storage maze flooding unless entity @e[tag=maze_flood_new] run kill @e[type=marker,tag=maze_marker]
execute if data storage maze flooding unless entity @e[tag=maze_flood_new] run data remove storage maze building
execute if data storage maze flooding unless entity @e[tag=maze_flood_new] run data remove storage maze flooding
execute if data storage maze running unless entity @e[tag=maze_flood_new] unless data storage maze stack_pos[0] run data modify storage maze stack_pos append from entity @e[tag=maze_seed,limit=1] Pos

# Generate the maze
scoreboard players operation MazeVars maze_speed = MazeConst maze_speed
execute if data storage maze running unless entity @e[tag=maze_flood_new] if data storage maze stack_pos[0] as @e[tag=maze_seed,limit=1] at @s run function mazegen:low_entity_stack
execute if data storage maze running unless entity @e[tag=maze_flood_new] unless data storage maze stack_pos[0] run data remove storage maze running