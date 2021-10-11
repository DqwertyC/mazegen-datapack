# Maze Generator
This datapack provides resources to quickly generate a random maze in Minecraft. It uses a depth-first algorithm to fill an area with a non-looping maze.

## Using the Datapack
To use this datapack, you'll need to start by preparing a place to build your maze. The area to generate a maze in needs to be flat. By default, the maze will generate on `light_gray_concrete`. This can be changed by modifying  `flood_entities.mcfunction` and `low_entity_stack.mcfunction` to check for a different block type.

The command `/function mazegen:give_markers` will give the player three items. The first is an armor stand spawn egg that will set the starting point of the maze. Place in on any tile in the area that you want the maze generated in. The second is a green lingering potion bottle. Throw it to start generating the maze. Throwing the red lingering potion bottle will clear the existing maze.

The command `/scoreboard players set MazeConst maze_speed X` will change the speed of maze generation. It defaults to 1 when the datapack is loaded for the first time. 