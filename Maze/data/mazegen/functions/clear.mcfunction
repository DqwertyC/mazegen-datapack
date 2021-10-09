# Clear maze around markers
execute as @e[tag=maze_marker] at @s run fill ~-1 ~ ~-1 ~1 ~ ~1 air
tag @e[tag=maze_seed] remove maze_marker

# Reset markers except for the seed
kill @e[tag=maze_marker]

data remove storage maze running