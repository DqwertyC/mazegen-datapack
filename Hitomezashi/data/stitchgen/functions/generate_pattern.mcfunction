
execute as @e[tag=active_z_starter,limit=1] at @s if block ~02 ~00 ~00 minecraft:red_concrete if block ~02 ~-1 ~00 minecraft:light_gray_concrete positioned ~02 ~00 ~00 run summon minecraft:marker ~0 ~ ~0 {Tags:['next_z_starter']}
execute as @e[tag=active_z_starter,limit=1] at @s run summon minecraft:marker ~0 ~ ~1 {Tags:['valid_z']}
execute as @e[tag=active_z_starter,limit=1] at @s run summon minecraft:marker ~0 ~ ~3 {Tags:['valid_z']}
kill @e[tag=valid_z,sort=random,limit=1]
execute as @e[tag=valid_z,limit=1] at @s run function stitchgen:fill_z
kill @e[tag=valid_z]

execute as @e[tag=active_x_starter,limit=1] at @s if block ~00 ~00 ~02 minecraft:red_concrete if block ~00 ~-1 ~02 minecraft:light_gray_concrete positioned ~00 ~00 ~02 run summon minecraft:marker ~0 ~ ~0 {Tags:['next_x_starter']}
execute as @e[tag=active_x_starter,limit=1] at @s run summon minecraft:marker ~1 ~ ~0 {Tags:['valid_x']}
execute as @e[tag=active_x_starter,limit=1] at @s run summon minecraft:marker ~3 ~ ~0 {Tags:['valid_x']}
kill @e[tag=valid_x,sort=random,limit=1]
execute as @e[tag=valid_x,limit=1] at @s run function stitchgen:fill_x
kill @e[tag=valid_x]

kill @e[tag=active_z_starter]
kill @e[tag=active_x_starter]
tag @e[tag=next_z_starter] add active_z_starter
tag @e[tag=next_x_starter] add active_x_starter
tag @e[tag=active_z_starter] remove next_z_starter
tag @e[tag=active_x_starter] remove next_x_starter
tag @e[tag=active_z_starter] add active_starter
tag @e[tag=active_x_starter] add active_starter

scoreboard players remove stitchVars stitch_speed 1
execute if entity @e[tag=active_starter] if score stitchVars stitch_speed matches 1.. run function stitchgen:generate_pattern