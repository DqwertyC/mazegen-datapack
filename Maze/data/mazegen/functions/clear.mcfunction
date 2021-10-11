# Clear maze around markers
function mazegen:start_flood
data remove storage maze running
data modify storage maze flooding set value 1b