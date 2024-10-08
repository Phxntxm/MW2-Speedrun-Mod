// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_enemy_airborne_RPG (1.0 0.25 0.0) (-16 -16 0) (16 16 72) SPAWNER FORCESPAWN UNDELETABLE PERFECTENEMYINFO DONTSHAREENEMYINFO
defaultmdl="body_airborne_lmg"
"count" -- max AI to ever spawn from this spawner
SPAWNER -- makes this a spawner instead of a guy
FORCESPAWN -- will try to delete an AI if spawning fails from too many AI
UNDELETABLE -- this AI (or AI spawned from here) cannot be deleted to make room for FORCESPAWN guys
PERFECTENEMYINFO -- this AI when spawned will get a snapshot of perfect info about all enemies
DONTSHAREENEMYINFO -- do not get shared info about enemies at spawn time from teammates
*/
main()
{
	self.animTree = "";
	self.additionalAssets = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.0;
	self.health = 75;
	self.secondaryweapon = "ak47_reflex";
	self.sidearm = "pp2000";
	self.grenadeWeapon = "fraggrenade";
	self.grenadeAmmo = 0;

	if ( isAI( self ) )
	{
		self setEngagementMinDist( 768.000000, 512.000000 );
		self setEngagementMaxDist( 1024.000000, 1500.000000 );
	}

	self.weapon = "rpg";

	switch( codescripts\character::get_random_character(3) )
	{
	case 0:
		character\character_airborne_lmg::main();
		break;
	case 1:
		character\character_airborne_lmg_b::main();
		break;
	case 2:
		character\character_airborne_lmg_c::main();
		break;
	}
}

spawner()
{
	self setspawnerteam("axis");
}

precache()
{
	character\character_airborne_lmg::precache();
	character\character_airborne_lmg_b::precache();
	character\character_airborne_lmg_c::precache();

	precacheItem("rpg");
	precacheItem("ak47_reflex");
	precacheItem("pp2000");
	precacheItem("fraggrenade");
}
