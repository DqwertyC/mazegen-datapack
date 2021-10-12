# Maze Generator
This datapack provides resources to quickly generate a random maze in Minecraft. It uses a depth-first algorithm to fill an area with a non-looping maze.

## Using the Datapack
To use this datapack, you'll need to start by preparing a place to build your maze. The area to generate a maze in needs to be flat. By default, the maze will generate on `light_gray_concrete`. This can be changed by modifying  `flood_entities.mcfunction` and `low_entity_stack.mcfunction` to check for a different block type.

The command `/function mazegen:give_markers` will give the player four items. The first is an armor stand spawn egg that will set the starting point of the maze. Place in on any tile in the area that you want the maze generated in. The second is a blue lingering potion bottle, which can be thrown start generating the maze. After the maze is complete, throw the purple lingering potion to spawn in walls. Throwing the red lingering potion bottle will clear the existing maze.

The walls and floor of the maze are stored as structures. You can save a 1x5x1 structure to `mazegen:maze_path` and `mazegen:maze_wall` if you want to change the appearance of the maze.

The command `/scoreboard players set MazeConst maze_speed X` will change the speed of maze generation. It defaults to 1 when the datapack is loaded for the first time. 
