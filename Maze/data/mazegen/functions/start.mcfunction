function mazegen:clear

tag @e[tag=maze_nw] add maze_flood_new
tag @e[tag=maze_nw] add maze_marker
tag @e[tag=maze_se] add maze_marker

tag @e[tag=maze_nw] remove maze_visited
tag @e[tag=maze_se] remove maze_visited

execute as @e[tag=maze_nw] store result score @s maze_x run data get entity @s Pos[0] 2
execute as @e[tag=maze_nw] store result score @s maze_z run data get entity @s Pos[2] 2
execute as @e[tag=maze_se] store result score @s maze_x run data get entity @s Pos[0] 2
execute as @e[tag=maze_se] store result score @s maze_z run data get entity @s Pos[2] 2

execute as @e[tag=maze_se] run scoreboard players operation @s offset_x = @s maze_x
execute as @e[tag=maze_se] run scoreboard players operation @s offset_x -= @e[tag=maze_nw,limit=1] maze_x
execute as @e[tag=maze_se] run scoreboard players operation @s offset_x %= MazeConst maze_scale
execute as @e[tag=maze_se,scores={offset_x=1..}] at @s run tp ~-1 ~ ~

execute as @e[tag=maze_se] run scoreboard players operation @s offset_z = @s maze_z
execute as @e[tag=maze_se] run scoreboard players operation @s offset_z -= @e[tag=maze_nw,limit=1] maze_z
execute as @e[tag=maze_se] run scoreboard players operation @s offset_z %= MazeConst maze_scale
execute as @e[tag=maze_se,scores={offset_z=1..}] at @s run tp ~ ~ ~-1

scoreboard players set MazeVars maze_id 1
scoreboard players set @e[tag=maze_nw] maze_id 0
scoreboard players set @e[tag=maze_se] maze_id 0

execute as @e[tag=maze_se] at @s run fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 light_gray_concrete
execute as @e[tag=maze_se] at @s run setblock ~ ~-1 ~ red_concrete

data modify storage minecraft:maze stack set value [1]