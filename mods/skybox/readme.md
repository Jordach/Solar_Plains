
## skybox - a player skybox mod (and API!)

### License of code and artwork

Copyright (C) 2017 - Auke Kok <sofar@foo-projects.org>

Provides a basic API for modifying a player sky box in a coherent
fashion.

SkyboxSet by Heiko Irrgang ( http://gamvas.com ) is licensed under
the Creative Commons Attribution-ShareAlike 3.0 Unported License.
Based on a work at http://93i.de.

### Usage

The `skybox` privilege allows players to change their own sky boxes.
The command allows listing, and changing skyboxes, or turning skybox
settings `off`.

### API

The `skybox` handle can be used to perform various actions:

`skybox.clear(player)`
 -- Reverts the player skybox setting to the default.

`skybox.set(player, number)`
 -- Sets the skybox to the `number` in the list of current skyboxes.

`skybox.add(skyboxdef)`
 -- Add a new skybox with skyboxdef to the list of available skyboxes.


```
skyboxdef = {
	[1] -- Base name of texture. The 6 textures you need to
	    -- provide need to start with this value, and then
	    -- have "Up", "Down", "Front", "Back", "Left" and
	    -- "Right", Followed by ".jpg" as the file name.
	[2] -- Sky color (colorstring)
	[3] -- Day/Night ratio value (float - [0.0, 1.0])
