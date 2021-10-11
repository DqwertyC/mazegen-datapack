execute store result score MazeVars active_id run data get storage minecraft:maze stack[-1]
execute as @e[tag=maze_marker] if score @s maze_id = MazeVars active_id run tag @s add maze_stack_active

execute as @e[tag=maze_stack_active] at @s run tag @e[tag=!maze_visited,tag=maze_marker,distance=1..2.1] add maze_stack_valid
execute as @e[tag=maze_stack_valid] at @s anchored feet facing entity @e[tag=maze_stack_active,limit=1] feet unless block ^ ^-1 ^1 light_gray_concrete run tag @s remove maze_stack_valid
tag @e[tag=maze_stack_valid,sort=random,limit=1] add maze_stack_next
tag @e remove maze_stack_valid

#If there's a valid next marker, add it to the stack and go to it
execute if entity @e[tag=maze_stack_next] as @e[tag=maze_stack_active] at @s run setblock ~ ~ ~ green_concrete
execute if entity @e[tag=maze_stack_next] as @e[tag=maze_stack_active] at @s anchored feet facing entity @e[tag=maze_stack_next,limit=1] feet run setblock ^ ^ ^1 green_concrete
execute if entity @e[tag=maze_stack_next] store result storage minecraft:maze stack_next int 1 run scoreboard players get @e[tag=maze_stack_next,limit=1] maze_id
execute if entity @e[tag=maze_stack_next] run data modify storage maze stack append from storage minecraft:maze stack_next 

#If not, mark this tile as done and remove it from the stack
execute unless entity @e[tag=maze_stack_next] as @e[tag=maze_stack_active] at @s run setblock ~ ~ ~ lime_concrete
execute unless entity @e[tag=maze_stack_next] run data remove storage maze stack[-1]
execute unless entity @e[tag=maze_stack_next] store result score MazeVars active_id run data get storage minecraft:maze stack[-1]
execute unless entity @e[tag=maze_stack_next] as @e[tag=maze_marker] if score @s maze_id = MazeVars active_id run tag @s add maze_stack_last
execute if entity @e[tag=maze_stack_last] as @e[tag=maze_stack_active] at @s anchored feet facing entity @e[tag=maze_stack_last,limit=1] feet run setblock ^ ^ ^1 lime_concrete

#Either way, mark the active tile as visited and reset tags
tag @e[tag=maze_stack_active] add maze_visited
tag @e remove maze_stack_active
tag @e remove maze_stack_next
tag @e remove maze_stack_last

scoreboard players remove MazeVars maze_speed 1
execute if score MazeVars maze_speed matches 1.. run function mazegen:iterate_stack