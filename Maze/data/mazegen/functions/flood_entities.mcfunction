# Put a limit here to limit the number of new entities appearing at once
tag @e[tag=maze_flood_new,sort=arbitrary,limit=128] add maze_flood_active
tag @e[tag=maze_flood_active] remove maze_flood_new

execute unless data storage maze building as @e[tag=maze_flood_active] at @s run fill ~-1 ~ ~-1 ~1 ~9 ~1 light[level=15] replace
execute unless data storage maze building if data storage maze running as @e[tag=maze_flood_active] at @s run fill ~-1 ~ ~-1 ~1 ~ ~1 black_concrete
execute unless data storage maze building if data storage maze running as @e[tag=maze_flood_active] at @s run setblock ~ ~ ~ red_concrete

execute if data storage maze building as @e[tag=maze_flood_active] at @s run fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:structure_block[mode=load]{ignoreEntities:1b,integrity:1.0f,mode:"LOAD",name:"mazegen:maze_wall",posX:0,posY:0,posZ:0,sizeX:1,sizeY:10,sizeZ:1} replace black_concrete
execute if data storage maze building as @e[tag=maze_flood_active] at @s run fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:structure_block[mode=load]{ignoreEntities:1b,integrity:1.0f,mode:"LOAD",name:"mazegen:maze_path",posX:0,posY:0,posZ:0,sizeX:1,sizeY:10,sizeZ:1} replace lime_concrete
execute if data storage maze building as @e[tag=maze_flood_active] at @s run fill ~-1 ~1 ~-1 ~1 ~1 ~1 redstone_block replace light
execute if data storage maze building as @e[tag=maze_flood_active] at @s run fill ~-1 ~1 ~-1 ~1 ~1 ~1 redstone_block replace air

# Spread out in all four directions, avoiding duplicates
execute as @e[tag=maze_flood_active] at @s if block ~01 ~-1 ~00 minecraft:light_gray_concrete if block ~02 ~-1 ~00 minecraft:light_gray_concrete positioned ~02 ~00 ~00 unless entity @e[tag=maze_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["maze_flood_new","maze_marker"]}
execute as @e[tag=maze_flood_active] at @s if block ~-1 ~-1 ~00 minecraft:light_gray_concrete if block ~-2 ~-1 ~00 minecraft:light_gray_concrete positioned ~-2 ~00 ~00 unless entity @e[tag=maze_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["maze_flood_new","maze_marker"]}
execute as @e[tag=maze_flood_active] at @s if block ~00 ~-1 ~01 minecraft:light_gray_concrete if block ~00 ~-1 ~02 minecraft:light_gray_concrete positioned ~00 ~00 ~02 unless entity @e[tag=maze_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["maze_flood_new","maze_marker"]}
execute as @e[tag=maze_flood_active] at @s if block ~00 ~-1 ~-1 minecraft:light_gray_concrete if block ~00 ~-1 ~-2 minecraft:light_gray_concrete positioned ~00 ~00 ~-2 unless entity @e[tag=maze_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["maze_flood_new","maze_marker"]}

# Mark used entities
scoreboard players set @e[tag=maze_flood_active] maze_id 0
tag @e[tag=maze_flood_active] remove maze_flood_active

# Recurse if speed is set
scoreboard players remove MazeVars maze_speed 1
execute if entity @e[tag=maze_flood_new] if score MazeVars maze_speed matches 1.. run function mazegen:flood_entities