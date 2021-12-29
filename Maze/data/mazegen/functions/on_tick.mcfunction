# If new markers have been placed, kill the old ones
execute if entity @e[tag=maze_seed,tag=maze_tracked] if entity @e[tag=maze_seed,tag=!maze_tracked] run kill @e[tag=maze_seed,tag=maze_tracked]

# Check for Start/Reset potions
execute if entity @e[type=potion,nbt={Item:{tag:{MazeCreate:1b}}}] run function mazegen:start
execute if entity @e[type=potion,nbt={Item:{tag:{MazeBuild:1b}}}] run function mazegen:build
execute if entity @e[type=potion,nbt={Item:{tag:{MazeReset:1b}}}] run function mazegen:clear
execute if entity @e[type=potion,nbt={Item:{tag:{MazeFast:1b}}}] run function mazegen:faster
execute if entity @e[type=potion,nbt={Item:{tag:{MazeSlow:1b}}}] run function mazegen:slower

execute if entity @e[type=potion,nbt={Item:{tag:{MazePause:1b}}}] unless data storage minecraft:maze paused run function mazegen:pause
execute if entity @e[type=potion,nbt={Item:{tag:{MazePause:1b}}}] if data storage minecraft:maze paused run function mazegen:unpause

kill @e[type=potion,nbt={Item:{tag:{MazeCreate:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{MazeBuild:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{MazeReset:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{MazeFast:1b}}}]
kill @e[type=potion,nbt={Item:{tag:{MazeSlow:1b}}}]

# Get the positions of relevant entities
tag @e[tag=maze_seed] add maze_tracked

execute unless data storage minecraft:maze paused run function mazegen:pausable