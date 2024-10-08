#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;

main()
{
	generic_human();
	vehicles();
	script_model();
	dialog();
}

#using_animtree( "generic_human" );
generic_human()
{
	level.scr_anim[ "zpu_gunner" ][ "fire_a" ]					 = %zpu_gunner_fire_a;
	level.scr_anim[ "zpu_gunner" ][ "fire_b" ]					 = %zpu_gunner_fire_b;
	level.scr_anim[ "zpu_gunner" ][ "gunnerdeath" ]				 = %zpu_gunner_deathslouch;
	level.scr_anim[ "zpu_gunner" ][ "death_idle" ][ 0 ]			 = %zpu_gunner_deathslouchidle;
	level.scr_anim[ "zpu_gunner" ][ "dismount" ]				 = %zpu_gunner_dismount;
	
	level.scr_anim[ "fridge_guy" ][ "fridge_idle" ][ 0 ]		 = %arcadia_fridge_idle;
	level.scr_anim[ "fridge_guy" ][ "fridge_react" ]			 = %arcadia_fridge_react;
	
	level.scr_anim[ "panicroom_enemy" ][ "ending_pose" ]		 = %arcadia_ending_sceneA_enemy2_death_pose;
	level.scr_anim[ "panicroom_hvi" ][ "ending_pose" ]			 = %arcadia_ending_sceneA_dead_civilian;
	
	level.scr_anim[ "dunn" ][ "ending" ]						 = %arcadia_ending_sceneB_guy2;
	addNotetrack_dialogue( "dunn", "dialog", "ending", "arcadia_cpd_checkouttats" );
	addNotetrack_attach( "dunn", "attach_camera", "electronics_camera_pointandshoot_animated", "tag_inhand", "ending" );
	addNotetrack_detach( "dunn", "detach_camera", "electronics_camera_pointandshoot_animated", "tag_inhand", "ending" );
	addOnStart_animSound( "dunn", "ending", "scn_arcadia_photographer" );
	addNotetrack_animSound( "dunn", "ending", "camera_shutter", "scn_arcadia_photo_snap" );
	
	level.scr_anim[ "generic" ][ "patrol_walk" ]				  	= %patrol_bored_patrolwalk;
	level.scr_anim[ "generic" ][ "patrol_walk_twitch" ]				= %patrol_bored_patrolwalk_twitch;
	level.scr_anim[ "generic" ][ "patrol_stop" ]				  	= %patrol_bored_walk_2_bored;
	level.scr_anim[ "generic" ][ "patrol_start" ]				  	= %patrol_bored_2_walk;
	level.scr_anim[ "generic" ][ "patrol_turn180" ]				 	= %patrol_bored_2_walk_180turn;
	
	level.scr_face[ "foley" ][ "arcadia_fly_nosign" ]				= %arcadia_fly_nosign;
	level.scr_face[ "foley" ][ "arcadia_fly_getthatbriefcase" ]		= %arcadia_fly_getthatbriefcase;
	level.scr_face[ "foley" ][ "arcadia_fly_photosforg2" ]			= %arcadia_fly_photosforg2;
	level.scr_face[ "foley" ][ "arcadia_fly_notgoingtolike" ]		= %arcadia_fly_notgoingtolike;
	level.scr_face[ "foley" ][ "arcadia_fly_overlordhvi" ]			= %arcadia_fly_overlordhvi;
}

#using_animtree( "vehicles" );
vehicles()
{
	level.scr_animtree[ "zpu_turret" ]							 = #animtree;
	level.scr_model[ "zpu_turret" ]							 	 = "vehicle_zpu4";
	level.scr_anim[ "zpu_turret" ][ "fire_a" ]					 = %zpu_gun_fire_a;
	level.scr_anim[ "zpu_turret" ][ "fire_b" ]					 = %zpu_gun_fire_b;
	level.scr_anim[ "zpu_turret" ][ "idle" ]					 = %zpu_gun_stop;
	
	addNotetrack_customFunction( "zpu_turret", "fire_1", maps\arcadia_code::zpu_shoot1 );
	addNotetrack_customFunction( "zpu_turret", "fire_2", maps\arcadia_code::zpu_shoot2 );
}

#using_animtree( "script_model" );
script_model()
{
	level.scr_animtree[ "distant_parachute_left" ]				 = #animtree;
	level.scr_model[ "distant_parachute_left" ]				 	 = "parachute_deploy";
	level.scr_anim[ "distant_parachute_left" ][ "drop1" ]		 = %paratrooper_jump_leftA_chute;
	level.scr_anim[ "distant_parachute_left" ][ "drop2" ]		 = %paratrooper_jump_leftB_chute;
	
	level.scr_animtree[ "distant_parachute_right" ]				 = #animtree;
	level.scr_model[ "distant_parachute_right" ]				 = "parachute_deploy";
	level.scr_anim[ "distant_parachute_right" ][ "drop1" ]		 = %paratrooper_jump_RightA_chute;
	level.scr_anim[ "distant_parachute_right" ][ "drop2" ]		 = %paratrooper_jump_RightB_chute;	
	
	level.scr_animtree[ "distant_parachute_left_guy" ]			 = #animtree;
	level.scr_animtree[ "distant_parachute_right_guy" ]			 = #animtree;
	level.scr_anim[ "distant_parachute_left_guy" ][ "drop1" ] 	 = %paratrooper_jump_leftA_guy;
	level.scr_anim[ "distant_parachute_left_guy" ][ "drop2" ] 	 = %paratrooper_jump_leftB_guy;
	level.scr_anim[ "distant_parachute_right_guy" ][ "drop1" ] 	 = %paratrooper_jump_RightA_guy;
	level.scr_anim[ "distant_parachute_right_guy" ][ "drop2" ] 	 = %paratrooper_jump_RightB_guy;
	
	level.scr_animtree[ "fridge" ]								 = #animtree;
	level.scr_anim[ "fridge" ][ "fridge_idle" ][ 0 ]			 = %arcadia_fridge_idle_fridgerig;
	level.scr_anim[ "fridge" ][ "fridge_react" ]				 = %arcadia_fridge_react_fridgerig;
}

dialog()
{	
	//-----------------------------------------
	// Opening mission dialog
	//-----------------------------------------
	
	// Hunter Two-One, this is Hunter Two-One Actual. Our evac choppers are taking heavy losses from ground fire!

	
	// We gotta destroy those triple-A positions so they can get the rest of the civvies outta here! Let's go!

	
	//-----------------------------------------
	// After checkpoint - mission dialog
	//-----------------------------------------
	
	// Hunter Two-One-Actual, Overlord. Gimme a sitrep over.

	
	// We're just past the enemy blockade at Checkpoint Lima. Now proceeding into Arcadia, over.

	
	// Roger that. I have new orders for you. This comes down from the top, over.

	
	// Solid copy Overlord, send it.

	
	// Your team is to divert to 4677 Brookmere Road after you have eliminated the triple-A.

	
	// Solid copy Overlord. Divert to 4677 Brookmere Road once the guns are destroyed. Got it.

	
	// Check back with me when you've completed your main objective. Overlord out.

	
	// Look look! That's an AC-130 man.

	
	// That's why they don't fly during the day soldier.

	
	// Damn?sucks to be them?

	
	// Huah.

	
	//-----------------------------------------
	// Player designates a valid stryker target
	//-----------------------------------------
	
	// Roger, we have a lock. Engaging target.

	
	// Badger One copies, engaging your target.

	
	// Roger, attacking your target.
	level.scr_radio[ "arcadia_str_attacking" ] 					 = "arcadia_str_attacking";
	
	// Solid copy. Engaging target.
	level.scr_radio[ "arcadia_str_solidcopyeng" ] 				 = "arcadia_str_solidcopyeng";
	
	// Roger, we have a lock. Engaging house.
	level.scr_radio[ "arcadia_str_havealock" ] 					 = "arcadia_str_havealock";
	
	// Badger One copies, engaging house.
	level.scr_radio[ "arcadia_str_badgeronecopies" ] 			 = "arcadia_str_badgeronecopies";
	
	// Roger, attacking vehicle.
	level.scr_radio[ "arcadia_str_attackingvehicle" ] 			 = "arcadia_str_attackingvehicle";
	
	// Roger. Engaging enemy chopper
	level.scr_radio[ "arcadia_str_engchopper" ] 				 = "arcadia_str_engchopper";
	
	// Solid copy. Engaging infantry.
	level.scr_radio[ "arcadia_str_engaginginfantry" ] 			 = "arcadia_str_engaginginfantry";
	
	// Solid copy. Engaging vehicle.
	level.scr_radio[ "arcadia_str_engagingvehicle" ] 			 = "arcadia_str_engagingvehicle";
	
	// Badger One copies, engaging enemies at apartment office.
	level.scr_radio[ "arcadia_str_apartmentoffice" ] 			 = "arcadia_str_apartmentoffice";
	
	// Roger, attacking targets at security station.
	level.scr_radio[ "arcadia_str_securitystation" ] 			 = "arcadia_str_securitystation";
	
	// Confirmed, engaging enemies at checkpoint.
	level.scr_radio[ "arcadia_str_checkpoint" ] 				 = "arcadia_str_checkpoint";
	
	// Badger One engaging enemies at the yellow house
	level.scr_radio[ "arcadia_str_engyellowhouse" ] 			 = "arcadia_str_engyellowhouse";
	
	// Copy. Targeting enemies at the grey house
	level.scr_radio[ "arcadia_str_targgreyhouse" ] 				 = "arcadia_str_targgreyhouse";
	
	// Roger, engaging targets near the fire truck
	level.scr_radio[ "arcadia_str_engfiretruck" ] 				 = "arcadia_str_engfiretruck";
	
	// Confirmed, suppressing enemies near the police car
	level.scr_radio[ "arcadia_str_confpolicecar" ] 				 = "arcadia_str_confpolicecar";
	
	//-----------------------------------------
	// Stryker finished firing at target area
	//-----------------------------------------
	
	// Badger One to Hunter Two, target destroyed.

	
	// Badger One to Hunter Two, area suppressed.

	
	// Badger One to Hunter Two, target area suppressed.

	
	//-----------------------------------------
	// Player designates an invalid target or out of range
	//-----------------------------------------
	
	// Uh, negative, that target is out of range, over.
	level.scr_radio[ "arcadia_str_uhnegative" ] 				 = "arcadia_str_uhnegative";
	
	// Negative, that's an invalid target over.
	level.scr_radio[ "arcadia_str_invalidtarget" ] 				 = "arcadia_str_invalidtarget";
	
	// Negative, that target's outta range!
	level.scr_radio[ "arcadia_str_outtarange" ] 				 = "arcadia_str_outtarange";
	
	// Target is out of range.
	level.scr_radio[ "arcadia_str_outofrange" ] 				 = "arcadia_str_outofrange";
	
	//-----------------------------------------
	// Stryker is about to advance
	//-----------------------------------------
	
	// Stand clear, we're rollin'.

	
	// Be advised, we're movin' up. Stand clear.

	
	// All ground units, stand clear. Badger One is oscar mike.

	
	//-----------------------------------------
	// Stryker is staying put
	//-----------------------------------------
	
	// Badger One holding position.

	
	//-----------------------------------------
	// Calling out enemies in the houses
	//-----------------------------------------
	
	// We got hostiles in the yellow house!

	
	// Enemies in the grey house!!!

	
	// Squad, we got hostiles that grey house! Take 'em out!!

	
	// Squad, put suppressing fire on that house!!

	
	// Squad, concentrate your fire on that house!!

	
	// Enemy foot-mobiles by the apartments!

	
	// Roger that, enemy foot-mobiles by the apartments, take 'em ouuut!!

	
	//-----------------------------------------
	// Remind player to use laser designator
	//-----------------------------------------
	
	// Use your designator! Lase targets for the Stryker!

	
	// Squad, use your laser designators! Paint targets for the Stryker!

	
	// All Hunter units, this is Badger One. Lase the target, over.

	
	// All Hunter units, this is Badger One. Standing by to engage your targets, over.
	level.scr_radio[ "arcadia_str_standingby" ] 				 = "arcadia_str_standingby";
	
	// All Hunter teams, this is Badger One. Paint the target, over.
	level.scr_radio[ "arcadia_str_painttarget" ] 				 = "arcadia_str_painttarget";
	
	//-----------------------------------------
	// Player eliminated RPG threats
	//-----------------------------------------
	
	// Thanks for the assist, Hunter Two-One.
	level.scr_radio[ "arcadia_str_thanks" ] 					 = "arcadia_str_thanks";
	
	// Nice work, Hunter Two-One. Thanks for the assist.
	level.scr_radio[ "arcadia_str_nicework" ] 					 = "arcadia_str_nicework";
	
	//-----------------------------------------
	// Friendlies move up
	//-----------------------------------------
	
	// Everyone move up!

	
	// Move up!

	
	// Move up!!!

	
	// Let's go, let's go!!

	
	//-----------------------------------------
	// Stryker dies
	//-----------------------------------------
	
	// All Hunter units, be advised, we just lost Badger One. Stryker support is unavailable, I repeat, Stryker support is unavailable. Make do with what you got. Out.
	level.scr_sound[ "foley" ][ "arcadia_fly_lostbadgerone" ]	= "arcadia_fly_lostbadgerone";
	
	//-----------------------------------------
	// Use houses for cover, get off streets
	//-----------------------------------------
	
	// Get off the streets, use the houses for cover!!

	
	// Flank 'em through the houses!! Go go go!!

	
	// Squad, move up through these houses, let's go, let's go!!

	
	// Get off the streets!!

	
	// Get outta the street!!

	
	//-----------------------------------------
	// Sentry gun shoutouts
	//-----------------------------------------
	
	// Squad, take out the sentry guns!

	
	// Take out that sentry gun!

	
	//-----------------------------------------
	// Stryker warns about RPGs
	//-----------------------------------------
	
	// Hunter Two-One Actual, this is Badger One! Our anti-missile system cannot handle the volume of RPG fire, we need your team to thin 'em out, how copy, over?

	
	// Solid copy Badger One, we're on it! Out!

	
	// Squad! Protect the Stryker! Watch for foot-mobiles with RPGs!

	
	// Squad! They're targeting the Stryker! Watch for RPGs!

	
	//-----------------------------------------
	// Golf course vehicle laser designation
	//-----------------------------------------
	
	// Ramirez, use your laser designator to call in artillery on those vehicles!
	level.scr_sound[ "foley" ][ "arcadia_fly_laserdes" ]		= "arcadia_fly_laserdes";
	
	// Ramirez, call artrillery on the enemy vehicles! Use your laser designator!
	level.scr_sound[ "foley" ][ "arcadia_fly_callartillery" ]	= "arcadia_fly_callartillery";
	
	// Ramirez, use the designator on the vehicles on the golf course!
	//level.scr_sound[ "foley" ][ "arcadia_fly_golfcourse" ]		= "arcadia_fly_golfcourse";
	
	// Nice work Ramirez, one more to go.
	//level.scr_sound[ "foley" ][ "arcadia_fly_onemoretogo" ]		= "arcadia_fly_onemoretogo";
	
	// Fire mission received, artillery inbound.
	level.scr_radio[ "arcadia_art_missionrec" ] 				= "arcadia_art_missionrec";
	
	// Coordinates confirmed. Firing!
	level.scr_radio[ "arcadia_art_confirmed" ] 					= "arcadia_art_confirmed";
	
	//-----------------------------------------
	// Stryker about to run over player
	//-----------------------------------------
	
	// Ramirez! You're gonna get run over! Get outta their way!
	level.scr_sound[ "foley" ][ "arcadia_fly_getrunover" ]		= "arcadia_fly_getrunover";
	
	// Ramirez! Honey Badger's moving! Get outta their way!
	level.scr_sound[ "dunn" ][ "arcadia_cpd_getoutta" ]			= "arcadia_cpd_getoutta";
	
	//-----------------------------------------
	// After AA neutralized - mission dialog
	//-----------------------------------------
	
	// Overlord, Hunter Two-One-Actual. Triple-A has been neutralized. We're heading to 4677 Brookmere Road, over.

	
	// Interrogative - what exactly are we looking for, over?

	
	// Sergeant Foley, this is General Shepherd.

	
	// Your objective is to extract a high value individual from a 'panic room' on the second floor of that house.
	level.scr_radio[ "arcadia_shp_panicroom" ] 					= "arcadia_shp_panicroom";
	
	// Yes sir!
	level.scr_sound[ "foley" ][ "arcadia_fly_yessir" ]			= "arcadia_fly_yessir";
	
	// He'll be expecting you. Challenge is "Icepick", countersign is "Phoenix".
	level.scr_radio[ "arcadia_shp_phoenix" ] 					= "arcadia_shp_phoenix";
	
	// Get him outta there and report back to Overlord. Shepherd out.
	level.scr_radio[ "arcadia_shp_reportback" ] 				= "arcadia_shp_reportback";
	
	// All right, you heard the man - 4677 Brookmere Road. Move!
	level.scr_sound[ "foley" ][ "arcadia_fly_heardtheman" ]		= "arcadia_fly_heardtheman";
	
	//-----------------------------------------
	// Ending mission dialog
	//-----------------------------------------
	
	// Icepick.

	
	// Icepick!

	
	// Something's not right here?Check the panic room - move!
	level.scr_sound[ "foley" ][ "arcadia_fly_notright" ]		= "arcadia_fly_notright";
	
	// Hmph. No sign of forced entry?
	level.scr_sound[ "foley" ][ "arcadia_fly_nosign" ]			= "arcadia_fly_nosign";
	
	// Ramirez, get that briefcase...what's left of it.
	level.scr_sound[ "foley" ][ "arcadia_fly_getthatbriefcase" ]= "arcadia_fly_getthatbriefcase";
	
	// Sarge, check out these tats. Not your average paratrooper, huah?
	level.scr_sound[ "dunn" ][ "arcadia_cpd_checkouttats" ]		= "arcadia_cpd_checkouttats";
	
	// Huah. Get a couple photos for G-2 and check the bodies for intel.
	level.scr_sound[ "foley" ][ "arcadia_fly_photosforg2" ]		= "arcadia_fly_photosforg2";
	
	// Huah.
	level.scr_sound[ "dunn" ][ "arcadia_cpd_huah" ]				= "arcadia_cpd_huah";
	
	// Shepherd's not gonna like this.
	level.scr_sound[ "foley" ][ "arcadia_fly_notgoingtolike" ]	= "arcadia_fly_notgoingtolike";
	
	// Overlord, the HVI is dead.
	level.scr_sound[ "foley" ][ "arcadia_fly_overlordhvi" ]		= "arcadia_fly_overlordhvi";
}