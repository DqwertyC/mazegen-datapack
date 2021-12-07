# If new markers have been placed, kill the old ones
execute if entity @e[tag=pattern_seed,tag=stitch_tracked] if entity @e[tag=pattern_seed,tag=!stitch_tracked] run kill @e[tag=pattern_seed,tag=stitch_tracked]
tag @e[tag=pattern_seed,tag=!stitch_tracked] add stitch_tracked

# Check for Start/Reset potions
execute if entity @e[type=potion,nbt={Item:{tag:{PatternCreate:1b}}}] run function stitchgen:start
execute if entity @e[type=potion,nbt={Item:{tag:{PatternReset:1b}}}] run function stitchgen:clear

kill @e[type=potion,nbt={Item:{tag:{PatternCreate:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{PatternReset:1b}}}]

# If there are entities to flood, do so
execute if data storage stitch flooding run scoreboard players operation stitchVars stitch_speed = stitchConst stitch_speed
execute if data storage stitch flooding run execute if entity @e[tag=stitch_flood_new] run function stitchgen:flood_entities

# Handle switching from flooding to generating
execute if data storage stitch flooding unless entity @e[tag=stitch_flood_new] run kill @e[type=marker,tag=stitch_marker]
execute if data storage stitch flooding unless entity @e[tag=stitch_flood_new] at @e[tag=pattern_seed,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:['active_x_starter','active_z_starter','active_starter']}
execute if data storage stitch flooding unless entity @e[tag=stitch_flood_new] run data remove storage stitch flooding

# Generate the stitch pattern
scoreboard players operation stitchVars stitch_speed = stitchConst stitch_speed
execute if data storage stitch running unless data storage stitch flooding if entity @e[tag=active_starter] run function stitchgen:generate_pattern
execute if data storage stitch running unless data storage stitch flooding unless entity @e[tag=active_starter] run data remove storage stitch running