scoreboard objectives add maze_id dummy
scoreboard objectives add active_id dummy

scoreboard objectives add maze_x dummy
scoreboard objectives add maze_z dummy
scoreboard objectives add offset_x dummy
scoreboard objectives add offset_z dummy

scoreboard objectives add maze_speed dummy
scoreboard players set MinSpeed maze_speed 1
scoreboard players set MaxSpeed maze_speed 1000
scoreboard players set DelSpeed maze_speed 10
execute unless score MazeConst maze_speed matches 1.. run scoreboard players set MazeConst maze_speed 1