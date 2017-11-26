
## luscious

Makes your map luscious.

This mod heavily modifies your base landscape and modifies various
nodes like dirt and leaves so that they become colored using node
coloring.

The color selection of each node is decided based on the biome data,
using heat and humidity. These are mapped on a 16x16 palette where
the heat is mapped along the x axis from 0-15 and the humidity along
the y axis with the same range. This gives us a total of 256 possible
colorizations of each node.

Manual placing of the nodes, and sapling placement is also modified to
make trees growing or manual placing of nodes also result in colorized
nodes in the landscape.

## features

- Player placed blocks are properly colored.
- Saplings that grow into trees color correctly.
- separate palette to color leaves and grass.
- should not break with texture packs, but you'll lose texture
  pack specific leaf and grass textures.
- jungle dirt is replaced by dirt with grass.
- dirt with dry grass is replaced by dirt with grass.
- dirt with snow is replaced by dirt with grass.
- dry grass is replaced with grass.

## bugs

- leaf decay is broken due to p2 usage
- grass spread is broken or will place wrongly colored grass nodes
- snowy pine trees are no longer generated, only regular pines

## palette

The large palette image is generated with:

```
  convert textures/luscious_grass_palette.png -filter point \
   -resize 256x256 textures/luscious_grass_palette_large.png
```

## Installation

Create a new world, enable this mod. Do not use this mod in an existing
world, ever.

## How does this work?

The biome data is available in a special thread when mapgen emerges
new map blocks. This mod captures the biome heat and humidity values
right as mapgen creates them and stores them permanently for later
use. This is why you need to have a `luscious` folder in the world
folder. In this folder, we store the heat & humidity param2 values
for each node that needs coloring in an X-Z map (Y is discarded as
biome data does not use Y and is not 3d noise, it's only 2D).

Once the biome data is known, we can retrieve it to set the correct
p2 values when a player places any of the nodes that need coloring, or
when a tree grows. This is also why the biome data needs to be stored
on disk - otherwise it would be lost. The storage of the biome data
is reasonably small - it is stored compressed and uses about 600 bytes
or so per x, z chunk, which is small compared to the actual map.sqlite
size. The data increases the size of your world by about 12% or so.
