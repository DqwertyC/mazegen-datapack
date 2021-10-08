scoreboard objectives add maze_id dummy
scoreboard objectives add active_id dummy

scoreboard objectives add maze_x dummy
scoreboard objectives add maze_z dummy
scoreboard objectives add offset_x dummy
scoreboard objectives add offset_z dummy

scoreboard objectives add maze_speed dummy
scoreboard objectives add maze_scale dummy
scoreboard players set MazeConst maze_scale 4
execute unless score MazeConst maze_speed matches 1.. run scoreboard players set MazeConst maze_speed 1