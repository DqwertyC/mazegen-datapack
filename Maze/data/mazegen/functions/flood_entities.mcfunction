#Put a limit here to limit the number of new entities appearing at once
tag @e[tag=maze_flood_new,sort=arbitrary,limit=128] add maze_flood_active
tag @e[tag=maze_flood_active] remove maze_flood_new

execute as @e[tag=maze_flood_active] at @s run fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 light_gray_concrete
execute as @e[tag=maze_flood_active] at @s run setblock ~ ~-1 ~ red_concrete

execute as @e[tag=maze_flood_active] store result score @s maze_x run data get entity @s Pos[0] 2
execute as @e[tag=maze_flood_active] store result score @s maze_z run data get entity @s Pos[2] 2

execute as @e[tag=maze_flood_active] if score @s maze_x < @e[tag=maze_se,limit=1] maze_x at @s positioned ~2 ~ ~ unless entity @e[tag=maze_marker,distance=0...1] run summon minecraft:armor_stand ~ ~ ~ {Invisible:1b,Tags:["maze_flood_new","maze_marker"]}
execute as @e[tag=maze_flood_active] if score @s maze_z < @e[tag=maze_se,limit=1] maze_z at @s positioned ~ ~ ~2 unless entity @e[tag=maze_marker,distance=0...1] run summon minecraft:armor_stand ~ ~ ~ {Invisible:1b,Tags:["maze_flood_new","maze_marker"]}

scoreboard players set @e[tag=maze_flood_active] maze_id 0
tag @e[tag=maze_flood_active] remove maze_flood_active