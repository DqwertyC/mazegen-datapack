scoreboard objectives add stitch_id dummy
scoreboard objectives add active_id dummy

scoreboard objectives add stitch_x dummy
scoreboard objectives add stitch_z dummy
scoreboard objectives add offset_x dummy
scoreboard objectives add offset_z dummy

scoreboard objectives add stitch_speed dummy
scoreboard objectives add stitch_scale dummy
scoreboard players set stitchConst stitch_scale 4
execute unless score stitchConst stitch_speed matches 1.. run scoreboard players set stitchConst stitch_speed 1