summon minecraft:marker ~ ~ ~ {Tags:['active_marker']}

data modify entity @e[tag=active_marker,limit=1] Pos set from storage maze stack_pos[-1]
#execute as @e[tag=active_marker,limit=1] at @s run tp ~0.5 ~ ~0.5

execute as @e[tag=active_marker,limit=1] at @s if block ~02 ~00 ~00 minecraft:red_concrete if block ~01 ~-1 ~00 minecraft:light_gray_concrete positioned ~02 ~00 ~00 run summon minecraft:marker ~0 ~ ~0 {Tags:['valid_next']}
execute as @e[tag=active_marker,limit=1] at @s if block ~-2 ~00 ~00 minecraft:red_concrete if block ~-1 ~-1 ~00 minecraft:light_gray_concrete positioned ~-2 ~00 ~00 run summon minecraft:marker ~0 ~ ~0 {Tags:['valid_next']}
execute as @e[tag=active_marker,limit=1] at @s if block ~00 ~00 ~02 minecraft:red_concrete if block ~00 ~-1 ~01 minecraft:light_gray_concrete positioned ~00 ~00 ~02 run summon minecraft:marker ~0 ~ ~0 {Tags:['valid_next']}
execute as @e[tag=active_marker,limit=1] at @s if block ~00 ~00 ~-2 minecraft:red_concrete if block ~00 ~-1 ~-1 minecraft:light_gray_concrete positioned ~00 ~00 ~-2 run summon minecraft:marker ~0 ~ ~0 {Tags:['valid_next']}
tag @e[tag=valid_next,sort=random,limit=1] add maze_next

# If there's a valid next marker, add it to the stack and go to it
execute if entity @e[tag=maze_next] as @e[tag=active_marker] at @s run setblock ~ ~ ~ green_concrete
execute if entity @e[tag=maze_next] as @e[tag=active_marker] at @s anchored feet facing entity @e[tag=maze_next,limit=1] feet run setblock ^ ^ ^1 green_concrete

execute if entity @e[tag=maze_next] run data modify storage maze stack_next_pos set from entity @e[tag=maze_next,limit=1] Pos
execute if entity @e[tag=maze_next] run data modify storage maze stack_pos append from storage maze stack_next_pos

# If not, mark this tile as done and remove it from the stack
execute unless entity @e[tag=maze_next] as @e[tag=active_marker] at @s run setblock ~ ~ ~ lime_concrete
execute unless entity @e[tag=maze_next] run data remove storage maze stack_pos[-1]

# Backtrack to the previous item on the stack
execute unless entity @e[tag=maze_next] if data storage maze stack_pos[0] run summon minecraft:marker ~ ~ ~ {Tags:['last_marker']}
execute unless entity @e[tag=maze_next] if data storage maze stack_pos[0] run data modify entity @e[tag=last_marker,limit=1] Pos set from storage maze stack_pos[-1]
execute unless entity @e[tag=maze_next] if entity @e[tag=last_marker] as @e[tag=active_marker] at @s anchored feet facing entity @e[tag=last_marker,limit=1] feet run setblock ^ ^ ^1 lime_concrete

kill @e[tag=active_marker]
kill @e[tag=valid_next]
kill @e[tag=last_marker]

scoreboard players remove MazeVars maze_speed 1
execute if data storage maze stack_pos[0] if score MazeVars maze_speed matches 1.. run function mazegen:low_entity_stack