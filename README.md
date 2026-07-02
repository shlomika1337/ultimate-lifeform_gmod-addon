# Ultimate Lifeform (SWEP) — Stone Mask of Chaos

A Garry's Mod weapon (SWEP) written in Lua, published on the Steam Workshop. It turns the player into an over-the-top "ultimate lifeform" with a roster of scripted abilities: laser eyes, a time-stop prop-kill, powered flight, an object pickup-and-throw mechanic, and health-driven music states.

Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2839481410

I wrote this by hand, before AI coding assistants were useful for this kind of work. It is a self-taught project against Garry's Mod's Lua API, which is sparsely documented, so most of it came from reading the engine's function reference and a lot of trial and error on a live server.

## What it does

- **Laser eyes** (left mouse): a continuous traced beam that damages what it hits, with fire and impact sounds.
- **Time-stop prop-kill** (right mouse): a "ZA WARUDO" ability that freezes the scene, repositions the player, and applies a burst of physics force to nearby props and players before time resumes.
- **Powered movement** (spacebar): a charged powerjump on the ground and mid-air wing-flapping flight, with looping wind and wing sounds.
- **Pick up and throw** (E): grab any player or prop and hurl it, using the physics API to apply directional force.
- **King Crimson dodge**: a probabilistic damage-negation ability. A `PlayerShouldTakeDamage` hook rolls against a dodge chance on every incoming hit; on a successful roll it "erases" the damage and teleports the player to a random valid in-world position, with the dodge sound played at both the old and new location. The dodge chance ramps up as the player's health drops.
- **ESP overlay**: a `HUDPaint` hook that walks every entity in the world, projects its position to screen space with world-to-screen (`:ToScreen()`) projection each frame, and labels it on the HUD (name, or `???` when unknown).
- **Chaos abilities**: simulated AC-130 and A-10 strafing runs (blast damage, explosions, screen shake, near-miss bullet audio), random lightning strikes traced from the sky, and a rotating list of ragdoll/prop models flung around for effect.
- **Health-driven state**: the weapon tracks the player's HP and swaps background music, dodge chance, and behavior when low.

## What it demonstrates (technically)

- Garry's Mod client/server model: the `CLIENT` / `SERVER` split, sound and effect broadcasting, and precaching of assets.
- The entity and physics API: trace lines, `ApplyForceCenter`, blast damage, world-bounds checks, and prop spawning/manipulation.
- HUD and rendering: custom fonts and on-screen drawing on the client.
- Event-driven structure: per-tick `Think` logic, primary/secondary attack handlers, and heavy use of GMod's hook system (`PlayerShouldTakeDamage`, `HUDPaint`, `GetFallDamage`, `PlayerDeathThink`) to override engine behavior, with matching teardown when the weapon is holstered.
- World-to-screen projection for the ESP overlay, and probabilistic event interception for the dodge mechanic.
- Roughly 1,000 lines of Lua managing state across a networked multiplayer game.

## Assets not included

The original Workshop version ships with audio and a texture that are copyrighted third-party material (anime and game soundtrack clips, character theming). Those are **not** included in this repository. Only my own code is here. The addon references the assets by the paths listed in `lua/autorun/server/init.lua`; to run it as published, use the Steam Workshop version linked above.

## Layout

```
lua/weapons/weapon_kars_mask.lua   -- the SWEP: all abilities and logic (~985 lines)
lua/autorun/server/init.lua        -- server-side asset registration
addon.json                         -- Workshop addon manifest
```

## Note

Published on the Workshop under the author name "nativ" (me).

