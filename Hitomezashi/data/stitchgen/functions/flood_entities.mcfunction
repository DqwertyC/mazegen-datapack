# Put a limit here to limit the number of new entities appearing at once
tag @e[tag=stitch_flood_new,sort=arbitrary,limit=128] add stitch_flood_active
tag @e[tag=stitch_flood_active] remove stitch_flood_new

execute if data storage stitch clearing as @e[tag=stitch_flood_active] at @s run fill ~-1 ~ ~-1 ~1 ~9 ~1 air
execute if data storage stitch running as @e[tag=stitch_flood_active] at @s run fill ~-1 ~ ~-1 ~1 ~ ~1 white_concrete
execute if data storage stitch running as @e[tag=stitch_flood_active] at @s run fill ~-1 ~1 ~-1 ~1 ~1 ~1 light[level=12]
execute if data storage stitch running as @e[tag=stitch_flood_active] at @s run setblock ~ ~ ~ red_concrete

# Spread out in all four directions, avoiding duplicates
execute as @e[tag=stitch_flood_active] at @s if block ~01 ~-1 ~00 minecraft:light_gray_concrete if block ~02 ~-1 ~00 minecraft:light_gray_concrete positioned ~02 ~00 ~00 unless entity @e[tag=stitch_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["stitch_flood_new","stitch_marker"]}
execute as @e[tag=stitch_flood_active] at @s if block ~-1 ~-1 ~00 minecraft:light_gray_concrete if block ~-2 ~-1 ~00 minecraft:light_gray_concrete positioned ~-2 ~00 ~00 unless entity @e[tag=stitch_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["stitch_flood_new","stitch_marker"]}
execute as @e[tag=stitch_flood_active] at @s if block ~00 ~-1 ~01 minecraft:light_gray_concrete if block ~00 ~-1 ~02 minecraft:light_gray_concrete positioned ~00 ~00 ~02 unless entity @e[tag=stitch_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["stitch_flood_new","stitch_marker"]}
execute as @e[tag=stitch_flood_active] at @s if block ~00 ~-1 ~-1 minecraft:light_gray_concrete if block ~00 ~-1 ~-2 minecraft:light_gray_concrete positioned ~00 ~00 ~-2 unless entity @e[tag=stitch_marker,distance=0...1] run summon minecraft:marker ~ ~ ~ {Tags:["stitch_flood_new","stitch_marker"]}

# Mark used entities
tag @e[tag=stitch_flood_active] remove stitch_flood_active

# Recurse if speed is set
scoreboard players remove stitchVars stitch_speed 1
execute if entity @e[tag=stitch_flood_new] if score stitchVars stitch_speed matches 1.. run function stitchgen:flood_entities