#If new markers have been placed, kill the old ones
execute if entity @e[tag=maze_nw,tag=maze_tracked] if entity @e[tag=maze_nw,tag=!maze_tracked] run kill @e[tag=maze_nw,tag=maze_tracked]
execute if entity @e[tag=maze_se,tag=maze_tracked] if entity @e[tag=maze_se,tag=!maze_tracked] run kill @e[tag=maze_se,tag=maze_tracked]

#Check for Start/Reset potions
execute if entity @e[type=potion,nbt={Item:{tag:{MazeCreate:1b}}}] run function mazegen:start
execute if entity @e[type=potion,nbt={Item:{tag:{MazeReset:1b}}}] run function mazegen:clear

kill @e[type=potion,nbt={Item:{tag:{MazeCreate:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{MazeReset:1b}}}]

#Get the positions of relevant entities
tag @e[tag=maze_nw] add maze_tracked
tag @e[tag=maze_se] add maze_tracked

#If there are entities to flood, do so
scoreboard players operation MazeVars maze_speed = MazeConst maze_speed
execute if entity @e[tag=maze_flood_new] run function mazegen:flood_entities

execute unless entity @e[tag=maze_flood_new] as @e[tag=maze_marker,scores={maze_id=0},sort=random] run function mazegen:init_marker

scoreboard players operation MazeVars maze_speed = MazeConst maze_speed
execute unless entity @e[tag=maze_flood_new] if data storage minecraft:maze stack[0] run function mazegen:iterate_stack

execute unless entity @e[tag=maze_flood_new] unless data storage minecraft:maze stack[0] run function mazegen:clear