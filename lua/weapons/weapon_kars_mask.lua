-- SWEP properties
SWEP.PrintName			     = "Stone Mask"
SWEP.Author			         = "nativ"
SWEP.Instructions		     = "Left Mouse - Laser eyes\nRight Mouse - Time-stop propkill\nHold spacebar for powerjump (on ground) / flapping your wings (mid-air)\n Press E to pick-up any player or prop"
SWEP.Primary.ClipSize		 = -1
SWEP.Primary.DefaultClip	 = -1
SWEP.Primary.Automatic		 = true
SWEP.Primary.Ammo		     = "none"
SWEP.ClassName				 = "weapon_kars_mask"
SWEP.m_WeaponDeploySpeed	 = 3
SWEP.Category				 = "Chaos"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Secondary.ClipSize		 = -1
SWEP.Secondary.DefaultClip	 = -1
SWEP.Secondary.Automatic	 = false
SWEP.Secondary.Ammo		     = "none"

SWEP.Weight			    = 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= false

SWEP.Slot			    = 0
SWEP.SlotPos			= 0
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.ViewModel			= "models/weapons/v_hands.mdl"
SWEP.WorldModel			= "models/nova/w_headgear.mdl"

-- Model list for chaotic effect
local model_list = {"models/props_c17/FurnitureChair001a.mdl",
    "models/props_c17/oildrum001_explosive.mdl",
    "models/props_c17/oildrum001.mdl",
    "models/props_junk/sawblade001a.mdl",
    "models/props_c17/doll01.mdl",
    "models/Gibs/HGIBS.mdl",
    "models/props_junk/bicycle01a.mdl",
    "models/props_junk/watermelon01.mdl",
    "models/props_lab/monitor02.mdl",
    "models/props_lab/monitor01a.mdl",
    "models/props_interiors/BathTub01a.mdl",
    "models/props_c17/FurnitureWashingmachine001a.mdl",
    "models/props_wasteland/laundry_dryer002.mdl",
    "models/props_c17/FurnitureCouch002a.mdl",
    "models/props_interiors/VendingMachineSoda01a.mdl",
    "models/props_junk/TrashBin01a.mdl",
    "models/props_junk/TrafficCone001a.mdl",
    "models/props_lab/blastdoor001c.mdl",
    "models/props_wasteland/controlroom_storagecloset001b.mdl",
    "models/props_wasteland/controlroom_desk001b.mdl",
    "models/props_interiors/Furniture_Couch01a.mdl",
    "models/props_vehicles/car003a_physics.mdl",
    "models/props_interiors/Radiator01a.mdl",
    "models/props_c17/FurnitureFridge001a.mdl"}

-- Font
if (CLIENT) then surface.CreateFont("DarkSoulsFont", {font = "Liberation Mono",size = 24,weight = 1000, }) end
if (CLIENT) then surface.CreateFont("DarkSoulsFontSmall", {font = "Liberation Mono",size = 12,weight = 1000, }) end

-- Precached Sounds
local avalon_theme 			= Sound("avalon.mp3")
local kars_laugh 			= Sound("kars_laugh.mp3")
local timestop_sound 		= Sound("zawarudo.mp3")
local a10_flyby				= Sound("a10fly.mp3")
local a10_gau				= Sound("gau.mp3")
local a10_bullet_sound 		= Sound("physics/concrete/concrete_impact_bullet3.wav")
local a10_bullet_miss_sound = Sound("weapons/fx/nearmiss/bulletLtoR14.wav")
local kars_blink			= Sound("whammm.mp3")
local kars_death			= Sound("kars_death.mp3")
local flapp_table			= { Sound("wings.mp3"), Sound("wings2.mp3"), Sound("wings3.mp3"), Sound("wings4.mp3") }
local low_hp_theme			= Sound("low_hp.mp3")
local glide_sound			= Sound("ambient/wind/wind1.wav")
local strongjump_sound		= Sound("powerjump.mp3")
local nuclear_sound			= Sound("tactical.mp3")
local ac130above_sound		= Sound("above.mp3")
local dodge_sound			= Sound("kingcrimson.mp3")
local crashing_sound 		= {
	Sound("physics/concrete/boulder_impact_hard1.wav"),
	Sound("physics/concrete/boulder_impact_hard2.wav"),
	Sound("physics/concrete/boulder_impact_hard3.wav"),
	Sound("physics/concrete/boulder_impact_hard4.wav") }
local exploding_sound		= Sound("weapons/mortar/mortar_explode1.wav")
local shell_incoming 		= Sound("weapons/mortar/mortar_shell_incomming1.wav")
local hesitation_sound		= Sound("hesitation.mp3")
local laser_hit_sound		= Sound("ambient/energy/weld1.wav")
local laser_fire_sound		= Sound("ambient/energy/weld2.wav")
local charged_jump			= Sound("npc/antlion/rumble1.wav")
local rumbling_sound		= Sound("ambient/atmosphere/underground_hall_loop1.wav")
local thunders				= {
	Sound("ambient/atmosphere/thunder1.wav"),
	Sound("ambient/atmosphere/thunder2.wav"),
	Sound("ambient/atmosphere/thunder3.wav"),
	Sound("ambient/atmosphere/thunder4.wav") }
local lightning_sound		= Sound("ambient/energy/spark1.wav")
local lightning_sound_init  = {
	Sound("ambient/levels/labs/electric_explosion1.wav"),
	Sound("ambient/levels/labs/electric_explosion2.wav"),
	Sound("ambient/levels/labs/electric_explosion3.wav"),
	Sound("ambient/levels/labs/electric_explosion4.wav"),
	Sound("ambient/levels/labs/electric_explosion5.wav"),
}
--local forcefield_sound		= Sound("ambient/energy/force_field_loop1.wav")
local lasereyes_sound		= Sound("ambient/energy/electric_loop.wav")

-- SWEP Owner First-person ViewModels
local firemode0_viewmodel	= "weapon_fists"
local firemode1_viewmodel	= "weapon_fists"

-- Global Maximums
local max_hp				= 5000
local max_armor				= 500
local max_hp_reached		= false
local max_armor_reached		= false
local max_timed_fly			= 50
local max_timed_armor		= 45
local max_timed_chaos		= 500
local max_blink_distance	= 300
local max_jump_power		= 2000
local ac130_radius			= 250
local a10_radius			= 100
local blink_damage			= 75
local glide_speed			= 700
local phase2_hp_percent		= 0.5

-- Global Counters
local timed_armor 			= 0
local timed_fly				= 0
local timed_jump_power		= 0
local timed_chaos			= 0
local fly_power				= 450
local phase2_reached		= false
local owner_flying			= false
local dodge_chance			= 0.04

-- More Globals
local placeholder_model		= "models/props_c17/FurnitureDrawer001a_Shard01.mdl"
local skylaser_material		= "cable/redlaser"
local laser_decal			= "FadingScorch"
local lightning_materials	= {"cable/physbeam", "cable/blue_elec"}
local broken_surface		= "models/props_debris/plaster_floor003a.mdl"
local flying_debris			= {"models/props_debris/concrete_spawnchunk001a.mdl",
"models/props_debris/concrete_spawnchunk001b.mdl",
"models/props_debris/concrete_spawnchunk001c.mdl",
"models/props_debris/concrete_spawnchunk001d.mdl",
"models/props_debris/concrete_spawnchunk001e.mdl",
"models/props_debris/concrete_spawnchunk001f.mdl",
"models/props_debris/concrete_spawnchunk001g.mdl",
"models/props_debris/concrete_spawnchunk001h.mdl",
"models/props_debris/concrete_spawnchunk001i.mdl",
"models/props_debris/concrete_spawnchunk001j.mdl",
"models/props_debris/concrete_spawnchunk001k.mdl"}
local ply_trace 			= {}
local ply_sounds			= {}
local incoming_not_playing	= true
local sky_height			= 0
local sky_vec_z				= 9999
local supersonic_speed		= 1200
local forcefield_material	= "Models/effects/comball_sphere"

function SWEP:Precache()
	util.PrecacheSound(avalon_theme)
	util.PrecacheSound(kars_laugh)
	util.PrecacheSound(timestop_sound)
	util.PrecacheSound(a10_flyby)
	util.PrecacheSound(a10_gau)
	util.PrecacheSound(a10_bullet_sound)
	util.PrecacheSound(a10_bullet_miss_sound)
	util.PrecacheSound(kars_blink)
	util.PrecacheSound(kars_death)
	util.PrecacheSound(low_hp_theme)
	util.PrecacheSound(glide_sound)
	util.PrecacheSound(strongjump_sound)
	util.PrecacheSound(nuclear_sound)
	util.PrecacheSound(ac130above_sound)
	util.PrecacheSound(dodge_sound)
	util.PrecacheSound(crashing_sound)
	util.PrecacheSound(exploding_sound)
	util.PrecacheSound(shell_incoming)
	util.PrecacheSound(hesitation_sound)
	util.PrecacheSound(laser_hit_sound)
	util.PrecacheSound(laser_fire_sound)
	util.PrecacheSound(charged_jump)
	util.PrecacheSound(rumbling_sound)
	util.PrecacheSound(lasereyes_sound)
end

function notIn(obj, t)
	for i,k in ipairs(t) do
		if obj == k then return true end
	end
	return false
end

function fixedSoundEmit(pos, sound, volume)
	volume = volume or 100
	local temp_ent = ents.Create( "prop_physics" )
	temp_ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	temp_ent:SetPos(pos)
	temp_ent:SetModel(placeholder_model)
	temp_ent:Spawn()
	temp_ent:EmitSound(sound, volume)
	temp_ent:Remove()
end

function doTimeskipDodge(ply, target)
	if (CLIENT) then return end
	--hook.Add("RenderScreen", "timeskip", function(origin, angles, fov) return true end)
	--hook.Add("FinishMove", "timeskip_move", function(ply, mv) return true end)
	--hook.Add("KeyPressed", "timeskip_keys", function(ply, key) return true end)
	--hook.Add("PreRender", "timeskip_render", function() return true end)
	--last_pos = ply:GetPos()
	--random_pos = Vector(ply:GetPos().x + math.random(-max_blink_distance, max_blink_distance), 
	--ply:GetPos().y + math.random(-max_blink_distance, max_blink_distance), ply:GetPos().z)
	
	target_back = (target:GetPos() + (-50)*(target:GetAimVector():GetNormalized())) * Vector(1,1,0) + Vector(0,0,(target:GetPos().z+1))
	if(util.IsInWorld(target_back)) then 
		fixedSoundEmit(ply:GetPos(), dodge_sound)
		fixedSoundEmit(target_back, dodge_sound)
		ply:SetPos(target_back)
		ply:SetEyeAngles(target:GetAimVector():Angle())
	end
	--ply:SetPos(random_pos)
	--timer.Simple(0.75, function()
	--	ply:SetPos(last_pos)
	--end)

	--hook.Remove("RenderScreen", "timeskip")
	--hook.Remove("FinishMove", "timeskip_move")
	--hook.Remove("KeyPressed", "timeskip_keys")
	--hook.Remove("PreRender", "timeskip_render")
	--hook.Add("RenderScreen", "undo_timeskip", function(origin, angles, fov) return false end)
	--hook.Add("FinishMove", "undo_timeskip_move", function(ply, mv) return false end)
	--hook.Add("KeyPressed", "undo_timeskip_keys", function(ply,key) return false end)
	--hook.Add("PreRender", "undo_timeskip_render", function() return false end)
end

function createRandomDebrisProp(pos, normal, prop, speed)
	local ent = ents.Create( "prop_physics" )
	if ( not ent:IsValid() ) then return end
	local random_direction = Angle(0,math.random(0,360),0):Forward()
	local random_angle = Angle(math.random(185,250),0,math.random(185,250)):Forward()
	local random_push_direction = random_direction + random_angle
	ent:SetModel( prop )
	ent:SetPos(pos + random_direction*90 + random_angle)
	--ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	ent:Spawn()
	phys = ent:GetPhysicsObject()
	random_push_direction:Mul(speed*25)
	phys:ApplyForceCenter(random_push_direction)
	if ( speed > supersonic_speed) then ent:Ignite(12) end
	timer.Simple(20, function() if (ent:IsValid()) then ent:Remove() end end)
end

function createDebris(ply, prop, speed)
	if ( speed < supersonic_speed/2) then return end
	local ply_pos = ply:GetPos()
	local effectData = EffectData()
	local ground_trace = util.TraceLine({start=ply:GetPos(),
				endpos=ply:GetPos()-Vector(0,0,300),
				collisiongroup=COLLISION_GROUP_WORLD})
	local a_pos = ground_trace.HitPos
	local a_normal = ground_trace.HitNormal
	timer.Simple(0.1, function() 
		for i=0, 7, 1 do
			util.Effect("ThumperDust", effectData)
		end
	end)
	effectData:SetOrigin(a_pos)
	effectData:SetScale(100)
	effectData:SetRadius(900)
	local ent = ents.Create( "prop_physics" )
	if ( not ent:IsValid() ) then return end
	ent:SetModel( prop )
	ent:SetPos(a_pos-Vector(0,0,1.5))
	ent:SetAngles(a_normal:Angle() + Angle(90,0,0))
	ent:Spawn()
	if ( speed > supersonic_speed) then 
		ent:Ignite(15)
	end
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	ent:GetPhysicsObject():EnableMotion(false)
	timer.Simple(20, function() if (ent:IsValid()) then ent:Remove() end end)
	util.ScreenShake(ply:GetPos(), 100000*speed, 1000*speed, speed/500, 10000)
	fixedSoundEmit(ply:GetPos(), table.Random(crashing_sound), 6*speed)
	fixedSoundEmit(ply:GetPos(), exploding_sound, 6*speed/10)
	for k=0, speed/60, 1 do
		createRandomDebrisProp(a_pos, a_normal, table.Random(flying_debris), speed)
	end
end

function SWEP:ZaWarudoDodge()
	old_pos = self:GetOwner():GetPos()
	for i=0, 10, 1 do
		random_pos = Vector(self:GetOwner():GetPos().x + math.random(-max_blink_distance, max_blink_distance), 
			self:GetOwner():GetPos().y + math.random(-max_blink_distance, max_blink_distance), self:GetOwner():GetPos().z+5)
		if (util.IsInWorld(random_pos)) then
			self:GetOwner():EmitSound(kars_blink, 100)
			self:SetNextPrimaryFire( CurTime() + 2 )
			fixedSoundEmit(self:GetOwner():GetPos(), timestop_sound)
			timer.Simple(0.1, function()
				self:GetOwner():SetPos(random_pos)
			end)
			break
		else continue end
	end
	for x=0,20,1 do
		local forcefield_ent = ents.Create( "prop_physics" )
		forcefield_ent:SetPos(old_pos)
		forcefield_ent:SetModel("models/hunter/misc/sphere375x375.mdl")
		forcefield_ent:SetMaterial(forcefield_material)
		forcefield_ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		forcefield_ent:Spawn()
		forcefield_ent:GetPhysicsObject():EnableMotion(false)
		timer.Simple(0.05*x, function() if (forcefield_ent:IsValid()) then forcefield_ent:Remove() end end)
	end
end

function SWEP:randomLightning()
	local random_x = math.random(-9999,9999)
	local random_y = math.random(-9999,9999)
	local trace = util.TraceLine({start=Vector(random_x,random_y,sky_vec_z*0.99),
		endpos=Vector(random_x+math.random(-300,300),random_y+math.random(-300,300),-999999),
	collisiongroup=COLLISION_GROUP_NONE})
	local lightning_end = trace.HitPos
	fixedSoundEmit(lightning_end, lightning_sound)
	timer.Simple(sky_height*0.01*math.random(5,10), function() 
		fixedSoundEmit(lightning_end+Vector(0,0,100), table.Random(lightning_sound_init)) end)
	if (trace.Entity != self:GetOwner() and trace.Hit and not trace.HitWorld) then 
		trace.Entity:TakeDamage(500) end
	if (trace.Hit and not trace.HitWorld) then trace.Entity:Ignite(3) end
	local lightning_bolt = constraint.CreateKeyframeRope( Vector(0,0,0), math.random(9,40), lightning_materials[2], nil,
		game.GetWorld(), Vector(random_x,random_y,sky_vec_z), 0, game.GetWorld(), lightning_end, 0)
	timer.Simple(0.05*math.random(5,10), function() lightning_bolt:Remove() end)
end

function effectRandomPosition(effect, trace, radius)
	if (trace.Entity:IsWorld()) then
		effect:SetOrigin(trace.HitPos)
		effect:SetNormal(trace.HitNormal)
		if (trace.HitNormal.x == 0) then
			effect:SetOrigin(effect:GetOrigin()+Vector(math.Rand(-radius,radius),0,0))
		end
		if (trace.HitNormal.y == 0) then
			effect:SetOrigin(effect:GetOrigin()+Vector(0,math.Rand(-radius,radius),0))
		end
		if (trace.HitNormal.z == 0) then
			effect:SetOrigin(effect:GetOrigin()+Vector(0,0,math.Rand(-radius,radius)))
		end
	else
		effect:SetOrigin(trace.HitPos+Vector(math.Rand(-radius,radius),math.Rand(-radius,radius),0))
	end

	return effect
end

function skyLaser(pos)
	local ent, rope = constraint.Rope( game.GetWorld(), game.GetWorld(), 0,0, pos, pos+Vector(0,0,10000),
	 5000, 0, 0, 25, skylaser_material, true, Color(255,0,0))
end

function SWEP:AC130(aim_trace)

	for i=1,35,1 do
		timer.Simple(0.25+i/30+1, function ()
				local effectData = EffectData()	
				effectData:SetScale(1)
				effectData = effectRandomPosition(effectData, aim_trace, ac130_radius)
				util.BlastDamage(self:GetOwner(), self:GetOwner(), effectData:GetOrigin(), ac130_radius, 25)
				util.Effect("Explosion", effectData)
				util.Effect("HelicopterMegaBomb", effectData)
				util.ScreenShake(aim_trace.HitPos, 7, 5, 2, 3000)
			end)
	end
end

function SWEP:A10(aim_trace)
	timer.Simple(0.75, function()
		fixedSoundEmit(aim_trace.HitPos+Vector(0,0,1000), a10_gau)
		fixedSoundEmit(aim_trace.HitPos+Vector(0,0,1000), a10_flyby)
		util.ScreenShake(aim_trace.HitPos, 10, 1, 1, 1500)
	end)
	
	for i=1,150,1 do
		timer.Simple(0.25+i/50, function ()
				local effectData = EffectData()
				effectData:SetScale(500)
				effectData:SetNormal(aim_trace.HitNormal)
				effectData = effectRandomPosition(effectData, aim_trace, a10_radius)
				fixedSoundEmit(effectData:GetOrigin(), a10_bullet_sound)
				fixedSoundEmit(effectData:GetOrigin(), a10_bullet_miss_sound, 90)
				util.BlastDamage(self:GetOwner(), self:GetOwner(), effectData:GetOrigin(), a10_radius, 3)
				util.Effect("metalspark", effectData)
				util.Effect("ThumperDust", effectData)
				util.ScreenShake(aim_trace.HitPos, 3, 1, 1, 1500)
			end)
	end
end

function SWEP:ThrowObjects( prop_model, flag)
	if ( not self:GetOwner():IsValid() ) then return end

	local ent = ents.Create( "prop_physics" )
	if ( not ent:IsValid() ) then return end

	ent:SetModel( prop_model )
	local aimvec = self:GetOwner():GetAimVector()
	local pos = aimvec*128
	pos:Add( self:GetOwner():EyePos() ) 
	if( util.IsInWorld(pos)) then ent:SetPos( pos )
	else ent:SetPos(aimvec+Vector(0,0,1000)) end
	ent:SetAngles( self:GetOwner():EyeAngles()+AngleRand() )
	ent:Spawn()
	if (math.random(0,1)>0.5) then ent:Ignite(20) end
 	timer.Simple(0, function() ent:SetCollisionGroup(COLLISION_GROUP_NONE) end)

	local phys = ent:GetPhysicsObject()
	if ( not phys:IsValid() ) then ent:Remove() return end
	aimvec:Mul( 99999999 )
	aimvec:Add( VectorRand( -1000, 1000 ) )
	phys:EnableGravity(math.random(0,1)>0.5)
	phys:EnableDrag(math.random(0,1)>0.5)
	phys:ApplyForceCenter( aimvec )
	 
	cleanup.Add( self:GetOwner(), "props", ent )
	undo.Create( "kars_random_prop" )
		undo.AddEntity( ent )
		undo.SetPlayer( self:GetOwner() )
	undo.Finish()

	timer.Simple(20, function() if (ent:IsValid()) then ent:Remove() end end)
end

function SWEP:Fly()
	self:GetOwner():SetVelocity( Vector(0,0,fly_power) )
	util.ScreenShake(self:GetOwner():GetPos(), 7, 3, 1, 1500)
	if self:GetOwner():KeyDown(IN_FORWARD) then
		self:GetOwner():SetVelocity((self:GetOwner():GetEyeTrace().Normal*fly_power*1.55)+Vector(0,0,fly_power))
	end
	if self:GetOwner():KeyDown(IN_BACK) then
		self:GetOwner():SetVelocity(-((self:GetOwner():GetEyeTrace().Normal*fly_power*1.15)-Vector(0,0,fly_power)))
	end
end

function SWEP:PerformChaos()
	local aim_trace = self:GetOwner():GetEyeTrace()
	self:GetOwner():EmitSound(timestop_sound, 100)
	--for i=0, 5, 1 do
		--timer.Simple(i/2, function()
			for i=0, 3, 1 do
				self:ThrowObjects(table.Random(model_list))
			end
		--end)
	--end
end

function SWEP:Initialize()
		

		max_hp_reached = false
		max_armor_reached = false

		if ( SERVER ) then 
			

			-- Calculate Sky Height
			local sky_trace = util.TraceLine({start=self:GetOwner():GetPos(), endpos=self:GetOwner():GetPos()+Vector(0,0,99999),
				collisiongroup=COLLISION_GROUP_WORLD})
			sky_height = math.abs((sky_trace.HitPos - self:GetOwner():GetPos()).z)
			sky_vec_z = sky_trace.HitPos.z

			for i, ply in ipairs( player.GetAll() ) do
				ply:ChatPrint("The Ultimate Lifeform has been chosen." )
				ply:ChatPrint("All creation must bow to his will!")
			end
		end
		--self:GetOwner():SetModel("models/minson97/hitler/hitler.mdl")
		hook.Add("HUDPaint", "boss_hp", function()
			local smooth_hp = self:GetOwner():Health()
			local smooth_armor = self:GetOwner():Armor()
			local smoothy_hp = Lerp(10*FrameTime(), smooth_hp, self:GetOwner():Health())
			local smoothy_armor = Lerp(10*FrameTime(), smooth_armor, self:GetOwner():Armor())
			draw.DrawText( "Ultimate Lifeform " .. self:GetOwner():GetName(),"DarkSoulsFont", ScrW() * 0.15, ScrH() * 0.8 - 30, Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT )
			draw.RoundedBox(25,  ScrW() * 0.15, ScrH() * 0.8, 0.00075*ScrW()*max_hp/5, 15, Color(76,73,68,202)) -- white thingy
			draw.RoundedBox(50,  ScrW() * 0.15 + 2, ScrH() * 0.8 + 2, 0.00075*ScrW()*max_hp/5 - 5, 10, Color(0,0,0, 202)) -- black inline
			draw.RoundedBox(50,  ScrW() * 0.15 + 2, ScrH() * 0.8 + 2, 0.00075*ScrW()*smoothy_hp/5 - 5, 10, Color(90,39,38, 255)) -- hp red
			draw.RoundedBox(50,  ScrW() * 0.15 + 2, ScrH() * 0.8 + 2, 0.00075*ScrW()*smoothy_armor*2 - 5, 10, Color(33,37,82,170)) -- armor blue
			--draw.RoundedBox(25,  ScrW() * 0.15, ScrH() * 0.8 + 12, 0.00075*ScrW()*max_armor*2, 15,Color(76,73,68,202)) -- white thingy
			--draw.RoundedBox(50,  ScrW() * 0.15 + 2, ScrH() * 0.8 + 14, 0.00075*ScrW()*max_armor*2 - 5, 10, Color(0,0,0, 202)) -- black inline
			--draw.RoundedBox(50,  ScrW() * 0.15 + 2, ScrH() * 0.8 + 14, 0.00075*ScrW()*smoothy_armor*2 - 5, 10, Color(33,37,82,255)) -- armor blue
		end)

		-- Extra Sensory Perception
		hook.Add("HUDPaint", "esp", function()
			if (LocalPlayer() != self:GetOwner()) then return end
			for k,v in ipairs(ents.GetAll()) do
				if (v == self:GetOwner() or (not v:IsPlayer() and not v:IsNPC())) then continue end
				local pos = v:GetPos() + Vector(0,0,50)
				pos = pos:ToScreen()
				if (not util.TraceLine({start=self:GetOwner():EyePos(),endpos=v:GetPos()+Vector(0,0,50),
				collisiongroup=COLLISION_GROUP_WORLD}).Hit) then
					surface.SetTextColor(45,19,19,255)
					surface.SetTextPos(pos.x-15, pos.y+15)
					surface.SetFont("DarkSoulsFontSmall")
					if((v:IsPlayer()) and v:GetPos():Distance(self:GetOwner():GetPos()) <= 10000) then 
						surface.DrawText(v:GetName()) 
					else surface.DrawText("???") end
					surface.DrawCircle(pos.x, pos.y, 10, 90, 39, 38, 255)
					surface.SetDrawColor(90,39,38,255)
					surface.DrawRect(pos.x-15, pos.y+25,v:Health()/2,5)
					if(v:IsPlayer()) then
						surface.SetDrawColor(33,37,82,255)
						surface.DrawRect(pos.x-15, pos.y+30,v:Armor()/2,5)
					end
				end
			end
		end)

		-- Hesitation is Defeat
		hook.Add("PlayerDeath", "kars_hesitation", function(ply,inflictor,attacker) 
			if (ply != self:GetOwner()) then ply:StartLoopingSound(hesitation_sound)
			else 
				hook.Add("PlayerDeathThink", "kars_may_not_respawn_yet", function(ply)
					if (ply == self:GetOwner()) then return false else return true end end)
				timer.Simple(4.99, function() hook.Remove("PlayerDeathThink", "kars_may_not_respawn_yet") end)
				local effectData = EffectData()
				effectData:SetScale(9999)
				effectData:SetRadius(9999)
				effectData:SetMagnitude(9999)
				for j=0, 100, 1 do
					timer.Simple(0.035*j, function ()
					util.Effect("HelicopterMegaBomb", effectData)
					util.Effect("Explosion", effectData)
					util.Effect("ThumperDust", effectData)
					util.ScreenShake(ply:GetPos(), 500, 200, 0.5, 99999)
					effectData:SetOrigin(ply:GetPos())
					local trace = util.TraceLine({start=ply:GetPos(),
						endpos=ply:GetPos()+Vector(math.random(-9999,9999),math.random(-9999,9999),math.random(-9999,9999)),
					collisiongroup=COLLISION_GROUP_NONE})
					local lightning_end = trace.HitPos
					if (trace.Hit and trace.Entity != ply and not trace.HitWorld) then 
						trace.Entity:Ignite(3)
						trace.Entity:TakeDamage(500)
					end
					local lightning_bolt = constraint.CreateKeyframeRope( Vector(0,0,0), 15, table.Random(lightning_materials), nil,
						game.GetWorld(), ply:GetPos(), 0, game.GetWorld(), lightning_end, 0)
					timer.Simple(0.005*j, function() lightning_bolt:Remove() end)
					createRandomDebrisProp(ply:GetPos(), Vector(0,0,1), table.Random(flying_debris), 9999)
						end)
				end
			end
		end)

		-- No Fall Damage
		hook.Add( "GetFallDamage", "kars_falldamage", function( ply, speed )
    		if (ply != self:GetOwner()) then return 10 else return 0 end
		end )

		-- Surface Breaking
		hook.Add("OnPlayerHitGround", "kars_breakground", function(ply,inWater,onFloater,speed)
			owner_flying = false
			incoming_not_playing = true
			if (not inWater and not onFloater and SERVER and ply == self:GetOwner()) then 
				if (util.TraceLine({start=ply:GetPos(),
				endpos=ply:GetPos()-Vector(0,0,50),
				collisiongroup=COLLISION_GROUP_WORLD}).HitWorld) then
					createDebris(ply, broken_surface, speed)
				end
			end
		end)

		-- Kars Dodge
		hook.Add("PlayerShouldTakeDamage", "kars_dodging", function(ply, attacker)
			if(ply != self:GetOwner()) then return true end
			if(math.random(1,1000) < 100*dodge_chance) then
				self:ZaWarudoDodge()
				return false
			end
			return true
		end)

		-- Kars is unique
		hook.Add( "PlayerGiveSWEP", "kars_unique", function( ply, class, info )
			if ( class == self.ClassName ) then return false end
		end )

		-- Play Theme
		if ( SERVER ) then 
			for i, ply in ipairs( player.GetAll() ) do
				table.insert(ply_sounds	, ply:StartLoopingSound(avalon_theme))
				table.insert(ply_sounds, ply:StartLoopingSound(kars_laugh))
			end
		return end
		
		-- COOL
		timer.Simple(1, function ()
			local effectData = EffectData()
			effectData:SetOrigin(self:GetOwner():GetPos())
			effectData:SetScale(100)
			util.Effect("HelicopterMegaBomb", effectData)
			--util.Effect("Explosion", effectData)
			util.ScreenShake(self:GetOwner():GetPos(), 25, 10, 5, 10000)
			end)

		self:SetWeaponHoldType("normal") -- Empty hands

		-- Create ConVars
		
		
		hook.Add( "Think", "kars_tick", function()

			-- Za Warudo
			for k,v in ipairs(ents.GetAll()) do
				if(v:IsPlayer() and v != self:GetOwner()) then
					if(v:GetEyeTrace().Entity == self:GetOwner() and (v:KeyDown(IN_ATTACK) or v:KeyDown(IN_ATTACK2))) then
						if(math.random(1,10000) < 100*dodge_chance) then
							doTimeskipDodge(self:GetOwner(), v)
						end
						if(math.random(1,1000) < 100*dodge_chance) then
							self:ZaWarudoDodge()
						end
					end
				elseif(v:IsNPC()) then
				end
			end

			-- Should we init Phase 2?
			if ((max_hp_reached and self:GetOwner():Health() <= max_hp*phase2_hp_percent) and (max_armor_reached and self:GetOwner():Armor() <= 0) and not phase2_reached) then
				if ( SERVER ) then
					sky_height = (util.TraceLine({start=self:GetOwner():GetPos(), endpos=self:GetOwner():GetPos()+Vector(0,0,99999),
						collisiongroup=COLLISION_GROUP_WORLD}).HitPos - self:GetOwner():GetPos()).z
					for i, sound in ipairs( ply_sounds ) do
						self:StopLoopingSound(sound)
					end
					ply_sounds = {}
					timer.Simple(3, function ()
					for i, ply in ipairs(player.GetAll()) do
						table.insert(ply_sounds ,ply:StartLoopingSound(low_hp_theme))
						table.insert(ply_sounds, ply:StartLoopingSound(rumbling_sound))
						ply:UnfreezePhysicsObjects()
					end 
					constraint.RemoveAll(game.GetWorld())
					for i, ent in ipairs( ents.GetAll() ) do
						constraint.RemoveAll(ent)
					end
						end)
				end
				timer.Simple(1, function ()
					local effectData = EffectData()
					effectData:SetOrigin(self:GetOwner():GetPos())
					effectData:SetScale(100)
					effectData:SetRadius(1023)
					for i=0, 15, 1 do
						util.Effect("HelicopterMegaBomb", effectData)
						util.Effect("Explosion", effectData)
					end
					util.ScreenShake(self:GetOwner():GetPos(), 50, 20, 7, 10000)
				end)
				timer.Simple(3, function ()
					for i, ply in ipairs( player.GetAll() ) do
						ply:EmitSound(ac130above_sound, 75)
					end
				end)
				phase2_reached = true
				dodge_chance = 0.25
			end

			-- Glide action calculation
			if ((math.abs(self:GetOwner():GetVelocity().y) > glide_speed or math.abs(self:GetOwner():GetVelocity().x) > glide_speed)) then
				if (glide_sound_id == nil and CLIENT) then glide_sound_id = self:StartLoopingSound(glide_sound) end
					if(not self:GetOwner():KeyDown(IN_DUCK) and self:GetOwner():GetVelocity().z <= 10)
						then self:GetOwner():SetVelocity(Vector(0,0,fly_power/55)) end
			elseif (glide_sound_id != nil and CLIENT) then 
				self:StopLoopingSound(glide_sound_id)
				glide_sound_id = nil
			end


			-- Cool sound for landing when speedy
			if (self:GetOwner():GetVelocity():Dot(Vector(0,0,-1))>supersonic_speed and SERVER) then
				util.TraceLine({start=self:GetOwner():GetPos(),
						endpos=self:GetOwner():GetPos()-Vector(0,0,100+self:GetOwner():GetVelocity():Dot(Vector(0,0,-1))),
						collisiongroup=COLLISION_GROUP_WORLD,
						output=ply_trace})
				if (ply_trace.HitWorld and incoming_not_playing) then 
					self:StartLoopingSound(shell_incoming)
					incoming_not_playing = false
				end
			end

			-- Pickup players and stuff with E
			if (self:GetOwner():KeyDown(IN_USE)) then
				local ent = self:GetOwner():GetEyeTrace().Entity
				if (self:GetOwner():EyePos():DistToSqr(ent:GetPos()) <= 250000) then
					for x=0, 100, 1 do
						timer.Simple(x*0.01, function()
							ent:SetPos(self:GetOwner():EyePos() 
							+ self:GetOwner():EyeAngles():Forward()*120
							+ self:GetOwner():GetVelocity()/20)
						end)
						if(self:GetOwner():KeyReleased(IN_USE)) then break end
					end
				end
			end

			-- Supersonic speed
			if (self:GetOwner():GetVelocity():Dot(Vector(0,0,-1))>5000 and SERVER) then
				self:GetOwner():Ignite(0.01)
			end

			-- Phased Armor regen
			if(max_armor_reached) then timed_armor = timed_armor + 1 end
			if ((0 < self:GetOwner():Armor() and self:GetOwner():Armor() < max_armor) or (0 >= self:GetOwner():Armor() and not max_armor_reached)) then
				if timed_armor % max_timed_armor == 0 then
					if ( SERVER ) then self:GetOwner():SetArmor(self:GetOwner():Armor() + 1) end
				end
			else max_armor_reached = true end

			-- Manual Phase 2
			if(self:GetOwner():KeyDown(IN_WALK) and self:GetOwner():KeyDown(IN_RELOAD) and self:GetOwner():KeyDown(IN_ATTACK2) 
				and not phase2_reached and self:GetOwner():Health() > max_hp*phase2_hp_percent and SERVER) then 
				self:GetOwner():SetHealth(max_hp*phase2_hp_percent)
				self:GetOwner():SetArmor(0)
			end

			-- Initial Health regen
			if(self:GetOwner():Health() < max_hp and not max_hp_reached) then 
				if ( SERVER ) then self:GetOwner():SetHealth(self:GetOwner():Health() + 10) end
			else max_hp_reached = true end

			-- Counter resets to avoid overflow
			if timed_fly >= max_timed_fly then timed_fly = 0 end
			if timed_armor >= max_timed_armor then timed_armor = 0 end
			if timed_chaos >= max_timed_chaos then timed_chaos = 0 end
			if self:GetOwner():Health() > max_hp then self:GetOwner():SetHealth(max_hp) end
			if self:GetOwner():Armor() > max_armor then self:GetOwner():SetArmor(max_armor) end

			timed_chaos = timed_chaos + 1
			-- Phase 2 calculations
			if (phase2_reached and (timed_chaos % 21 == 0)) then 
				timer.Simple(0.01*math.random(1,100), function() self:propRain_explosive() end)
			end
			if ( phase2_reached and (timed_chaos % max_timed_chaos == 0) and SERVER) then
				physenv.SetGravity(Vector(math.random(-100,100),math.random(-100,100),math.random(-200,100)))
				for i, ent in ipairs( ents.GetAll() ) do
					if (ent:IsPlayer()) then table.insert(ply_sounds, ent:StartLoopingSound(table.Random(thunders))) end
					if (ent:IsPlayer() or ent:IsNPC() and (ent == self:GetOwner() or math.random(1,100)>97)) then for x = 0, 15, 1 do
						timer.Simple(0.1*x, function() 
							self:propRain(ent) 
							timer.Simple(0.1*math.random(0,5), function() self:randomLightning() end)
						end)
					end end
					if (ent != self:GetOwner() and (ent:IsPlayer() or ent:IsNPC()) and (math.random(1,100)>97)) then
						if (ent:GetVelocity().z == 0) then ent:SetPos(ent:GetPos()+Vector(0,0,1)) end
						if (math.random(0,100) < 5) then 
							ent:SetGravity(-physenv.GetGravity().z/2000)
							ent:SetVelocity(physenv:GetGravity()/1000)
						else ent:SetGravity(0.75) end
						for x = 0, 3, 1 do
							timer.Simple(x + 1.1, function()
								local plypos = Vector(ent:GetPos().x + math.random(-2*ac130_radius, 2*ac130_radius),
										ent:GetPos().y + math.random(-2*ac130_radius, 2*ac130_radius),ent:GetPos().z)
								local random_trace = {start=plypos+Vector(0,0,10),
									endpos=plypos-Vector(0,0,1000), collisiongroup=COLLISION_GROUP_WORLD}
								local world_trace = util.TraceLine(random_trace)
								if (world_trace.HitWorld and math.random(0,1)>=0.85 and
								not util.TraceLine({start=ent:GetPos(), endpos=ent:GetPos()+Vector(0,0,sky_height*0.95),
						collisiongroup=COLLISION_GROUP_WORLD}).Hit and 
								not util.TraceLine({start=world_trace.HitPos, endpos=Vector(0,0,sky_height*0.95) + world_trace.HitPos,
						collisiongroup=COLLISION_GROUP_WORLD}).Hit and math.random(1,100)>97) then
										skyLaser(world_trace.HitPos)
										fixedSoundEmit(world_trace.HitPos,nuclear_sound)
										timer.Simple(0.75, function()
											self:AC130(world_trace)
											self:A10(world_trace)
										end)
								end
							end)
						end
						timer.Simple(7, function() 
							constraint.RemoveConstraints(game.GetWorld(), "Rope")
						end)
					end
				end
			end
			-- Fly/Jump calculations
			if (self:GetOwner():KeyDown(IN_JUMP)) then
				-- Wings flying calculations
				if (owner_flying) then
					timed_fly = timed_fly + 1
					if (timed_fly % max_timed_fly == 0) then 
						if SERVER then 
							self:Fly()
							sound.Play(table.Random(flapp_table), self:GetOwner():GetPos(), 100,  math.random( 100 - 10, 100 + 10 ), math.Clamp( 300 / 150, 0, 1 ))
							end
						end
				-- Jump with time-based power calculations
				else
					if timed_jump_power == 0 then timed_jump_power = 300
					elseif timed_jump_power < max_jump_power then timed_jump_power = timed_jump_power + 20 end
					if timed_jump_power >= max_jump_power*0.75 then 
						util.ScreenShake(self:GetPos(), timed_jump_power*0.0007, timed_jump_power*0.0007, timed_jump_power*0.0007, 1000)
					end
				end

			-- If jumpkey is released then perform jump
			elseif (self:GetOwner():KeyReleased(IN_JUMP)) then
				if(not owner_flying) then 
					self:GetOwner():SetVelocity(Vector(0,0,timed_jump_power))
					if (timed_jump_power >= max_jump_power/2) then self:StartLoopingSound(strongjump_sound) end
					timed_jump_power = 0
					owner_flying = true
				end
			end
		end)
	end

function SWEP:Deploy()

			-- ULTIMATE LIFEFORM POWA
			self:GetOwner():SetRunSpeed(glide_speed-50)
			self:GetOwner():SetHealth(1)
			self:GetOwner():SetArmor(1)
			self:GetOwner():SetJumpPower(0)
			self:GetOwner():SetAllowFullRotation(false)
			self:GetOwner():SetDuckSpeed(0)
			self:GetOwner():SetCrouchedWalkSpeed(1)
			self:GetOwner():SetWalkSpeed(glide_speed-200)
		
	end


function SWEP:OnRemove()

	print("THE ULTIMATE LIFEFORM HAS BEEN ELIMINATED.")
	if ( SERVER ) then

		timer.Simple(5, function() constraint.RemoveConstraints(self:GetOwner(), "Rope") end)
		-- Global death
		for i, ply in ipairs( player.GetAll() ) do
			ply:Say("HOW? WTF? NANI???")
		end

		timer.Simple(3, function ()
			physenv.SetGravity(Vector(0,0,-600))
			for i, ent in ipairs( ents.GetAll() ) do
				if (ent != self:GetOwner() and (ent:IsPlayer() or ent:IsNPC())) then
					ent:SetGravity(1)
				end
			end
			end)
	end

	-- Reset global variables --
	timed_armor 		= 0
	timed_fly 			= 0
	timed_jump_power	= 0
	timed_chaos 		= 0
	firemode 			= 0
	phase2_reached		= false
	
	-- Remove all hooks --
	hook.Remove("HUDPaint", "boss_hp")
	hook.Remove("HUDPaint", "esp")
	hook.Remove("OnPlayerHitGround", "kars_breakground")
	hook.Remove("GetFallDamage", "kars_falldamage")
	hook.Remove("PlayerShouldTakeDamage", "kars_dodging")
	hook.Remove("PlayerGiveSWEP", "kars_unique")
	hook.Remove("Think", "kars_tick")
	timer.Simple(5, function() hook.Remove("PlayerDeath", "kars_hesitation") end)
	--hook.Remove("PlayerFootstep", "kars_footsteps")
	--hook.Remove("PlayerShouldTakeDamage", "kars_firedamage")
	--hook.Remove("OnPlayerHitGround", "JumpTimer")

	-- Stop all sounds --
	if ( SERVER ) then 
		for i, sound in ipairs( ply_sounds ) do
			self:StopLoopingSound(sound)
		end
		return
	end
	if (glide_sound_id != nil) then self:StopLoopingSound(glide_sound_id) end

	-- Reset client global variables
	glide_sound_id 		= nil
	kars_theme_id 		= nil
	kars_laugh_id		= nil

	-- Remove Kars Ent
	local kars_death_id = self:StartLoopingSound(kars_death)
end

function SWEP:propRain(ent)
	if (sky_height < 1000) then return end
	--if (util.TraceLine({start=self:GetOwner():GetPos(), endpos=self:GetOwner():GetPos() + Vector(0,0,sky_height*0.05),collisiongroup=COLLISION_GROUP_WORLD}).Hit) then return end
	local sky_rand_pos = Vector(self:GetOwner():GetPos().x+math.random(-3000,3000),
		self:GetOwner():GetPos().y+math.random(-3000,3000),math.random(sky_vec_z*0.89,sky_vec_z*0.97))
	if (not util.IsInWorld(sky_rand_pos)) then return end
	local prop = ents.Create( "prop_physics" )
	if (not prop:IsValid()) then return end
	prop:SetPos(sky_rand_pos)
	prop:SetModel(table.Random(model_list))
	prop:Spawn()
	if (math.random(0,1)>=0.5) then prop:Ignite(20) end
	timer.Simple(30, function() 
		if (prop:IsValid()) then prop:Remove() end
	end)
	prop:GetPhysicsObject():ApplyForceCenter(Vector(math.random(-1,1),math.random(-1,1),math.random(-100,0))*math.random(100,9999))
	prop:GetPhysicsObject():EnableDrag( false)
	if (ent != self:GetOwner() and math.random(1, 1000) < 250) then 
		prop:GetPhysicsObject():ApplyForceCenter(9999*(ent:GetPos()-prop:GetPos()))
		prop:GetPhysicsObject():EnableGravity(false)
	end
end

function SWEP:propRain_explosive()
	if (sky_height < 1000) then return end
	--if (util.TraceLine({start=self:GetOwner():GetPos(), endpos=self:GetOwner():GetPos() + Vector(0,0,sky_height*0.05),collisiongroup=COLLISION_GROUP_WORLD}).Hit) then return end
	local sky_rand_pos = Vector(self:GetOwner():GetPos().x+math.random(-3000,3000),
		self:GetOwner():GetPos().y+math.random(-3000,3000),math.random(sky_vec_z*0.91,sky_vec_z*0.97))
	if (not util.IsInWorld(sky_rand_pos)) then return end
	local prop = ents.Create( "prop_physics" )
	if (not prop:IsValid()) then return end
	prop:SetPos(sky_rand_pos)
	prop:SetModel("models/props_c17/oildrum001_explosive.mdl")
	prop:Spawn()
	prop:Ignite(99)
	timer.Simple(7, function() 
		if (prop:IsValid()) then prop:Remove() end
	end)
	prop:GetPhysicsObject():ApplyForceCenter(Vector(math.random(-1,1),math.random(-1,1),math.random(-100,0))*math.random(10,999))
	prop:GetPhysicsObject():EnableDrag(false)
	prop:GetPhysicsObject():EnableGravity(false)
end

function createDummyEnt(pos)
	local ent = ents.Create( "prop_physics" )
	if (not ent:IsValid()) then return end
	ent:SetPos(pos)
	ent:SetModel("models/Items/AR2_Grenade.mdl")
	ent:SetColor(Color(255,255,255,0))
	ent:Spawn()
	ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	ent:GetPhysicsObject():EnableMotion(false)
	return ent
end

function SWEP:LaserEyes()
	local look_direction = self:GetOwner():GetEyeTrace().HitPos - self:GetOwner():GetEyeTrace().StartPos
	local right_eye_pos = self:GetOwner():EyePos() + 2.25*Vector(0,0,1):Cross(look_direction):GetNormalized() + 7*self:GetOwner():EyeAngles():Forward()
	local left_eye_pos = self:GetOwner():EyePos() - 2.25*Vector(0,0,1):Cross(look_direction):GetNormalized() + 7*self:GetOwner():EyeAngles():Forward()
	local right_eye = constraint.CreateKeyframeRope( Vector(0,0,0), 5, skylaser_material, nil,
		game.GetWorld(), right_eye_pos, 0, game.GetWorld(), self:GetOwner():GetEyeTrace().HitPos, 0)
	local left_eye = constraint.CreateKeyframeRope( Vector(0,0,0), 5, skylaser_material, nil,
		game.GetWorld(), left_eye_pos, 0, game.GetWorld(), self:GetOwner():GetEyeTrace().HitPos, 0)
	timer.Simple(0.2, function() 
		if (right_eye:IsValid()) then right_eye:Remove() end
		if (right_eye:IsValid()) then left_eye:Remove() end
	end)
	util.Decal(laser_decal, self:GetOwner():GetEyeTrace().HitPos - self:GetOwner():EyeAngles():Forward()
			,self:GetOwner():GetEyeTrace().HitPos + self:GetOwner():EyeAngles():Forward())
	self:GetOwner():GetEyeTrace().Entity:Ignite(1)
	self:GetOwner():GetEyeTrace().Entity:TakeDamage(1, self:GetOwner(), self)
	fixedSoundEmit(self:GetOwner():GetPos(), laser_fire_sound)
	fixedSoundEmit(self:GetOwner():GetEyeTrace().HitPos, laser_hit_sound)
end

function SWEP:PrimaryAttack()
	if ( CLIENT ) then return end
	self:SetNextPrimaryFire(CurTime())
	self:SetNextSecondaryFire(CurTime() + 0.5)
	self:LaserEyes()
end
 
function SWEP:AdjustMouseSensitivity()
	if (self:GetOwner():KeyDown(IN_ATTACK)) then return 0.15 else return 1 end
end

function SWEP:SecondaryAttack()
	if ( CLIENT ) then return end
	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:SetNextSecondaryFire(CurTime() + 0.25)
	self:PerformChaos()
end
