#include common_scripts\utility;
#include animscripts\utility;
#include maps\_utility_code;


is_coop()
{
	if ( IsSplitScreen() || ( GetDvar( "coop" ) == "1" ) )
	{
		AssertEx( IsDefined( level.player2 ), "In co-op mode but level.player2 is undefined. IsSplitScreen=" + IsSplitScreen() + " coop dvar=" + GetDvar( "coop" ) );
		return true;
	}

	return false;
}


is_coop_online()
{
	if ( issplitscreen() )
		return false;
		
	if ( !is_coop() )
		return false;
	
	return true;
}


is_player_down( player )
{
	assertex( isdefined( player ) && isplayer( player ), "player_coop_is_down() requires a valid player to test." );

	if ( !is_coop() )
		return false;
			
	if ( !isdefined( player.laststand ) )
		return false;
		
	return player.laststand;
}


is_player_down_and_out( player )
{
	assertex( isdefined( player ) && isplayer( player ), "player_coop_is_down_and_out() requires a valid player to test." );

	if ( !is_coop() )
		return false;
			
	if ( !isdefined( player.down_part2_proc_ran ) )
		return false;
		
	return player.down_part2_proc_ran;
}


clear_custom_eog_summary()
{
	for ( i = 1; i < 7; i++ )
	{
		SetDvar( "ui_eog_r" + i + "c1_player1", "" );
		SetDvar( "ui_eog_r" + i + "c1_player2", "" );
	}

	for ( i = 1; i < 7; i++ )
	{
		SetDvar( "ui_eog_r" + i + "c2_player1", "" );
		SetDvar( "ui_eog_r" + i + "c2_player2", "" );
	}

	SetDvar( "ui_eog_success_heading_player1", "" );
	SetDvar( "ui_eog_success_heading_player2", "" );
}


set_custom_eog_summary( row, col, data )
{
	AssertEx( IsDefined( self ) && IsPlayer( self ), "set_custom_eog_summary() Must be called on a Player entity!" );

	AssertEx( IsDefined( level.eog_summary_callback ), "Setting custom eog display data when callback function is not set. level.ego_summary_callback function pointer is undefined." );
	level.custom_eog_summary = true;

	r = Int( row );
	c = Int( col );

	AssertEx( r >= 1 && r <= 6, "Row: " + r + " is out of bound, row = 1->6." );
	AssertEx( c >= 1 && c <= 2, "Column: " + c + " is out of bound, column = 1->2." );

	eog_dvar = "";
	if ( level.players.size > 1 )
	{
		if ( self == level.player )
			eog_dvar = "ui_eog_r" + r + "c" + c + "_player1";
		else if ( self == level.player2 )
			eog_dvar = "ui_eog_r" + r + "c" + c + "_player2";
		else
			AssertEx( true, "set_custom_eog_summary() Must be called on a Player entity!" );
	}
	else
	{
		eog_dvar = "ui_eog_r" + r + "c" + c + "_player1";
	}

	SetDvar( eog_dvar, data );
}


add_custom_eog_summary_line( eog_title, eog_value, eog_line_override )
{
	assertex( isdefined( eog_title ), "so_add_eog_summary_line() requires a valid eog_title." );
	assertex( isdefined( eog_value ), "so_add_eog_summary_line() requires a valid eog_title." );
	assertex( isdefined( self ) && isplayer( self ), "so_add_eog_summary_line() must be called on a player." );

	if ( !isdefined( self.eog_line ) )
		self.eog_line = 0;
		
	eog_line = undefined;
	if ( isdefined( eog_line_override ) )
	{
		eog_line = eog_line_override;
	}
	else
	{
		self.eog_line++;
		eog_line = self.eog_line;
	}
		
	self set_custom_eog_summary( eog_line, 1, eog_title );
	self set_custom_eog_summary( eog_line, 2, eog_value );
}


add_custom_eog_summary_line_blank()
{
	if ( !isdefined( self.eog_line ) )
		self.eog_line = 0;
		
	self.eog_line++;
}


set_eog_success_heading( title )
{
	AssertEx( IsDefined( self ) && IsPlayer( self ), "set_custom_eog_summary() Must be called on a Player entity!" );

	AssertEx( IsDefined( level.eog_summary_callback ), "Setting custom eog display data when callback function is not set. level.ego_summary_callback function pointer is undefined." );
	level.custom_eog_summary = true;

	eog_dvar = "";
	if ( level.players.size > 1 )
	{
		if ( self == level.player )
			eog_dvar = "ui_eog_success_heading_player1";
		else if ( self == level.player2 )
			eog_dvar = "ui_eog_success_heading_player2";
		else
			AssertEx( true, "set_eog_success_heading() Must be called on a Player entity!" );
	}
	else
	{
		eog_dvar = "ui_eog_success_heading_player1";
	}

	SetDvar( eog_dvar, title );
}


is_specialop()
{
	return GetDvar( "specialops" ) == "1";
}


convert_to_time_string( timer, show_tenths )
{
	string = "";
	if ( timer < 0 )
		string += "-";

	timer_clipped = timer * 100;
	timer_clipped = int( timer_clipped );
	timer_clipped = abs( timer_clipped );

	minutes = timer_clipped / 6000;
	minutes = int( minutes );
	string += minutes;

	seconds = timer_clipped / 100;
	seconds = int( seconds );
	seconds -= minutes * 60;
	if ( seconds < 10 )
		string += ":0" + seconds;
	else
		string += ":" + seconds;

	if ( IsDefined( show_tenths ) && show_tenths )
	{
		tenths = timer_clipped;
		tenths -= minutes * 6000;
		tenths -= seconds * 100;
		tenths = int( tenths );
		if ( tenths < 10 )
			string += ".0" + tenths;
		else
			string += "." + tenths;
	}

	return string;
}


set_vision_set( visionset, transition_time )
{
	if ( init_vision_set( visionset ) )
		return;

	if ( !isdefined( transition_time ) )
		transition_time = 1;
	//iprintlnbold( visionset );
	VisionSetNaked( visionset, transition_time );
	SetDvar( "vision_set_current", visionset );
}


set_vision_set_player( visionset, transition_time )
{
	if ( init_vision_set( visionset ) )
		return;

	Assert( IsDefined( self ) );
	Assert( level != self );

	if ( !isdefined( transition_time ) )
		transition_time = 1;
	self VisionSetNakedForPlayer( visionset, transition_time );
}


set_nvg_vision( visionset, transition_time )
{
//	init_vision_set( visionset );

	if ( !isdefined( transition_time ) )
		transition_time = 1;
	VisionSetNight( visionset, transition_time );
}

 

sun_light_fade( startSunColor, endSunColor, fTime )
{
	fTime = Int( fTime * 20 );

	// determine difference btwn starting and target sun RGBs
	increment = [];
	for ( i = 0; i < 3; i++ )
		increment[ i ] = ( startSunColor[ i ] - endSunColor[ i ] ) / fTime;

	// change gradually to new sun color over time
    newSunColor = [];
    for ( i = 0; i < fTime; i++ )
    {
    	wait( 0.05 );
    	for ( j = 0; j < 3; j++ )
    		newSunColor[ j ] = startSunColor[ j ] - ( increment[ j ] * i );
		SetSunLight( newSunColor[ 0 ], newSunColor[ 1 ], newSunColor[ 2 ] );
    }
    //set sunlight to new target values to account for rounding off decimal places
    SetSunLight( endSunColor[ 0 ], endSunColor[ 1 ], endSunColor[ 2 ] );
}

 
ent_flag_wait( msg )
{
	AssertEx( ( !IsSentient( self ) && IsDefined( self ) ) || IsAlive( self ), "Attempt to check a flag on entity that is not alive or removed" );

	while ( IsDefined( self ) && !self.ent_flag[ msg ] )
		self waittill( msg );
}

  
ent_flag_wait_either( flag1, flag2 )
{
	AssertEx( ( !IsSentient( self ) && IsDefined( self ) ) || IsAlive( self ), "Attempt to check a flag on entity that is not alive or removed" );

	while ( IsDefined( self ) )
	{
		if ( ent_flag( flag1 ) )
			return;
		if ( ent_flag( flag2 ) )
			return;

		self waittill_either( flag1, flag2 );
	}
}

  
ent_flag_wait_or_timeout( flagname, timer )
{
	AssertEx( ( !IsSentient( self ) && IsDefined( self ) ) || IsAlive( self ), "Attempt to check a flag on entity that is not alive or removed" );

	start_time = GetTime();
	while ( IsDefined( self ) )
	{
		if ( self.ent_flag[ flagname ] )
			break;

		if ( GetTime() >= start_time + timer * 1000 )
			break;

		self ent_wait_for_flag_or_time_elapses( flagname, timer );
	}
}


ent_flag_waitopen( msg )
{
	AssertEx( ( !IsSentient( self ) && IsDefined( self ) ) || IsAlive( self ), "Attempt to check a flag on entity that is not alive or removed" );

	while ( IsDefined( self ) && self.ent_flag[ msg ] )
		self waittill( msg );
}

ent_flag_assert( msg )
{
	AssertEx( !self ent_flag( msg ), "Flag " + msg + " set too soon on entity" );
}


  
ent_flag_waitopen_either( flag1, flag2 )
{
	AssertEx( ( !IsSentient( self ) && IsDefined( self ) ) || IsAlive( self ), "Attempt to check a flag on entity that is not alive or removed" );

	while ( IsDefined( self ) )
	{
		if ( !ent_flag( flag1 ) )
			return;
		if ( !ent_flag( flag2 ) )
			return;

		self waittill_either( flag1, flag2 );
	}
}

  
ent_flag_init( message )
{
	if ( !isDefined( self.ent_flag ) )
	{
		self.ent_flag = [];
		self.ent_flags_lock = [];
	}

	/#
	if ( IsDefined( level.first_frame ) && level.first_frame == -1 )
		AssertEx( !isDefined( self.ent_flag[ message ] ), "Attempt to reinitialize existing message: " + message + " on entity." );
	#/

	self.ent_flag[ message ] = false;
/#
	self.ent_flags_lock[ message ] = false;
#/
}

 
ent_flag_exist( message )
{
	if ( IsDefined( self.ent_flag ) && IsDefined( self.ent_flag[ message ] ) )
		return true;
	return false;
}

  
ent_flag_set_delayed( message, delay )
{
	self endon( "death" );

	wait( delay );
	self ent_flag_set( message );
}

  
ent_flag_set( message )
{
/#
 	AssertEx( IsDefined( self ), "Attempt to set a flag on entity that is not defined" );
	AssertEx( IsDefined( self.ent_flag[ message ] ), "Attempt to set a flag before calling flag_init: " + message + " on entity." );
	Assert( self.ent_flag[ message ] == self.ent_flags_lock[ message ] );
	self.ent_flags_lock[ message ] = true;
#/
	self.ent_flag[ message ] = true;
	self notify( message );
}

  
ent_flag_clear( message )
{
/#
 	AssertEx( IsDefined( self ), "Attempt to clear a flag on entity that is not defined" );
	AssertEx( IsDefined( self.ent_flag[ message ] ), "Attempt to set a flag before calling flag_init: " + message + " on entity." );
	Assert( self.ent_flag[ message ] == self.ent_flags_lock[ message ] );
	self.ent_flags_lock[ message ] = false;
#/
	//do this check so we don't unneccessarily send a notify
	if ( 	self.ent_flag[ message ] )
	{
		self.ent_flag[ message ] = false;
		self notify( message );
	}
}


ent_flag_clear_delayed( message, delay )
{
	wait( delay );
	self ent_flag_clear( message );
}

  
ent_flag( message )
{
	AssertEx( IsDefined( message ), "Tried to check flag but the flag was not defined." );
	AssertEx( IsDefined( self.ent_flag[ message ] ), "Tried to check flag " + message + " but the flag was not initialized." );

	return self.ent_flag[ message ];
}
  
get_closest_to_player_view( array, player, use_eye, min_dot )
{
	if ( !array.size )
		return;

	if ( !isdefined( player ) )
		player = level.player;

	if ( !isdefined( min_dot ) )
		min_dot = -1;

	player_origin = player.origin;
	if ( IsDefined( use_eye ) && use_eye )
		player_origin = player GetEye();

	ent = undefined;

	player_angles = player GetPlayerAngles();
	player_forward = AnglesToForward( player_angles );

	dot = -1;
	foreach ( array_item in array )
	{
		angles = VectorToAngles( array_item.origin - player_origin );
		forward = AnglesToForward( angles );

		newdot = VectorDot( player_forward, forward );
		if ( newdot < dot )
			continue;
		if ( newdot < min_dot )
			continue;
		dot = newdot;
		ent = array_item;
	}
	return ent;
}

 
get_closest_index_to_player_view( array, player, use_eye )
{
	if ( !array.size )
		return;

	if ( !isdefined( player ) )
		player = level.player;

	player_origin = player.origin;
	if ( IsDefined( use_eye ) && use_eye )
		player_origin = player GetEye();

	index = undefined;

	player_angles = player GetPlayerAngles();
	player_forward = AnglesToForward( player_angles );

	dot = -1;
	for ( i = 0; i < array.size; i++ )
	{
		angles = VectorToAngles( array[ i ].origin - player_origin );
		forward = AnglesToForward( angles );

		newdot = VectorDot( player_forward, forward );
		if ( newdot < dot )
			continue;

		dot = newdot;
		index = i;
	}
	return index;
}

flag_trigger_init( message, trigger, continuous )
{
	flag_init( message );

	if ( !isDefined( continuous ) )
		continuous = false;

	Assert( IsSubStr( trigger.classname, "trigger" ) );
	trigger thread _flag_wait_trigger( message, continuous );

	return trigger;
}


flag_triggers_init( message, triggers, all )
{
	flag_init( message );

	if ( !isDefined( all ) )
		all = false;

	for ( index = 0; index < triggers.size; index++ )
	{
		Assert( IsSubStr( triggers[ index ].classname, "trigger" ) );
		triggers[ index ] thread _flag_wait_trigger( message, false );
	}

	return triggers;
}



flag_set_delayed( message, delay )
{
	wait( delay );
	flag_set( message );
}


flag_clear_delayed( message, delay )
{
	wait( delay );
	flag_clear( message );
}

_flag_wait_trigger( message, continuous )
{
	self endon( "death" );

	for ( ;; )
	{
		self waittill( "trigger", other );
		flag_set( message );

		if ( !continuous )
			return;

		while ( other IsTouching( self ) )
			wait( 0.05 );

		flag_clear( message );
	}
}

level_end_save()
{
	if ( arcadeMode() )
		return;

	if ( level.MissionFailed )
		return;

	if ( flag( "game_saving" ) )
		return;

	for ( i = 0; i < level.players.size; i++ )
	{
		player = level.players[ i ];
		if ( !isAlive( player ) )
			return;
	}

	flag_set( "game_saving" );

	imagename = "levelshots / autosave / autosave_" + level.script + "end";

	// string not found for AUTOSAVE_AUTOSAVE
	SaveGame( "levelend", &"AUTOSAVE_AUTOSAVE", imagename, true );// does not print "Checkpoint Reached"

	flag_clear( "game_saving" );
}


add_extra_autosave_check( name, func, msg )
{
	level._extra_autosave_checks[ name ] = [];
	level._extra_autosave_checks[ name ][ "func" ] = func;
	level._extra_autosave_checks[ name ][ "msg" ] = msg;
}


remove_extra_autosave_check( name )
{
	level._extra_autosave_checks[ name ] = undefined;
}


autosave_stealth()
{
	thread autosave_by_name_thread( "autosave_stealth", 8, true );
}


autosave_tactical()
{
	autosave_tactical_setup();
	thread autosave_tactical_proc();
}


autosave_by_name( name )
{
	thread autosave_by_name_thread( name );
}


autosave_by_name_silent( name )
{
	thread autosave_by_name_thread( name, undefined, undefined, true );
}

autosave_by_name_thread( name, timeout, doStealthChecks, suppress_hint )
{
	if ( !isDefined( level.curAutoSave ) )
		level.curAutoSave = 1;


	// nate - sorry auto style guide makes this ugly.. fixing it is complicated and this doesn't hurt things
	imageName = "levelshots / autosave / autosave_" + level.script + level.curAutoSave;
	result = level maps\_autosave::tryAutoSave( level.curAutoSave, "autosave", imagename, timeout, doStealthChecks, suppress_hint );
	if ( IsDefined( result ) && result )
		level.curAutoSave++;
}


autosave_or_timeout( name, timeout )
{
	thread autosave_by_name_thread( name, timeout );
}


debug_message( message, origin, duration, entity )
{
	if ( !isDefined( duration ) )
		duration = 5;

	if ( IsDefined( entity ) )
	{
		entity endon( "death" );
		origin = entity.origin;
	}


	for ( time = 0; time < ( duration * 20 ); time++ )
	{
		if ( !isdefined( entity ) )
			Print3d( ( origin + ( 0, 0, 45 ) ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
		else
			Print3d( entity.origin, message, ( 0.48, 9.4, 0.76 ), 0.85 );
		wait 0.05;
	}
}


debug_message_ai( message, duration )
{
	self notify( "debug_message_ai" );
	self endon( "debug_message_ai" );
	self endon( "death" );

	if ( !isDefined( duration ) )
		duration = 5;

	for ( time = 0; time < ( duration * 20 ); time++ )
	{
		Print3d( ( self.origin + ( 0, 0, 45 ) ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
		wait 0.05;
	}
}


debug_message_clear( message, origin, duration, extraEndon )
{
	if ( IsDefined( extraEndon ) )
	{
		level notify( message + extraEndon );
		level endon( message + extraEndon );
	}
	else
	{
		level notify( message );
		level endon( message );
	}

	if ( !isDefined( duration ) )
		duration = 5;

	for ( time = 0; time < ( duration * 20 ); time++ )
	{
		Print3d( ( origin + ( 0, 0, 45 ) ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
		wait 0.05;
	}
}

chain_off( chain )
{
	trigs = GetEntArray( "trigger_friendlychain", "classname" );
	for ( i = 0; i < trigs.size; i++ )
	if ( ( IsDefined( trigs[ i ].script_chain ) ) && ( trigs[ i ].script_chain == chain ) )
	{
		if ( IsDefined( trigs[ i ].oldorigin ) )
			trigs[ i ].origin = trigs[ i ].oldorigin;
		else
			trigs[ i ].oldorigin = trigs[ i ].origin;

		trigs[ i ].origin = trigs[ i ].origin + ( 0, 0, -5000 );
	}
}

chain_on( chain )
{
	trigs = GetEntArray( "trigger_friendlychain", "classname" );
	for ( i = 0; i < trigs.size; i++ )
	if ( ( IsDefined( trigs[ i ].script_chain ) ) && ( trigs[ i ].script_chain == chain ) )
	{
		if ( IsDefined( trigs[ i ].oldorigin ) )
			trigs[ i ].origin = trigs[ i ].oldorigin;
	}
}

precache( model )
{
	ent = Spawn( "script_model", ( 0, 0, 0 ) );
	ent.origin = level.player GetOrigin();
	ent SetModel( model );
	ent Delete();
}


closerFunc( dist1, dist2 )
{
	return dist1 >= dist2;
}

fartherFunc( dist1, dist2 )
{
	return dist1 <= dist2;
}

  
getClosest( org, array, maxdist )
{
	if ( !IsDefined( maxdist ) )
		maxdist = 500000; // twice the size of the grid
		
	ent = undefined;
	foreach ( item in array )
	{
		newdist = Distance( item.origin, org );
		if ( newdist >= maxdist )
			continue;
		maxdist = newdist;
		ent = item;
	}
	return ent;
}

  
getFarthest( org, array, maxdist )
{
	if ( !IsDefined( maxdist ) )
		maxdist = 500000; // twice the size of the grid
	
	dist = 0;
	ent = undefined;
	foreach ( item in array )
	{
		newdist = Distance( item.origin, org );
		if ( newdist <= dist || newdist >= maxdist )
			continue;
		dist = newdist;
		ent = item;
	}
	return ent;
}

  
getClosestFx( org, fxarray, dist )
{
	return compareSizesFx( org, fxarray, dist, ::closerFunc );
}



  
get_closest_point( origin, points, maxDist )
{
	Assert( points.size );

	closestPoint = points[ 0 ];
	dist = Distance( origin, closestPoint );

	for ( index = 0; index < points.size; index++ )
	{
		testDist = Distance( origin, points[ index ] );
		if ( testDist >= dist )
			continue;

		dist = testDist;
		closestPoint = points[ index ];
	}

	if ( !isDefined( maxDist ) || dist <= maxDist )
		return closestPoint;

	return undefined;
}

  
get_farthest_ent( org, array )
{
	if ( array.size < 1 )
		return;

	dist = Distance( array[ 0 ] GetOrigin(), org );
	ent = array[ 0 ];
	for ( i = 0; i < array.size; i++ )
	{
		newdist = Distance( array[ i ] GetOrigin(), org );
		if ( newdist < dist )
			continue;
		dist = newdist;
		ent = array[ i ];
	}
	return ent;
}


  
get_within_range( org, array, dist )
{
	guys = [];
	for ( i = 0; i < array.size; i++ )
	{
		if ( Distance( array[ i ].origin, org ) <= dist )
			guys[ guys.size ] = array[ i ];
	}
	return guys;
}

  
get_outside_range( org, array, dist )
{
	guys = [];
	for ( i = 0; i < array.size; i++ )
	{
		if ( Distance( array[ i ].origin, org ) > dist )
			guys[ guys.size ] = array[ i ];
	}
	return guys;
}

  
get_closest_living( org, array, dist )
{
	if ( !isdefined( dist ) )
		dist = 9999999;
	if ( array.size < 1 )
		return;
	ent = undefined;
	for ( i = 0; i < array.size; i++ )
	{
		if ( !isalive( array[ i ] ) )
			continue;
		newdist = Distance( array[ i ].origin, org );
		if ( newdist >= dist )
			continue;
		dist = newdist;
		ent = array[ i ];
	}
	return ent;
}


get_highest_dot( start, end, array )
{
	if ( !array.size )
		return;

	ent = undefined;

	angles = VectorToAngles( end - start );
	dotforward = AnglesToForward( angles );
	dot = -1;

	foreach ( member in array )
	{
		angles = VectorToAngles( member.origin - start );
		forward = AnglesToForward( angles );

		newdot = VectorDot( dotforward, forward );
		if ( newdot < dot )
			continue;
		dot = newdot;
		ent = member;
	}
	return ent;
}

  
get_closest_index( org, array, dist )
{
	if ( !isdefined( dist ) )
		dist = 9999999;
	if ( array.size < 1 )
		return;
	index = undefined;
	foreach ( i, ent in array )
	{
		newdist = Distance( ent.origin, org );
		if ( newdist >= dist )
			continue;
		dist = newdist;
		index = i;
	}
	return index;
}


get_closest_exclude( org, ents, excluders )
{
	if ( !isdefined( ents ) )
		return undefined;

	range = 0;
	if ( IsDefined( excluders ) && excluders.size )
	{
		exclude = [];
		for ( i = 0; i < ents.size; i++ )
			exclude[ i ] = false;

		for ( i = 0; i < ents.size; i++ )
		for ( p = 0; p < excluders.size; p++ )
		if ( ents[ i ] == excluders[ p ] )
			exclude[ i ] = true;

		found_unexcluded = false;
		for ( i = 0; i < ents.size; i++ )
		if ( ( !exclude[ i ] ) && ( IsDefined( ents[ i ] ) ) )
		{
			found_unexcluded = true;
			range = Distance( org, ents[ i ].origin );
			ent = i;
			i = ents.size + 1;
		}

		if ( !found_unexcluded )
			return( undefined );
	}
	else
	{
		for ( i = 0; i < ents.size; i++ )
		if ( IsDefined( ents[ i ] ) )
		{
			range = Distance( org, ents[ 0 ].origin );
			ent = i;
			i = ents.size + 1;
		}
	}

	ent = undefined;

	for ( i = 0; i < ents.size; i++ )
	if ( IsDefined( ents[ i ] ) )
	{
		exclude = false;
		if ( IsDefined( excluders ) )
		{
			for ( p = 0; p < excluders.size; p++ )
			if ( ents[ i ] == excluders[ p ] )
				exclude = true;
		}

		if ( !exclude )
		{
			newrange = Distance( org, ents[ i ].origin );
			if ( newrange <= range )
			{
				range = newrange;
				ent = i;
			}
		}
	}

	if ( IsDefined( ent ) )
		return ents[ ent ];
	else
		return undefined;
}

  
get_closest_player( org )
{
	if ( level.players.size == 1 )
		return level.player;

	player = getClosest( org, level.players );
	return player;
}

  
get_closest_player_healthy( org )
{
	if ( level.players.size == 1 )
		return level.player;

	healthyPlayers = [];
	foreach ( player in level.players )
	{
		if ( player ent_flag( "coop_downed" ) )
			continue;
		// Checking player.coop_downed is unreliable due to it being set in more than _coop.gsc (see dog_combat.gsc).
		// We need to go through everything and make the use of player.coop_downed and 
		// ent_flag( "coop_downed" ) consistent and not maintain both.

		healthyPlayers[ healthyPlayers.size ] = player;
	}

	/#
	assertex( healthyPlayers.size > 0, "get_closest_player_healthy() was unable to find a healthy player. This should never be possible." );
	#/
	
	player = getClosest( org, healthyPlayers );

	return player;
}

  
get_closest_ai( org, team, excluders )
{
	if ( IsDefined( team ) )
		ents = GetAIArray( team );
	else
		ents = GetAIArray();

	if ( ents.size == 0 )
		return undefined;

	if ( IsDefined( excluders ) )
	{
		Assert( excluders.size > 0 );
		ents = array_remove_array( ents, excluders );
	}

	return getClosest( org, ents );
}

  
get_array_of_farthest( org, array, excluders, max, maxdist, mindist )
{
	aArray = get_array_of_closest( org, array, excluders, max, maxdist, mindist );
	aArray = array_reverse( aArray );
	return aArray;
}



  
get_array_of_closest( org, array, excluders, max, maxdist, mindist )
{
	// pass an array of entities to this function and it will return them in the order of closest
	// to the origin you pass, you can also set max to limit how many ents get returned
	if ( !isdefined( max ) )
		max = array.size;
	if ( !isdefined( excluders ) )
		excluders = [];

	maxdist2rd = undefined;
	if ( IsDefined( maxdist ) )
		maxdist2rd = maxdist * maxdist;

	mindist2rd = 0;
	if ( IsDefined( mindist ) )
		mindist2rd = mindist * mindist;

	// optimize the common case of a simple sort
	if ( excluders.size == 0 && max >= array.size && mindist2rd == 0 && !isdefined( maxdist2rd ) )
		return SortByDistance( array, org );

	newArray = [];
	foreach ( ent in array )
	{
		excluded = false;
		foreach ( excluder in excluders )
		{
			if ( ent == excluder )
			{
				excluded = true;
				break;
			}
		}
		if ( excluded )
			continue;

		dist2rd = DistanceSquared( org, ent.origin );

		if ( IsDefined( maxdist2rd ) && dist2rd > maxdist2rd )
			continue;

		if ( dist2rd < mindist2rd )
			continue;

		newArray[ newArray.size ] = ent;
	}

	newArray = SortByDistance( newArray, org );

	if ( max >= newArray.size )
		return newArray;

	finalArray = [];
	for ( i = 0; i < max; i++ )
		finalArray[ i ] = newArray[ i ];

	return finalArray;
}


get_closest_ai_exclude( org, team, excluders )
{
	if ( IsDefined( team ) )
		ents = GetAIArray( team );
	else
		ents = GetAIArray();

	if ( ents.size == 0 )
		return undefined;

	return get_closest_exclude( org, ents, excluders );
}


can_see_origin( origin, test_characters )
{
	AssertEx( IsDefined( origin ), "can_see_origin() requires a valid origin to be passed in." );
	AssertEx( IsPlayer( self ) || IsAI( self ), "can_see_origin() can only be called on a player or AI." );

	if ( !isdefined( test_characters ) )
		test_characters = true;

	// if not in FOV, return false
	if ( !self point_in_fov( origin ) )
	{
		return false;
	}

	// if in FOV but sight trace fails, return false
	if ( !SightTracePassed( self GetEye(), origin, test_characters, self ) )
	{
		return false;
	}

	// if in FOV with successful trace, return true
	return true;
}


point_in_fov( origin )
{
    forward = AnglesToForward( self.angles );
    normalVec = VectorNormalize( origin - self.origin );

    dot = VectorDot( forward, normalVec );
    return dot > 0.766;// fov = 80
}

  

stop_magic_bullet_shield()
{
	self notify( "stop_magic_bullet_shield" );
	AssertEx( IsDefined( self.magic_bullet_shield ) && self.magic_bullet_shield, "Tried to stop magic bullet shield on a guy without magic bulletshield" );

	if ( IsAI( self ) )
		self.attackeraccuracy = 1;

	self.magic_bullet_shield = undefined;
	self.damageShield = false;

	self notify( "internal_stop_magic_bullet_shield" );
}

// For future projects we should distinguish between "death" and "deletion"
// Since we currently do not, bulletshield has to be turned off before deleting characters, or you will get the 2nd assert below
magic_bullet_death_detection()
{
	/#
	self endon( "internal_stop_magic_bullet_shield" );
	export = self.export;
	entnum = self GetEntNum();

	self waittill( "death" );
	if ( IsDefined( self ) )
		AssertEx( 0, "Magic bullet shield guy with export " + export + " died some how." );
	else
		AssertEx( 0, "Magic bullet shield guy with export " + export + " died, most likely deleted from spawning guys." );

	export = export;// extra line so you can get this info in the debugger without a breakpoint.

	#/
}

  

magic_bullet_shield( no_death_detection )
{
	if ( IsAI( self ) )// AI only
	{
		AssertEx( IsAlive( self ), "Tried to do magic_bullet_shield on a dead or undefined guy." );
		AssertEx( !self.delayedDeath, "Tried to do magic_bullet_shield on a guy about to die." );
		AssertEx( !isDefined( self.Melee ), "Trying to turn on magic_bullet_shield while melee in progress (might be about to die)." );
	}
	else
	{
		self.health = 100000;
	}


	self endon( "internal_stop_magic_bullet_shield" );
	AssertEx( !isdefined( self.magic_bullet_shield ), "Can't call magic bullet shield on a character twice. Use make_hero and remove_heroes_from_array so that you don't end up with shielded guys in your logic." );

	if ( IsAI( self ) )// AI only
		self.attackeraccuracy = 0.1;

	/#
	if ( !isdefined( no_death_detection ) )
		thread magic_bullet_death_detection();
	else
		AssertEx( no_death_detection, "no_death_detection must be undefined or true" );
	#/

	self.magic_bullet_shield = true;
	self.damageShield = true;
}



disable_long_death()
{
	AssertEx( IsAlive( self ), "Tried to disable long death on a non living thing" );
	self.a.disableLongDeath = true;
}


enable_long_death()
{
	AssertEx( IsAlive( self ), "Tried to enable long death on a non living thing" );
	self.a.disableLongDeath = false;
}


enable_blood_pool()
{
	self.skipBloodPool = undefined;
}


disable_blood_pool()
{
	self.skipBloodPool = true;
}


deletable_magic_bullet_shield()
{
	magic_bullet_shield( true );
}



get_ignoreme()
{
	return self.ignoreme;
}


set_ignoreme( val )
{
	AssertEx( IsSentient( self ), "Non ai tried to set ignoreme" );
	self.ignoreme = val;
}


set_ignoreall( val )
{
	AssertEx( IsSentient( self ), "Non ai tried to set ignoraell" );
	self.ignoreall = val;
}



set_favoriteenemy( enemy )
{
	self.favoriteenemy = enemy;
}


get_pacifist()
{
	return self.pacifist;
}


set_pacifist( val )
{
	AssertEx( IsSentient( self ), "Non ai tried to set pacifist" );
	self.pacifist = val;
}

ignore_me_timer( time )
{
	self notify( "new_ignore_me_timer" );
	self endon( "new_ignore_me_timer" );
	self endon( "death" );

	if ( !isdefined( self.ignore_me_timer_prev_value ) )
		self.ignore_me_timer_prev_value = self.ignoreme;

	ai = GetAIArray( "bad_guys" );

	foreach ( guy in ai )
	{
		if ( !isalive( guy.enemy ) )
			continue;
		if ( guy.enemy != self )
			continue;

		guy ClearEnemy();
	}

	self.ignoreme = true;
	wait( time );

	self.ignoreme = self.ignore_me_timer_prev_value;
	self.ignore_me_timer_prev_value = undefined;
}


  
array_randomize( array )
{
    for ( i = 0; i < array.size; i++ )
    {
        j = RandomInt( array.size );
        temp = array[ i ];
        array[ i ] = array[ j ];
        array[ j ] = temp;
    }
    return array;
}
  
array_reverse( array )
{
	array2 = [];
	for ( i = array.size - 1; i >= 0; i-- )
		array2[ array2.size ] = array[ i ];
	return array2;
}



delete_exploder( num )
{
	num += "";

	prof_begin( "delete_exploder" );

	for ( i = 0; i < level.createFXent.size; i++ )
	{
		ent = level.createFXent[ i ];
		if ( !isdefined( ent ) )
			continue;

		if ( ent.v[ "type" ] != "exploder" )
			continue;

		// make the exploder actually removed the array instead?
		if ( !isdefined( ent.v[ "exploder" ] ) )
			continue;

		if ( ent.v[ "exploder" ] + "" != num )
			continue;

		if ( IsDefined( ent.model ) )
			ent.model Delete();
	}

	//ends trigger threads.
	level notify( "killexplodertridgers" + num );

	prof_end( "delete_exploder" );
}



hide_exploder_models( num )
{
	num += "";

	prof_begin( "hide_exploder" );

	for ( i = 0; i < level.createFXent.size; i++ )
	{
		ent = level.createFXent[ i ];
		if ( !isdefined( ent ) )
			continue;

		if ( ent.v[ "type" ] != "exploder" )
			continue;

		// make the exploder actually removed the array instead?
		if ( !isdefined( ent.v[ "exploder" ] ) )
			continue;

		if ( ent.v[ "exploder" ] + "" != num )
			continue;


		if ( IsDefined( ent.model ) )
				ent.model Hide();

	}

	prof_end( "hide_exploder" );
}



show_exploder_models( num )
{
	num += "";

	prof_begin( "hide_exploder" );

	for ( i = 0; i < level.createFXent.size; i++ )
	{
		ent = level.createFXent[ i ];
		if ( !isdefined( ent ) )
			continue;

		if ( ent.v[ "type" ] != "exploder" )
			continue;

		// make the exploder actually removed the array instead?
		if ( !isdefined( ent.v[ "exploder" ] ) )
			continue;

		if ( ent.v[ "exploder" ] + "" != num )
			continue;

		if ( IsDefined( ent.model ) )
		{

			//pre exploded geo.  don't worry about deleted exploder geo..
			if ( ! exploder_model_starts_hidden( ent.model ) && ! exploder_model_is_damaged_model( ent.model ) && !exploder_model_is_chunk( ent.model ) )
			{
					ent.model Show();
			}

			//exploded geo and should be shown
			if ( IsDefined( ent.brush_shown ) )
				ent.model Show();

		}
	}

	prof_end( "hide_exploder" );
}

exploder_model_is_damaged_model( ent )
{
	return( IsDefined( ent.targetname ) ) && ( ent.targetname == "exploder" );
}

exploder_model_starts_hidden( ent )
{
	return( ent.model == "fx" ) && ( ( !isdefined( ent.targetname ) ) || ( ent.targetname != "exploderchunk" ) );
}

exploder_model_is_chunk( ent )
{
	return( IsDefined( ent.targetname ) ) && ( ent.targetname == "exploderchunk" );
}


stop_exploder( num )
{
	num += "";

	for ( i = 0; i < level.createFXent.size; i++ )
	{
		ent = level.createFXent[ i ];
		if ( !isdefined( ent ) )
			continue;

		if ( ent.v[ "type" ] != "exploder" )
			continue;

		// make the exploder actually removed the array instead?
		if ( !isdefined( ent.v[ "exploder" ] ) )
			continue;

		if ( ent.v[ "exploder" ] + "" != num )
			continue;

		if ( !isdefined( ent.looper ) )
			continue;

		ent.looper Delete();
	}
}


get_exploder_array( msg )
{
	msg += "";
	array = [];
	foreach ( ent in level.createFXent )
	{
		if ( ent.v[ "type" ] != "exploder" )
			continue;

		// make the exploder actually removed the array instead?
		if ( !isdefined( ent.v[ "exploder" ] ) )
			continue;

		if ( ent.v[ "exploder" ] + "" != msg )
			continue;

		array[ array.size ] = ent;
	}

	return array;
}

flood_spawn( spawners )
{
	maps\_spawner::flood_spawner_scripted( spawners );
}


set_ambient( track )
{
	maps\_ambient::activateAmbient( track );
}


force_crawling_death( angle, num_crawls, array, nofallanim )
{
	if ( !isdefined( num_crawls ) )
		num_crawls = 4;

	self thread force_crawling_death_proc( angle, num_crawls, array, nofallanim );
}

#using_animtree( "generic_human" );
override_crawl_death_anims()
{
	if ( IsDefined( self.a.custom_crawling_death_array ) )
	{
		self.a.array[ "crawl" ] = self.a.custom_crawling_death_array[ "crawl" ];
		self.a.array[ "death" ] = self.a.custom_crawling_death_array[ "death" ];
		self.a.crawl_fx_rate = self.a.custom_crawling_death_array[ "blood_fx_rate" ];
		if( isdefined( self.a.custom_crawling_death_array[ "blood_fx" ] ) )
			self.a.crawl_fx = self.a.custom_crawling_death_array[ "blood_fx" ];	
	}

	self.a.array[ "stand_2_crawl" ] = [];
	self.a.array[ "stand_2_crawl" ][ 0 ] = %dying_stand_2_crawl_v3;

	if ( IsDefined( self.nofallanim ) )
		self.a.pose = "prone";

	self OrientMode( "face angle", self.a.force_crawl_angle );
	self.a.force_crawl_angle = undefined;
}

force_crawling_death_proc( angle, num_crawls, array, nofallanim )
{
	self.forceLongDeath = true;
	self.a.force_num_crawls = num_crawls;
	self.noragdoll = true;
	self.nofallanim = nofallanim;

	self.a.custom_crawling_death_array = array;
	self.crawlingPainAnimOverrideFunc = ::override_crawl_death_anims;

	self.maxhealth = 100000;
	self.health = 100000;
	self enable_long_death();

	if ( !isdefined( nofallanim ) || nofallanim == false )
		self.a.force_crawl_angle = angle + 181.02;
	else
	{
		self.a.force_crawl_angle = angle;
		self thread animscripts\shared::noteTrackPoseCrawl();
	}	
}

get_friendly_chain_node( chainstring )
{
	chain = undefined;
	trigger = GetEntArray( "trigger_friendlychain", "classname" );
	for ( i = 0; i < trigger.size; i++ )
	{
		if ( ( IsDefined( trigger[ i ].script_chain ) ) && ( trigger[ i ].script_chain == chainstring ) )
		{
			chain = trigger[ i ];
			break;
		}
	}

	if ( !isdefined( chain ) )
	{
/#
		error( "Tried to get chain " + chainstring + " which does not exist with script_chain on a trigger." );
#/
		return undefined;
	}

	node = GetNode( chain.target, "targetname" );
	return node;
}

shock_ondeath()
{
	Assert( IsPlayer( self ) );

	PreCacheShellShock( "default" );
	self waittill( "death" );

	if ( IsDefined( self.specialDeath ) )
		return;

	if ( GetDvar( "r_texturebits" ) == "16" )
		return;
	self ShellShock( "default", 3 );
}


delete_on_death_wait_sound( ent, sounddone )
{
	ent endon( "death" );
	self waittill( "death" );
	if ( IsDefined( ent ) )
	{
		if ( ent IsWaitingOnSound() )
			ent waittill( sounddone );

		ent Delete();
	}
}

is_dead_sentient()
{
	return IsSentient( self ) && !isalive( self );
}

  
play_sound_on_tag( alias, tag, ends_on_death, op_notify_string, radio_dialog )
{
	if ( is_dead_sentient() )
		return;

	org = Spawn( "script_origin", ( 0, 0, 0 ) );
	org endon( "death" );

	thread delete_on_death_wait_sound( org, "sounddone" );
	if ( IsDefined( tag ) )
		org LinkTo( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org LinkTo( self );
	}

	/#
	if ( IsDefined( level.player_radio_emitter ) && ( self == level.player_radio_emitter ) )
		PrintLn( "**dialog alias playing radio: " + alias );
	#/

	org PlaySound( alias, "sounddone" );
	if ( IsDefined( ends_on_death ) )
	{
		AssertEx( ends_on_death, "ends_on_death must be true or undefined" );
		if ( !isdefined( wait_for_sounddone_or_death( org ) ) )
			org StopSounds(); // don't call StopSounds (redundantly) when the sound stopped since this can cut off sounds in SO for the non host
		wait( 0.05 );// stopsounds doesnt work if the org is deleted same frame
	}
	else
	{
		org waittill( "sounddone" );
	}
	if ( IsDefined( op_notify_string ) )
		self notify( op_notify_string );
	org Delete();
}


 
play_sound_on_tag_endon_death( alias, tag )
{
	play_sound_on_tag( alias, tag, true );
}

  
play_sound_on_entity( alias, op_notify_string )
{
	AssertEx( !isSpawner( self ), "Spawner tried to play a sound" );

	play_sound_on_tag( alias, undefined, undefined, op_notify_string );
}

  
play_loop_sound_on_tag( alias, tag, bStopSoundOnDeath )
{
	org = Spawn( "script_origin", ( 0, 0, 0 ) );
	org endon( "death" );
	if ( !isdefined( bStopSoundOnDeath ) )
		bStopSoundOnDeath = true;
	if ( bStopSoundOnDeath )
		thread delete_on_death( org );
	if ( IsDefined( tag ) )
		org LinkTo( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org LinkTo( self );
	}
// 	org endon( "death" );
	org PlayLoopSound( alias );
// 	PrintLn( "playing loop sound ", alias, " on entity at origin ", self.origin, " at ORIGIN ", org.origin );
	self waittill( "stop sound" + alias );
	org StopLoopSound( alias );
	org Delete();
}

save_friendlies()
{
	ai = GetAIArray( "allies" );
	game_characters = 0;
	for ( i = 0; i < ai.size; i++ )
	{
		if ( IsDefined( ai[ i ].script_friendname ) )
			continue;

// 		attachsize = 
// 		PrintLn( "attachSize = ", self GetAttachSize() );

		game[ "character" + game_characters ] = ai[ i ] codescripts\character::save();
		game_characters++;
	}

	game[ "total characters" ] = game_characters;
}

  
spawn_failed( spawn )
{
	if ( !isalive( spawn ) )
		return true;
	if ( !isdefined( spawn.finished_spawning ) )
		spawn waittill( "finished spawning" );

	if ( IsAlive( spawn ) )
		return false;

	return true;
}

spawn_setcharacter( data )
{
	codescripts\character::precache( data );

	self waittill( "spawned", spawn );
	if ( maps\_utility::spawn_failed( spawn ) )
		return;

	PrintLn( "Size is ", data[ "attach" ].size );
	spawn codescripts\character::new();
	spawn codescripts\character::load( data );
}

key_hint_print( message, binding )
{
	// Note that this will insert only the first bound key for the action
	IPrintLnBold( message, binding[ "key1" ] );
}

view_tag( tag )
{
	self endon( "death" );
	for ( ;; )
	{
		maps\_debug::drawTag( tag );
		wait( 0.05 );
	}
}

  

assign_animtree( animname )
{
	if ( IsDefined( animname ) )
		self.animname = animname;

	AssertEx( IsDefined( level.scr_animtree[ self.animname ] ), "There is no level.scr_animtree for animname " + self.animname );
	self UseAnimTree( level.scr_animtree[ self.animname ] );
}


assign_model()
{
	AssertEx( IsDefined( level.scr_model[ self.animname ] ), "There is no level.scr_model for animname " + self.animname );

	if ( IsArray( level.scr_model[ self.animname ] ) )
	{
		randIndex = RandomInt( level.scr_model[ self.animname ].size );
		self SetModel( level.scr_model[ self.animname ][ randIndex ] );
	}
	else
		self SetModel( level.scr_model[ self.animname ] );
}

  

spawn_anim_model( animname, origin )
{
	if ( !isdefined( origin ) )
		origin = ( 0, 0, 0 );
	model = Spawn( "script_model", origin );
	model.animname = animname;
	model assign_animtree();
	model assign_model();
	return model;
}

  
trigger_wait( strName, strKey )
{
	eTrigger = GetEnt( strName, strKey );
	if ( !isdefined( eTrigger ) )
	{
		AssertMsg( "trigger not found: " + strName + " key: " + strKey );
		return;
	}
	eTrigger waittill( "trigger", eOther );
	level notify( strName, eOther );
	return eOther;
}
  

trigger_wait_targetname( strName )
{
	eTrigger = GetEnt( strName, "targetname" );
	if ( !isdefined( eTrigger ) )
	{
		AssertMsg( "trigger not found: " + strName + " targetname " );
		return;
	}
	eTrigger waittill( "trigger", eOther );
	level notify( strName, eOther );
	return eOther;
}


set_flag_on_dead( spawners, strFlag )
{
	thread set_flag_on_func_wait_proc( spawners, strFlag, ::waittill_dead, "set_flag_on_dead" );
}


set_flag_on_dead_or_dying( spawners, strFlag )
{
	thread set_flag_on_func_wait_proc( spawners, strFlag, ::waittill_dead_or_dying, "set_flag_on_dead_or_dying" );
}


set_flag_on_spawned( spawners, strFlag )
{
	thread set_flag_on_func_wait_proc( spawners, strFlag, ::empty_func, "set_flag_on_spawned" );
}

empty_func( var )
{
	return;
}

set_flag_on_spawned_ai_proc( system, internal_flag )
{
	self waittill( "spawned", guy );
	if ( maps\_utility::spawn_failed( guy ) )
		return;

	system.ai[ system.ai.size ] = guy;

	self ent_flag_set( internal_flag );
}

set_flag_on_func_wait_proc( spawners, strFlag, waitfunc, internal_flag )
{
	system = SpawnStruct();
	system.ai = [];

	AssertEx( spawners.size, "spawners is empty" );

	foreach ( key, spawn in spawners )
		spawn ent_flag_init( internal_flag );

	array_thread( spawners, ::set_flag_on_spawned_ai_proc, system, internal_flag );

	foreach ( key, spawn in spawners )
		spawn ent_flag_wait( internal_flag );

	[[ waitfunc ]]( system.ai );
	flag_set( strFlag );
}

  
set_flag_on_trigger( eTrigger, strFlag )
{
	if ( !flag( strFlag ) )
	{
		eTrigger waittill( "trigger", eOther );
		flag_set( strFlag );
		return eOther;
	}
}

  
set_flag_on_targetname_trigger( msg )
{
	Assert( IsDefined( level.flag[ msg ] ) );
	if ( flag( msg ) )
		return;

	trigger = GetEnt( msg, "targetname" );
	trigger waittill( "trigger" );
	flag_set( msg );
}

  
is_in_array( aeCollection, eFindee )
{
	for ( i = 0; i < aeCollection.size; i++ )
	{
		if ( aeCollection[ i ] == eFindee )
			return( true );
	}

	return( false );
}

  
waittill_dead( guys, num, timeoutLength )
{
	// verify the living - ness of the ai
	/#
	allAlive = true;
	foreach ( member in guys )
	{
		if ( IsAlive( member ) )
			continue;
		allAlive = false;
		break;
	}
	AssertEx( allAlive, "Waittill_Dead was called with dead or removed AI in the array, meaning it will never pass." );
	if ( !allAlive )
	{
		newArray = [];
		foreach ( member in guys )
		{
			if ( IsAlive( member ) )
				newArray[ newArray.size ] = member;
		}
		guys = newArray;
	}
	#/

	ent = SpawnStruct();
	if ( IsDefined( timeoutLength ) )
	{
		ent endon( "thread_timed_out" );
		ent thread waittill_dead_timeout( timeoutLength );
	}

	ent.count = guys.size;
	if ( IsDefined( num ) && num < ent.count )
		ent.count = num;
	array_thread( guys, ::waittill_dead_thread, ent );

	while ( ent.count > 0 )
		ent waittill( "waittill_dead guy died" );
}

  
waittill_dead_or_dying( guys, num, timeoutLength )
{
	// verify the living - ness and healthy - ness of the ai
	newArray = [];
	foreach ( member in guys )
	{
		if ( IsAlive( member ) && !member.ignoreForFixedNodeSafeCheck )
			newArray[ newArray.size ] = member;
	}
	guys = newArray;

	ent = SpawnStruct();
	if ( IsDefined( timeoutLength ) )
	{
		ent endon( "thread_timed_out" );
		ent thread waittill_dead_timeout( timeoutLength );
	}

	ent.count = guys.size;

	// optional override on count
	if ( IsDefined( num ) && num < ent.count )
		ent.count = num;

	array_thread( guys, ::waittill_dead_or_dying_thread, ent );

	while ( ent.count > 0 )
		ent waittill( "waittill_dead_guy_dead_or_dying" );
}

waittill_dead_thread( ent )
{
	self waittill( "death" );
	ent.count--;
	ent notify( "waittill_dead guy died" );
}

waittill_dead_or_dying_thread( ent )
{
	self waittill_either( "death", "pain_death" );
	ent.count--;
	ent notify( "waittill_dead_guy_dead_or_dying" );
}

waittill_dead_timeout( timeoutLength )
{
	wait( timeoutLength );
	self notify( "thread_timed_out" );
}

waittill_aigroupcleared( aigroup )
{
	while ( level._ai_group[ aigroup ].spawnercount || level._ai_group[ aigroup ].aicount )
		wait( 0.25 );
}

waittill_aigroupcount( aigroup, count )
{
	while ( level._ai_group[ aigroup ].spawnercount + level._ai_group[ aigroup ].aicount > count )
		wait( 0.25 );
}

get_ai_group_count( aigroup )
{
	return( level._ai_group[ aigroup ].spawnercount + level._ai_group[ aigroup ].aicount );
}

get_ai_group_sentient_count( aigroup )
{
	return( level._ai_group[ aigroup ].aicount );
}

get_ai_group_ai( aigroup )
{
	aiSet = [];
	for ( index = 0; index < level._ai_group[ aigroup ].ai.size; index++ )
	{
		if ( !isAlive( level._ai_group[ aigroup ].ai[ index ] ) )
			continue;

		aiSet[ aiSet.size ] = level._ai_group[ aigroup ].ai[ index ];
	}

	return( aiSet );
}

  

waittill_notetrack_or_damage( notetrack )
{
	self endon( "damage" );
	self endon( "death" );
	self waittillmatch( "single anim", notetrack );
}

  
get_living_ai( name, type )
{
	array = get_living_ai_array( name, type );
	if ( array.size > 1 )
	{
		AssertMsg( "get_living_ai used for more than one living ai of type " + type + " called " + name + "." );
		return undefined;
	}
	return array[ 0 ];
}

  
get_living_ai_array( name, type )
{
	ai = GetAISpeciesArray( "all", "all" );

	array = [];
	foreach ( actor in ai )
	{
		if ( !isalive( actor ) )
			continue;

		switch( type )
		{
			case "targetname":{
				if ( IsDefined( actor.targetname ) && actor.targetname == name )
					array[ array.size ] = actor;
			}break;
		 	case "script_noteworthy":{
				if ( IsDefined( actor.script_noteworthy ) && actor.script_noteworthy == name )
					array[ array.size ] = actor;
			}break;
		}
	}
	return array;
}
  
get_vehicle( name, type )
{
	Assert( IsDefined( name ) );
	Assert( IsDefined( type ) );
	array = get_vehicle_array( name, type );
	if ( !array.size )
		return undefined;

	AssertEx( array.size == 1, "tried to get_vehicle() on vehicles with key-pair: " + name + "," + type );
	return array[ 0 ];
}

  
get_vehicle_array( name, type )
{
	array = GetEntArray( name, type );
	vehicle = [];

	merge_array = [];

	foreach ( object in array )
	{
		if ( object.code_classname != "script_vehicle" )
			continue;
		merge_array[ 0 ] = object;
		//since vehicles lose their targetname return the last vehicle spawned from the spawner.
		if ( IsSpawner( object ) )
		{
			if ( IsDefined( object.last_spawned_vehicle ) )
			{
				merge_array[ 0 ] = object.last_spawned_vehicle;
				vehicle = array_merge( vehicle, merge_array );// least tricky way for me to do this.
			}
			continue;
		}
		vehicle = array_merge( vehicle, merge_array );// least tricky way for me to do this.
	}
	return vehicle;
}
  
get_living_aispecies( name, type, breed )
{
	array = get_living_ai_array( name, type, breed );
	if ( array.size > 1 )
	{
		AssertMsg( "get_living_aispecies used for more than one living ai of type " + type + " called " + name + "." );
		return undefined;
	}
	return array[ 0 ];
}

  
get_living_aispecies_array( name, type, breed )
{
	if ( !isdefined( breed ) )
		breed = "all";

	ai = GetAISpeciesArray( "allies", breed );
	ai = array_combine( ai, GetAISpeciesArray( "axis", breed ) );

	array = [];
	for ( i = 0; i < ai.size; i++ )
	{
		switch( type )
		{
			case "targetname":{
				if ( IsDefined( ai[ i ].targetname ) && ai[ i ].targetname == name )
					array[ array.size ] = ai[ i ];
			}break;
		 	case "script_noteworthy":{
				if ( IsDefined( ai[ i ].script_noteworthy ) && ai[ i ].script_noteworthy == name )
					array[ array.size ] = ai[ i ];
			}break;
		}
	}
	return array;
}

// Creates an event based on this message if none exists, and sets it to true after the delay.
gather_delay_proc( msg, delay )
{
	if ( IsDefined( level.gather_delay[ msg ] ) )
	{
		if ( level.gather_delay[ msg ] )
		{
			wait( 0.05 );
			if ( IsAlive( self ) )
				self notify( "gather_delay_finished" + msg + delay );
			return;
		}

		level waittill( msg );
		if ( IsAlive( self ) )
			self notify( "gather_delay_finished" + msg + delay );
		return;
	}

	level.gather_delay[ msg ] = false;
	wait( delay );
	level.gather_delay[ msg ] = true;
	level notify( msg );
	if ( IsAlive( self ) )
		self notify( "gather_delay_finished" + msg + delay );
}

gather_delay( msg, delay )
{
	thread gather_delay_proc( msg, delay );
	self waittill( "gather_delay_finished" + msg + delay );
}

set_environment( env )
{
	animscripts\utility::setEnv( env );
}

death_waiter( notifyString )
{
	self waittill( "death" );
	level notify( notifyString );
}

getchar( num )
{
	if ( num == 0 )
		return "0";
	if ( num == 1 )
		return "1";
	if ( num == 2 )
		return "2";
	if ( num == 3 )
		return "3";
	if ( num == 4 )
		return "4";
	if ( num == 5 )
		return "5";
	if ( num == 6 )
		return "6";
	if ( num == 7 )
		return "7";
	if ( num == 8 )
		return "8";
	if ( num == 9 )
		return "9";
}

  
player_god_on()
{
	thread player_god_on_thread();
}

player_god_on_thread()
{
	self endon( "godoff" );
	self.oldhealth = self.health;

	for ( ;; )
	{
		self waittill( "damage" );
		self.health = 10000;
	}
}

  
player_god_off()
{
	self notify( "godoff" );
	Assert( IsDefined( self.oldhealth ) );
	self.health = self.oldhealth;
}


getlinks_array( array, linkMap )// don't pass stuff through as an array of struct.linkname[] but only linkMap[]
{
	ents = [];
	for ( j = 0; j < array.size; j++ )
	{
		node = array[ j ];
		script_linkname = node.script_linkname;
		if ( !isdefined( script_linkname ) )
			continue;
		if ( !isdefined( linkMap[ script_linkname ] ) )
			continue;
		ents[ ents.size ] = node;
	}
	return ents;
}

// Adds only things that are new to the array.
// Requires the arrays to be of node with script_linkname defined.

array_merge_links( array1, array2 )
{
	if ( !array1.size )
		return array2;
	if ( !array2.size )
		return array1;

	linkMap = [];

	for ( i = 0; i < array1.size; i++ )
	{
		node = array1[ i ];
		linkMap[ node.script_linkName ] = true;
	}

	for ( i = 0; i < array2.size; i++ )
	{
		node = array2[ i ];
		if ( IsDefined( linkMap[ node.script_linkName ] ) )
			continue;
		linkMap[ node.script_linkName ] = true;
		array1[ array1.size ] = node;
	}

	return array1;
}

  
array_merge( array1, array2 )// adds only things that are new to the array
{
	if ( array1.size == 0 )
		return array2;
	if ( array2.size == 0 )
		return array1;
	newarray = array1;
	foreach ( array2_ent in array2 )
	{
		foundmatch = false;

		foreach ( array1_ent in array1 )
		{
			if ( array1_ent == array2_ent )
			{
				foundmatch = true;
				break;
			}
		}
		if ( foundmatch )
			continue;
		else
			newarray[ newarray.size ] = array2_ent;
	}
	return newarray;
}

  
array_exclude( array, arrayExclude )// returns "array" minus all members of arrayExclude
{
	newarray = array;
	for ( i = 0; i < arrayExclude.size; i++ )
	{
		if ( is_in_array( array, arrayExclude[ i ] ) )
			newarray = array_remove( newarray, arrayExclude[ i ] );
	}

	return newarray;
}


array_compare( array1, array2 )
{
	if ( array1.size != array2.size )
		return false;

	foreach ( key, member in array1 )
	{
		if ( !isdefined( array2[ key ] ) )
			return false;

		member2 = array2[ key ];

		if ( member2 != member )
			return false;
	}

	return true;
}


array_contains( array, compare )
{
	if ( array.size <= 0 )
		return false;

	foreach ( member in array )
	{
		if ( member == compare )
			return true;
	}

	return false;
}


getLinkedVehicleNodes()
{
	array = [];

	if ( IsDefined( self.script_linkTo ) )
	{
		linknames = get_links();
		foreach ( name in linknames )
		{
			entities = GetVehicleNodeArray( name, "script_linkname" );
			array = array_combine( array, entities );
		}
	}

	return array;
}




  
draw_line( org1, org2, r, g, b )
{
	while ( 1 )
	{
		Line( org1, org2, ( r, g, b ), 1 );
		wait .05;
	}

}

  
draw_line_to_ent_for_time( org1, ent, r, g, b, timer )
{
	timer = GetTime() + ( timer * 1000 );
	while ( GetTime() < timer )
	{
		Line( org1, ent.origin, ( r, g, b ), 1 );
		wait .05;
		if ( !isdefined( ent ) || !isdefined( ent.origin ) )
			return;
	}

}


draw_line_from_ent_for_time( ent, org, r, g, b, timer )
{
	draw_line_to_ent_for_time( org, ent, r, g, b, timer );
}

  
draw_line_from_ent_to_ent_for_time( ent1, ent2, r, g, b, timer )
{
	ent1 endon( "death" );
	ent2 endon( "death" );

	timer = GetTime() + ( timer * 1000 );
	while ( GetTime() < timer )
	{
		Line( ent1.origin, ent2.origin, ( r, g, b ), 1 );
		wait .05;
	}

}

  
draw_line_from_ent_to_ent_until_notify( ent1, ent2, r, g, b, notifyEnt, notifyString )
{
	Assert( IsDefined( notifyEnt ) );
	Assert( IsDefined( notifyString ) );

	ent1 endon( "death" );
	ent2 endon( "death" );

	notifyEnt endon( notifyString );

	while ( 1 )
	{
		Line( ent1.origin, ent2.origin, ( r, g, b ), 0.05 );
		wait .05;
	}

}

  
draw_line_until_notify( org1, org2, r, g, b, notifyEnt, notifyString )
{
	Assert( IsDefined( notifyEnt ) );
	Assert( IsDefined( notifyString ) );

	notifyEnt endon( notifyString );

	while ( 1 )
	{
		draw_line_for_time( org1, org2, r, g, b, 0.05 );
	}
}

  
draw_circle_until_notify( center, radius, r, g, b, notifyEnt, notifyString )
{
	circle_sides = 16;

	angleFrac = 360 / circle_sides;

	// Z circle
	circlepoints = [];
	for ( i = 0; i < circle_sides; i++ )
	{
		angle = ( angleFrac * i );
		xAdd = Cos( angle ) * radius;
		yAdd = Sin( angle ) * radius;
		x = center[ 0 ] + xAdd;
		y = center[ 1 ] + yAdd;
		z = center[ 2 ];
		circlepoints[ circlepoints.size ] = ( x, y, z );
	}
	thread draw_circle_lines_until_notify( circlepoints, r, g, b, notifyEnt, notifyString );
	/*
	// X circle
	circlepoints = [];
	for ( i = 0 ; i < circle_sides ; i++ )
	{
		angle = ( angleFrac * i );
		xAdd = Cos( angle ) * radius;
		yAdd = Sin( angle ) * radius;
		x = center[ 0 ];
		y = center[ 1 ] + xAdd;
		z = center[ 2 ] + yAdd;
		circlepoints[ circlepoints.size ] = ( x, y, z );
	}
	thread debug_circle_drawlines( circlepoints, 5.0, ( 1, 0, 0 ), center );
	
	// Y circle
	circlepoints = [];
	for ( i = 0 ; i < circle_sides ; i++ )
	{
		angle = ( angleFrac * i );
		xAdd = Cos( angle ) * radius;
		yAdd = Sin( angle ) * radius;
		x = center[ 0 ] + yAdd;
		y = center[ 1 ];
		z = center[ 2 ] + xAdd;
		circlepoints[ circlepoints.size ] = ( x, y, z );
	}
	thread debug_circle_drawlines( circlepoints, 5.0, ( 1, 0, 0 ), center );
	*/
}

draw_circle_lines_until_notify( circlepoints, r, g, b, notifyEnt, notifyString )
{
	for ( i = 0; i < circlepoints.size; i++ )
	{
		start = circlepoints[ i ];
		if ( i + 1 >= circlepoints.size )
			end = circlepoints[ 0 ];
		else
			end = circlepoints[ i + 1 ];

		thread draw_line_until_notify( start, end, r, g, b, notifyEnt, notifyString );
	}
}

clear_enemy_passthrough()
{
	self notify( "enemy" );
	self ClearEnemy();
}

  
battlechatter_off( team )
{
	level notify( "battlechatter_off_thread" );

	animscripts\battlechatter::bcs_setup_chatter_toggle_array();

	if ( IsDefined( team ) )
	{
		set_battlechatter_variable( team, false );
		soldiers = GetAIArray( team );
	}
	else
	{
		foreach ( team in anim.teams )
		{
			set_battlechatter_variable( team, false );
		}

		soldiers = GetAIArray();
	}

	if ( !isDefined( anim.chatInitialized ) || !anim.chatInitialized )
		return;

	for ( index = 0; index < soldiers.size; index++ )
		soldiers[ index ].battlechatter = false;

	for ( index = 0; index < soldiers.size; index++ )
	{
		soldier = soldiers[ index ];
		if ( !isalive( soldier ) )
			continue;

		if ( !soldier.chatInitialized )
			continue;

		if ( !soldier.isSpeaking )
			continue;

		soldier wait_until_done_speaking();
	}

	speakDiff = GetTime() - anim.lastTeamSpeakTime[ "allies" ];

	if ( speakDiff < 1500 )
		wait( speakDiff / 1000 );

	if ( IsDefined( team ) )
		level notify( team + " done speaking" );
	else
		level notify( "done speaking" );
}

  
battlechatter_on( team )
{
	thread battlechatter_on_thread( team );
}

battlechatter_on_thread( team )
{
	level endon( "battlechatter_off_thread" );

	animscripts\battlechatter::bcs_setup_chatter_toggle_array();

	while ( !IsDefined( anim.chatInitialized ) )
	{
		wait( 0.05 );
	}

	flag_set( "battlechatter_on_thread_waiting" );

	// buffer time
	wait( 1.5 );

	flag_clear( "battlechatter_on_thread_waiting" );

	if ( IsDefined( team ) )
	{
		set_battlechatter_variable( team, true );
		soldiers = GetAIArray( team );
	}
	else
	{
		foreach ( team in anim.teams )
		{
			set_battlechatter_variable( team, true );
		}
		soldiers = GetAIArray();
	}

	for ( index = 0; index < soldiers.size; index++ )
		soldiers[ index ] set_battlechatter( true );
}


set_battlechatter( state )
{
	if ( !anim.chatInitialized )
		return;

	if ( self.type == "dog" )
		return;

	if ( state )
	{
		if ( IsDefined( self.script_bcdialog ) && !self.script_bcdialog )
			self.battlechatter = false;
		else
			self.battlechatter = true;
	}
	else
	{
		self.battlechatter = false;

		if ( IsDefined( self.isSpeaking ) && self.isSpeaking )
			self waittill( "done speaking" );
	}
}


flavorbursts_on( team )
{
	thread set_flavorbursts_team_state( true, team );
}


flavorbursts_off( team )
{
	thread set_flavorbursts_team_state( false, team );
}

set_flavorbursts_team_state( state, team )
{
	if ( !IsDefined( team ) )
	{
		team = "allies";
	}

	if ( !anim.chatInitialized )
	{
		return;
	}

	// buffer time
	wait( 1.5 );

	level.flavorbursts[ team ] = state;

	guys = [];
	guys = GetAIArray( team );

	array_thread( guys, ::set_flavorbursts, state );
}


set_flavorbursts( state )
{
	self.flavorbursts = state;
}


friendlyfire_warnings_off()
{
	ais = GetAiArray( "allies" );
	
	foreach( guy in ais )
	{
		if( IsAlive( guy ) )
		{
			guy set_friendlyfire_warnings( false );
		}
	}
	
	level.friendlyfire_warnings = false;
}


friendlyfire_warnings_on()
{
	ais = GetAiArray( "allies" );
	
	foreach( guy in ais )
	{
		if( IsAlive( guy ) )
		{
			guy set_friendlyfire_warnings( true );
		}
	}
	
	level.friendlyfire_warnings = true;
}


set_friendlyfire_warnings( state )
{
	if( state )
	{
		self.friendlyfire_warnings_disable = undefined;
	}
	else
	{
		self.friendlyfire_warnings_disable = true;
	}
}


// 
// This is for scripted sequence guys that the LD has setup to not 
// get interrupted in route.
// 
set_friendly_chain_wrapper( node )
{
	level.player SetFriendlyChain( node );
	level notify( "newFriendlyChain", node.script_noteworthy );
}


// Newvillers objective management
  

get_obj_origin( msg )
{
	objOrigins = GetEntArray( "objective", "targetname" );
	for ( i = 0; i < objOrigins.size; i++ )
	{
		if ( objOrigins[ i ].script_noteworthy == msg )
			return objOrigins[ i ].origin;
	}
}

get_obj_event( msg )
{
	objEvents = GetEntArray( "objective_event", "targetname" );
	for ( i = 0; i < objEvents.size; i++ )
	{
		if ( objEvents[ i ].script_noteworthy == msg )
			return objEvents[ i ];
	}
}


waittill_objective_event()
{
	waittill_objective_event_proc( true );
}

waittill_objective_event_notrigger()
{
	waittill_objective_event_proc( false );
}


obj_set_chain_and_enemies()
{
	objChain = GetNode( self.target, "targetname" );
	objEnemies = GetEntArray( self.target, "targetname" );
	flood_and_secure_scripted( objEnemies );
// 	array_thread(, ::flood_begin );
	level notify( "new_friendly_trigger" );
	level.player set_friendly_chain_wrapper( objChain );
}

flood_begin()
{
	self notify( "flood_begin" );
}

flood_and_secure_scripted( spawners, instantRespawn )
{
	  

	if ( !isdefined( instantRespawn ) )
		instantRespawn = false;

	if ( !isdefined( level.spawnerWave ) )
		level.spawnerWave = [];
	array_thread( spawners, maps\_spawner::flood_and_secure_spawner, instantRespawn );

	for ( i = 0; i < spawners.size; i++ )
	{
		spawners[ i ].playerTriggered = true;
		spawners[ i ] notify( "flood_begin" );
	}
}


debugorigin()
{
// 	self endon( "killanimscript" );

	self notify( "Debug origin" );
	self endon( "Debug origin" );
	self endon( "death" );
	for ( ;; )
	{
		forward = AnglesToForward( self.angles );
		forwardFar = vector_multiply( forward, 30 );
		forwardClose = vector_multiply( forward, 20 );
		right = AnglesToRight( self.angles );
		left = vector_multiply( right, -10 );
		right = vector_multiply( right, 10 );
		Line( self.origin, self.origin + forwardFar, ( 0.9, 0.7, 0.6 ), 0.9 );
		Line( self.origin + forwardFar, self.origin + forwardClose + right, ( 0.9, 0.7, 0.6 ), 0.9 );
		Line( self.origin + forwardFar, self.origin + forwardClose + left, ( 0.9, 0.7, 0.6 ), 0.9 );
		wait( 0.05 );
	}
}




get_linked_structs()
{
	array = [];

	if ( IsDefined( self.script_linkTo ) )
	{
		linknames = get_links();
		for ( i = 0; i < linknames.size; i++ )
		{
			ent = getstruct( linknames[ i ], "script_linkname" );
			if ( IsDefined( ent ) )
			{
				array[ array.size ] = ent;
			}
		}
	}

	return array;
}

  
get_last_ent_in_chain( sEntityType )
{
	ePathpoint = self;
	while ( IsDefined( ePathpoint.target ) )
	{
		wait( 0.05 );
		if ( IsDefined( ePathpoint.target ) )
		{
			switch( sEntityType )
			{
				case "vehiclenode":
					ePathpoint = GetVehicleNode( ePathpoint.target, "targetname" );
					break;
				case "pathnode":
					ePathpoint = GetNode( ePathpoint.target, "targetname" );
					break;
				case "ent":
					ePathpoint = GetEnt( ePathpoint.target, "targetname" );
					break;
				case "struct":
					ePathpoint = getstruct( ePathpoint.target, "targetname" );
					break;
				default:
					AssertMsg( "sEntityType needs to be 'vehiclenode', 'pathnode', 'ent' or 'struct'" );
			}
		}
		else
			break;
	}
	ePathend = ePathpoint;
	return ePathend;
}


player_seek( timeout )
{
	goalent = Spawn( "script_origin", level.player.origin );
	goalent LinkTo( level.player );
	if ( IsDefined( timeout ) )
		self thread timeout( timeout );
	self SetGoalEntity( goalent );
	if ( !isdefined( self.oldgoalradius ) )
		self.oldgoalradius = self.goalradius;
	self.goalradius = 300;
	self waittill_any( "goal", "timeout" );
	if ( IsDefined( self.oldgoalradius ) )
	{
		self.goalradius = self.oldgoalradius;
		self.oldgoalradius = undefined;
	}
	goalent Delete();
}

timeout( timeout )
{
	self endon( "death" );
	wait( timeout );
	self notify( "timeout" );
}


set_forcegoal()
{
	if ( IsDefined( self.set_forcedgoal ) )
		return;

	self.oldfightdist 	 = self.pathenemyfightdist;
	self.oldmaxdist 	 = self.pathenemylookahead;
	self.oldmaxsight 	 = self.maxsightdistsqrd;

	self.pathenemyfightdist = 8;
	self.pathenemylookahead = 8;
	self.maxsightdistsqrd = 1;
	self.set_forcedgoal = true;
}


unset_forcegoal()
{
	if ( !isdefined( self.set_forcedgoal ) )
		return;

	self.pathenemyfightdist = self.oldfightdist;
	self.pathenemylookahead = self.oldmaxdist;
	self.maxsightdistsqrd 	 = self.oldmaxsight;
	self.set_forcedgoal = undefined;
}



array_add( array, ent )
{
	array[ array.size ] = ent;
	return array;
}


array_removeDead_keepkeys( array )
{
	newArray = [];
	keys = GetArrayKeys( array );
	for ( i = 0; i < keys.size; i++ )
	{
		key = keys[ i ];
		if ( !isalive( array[ key ] ) )
			continue;
		newArray[ key ] = array[ key ];
	}

	return newArray;
}

  
array_removeDead( array )
{
	newArray = [];
	foreach ( member in array )
	{
		if ( !isalive( member ) )
			continue;
		newArray[ newArray.size ] = member;
	}

	return newArray;
}


array_removeDead_or_dying( array )
{
	newArray = [];
	foreach ( member in array )
	{
		if ( !isalive( member ) )
			continue;
		if ( member doingLongDeath() )
			continue;
		newArray[ newArray.size ] = member;
	}

	return newArray;

}

  
array_insert( array, object, index )
{
	if ( index == array.size )
	{
		temp = array;
		temp[ temp.size ] = object;
		return temp;
	}
	temp = [];
	offset = 0;
	for ( i = 0; i < array.size; i++ )
	{
		if ( i == index )
		{
			temp[ i ] = object;
			offset = 1;
		}
		temp[ i + offset ] = array[ i ];
	}

	return temp;
}





array_remove_nokeys( ents, remover )
{
	newents = [];
	for ( i = 0; i < ents.size; i++ )
		if ( ents[ i ] != remover )
			newents[ newents.size ] = ents[ i ];
	return newents;
}


array_remove_index( array, index )
{
	for ( i = 0; i < array.size - 1; i++ )
	{
		if ( i == index )
		{
			array[ i ] = array[ i + 1 ];
			index++;
		}
	}
	array[ array.size - 1 ] = undefined;
	return array;
}


array_notify( ents, notifier, match )
{
	foreach ( key, value in ents )
		value notify( notifier, match );
}


// fancy quicker struct array handling, assumes array elements are objects with which an index can be asigned to( IE: can't do 5.struct_array_index ) 
// also have to be sure that objects can't be a part of another structarray setup as the index position is asigned to the object


struct_arrayspawn()
{
	struct = SpawnStruct();
	struct.array = [];
	struct.lastindex = 0;
	return struct;
}

  
structarray_add( struct, object )
{
	Assert( !isdefined( object.struct_array_index ) );// can't have elements of two structarrays on these. can add that later if it's needed
	struct.array[ struct.lastindex ] = object;
	object.struct_array_index = struct.lastindex;
	struct.lastindex++;
}

  

structarray_remove( struct, object )
{
	structarray_swaptolast( struct, object );
	struct.array[ struct.lastindex - 1 ] = undefined;
	struct.lastindex--;
}

structarray_remove_index( struct, index )
{
	// overwrite the index to remove with the last in the array
	struct.array[ index ] = struct.array[ struct.lastindex - 1 ];
	struct.array[ index ].struct_array_index = index;
	
	// remove the last from the array since it's now at position 'index'
	struct.array[ struct.lastindex - 1 ] = undefined;
	struct.lastindex = struct.array.size;
}

structarray_remove_undefined( struct )
{
	// remove undefined ents from array
	newArray = [];
	foreach( object in struct.array )
	{
		if ( !isdefined( object ) )
			continue;
		newArray[ newArray.size ] = object;
	}
	struct.array = newArray;
	
	// reassign all the index vars
	foreach( i, object in struct.array )
	{
		object.struct_array_index = i;
	}
	struct.lastindex = struct.array.size;
}

structarray_swaptolast( struct, object )
{
	struct structarray_swap( struct.array[ struct.lastindex - 1 ], object );
}

structarray_shuffle( struct, shuffle )
{
	for ( i = 0; i < shuffle; i++ )
		struct structarray_swap( struct.array[ i ], struct.array[ RandomInt( struct.lastindex ) ] );
}



// starts this ambient track
set_ambient_alias( ambient, alias )
{
	// change the meaning of this ambience so that the ambience can change over the course of the level
	level.ambient_modifier[ ambient ] = alias;
	// if the ambient being aliased is the current ambience then restart it so it gets the new track
	if ( level.ambient == ambient )
		maps\_ambient::activateAmbient( ambient );
}



get_use_key()
{
	if ( level.console )
	 	return " + usereload";
 	else
 		return " + activate";
}


doom()
{
	// send somebody far away then delete them
	self Teleport( ( 0, 0, -15000 ) );
	self Kill( ( 0, 0, 0 ) );
}



custom_battlechatter( phrase )
{
	return self animscripts\battlechatter_ai::custom_battlechatter_internal( phrase );
}



get_stop_watch( time, othertime )
{
	watch = NewHudElem();
	if ( level.console )
	{
		watch.x = 68;
		watch.y = 35;
	}
	else
	{
		watch.x = 58;
		watch.y = 95;
	}

	watch.alignx = "center";
	watch.aligny = "middle";
	watch.horzAlign = "left";
	watch.vertAlign = "middle";
	if ( IsDefined( othertime ) )
		timer = othertime;
	else
		timer = level.explosiveplanttime;
	watch SetClock( timer, time, "hudStopwatch", 64, 64 );// count down for level.explosiveplanttime of 60 seconds, size is 64x64
	return watch;
}

objective_is_active( msg )
{
	active = false;
	// objective must be active for this trigger to hit
	for ( i = 0; i < level.active_objective.size; i++ )
	{
		if ( level.active_objective[ i ] != msg )
			continue;
		active = true;
		break;
	}
	return( active );
}

objective_is_inactive( msg )
{
	inactive = false;
	// objective must be active for this trigger to hit
	for ( i = 0; i < level.inactive_objective.size; i++ )
	{
		if ( level.inactive_objective[ i ] != msg )
			continue;
		inactive = true;
		break;
	}
	return( inactive );
}

set_objective_inactive( msg )
{
	// remove the objective from the active list
	array = [];
	for ( i = 0; i < level.active_objective.size; i++ )
	{
		if ( level.active_objective[ i ] == msg )
			continue;
		array[ array.size ] = level.active_objective[ i ];
	}
	level.active_objective = array;


	// add it to the inactive list
	exists = false;
	for ( i = 0; i < level.inactive_objective.size; i++ )
	{
		if ( level.inactive_objective[ i ] != msg )
			continue;
		exists = true;
	}
	if ( !exists )
		level.inactive_objective[ level.inactive_objective.size ] = msg;

	/#
	// assert that each objective is only on one list
	for ( i = 0; i < level.active_objective.size; i++ )
	{
		for ( p = 0; p < level.inactive_objective.size; p++ )
			AssertEx( level.active_objective[ i ] != level.inactive_objective[ p ], "Objective is both inactive and active" );
	}
	#/
}

set_objective_active( msg )
{
	// remove the objective from the inactive list
	array = [];
	for ( i = 0; i < level.inactive_objective.size; i++ )
	{
		if ( level.inactive_objective[ i ] == msg )
			continue;
		array[ array.size ] = level.inactive_objective[ i ];
	}
	level.inactive_objective = array;

	// add it to the active list
	exists = false;
	for ( i = 0; i < level.active_objective.size; i++ )
	{
		if ( level.active_objective[ i ] != msg )
			continue;
		exists = true;
	}
	if ( !exists )
		level.active_objective[ level.active_objective.size ] = msg;

	/#
	// assert that each objective is only on one list
	for ( i = 0; i < level.active_objective.size; i++ )
	{
		for ( p = 0; p < level.inactive_objective.size; p++ )
			AssertEx( level.active_objective[ i ] != level.inactive_objective[ p ], "Objective is both inactive and active" );
	}
	#/
}



detect_friendly_fire()
{
	level thread maps\_friendlyfire::detectFriendlyFireOnEntity( self );
}


missionFailedWrapper()
{
	if ( level.MissionFailed )
		return;

	if ( IsDefined( level.nextmission ) )
		return;// don't fail the mission while the game is on it's way to the next mission.



	level.MissionFailed = true;
	flag_set( "missionfailed" );

	if ( arcadeMode() )
		return;

	if ( GetDvar( "failure_disabled" ) == "1" )
		return;

	if ( is_specialop() )
	{
		thread maps\_specialops_code::failure_summary_display();
		return;
	}

	MissionFailed();
}



script_delay()
{
	if ( IsDefined( self.script_delay ) )
	{
		wait( self.script_delay );
		return true;
	}
	else
	if ( IsDefined( self.script_delay_min ) && IsDefined( self.script_delay_max ) )
	{
		wait( RandomFloatRange( self.script_delay_min, self.script_delay_max ) );
		return true;
	}

	return false;
}



script_wait()
{
	startTime = GetTime();
	if ( IsDefined( self.script_wait ) )
	{
		wait( self.script_wait );

		if ( IsDefined( self.script_wait_add ) )
			self.script_wait += self.script_wait_add;
	}
	else if ( IsDefined( self.script_wait_min ) && IsDefined( self.script_wait_max ) )
	{
		wait( RandomFloatRange( self.script_wait_min, self.script_wait_max ) );

		if ( IsDefined( self.script_wait_add ) )
		{
			self.script_wait_min += self.script_wait_add;
			self.script_wait_max += self.script_wait_add;
		}
	}

	return( GetTime() - startTime );
}


guy_enter_vehicle( guy )
{
	self maps\_vehicle_aianim::guy_enter( guy );
}


guy_runtovehicle_load( guy, vehicle )
{
	maps\_vehicle_aianim::guy_runtovehicle( guy, vehicle );
}

get_force_color_guys( team, color )
{
	ai = GetAIArray( team );
	guys = [];
	for ( i = 0; i < ai.size; i++ )
	{
		guy = ai[ i ];
		if ( !isdefined( guy.script_forcecolor ) )
			continue;

		if ( guy.script_forcecolor != color )
			continue;
		guys[ guys.size ] = guy;
	}

	return guys;
}

get_all_force_color_friendlies()
{
	ai = GetAIArray( "allies" );
	guys = [];
	for ( i = 0; i < ai.size; i++ )
	{
		guy = ai[ i ];
		if ( !isdefined( guy.script_forcecolor ) )
			continue;
		guys[ guys.size ] = guy;
	}

	return guys;
}


get_all_target_ents( target )
{
	if ( !isdefined( target ) )
		target = self.target;

	AssertEx( IsDefined( target ), "Self had no target!" );
	array = [];

	ents = GetEntArray( target, "targetname" );
	array = array_combine( array, ents );

	ents = GetNodeArray( target, "targetname" );
	array = array_combine( array, ents );

	ents = getstructarray( target, "targetname" );
	array = array_combine( array, ents );

	ents = GetVehicleNodeArray( target, "targetname" );
	array = array_combine( array, ents );

	return array;
}




enable_ai_color()
{
	if ( IsDefined( self.script_forcecolor ) )
		return;
	if ( !isdefined( self.old_forceColor ) )
		return;

	set_force_color( self.old_forcecolor );
	self.old_forceColor = undefined;
}


enable_ai_color_dontmove()
{
	self.dontColorMove = true;
	self enable_ai_color();
}


disable_ai_color()
{
	if ( IsDefined( self.new_force_color_being_set ) )
	{
		self endon( "death" );
		// setting force color happens after waittillframeend so we need to wait until it finishes
		// setting before we disable it, so a set followed by a disable will send the guy to a node.
		self waittill( "done_setting_new_color" );
	}

	self ClearFixedNodeSafeVolume();
	// any color on this guy?
	if ( !isdefined( self.script_forcecolor ) )
	{
		return;
	}

	AssertEx( !isdefined( self.old_forcecolor ), "Tried to disable forcecolor on a guy that somehow had a old_forcecolor already. Investigate!!!" );

	self.old_forceColor = self.script_forceColor;


	// first remove the guy from the force color array he used to belong to
	level.arrays_of_colorForced_ai[ self maps\_colors::get_team() ][ self.script_forcecolor ] = array_remove( level.arrays_of_colorForced_ai[ self maps\_colors::get_team() ][ self.script_forcecolor ], self );
// 	self maps\_colors::removeAIFromColorNumberArray();

	maps\_colors::left_color_node();
	self.script_forcecolor = undefined;
	self.currentColorCode = undefined;
	/#
	update_debug_friendlycolor( self.unique_id );
	#/
}


clear_force_color()
{
	disable_ai_color();
}


check_force_color( _color )
{
	color = level.colorCheckList[ ToLower( _color ) ];
	if ( IsDefined( self.script_forcecolor ) && color == self.script_forcecolor )
		return true;
	else
		return false;
}


get_force_color()
{
	color = self.script_forceColor;
	return color;
}

shortenColor( color )
{
	AssertEx( IsDefined( level.colorCheckList[ ToLower( color ) ] ), "Tried to set force color on an undefined color: " + color );
	return level.colorCheckList[ ToLower( color ) ];
}



set_force_color( _color )
{
	// shorten and lowercase the ai's forcecolor to a single letter
	color = shortenColor( _color );

	AssertEx( maps\_colors::colorIsLegit( color ), "Tried to set force color on an undefined color: " + color );

	if ( !isAI( self ) )
	{
		set_force_color_spawner( color );
		return;
	}

	AssertEx( IsAlive( self ), "Tried to set force color on a dead / undefined entity." );
	  

	if ( self.team == "allies" )
	{
		// enable fixed node mode.
		self.fixednode = true;
		self.fixednodesaferadius = 64;
		self.pathenemyfightdist = 0;
		self.pathenemylookahead = 0;
	}

// 	maps\_colors::removeAIFromColorNumberArray();	
	self.script_color_axis = undefined;
	self.script_color_allies = undefined;
	self.old_forcecolor = undefined;

	team = maps\_colors::get_team();

	if ( IsDefined( self.script_forcecolor ) )
	{
		// first remove the guy from the force color array he used to belong to
		level.arrays_of_colorForced_ai[ team ][ self.script_forcecolor ] = array_remove( level.arrays_of_colorForced_ai[ team ][ self.script_forcecolor ], self );
	}
	self.script_forcecolor = color;

	// get added to the new array of AI that are forced to this color
	level.arrays_of_colorForced_ai[ team ][ color ] = array_removeDead( level.arrays_of_colorForced_ai[ team ][ color ] );
	level.arrays_of_colorForced_ai[ team ][ self.script_forcecolor ] = array_add( level.arrays_of_colorForced_ai[ team ][ self.script_forcecolor ], self );

	// set it here so that he continues in script as the correct color
	thread new_color_being_set( color );
}

set_force_color_spawner( color )
{
	  

	self.script_forcecolor = color;
// 	self.script_color_axis = undefined;
// 	self.script_color_allies = undefined;
	self.old_forceColor = undefined;
// 	thread maps\_colors::spawner_processes_colorCoded_ai();
}

issue_color_orders( color_team, team )
{
	colorCodes = StrTok( color_team, " " );
	colors = [];
	colorCodesByColorIndex = [];

	for ( i = 0; i < colorCodes.size; i++ )
	{
		color = undefined;
		if ( IsSubStr( colorCodes[ i ], "r" ) )
			color = "r";
		else
		if ( IsSubStr( colorCodes[ i ], "b" ) )
			color = "b";
		else
		if ( IsSubStr( colorCodes[ i ], "y" ) )
			color = "y";
		else
		if ( IsSubStr( colorCodes[ i ], "c" ) )
			color = "c";
		else
		if ( IsSubStr( colorCodes[ i ], "g" ) )
			color = "g";
		else
		if ( IsSubStr( colorCodes[ i ], "p" ) )
			color = "p";
		else
		if ( IsSubStr( colorCodes[ i ], "o" ) )
			color = "o";
		else
			AssertEx( 0, "Trigger at origin " + self GetOrigin() + " had strange color index " + colorCodes[ i ] );

		colorCodesByColorIndex[ color ] = colorCodes[ i ];
		colors[ colors.size ] = color;
	}

	Assert( colors.size == colorCodes.size );

	for ( i = 0; i < colorCodes.size; i++ )
	{
		// remove deleted spawners
		level.arrays_of_colorCoded_spawners[ team ][ colorCodes[ i ] ] = array_removeUndefined( level.arrays_of_colorCoded_spawners[ team ][ colorCodes[ i ] ] );

		AssertEx( IsDefined( level.arrays_of_colorCoded_spawners[ team ][ colorCodes[ i ] ] ), "Trigger refer to a color# that does not exist in any node for this team." );
		// set the .currentColorCode on each appropriate spawner
		for ( p = 0; p < level.arrays_of_colorCoded_spawners[ team ][ colorCodes[ i ] ].size; p++ )
			level.arrays_of_colorCoded_spawners[ team ][ colorCodes[ i ] ][ p ].currentColorCode = colorCodes[ i ];
	}

	for ( i = 0; i < colors.size; i++ )
	{
		// remove the dead from the color forced ai
		level.arrays_of_colorForced_ai[ team ][ colors[ i ] ] = array_removeDead( level.arrays_of_colorForced_ai[ team ][ colors[ i ] ] );

		// set the destination of the color forced spawners
		level.currentColorForced[ team ][ colors[ i ] ] = colorCodesByColorIndex[ colors[ i ] ];
	}

	for ( i = 0; i < colorCodes.size; i++ )
		self thread maps\_colors::issue_color_order_to_ai( colorCodes[ i ], colors[ i ], team );
}


// TODO: Non - hacky rumble.
flashRumbleLoop( duration )
{
	Assert( IsPlayer( self ) );

	goalTime = GetTime() + duration * 1000;

	while ( GetTime() < goalTime )
	{
		self PlayRumbleOnEntity( "damage_heavy" );
		wait( 0.05 );
	}
}

flashMonitorEnableHealthShield( time )
{
	self endon( "death" );
	self endon( "flashed" );

	wait 0.2;

	self EnableHealthShield( false );

	wait time + 2;

	self EnableHealthShield( true );
}

flashMonitor()
{
	Assert( IsPlayer( self ) );

	self endon( "death" );

	for ( ;; )
	{
		self waittill( "flashbang", origin, percent_distance, percent_angle, attacker, team );

		if ( "1" == GetDvar( "noflash" ) )
			continue;

		if ( isdefined( self.coop_downed ) )
			continue;

		// PrintLn( "Flashed by a grenade from team '", team, "'." );

		// if it's close enough, angle doesn't matter so much
		frac = ( percent_distance - 0.85 ) / ( 1 - 0.85 );
		if ( frac > percent_angle )
			percent_angle = frac;

		if ( percent_angle < 0.25 )
			percent_angle = 0.25;

		// at 300 or less of the full range of 1000 units, get the full effect
		minamountdist = 0.3;
		if ( percent_distance > 1 - minamountdist )
			percent_distance = 1.0;
		else
			percent_distance = percent_distance / ( 1 - minamountdist );

		if ( team != self.team )
			seconds = percent_distance * percent_angle * 6.0;
		else
			seconds = percent_distance * percent_angle * 3.0;

		if ( seconds < 0.25 )
			continue;

		if ( IsDefined( self.maxflashedseconds ) && seconds > self.maxflashedseconds )
 			seconds = self.maxflashedseconds;

		self.flashingTeam = team;
		self notify( "flashed" );
		self.flashendtime = GetTime() + seconds * 1000;// player is flashed if flashDoneTime > GetTime()
		self ShellShock( "flashbang", seconds );
		flag_set( "player_flashed" );
		thread unflash_flag( seconds );

		if ( percent_distance * percent_angle > 0.5 )
			self thread flashMonitorEnableHealthShield( seconds );

		if ( seconds > 2 )
			thread flashRumbleLoop( 0.75 );
		else
			thread flashRumbleLoop( 0.25 );

		// if it's an enemy's flash grenade, 
		// flash nearby allies so they can't take out enemies going after the player
		if ( team != "allies" )
			self thread flashNearbyAllies( seconds, team );
	}
}


flashNearbyAllies( baseDuration, team )
{
	Assert( IsPlayer( self ) );

	wait .05;

	allies = GetAIArray( "allies" );
	for ( i = 0; i < allies.size; i++ )
	{
		if ( DistanceSquared( allies[ i ].origin, self.origin ) < 350 * 350 )
		{
			duration = baseDuration + RandomFloatRange( -1000, 1500 );
			if ( duration > 4.5 )
				duration = 4.5;
			else if ( duration < 0.25 )
				continue;

			newendtime = GetTime() + duration * 1000;
			if ( !isdefined( allies[ i ].flashendtime ) || allies[ i ].flashendtime < newendtime )
			{
				allies[ i ].flashingTeam = team;
				allies[ i ] flashBangStart( duration );
			}
		}
	}
}


restartEffect()
{
	self common_scripts\_createfx::restart_fx_looper();
}


pauseExploder( num )
{
	num += "";

	foreach ( fx in level.createFXent )
	{
		if ( !isdefined( fx.v[ "exploder" ] ) )
			continue;

		if ( fx.v[ "exploder" ] != num )
			continue;

		fx pauseEffect();
	}
}


restartExploder( num )
{
	num += "";
	foreach ( fx in level.createFXent )
	{
		if ( !isdefined( fx.v[ "exploder" ] ) )
			continue;

		if ( fx.v[ "exploder" ] != num )
			continue;

		fx restartEffect();
	}
}


getfxarraybyID( fxid )
{
	array = [];
	for ( i = 0; i < level.createFXent.size; i++ )
	{
		if ( level.createFXent[ i ].v[ "fxid" ] == fxid )
			array[ array.size ] = level.createFXent[ i ];
	}
	return array;
}

ignoreAllEnemies( qTrue )
{
	self notify( "ignoreAllEnemies_threaded" );
	self endon( "ignoreAllEnemies_threaded" );

	if ( qTrue )
	{
		// put the ai in a threat bias group that ignores all the other groups so he
		// doesnt get distracted and go into exposed while his goal radius is too small

		self.old_threat_bias_group = self GetThreatBiasGroup();

		num = undefined;
		/#
			num = self GetEntNum();
			PrintLn( "entity: " + num + "ignoreAllEnemies TRUE" );
			PrintLn( "entity: " + num + " threatbiasgroup is " + self.old_threat_bias_group );
		#/

		CreateThreatBiasGroup( "ignore_everybody" );
		/#
			PrintLn( "entity: " + num + "ignoreAllEnemies TRUE" );
			PrintLn( "entity: " + num + " SetThreatBiasGroup( ignore_everybody )" );
		#/
		self SetThreatBiasGroup( "ignore_everybody" );
		teams = [];
		teams[ "axis" ] = "allies";
		teams[ "allies" ] = "axis";

		AssertEx( self.team != "neutral", "Why are you making a guy have team neutral? And also, why is he doing anim_reach?" );
		ai = GetAIArray( teams[ self.team ] );
		groups = [];
		for ( i = 0; i < ai.size; i++ )
			groups[ ai[ i ] GetThreatBiasGroup() ] = true;

		keys = GetArrayKeys( groups );
		for ( i = 0; i < keys.size; i++ )
		{
			/#
				PrintLn( "entity: " + num + "ignoreAllEnemies TRUE" );
				PrintLn( "entity: " + num + " SetThreatBias( " + keys[ i ] + ", ignore_everybody, 0 )" );
			#/
			SetThreatBias( keys[ i ], "ignore_everybody", 0 );
		}

		// should now be impossible for this guy to attack anybody on the other team
	}
	else
	{
		num = undefined;
		AssertEx( IsDefined( self.old_threat_bias_group ), "You can't use ignoreAllEnemies( false ) on an AI that has never ran ignoreAllEnemies( true )" );
		/#
			num = self GetEntNum();
			PrintLn( "entity: " + num + "ignoreAllEnemies FALSE" );
			PrintLn( "entity: " + num + " self.old_threat_bias_group is " + self.old_threat_bias_group );
		#/
		if ( self.old_threat_bias_group != "" )
		{
			/#
				PrintLn( "entity: " + num + "ignoreAllEnemies FALSE" );
				PrintLn( "entity: " + num + " SetThreatBiasGroup( " + self.old_threat_bias_group + " )" );
			#/
			self SetThreatBiasGroup( self.old_threat_bias_group );
		}
		self.old_threat_bias_group = undefined;
	}
}




vehicle_detachfrompath()
{
	maps\_vehicle::vehicle_pathdetach();
}

  

vehicle_resumepath()
{
	thread maps\_vehicle::vehicle_resumepathvehicle();
}

  

vehicle_land( neargoaldist )
{
	maps\_vehicle::vehicle_landvehicle( neargoaldist );
}


vehicle_liftoff( height )
{
	maps\_vehicle::vehicle_liftoffvehicle( height );
}


vehicle_dynamicpath( node, bwaitforstart )
{
	maps\_vehicle::vehicle_paths( node, bwaitforstart );
}

  

groundpos( origin )
{
	return BulletTrace( origin, ( origin + ( 0, 0, -100000 ) ), 0, self )[ "position" ];
}

change_player_health_packets( num )
{
	Assert( IsPlayer( self ) );

	self.player_health_packets += num;
	self notify( "update_health_packets" );

	if ( self.player_health_packets >= 3 )
		self.player_health_packets = 3;

// 	if( self.player_health_packets <= 0 )
// 		self Kill();
}


getvehiclespawner( targetname )
{
	spawners = getvehiclespawnerarray( targetname );
	Assert( spawners.size == 1 );
	return spawners[ 0 ];
}


getvehiclespawnerarray( targetname )
{
	return maps\_vehicle::_getvehiclespawnerarray( targetname );
}

  

player_fudge_moveto( dest, moverate )
{
	// moverate = units / persecond
	if ( !isdefined( moverate ) )
		moverate = 200;
	// this function is to fudge move the player. I'm using this as a placeholder for an actual animation

	org = Spawn( "script_origin", level.player.origin );
	org.origin = level.player.origin;
	level.player LinkTo( org );
	dist = Distance( level.player.origin, dest );
	movetime = dist / moverate;
	org MoveTo( dest, dist / moverate, .05, .05 );
	wait movetime;
	level.player Unlink();
}




add_start( msg, func, loc_string, optional_func )
{
	AssertEx( !isdefined( level._loadStarted ), "Can't create starts after _load" );
	if ( !isdefined( level.start_functions ) )
		level.start_functions = [];
//	AssertEx( IsDefined( loc_string ), "Starts now require a localize string" );
	msg = ToLower( msg );
	/#
	if ( IsDefined( loc_string ) )
	{
		PreCacheString( loc_string );
		level.start_loc_string[ msg ] = loc_string;
	}
	#/

	array = [];
	array[ "name" ] = msg;
	array[ "start_func" ] = func;
	array[ "logic_func" ] = optional_func;
	level.start_functions[ level.start_functions.size ] = array;
	level.start_arrays[ msg ] = array;
}

level_has_start_points()
{
	// account for no_game start point
	return level.start_functions.size > 1;
}


set_default_start( start )
{
	level.default_start_override = start;
}


default_start( func )
{
	level.default_start = func;
}

linetime( start, end, color, timer )
{
	thread linetime_proc( start, end, color, timer );
}

  
within_fov( start_origin, start_angles, end_origin, fov )
{
	normal = VectorNormalize( end_origin - start_origin );
	forward = AnglesToForward( start_angles );
	dot = VectorDot( forward, normal );

	return dot >= fov;
}

  
within_fov_2d( start_origin, start_angles, end_origin, fov )
{
	start_origin = set_z( start_origin, 0 );
	end_origin = set_z( end_origin, 0 );
	start_angles = ( 0, start_angles[ 1 ], 0 );

	normal = VectorNormalize( end_origin - start_origin );
	forward = AnglesToForward( start_angles );
	dot = VectorDot( forward, normal );

	return dot >= fov;
}


  
get_dot( start_origin, start_angles, end_origin )
{
	normal = VectorNormalize( end_origin - start_origin );
	forward = AnglesToForward( start_angles );
	dot = VectorDot( forward, normal );

	return dot;
}



  
within_fov_of_players( end_origin, fov )
{
	bDestInFOV = undefined;
	for ( i = 0; i < level.players.size; i++ )
	{
		playerEye = level.players[ i ] GetEye();
		bDestInFOV = within_fov( playerEye, level.players[ i ] GetPlayerAngles(), end_origin, fov );
		if ( !bDestInFOV )
			return false;
	}
	return true;
}

waitSpread( start, end )
{
	if ( !isdefined( end ) )
	{
		end = start;
		start = 0;
	}
	AssertEx( IsDefined( start ) && IsDefined( end ), "Waitspread was called without defining amount of time" );

	// temporarily disabling waitspread until I have time to fix it properly
	wait( RandomFloatRange( start, end ) );
	if ( 1 )
		return;

	personal_wait_index = undefined;

	if ( !isdefined( level.active_wait_spread ) )
	{
		// the first guy sets it up and runs the master logic. Thread it off in case he dies

		level.active_wait_spread = true;
		level.wait_spreaders = 0;
		personal_wait_index = level.wait_spreaders;
		level.wait_spreaders++;
		thread waitSpread_code( start, end );
	}
	else
	{
		personal_wait_index = level.wait_spreaders;
		level.wait_spreaders++;
		waittillframeend;// give every other waitspreader in this frame a chance to increment wait_spreaders
	}

	waittillframeend;// wait for the logic to setup the waits

	wait( level.wait_spreader_allotment[ personal_wait_index ] );

}


wait_for_buffer_time_to_pass( last_queue_time, buffer_time )
{
	timer = buffer_time * 1000 - ( GetTime() - last_queue_time );
	timer *= 0.001;
	if ( timer > 0 )
	{
		// 500ms buffer time between radio or dialogue sounds
		wait( timer );
	}
}

bcs_scripted_dialogue_start()
{
	anim.scriptedDialogueStartTime = GetTime();
}


dialogue_queue( msg )
{
	bcs_scripted_dialogue_start();

	self maps\_anim::anim_single_queue( self, msg );
}



generic_dialogue_queue( msg, timeout )
{
	bcs_scripted_dialogue_start();

	self maps\_anim::anim_generic_queue( self, msg, undefined, undefined, timeout );
}


radio_dialogue( msg, timeout )
{
	AssertEx( IsDefined( level.scr_radio[ msg ] ), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio" );

	//this is so we have a universal entity to stack radio dialogue on without worrying about
	//any other scripts dirtying up the stack with functions not related to radio_dialogue
	if ( !isdefined( level.player_radio_emitter ) )
	{
		ent = Spawn( "script_origin", ( 0, 0, 0 ) );
		ent LinkTo( level.player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
		level.player_radio_emitter = ent;
	}

	bcs_scripted_dialogue_start();

	success = false;
	if ( !IsDefined( timeout ) )
	{
		success = level.player_radio_emitter function_stack( ::play_sound_on_tag, level.scr_radio[ msg ], undefined, true );
	}
	else
	{
		success = level.player_radio_emitter function_stack_timeout( timeout, ::play_sound_on_tag, level.scr_radio[ msg ], undefined, true );
	}

	return success;
}


radio_dialogue_overlap( msg )
{
	AssertEx( IsDefined( level.scr_radio[ msg ] ), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio" );
	AssertEx( IsDefined( level.player_radio_emitter ), "Tried to overlap dialogue but no radio dialogue was playing, use radio_dialogue." );

	level.player_radio_emitter play_sound_on_tag( level.scr_radio[ msg ], undefined, true );
}


radio_dialogue_stop()
{
	if ( !isdefined( level.player_radio_emitter ) )
		return;
	//level.player_radio_emitter function_stack_clear(); ->don't need it - kills the funciton stack already
	level.player_radio_emitter Delete();
}


radio_dialogue_clear_stack()
{
	if ( !isdefined( level.player_radio_emitter ) )
		return;
	level.player_radio_emitter function_stack_clear();
}


radio_dialogue_interupt( msg )
{
	AssertEx( IsDefined( level.scr_radio[ msg ] ), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio" );

	if ( !isdefined( level.player_radio_emitter ) )
	{
		ent = Spawn( "script_origin", ( 0, 0, 0 ) );
		ent LinkTo( level.player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
		level.player_radio_emitter = ent;
	}

	level.player_radio_emitter play_sound_on_tag( level.scr_radio[ msg ], undefined, true );
}


radio_dialogue_safe( msg )
{
	return radio_dialogue( msg, .05 );
}

/////////////////////// DELETE ME ////////////////////////
radio_dialogue_queue( msg )
{
	radio_dialogue( msg );
}

// HUD ELEMENT STUFF
hint_create( text, background, backgroundAlpha )
{
	struct = SpawnStruct();
	if ( IsDefined( background ) && background == true )
		struct.bg = NewHudElem();
	struct.elm = NewHudElem();

	struct hint_position_internal( backgroundAlpha );
	// elm.label 		 = struct.text;
	// elm.debugtext 	 = struct.text;
	struct.elm SetText( text );

	return struct;
}

hint_delete()
{
	self notify( "death" );

	if ( IsDefined( self.elm ) )
		self.elm Destroy();
	if ( IsDefined( self.bg ) )
		self.bg Destroy();
}

hint_position_internal( bgAlpha )
{
	if ( level.console )
		self.elm.fontScale = 2;
	else
		self.elm.fontScale = 1.6;

	self.elm.x 			 = 0;
	self.elm.y		 	 = -40;
	self.elm.alignX 	 = "center";
	self.elm.alignY 	 = "bottom";
	self.elm.horzAlign 	 = "center";
	self.elm.vertAlign 	 = "middle";
	self.elm.sort		 = 1;
	self.elm.alpha		 = 0.8;

	if ( !isdefined( self.bg ) )
		return;

	self.bg.x 			 = 0;
	self.bg.y 			 = -40;
	self.bg.alignX 		 = "center";
	self.bg.alignY 		 = "middle";
	self.bg.horzAlign 	 = "center";
	self.bg.vertAlign 	 = "middle";
	self.bg.sort		 = -1;

	if ( level.console )
		self.bg SetShader( "popmenu_bg", 650, 52 );
	else
		self.bg SetShader( "popmenu_bg", 650, 42 );

	if ( !isdefined( bgAlpha ) )
		bgAlpha = 0.5;

	self.bg.alpha = bgAlpha;
}


string( num )
{
	return( "" + num );
}

ignoreEachOther( group1, group2 )
{
	// these threatbias groups ignore each other
	AssertEx( ThreatBiasGroupExists( group1 ), "Tried to make threatbias group " + group1 + " ignore " + group2 + " but " + group1 + " does not exist!" );
	AssertEx( ThreatBiasGroupExists( group2 ), "Tried to make threatbias group " + group2 + " ignore " + group1 + " but " + group2 + " does not exist!" );
	SetIgnoreMeGroup( group1, group2 );
	SetIgnoreMeGroup( group2, group1 );
}

  

add_global_spawn_function( team, function, param1, param2, param3 )
{
	AssertEx( IsDefined( level.spawn_funcs ), "Tried to add_global_spawn_function before calling _load" );

	func = [];
	func[ "function" ] = function;
	func[ "param1" ] = param1;
	func[ "param2" ] = param2;
	func[ "param3" ] = param3;

	level.spawn_funcs[ team ][ level.spawn_funcs[ team ].size ] = func;
}

  

remove_global_spawn_function( team, function )
{
	AssertEx( IsDefined( level.spawn_funcs ), "Tried to remove_global_spawn_function before calling _load" );

	array = [];
	for ( i = 0; i < level.spawn_funcs[ team ].size; i++ )
	{
		if ( level.spawn_funcs[ team ][ i ][ "function" ] != function )
		{
			array[ array.size ] = level.spawn_funcs[ team ][ i ];
		}
	}

	//assertEx( level.spawn_funcs[ team ].size != array.size, "Tried to remove a function from level.spawn_funcs, but that function didn't exist!" );
	level.spawn_funcs[ team ] = array;
}

  

exists_global_spawn_function( team, function )
{
	if ( !isdefined( level.spawn_funcs ) )
		return false;

	for ( i = 0; i < level.spawn_funcs[ team ].size; i++ )
	{
		if ( level.spawn_funcs[ team ][ i ][ "function" ] == function )
			return true;
	}

	return false;
}


  

remove_spawn_function( function )
{
	AssertEx( !isalive( self ), "Tried to remove_spawn_function to a living guy." );
	AssertEx( IsSpawner( self ), "Tried to remove_spawn_function to something that isn't a spawner." );
	AssertEx( IsDefined( self.spawn_functions ), "Tried to remove_spawn_function before calling _load" );

	new_spawn_functions = [];

	foreach ( func_array in self.spawn_functions )
	{
		if ( func_array[ "function" ] == function )
			continue;

		new_spawn_functions[ new_spawn_functions.size ] = func_array;
	}


	self.spawn_functions = new_spawn_functions;
}

  

add_spawn_function( function, param1, param2, param3, param4, param5 )
{
	AssertEx( !isalive( self ), "Tried to add_spawn_function to a living guy." );
	AssertEx( IsSpawner( self ), "Tried to add_spawn_function to something that isn't a spawner." );
	AssertEx( IsDefined( self.spawn_functions ), "Tried to add_spawn_function before calling _load" );

	foreach ( func_array in self.spawn_functions )
	{
		if ( func_array[ "function" ] == function )
			return;
	}

	func = [];
	func[ "function" ] = function;
	func[ "param1" ] = param1;
	func[ "param2" ] = param2;
	func[ "param3" ] = param3;
	func[ "param4" ] = param4;
	func[ "param5" ] = param5;

	self.spawn_functions[ self.spawn_functions.size ] = func;
}


array_delete( array )
{
	for ( i = 0; i < array.size; i++ )
	{
		array[ i ] Delete();
	}
}

ignore_triggers( timer )
{
	// ignore triggers for awhile so others can trigger the trigger we're in.
	self endon( "death" );
	self.ignoreTriggers = true;
	if ( IsDefined( timer ) )
	{
		wait( timer );
	}
	else
	{
		wait( 0.5 );
	}
	self.ignoreTriggers = false;
}


activate_trigger_with_targetname( msg )
{
	trigger = GetEnt( msg, "targetname" );
	trigger activate_trigger();
}


activate_trigger_with_noteworthy( msg )
{
	trigger = GetEnt( msg, "script_noteworthy" );
	trigger activate_trigger();
}


disable_trigger_with_targetname( msg )
{
	trigger = GetEnt( msg, "targetname" );
	trigger trigger_off();
}


disable_trigger_with_noteworthy( msg )
{
	trigger = GetEnt( msg, "script_noteworthy" );
	trigger trigger_off();
}


is_hero()
{
	return IsDefined( level.hero_list[ get_ai_number() ] );
}


get_ai_number()
{
	if ( !isdefined( self.unique_id ) )
	{
		set_ai_number();
	}
	return self.unique_id;
}


set_ai_number()
{
	self.unique_id = "ai" + level.ai_number;
	level.ai_number++;
}


make_hero()
{
	level.hero_list[ self.unique_id ] = true;
}


unmake_hero()
{
	level.hero_list[ self.unique_id ] = undefined;
}


get_heroes()
{
	array = [];
	ai = GetAIArray( "allies" );
	for ( i = 0; i < ai.size; i++ )
	{
		if ( ai[ i ] is_hero() )
			array[ array.size ] = ai[ i ];
	}
	return array;
}


set_team_pacifist( team, val )
{
	ai = GetAIArray( team );
	for ( i = 0; i < ai.size; i++ )
	{
		ai[ i ].pacifist = val;
	}
}


replace_on_death()
{
	// kill with either:
	// level notify( "kill_color_replacements" );
	// or
	// self notify( "_disable_reinforcement" );

	maps\_colors::colorNode_replace_on_death();
}

spawn_reinforcement( classname, color )
{
	maps\_colors::colorNode_spawn_reinforcement( classname, color );
}

clear_promotion_order()
{
	level.current_color_order = [];
}

set_promotion_order( deadguy, replacer )
{
	if ( !isdefined( level.current_color_order ) )
	{
		level.current_color_order = [];
	}

	deadguy = shortenColor( deadguy );
	replacer = shortenColor( replacer );

	level.current_color_order[ deadguy ] = replacer;

	// if there is no color order for the replacing color than
	// let script assume that it is meant to be replaced by
	// respawning guys
	if ( !isdefined( level.current_color_order[ replacer ] ) )
		set_empty_promotion_order( replacer );
}

set_empty_promotion_order( deadguy )
{
	if ( !isdefined( level.current_color_order ) )
	{
		level.current_color_order = [];
	}

	level.current_color_order[ deadguy ] = "none";
}


remove_dead_from_array( array )
{
	newarray = [];
	foreach ( item in array )
	{
		if ( !isalive( item ) )
			continue;
		newarray[ newarray.size ] = item;
	}
	return newarray;
}


remove_heroes_from_array( array )
{
	newarray = [];
	for ( i = 0; i < array.size; i++ )
	{
		if ( array[ i ] is_hero() )
			continue;
		newarray[ newarray.size ] = array[ i ];
	}
	return newarray;
}


remove_all_animnamed_guys_from_array( array )
{
	newarray = [];
	for ( i = 0; i < array.size; i++ )
	{
		if ( IsDefined( array[ i ].animname ) )
			continue;
		newarray[ newarray.size ] = array[ i ];
	}
	return newarray;
}



remove_color_from_array( array, color )
{
	newarray = [];
	for ( i = 0; i < array.size; i++ )
	{
		guy = array[ i ];
		if ( !isdefined( guy.script_forcecolor ) )
			continue;
		if ( guy.script_forcecolor == color )
			continue;
		newarray[ newarray.size ] = guy;
	}
	return newarray;
}


remove_noteworthy_from_array( array, noteworthy )
{
	newarray = [];
	for ( i = 0; i < array.size; i++ )
	{
		guy = array[ i ];
		if ( !isdefined( guy.script_noteworthy ) )
			continue;
		if ( guy.script_noteworthy == noteworthy )
			continue;
		newarray[ newarray.size ] = guy;
	}
	return newarray;
}


get_closest_colored_friendly( color, origin )
{
	allies = get_force_color_guys( "allies", color );
	allies = remove_heroes_from_array( allies );

	if ( !isdefined( origin ) )
		friendly_origin = level.player.origin;
	else
		friendly_origin = origin;

	return getClosest( friendly_origin, allies );
}


remove_without_classname( array, classname )
{
	newarray = [];
	for ( i = 0; i < array.size; i++ )
	{
		if ( !issubstr( array[ i ].classname, classname ) )
			continue;
		newarray[ newarray.size ] = array[ i ];
	}
	return newarray;
}


remove_without_model( array, model )
{
	newarray = [];
	for ( i = 0; i < array.size; i++ )
	{
		if ( !issubstr( array[ i ].model, model ) )
			continue;
		newarray[ newarray.size ] = array[ i ];
	}
	return newarray;
}


get_closest_colored_friendly_with_classname( color, classname, origin )
{
	allies = get_force_color_guys( "allies", color );
	allies = remove_heroes_from_array( allies );

	if ( !isdefined( origin ) )
		friendly_origin = level.player.origin;
	else
		friendly_origin = origin;

	allies = remove_without_classname( allies, classname );

	return getClosest( friendly_origin, allies );
}




promote_nearest_friendly( colorFrom, colorTo )
{
	for ( ;; )
	{
		friendly = get_closest_colored_friendly( colorFrom );
		if ( !isalive( friendly ) )
		{
			wait( 1 );
			continue;
		}

		friendly set_force_color( colorTo );
		return;
	}
}


instantly_promote_nearest_friendly( colorFrom, colorTo )
{
	for ( ;; )
	{
		friendly = get_closest_colored_friendly( colorFrom );
		if ( !isalive( friendly ) )
		{
			AssertEx( 0, "Instant promotion from " + colorFrom + " to " + colorTo + " failed!" );
			return;
		}

		friendly set_force_color( colorTo );
		return;
	}
}


instantly_promote_nearest_friendly_with_classname( colorFrom, colorTo, classname )
{
	for ( ;; )
	{
		friendly = get_closest_colored_friendly_with_classname( colorFrom, classname );
		if ( !isalive( friendly ) )
		{
			AssertEx( 0, "Instant promotion from " + colorFrom + " to " + colorTo + " failed!" );
			return;
		}

		friendly set_force_color( colorTo );
		return;
	}
}


promote_nearest_friendly_with_classname( colorFrom, colorTo, classname )
{
	for ( ;; )
	{
		friendly = get_closest_colored_friendly_with_classname( colorFrom, classname );
		if ( !isalive( friendly ) )
		{
			wait( 1 );
			continue;
		}

		friendly set_force_color( colorTo );
		return;
	}
}


riotshield_lock_orientation( yaw_angle )
{
	self OrientMode( "face angle", yaw_angle );
	self.lockOrientation = true;
}


riotshield_unlock_orientation()
{
	self.lockOrientation = false;
}


instantly_set_color_from_array_with_classname( array, color, classname )
{
	// the guy is removed from the array so the function can be run on the array again
	foundGuy = false;
	newArray = [];
	for ( i = 0; i < array.size; i++ )
	{
		guy = array[ i ];
		if ( foundGuy || !isSubstr( guy.classname, classname ) )
		{
			newArray[ newArray.size ] = guy;
			continue;
		}

		foundGuy = true;
		guy set_force_color( color );
	}
	return newArray;
}


instantly_set_color_from_array( array, color )
{
	// the guy is removed from the array so the function can be run on the array again
	foundGuy = false;
	newArray = [];
	for ( i = 0; i < array.size; i++ )
	{
		guy = array[ i ];
		if ( foundGuy )
		{
			newArray[ newArray.size ] = guy;
			continue;
		}

		foundGuy = true;
		guy set_force_color( color );
	}
	return newArray;
}


wait_for_script_noteworthy_trigger( msg )
{
	wait_for_trigger( msg, "script_noteworthy" );
}


wait_for_targetname_trigger( msg )
{
	wait_for_trigger( msg, "targetname" );
}


wait_for_flag_or_timeout( msg, timer )
{
	if ( flag( msg ) )
		return;

	ent = SpawnStruct();
	ent thread ent_waits_for_level_notify( msg );
	ent thread ent_times_out( timer );
	ent waittill( "done" );
}


wait_for_notify_or_timeout( msg, timer )
{
	ent = SpawnStruct();
	ent thread ent_waits_for_notify( self, msg );
	ent thread ent_times_out( timer );
	ent waittill( "done" );
}


wait_for_trigger_or_timeout( timer )
{
	ent = SpawnStruct();
	ent thread ent_waits_for_trigger( self );
	ent thread ent_times_out( timer );
	ent waittill( "done" );
}


wait_for_either_trigger( msg1, msg2 )
{
	ent = SpawnStruct();
	array = [];
	array = array_combine( array, GetEntArray( msg1, "targetname" ) );
	array = array_combine( array, GetEntArray( msg2, "targetname" ) );
	for ( i = 0; i < array.size; i++ )
	{
		ent thread ent_waits_for_trigger( array[ i ] );
	}

	ent waittill( "done" );
}



dronespawn_bodyonly( spawner )
{
	drone = maps\_spawner::spawner_dronespawn( spawner );
	Assert( IsDefined( drone ) );

	return drone;
}



dronespawn( spawner )
{
	if ( !isdefined( spawner ) )
		spawner = self;
	drone = maps\_spawner::spawner_dronespawn( spawner );
	Assert( IsDefined( drone ) );

	AssertEx( IsDefined( level.drone_spawn_func ), "You need to put maps\_drone_civilian::init(); OR maps\_drone_ai::init(); in your level script! Use the civilian version if your drone is a civilian and the _ai version if it's a friendly or enemy." );
	drone [[ level.drone_spawn_func ]]();

	drone.spawn_funcs = spawner.spawn_functions;
	drone thread maps\_spawner::run_spawn_functions();

	return drone;
}


makerealai( drone )
{
	return maps\_spawner::spawner_makerealai( drone );
}


get_trigger_flag()
{
	if ( IsDefined( self.script_flag ) )
	{
		return self.script_flag;
	}

	if ( IsDefined( self.script_noteworthy ) )
	{
		return self.script_noteworthy;
	}

	AssertEx( 0, "Flag trigger at " + self.origin + " has no script_flag set." );
}


set_default_pathenemy_settings()
{
	self.pathenemylookahead = 192;
	self.pathenemyfightdist = 192;
}


cqb_walk( on_or_off )// ( deprecated )
{
	if ( on_or_off == "on" )
	{
		self enable_cqbwalk();
	}
	else
	{
		Assert( on_or_off == "off" );
		self disable_cqbwalk();
	}
}


enable_cqbwalk( autoEnabled )
{
	if ( !isdefined( autoEnabled ) )
		self.cqbEnabled = true;

	self.cqbwalking = true;
	self.turnRate = 0.2;
	level thread animscripts\cqb::findCQBPointsOfInterest();

	/#
	self thread animscripts\cqb::CQBDebug();
	#/
}


disable_cqbwalk()
{
	self.cqbwalking = undefined;
	self.cqbEnabled = undefined;
	self.turnRate = 0.3;
	self.cqb_point_of_interest = undefined;

	/#
	self notify( "end_cqb_debug" );
	#/
}


cqb_aim( the_target )
{
	if ( !isdefined( the_target ) )
	{
		self.cqb_target = undefined;
	}
	else
	{
		self.cqb_target = the_target;

		if ( !isdefined( the_target.origin ) )
			AssertMsg( "target passed into cqb_aim does not have an origin!" );
	}
}



set_force_cover( val )
{
 	AssertEx( !isdefined( val ) || val == false || val == true, "invalid force cover set on guy" );
	AssertEx( IsAlive( self ), "Tried to set force cover on a dead guy" );
	if ( IsDefined( val ) && val )
		self.forceSuppression = true;
	else
		self.forceSuppression = undefined;
}


do_in_order( func1, param1, func2, param2 )
{
	if ( IsDefined( param1 ) )
		[[ func1 ]]( param1 );
	else
		[[ func1 ]]();
	if ( IsDefined( param2 ) )
		[[ func2 ]]( param2 );
	else
		[[ func2 ]]();
}

scrub()
{
	// sets an AI to default settings, ignoring the .script_ values on him.
	self maps\_spawner::scrub_guy();
}


send_notify( msg, optional_param )
{
	// functionalized so it can be function pointer'd
	if ( IsDefined( optional_param ) )
		self notify( msg, optional_param );
	else
		self notify( msg );
}



waittill_match_or_timeout( msg, match, timer )
{
	ent = SpawnStruct();
	ent endon( "complete" );
	ent delayThread( timer, ::send_notify, "complete" );

	self waittillmatch( msg, match );
}


deleteEnt( ent )
{
	// created so entities can be deleted using array_thread
	ent notify( "deleted" );
	ent Delete();
}



first_touch( ent )
{
	if ( !isdefined( self.touched ) )
		self.touched = [];

	AssertEx( IsDefined( ent ), "Ent is not defined!" );
	AssertEx( IsDefined( ent.unique_id ), "Ent has no unique_id" );

	if ( IsDefined( self.touched[ ent.unique_id ] ) )
		return false;

	self.touched[ ent.unique_id ] = true;
	return true;
}


getanim( anime )
{
	AssertEx( IsDefined( self.animname ), "Called getanim on a guy with no animname" );
	AssertEx( IsDefined( level.scr_anim[ self.animname ][ anime ] ), "Called getanim on an inexistent anim" );
	return level.scr_anim[ self.animname ][ anime ];
}


hasanim( anime )
{
	AssertEx( IsDefined( self.animname ), "Called getanim on a guy with no animname" );
	return IsDefined( level.scr_anim[ self.animname ][ anime ] );
}


getanim_from_animname( anime, animname )
{
	AssertEx( IsDefined( animname ), "Must supply an animname" );
	AssertEx( IsDefined( level.scr_anim[ animname ][ anime ] ), "Called getanim on an inexistent anim" );
	return level.scr_anim[ animname ][ anime ];
}


getanim_generic( anime )
{
	AssertEx( IsDefined( level.scr_anim[ "generic" ][ anime ] ), "Called getanim_generic on an inexistent anim" );
	return level.scr_anim[ "generic" ][ anime ];
}


add_hint_string( name, string, optionalFunc )
{
	if ( !isdefined( level.trigger_hint_string ) )
	{
		level.trigger_hint_string = [];
		level.trigger_hint_func = [];
	}

	AssertEx( IsDefined( name ), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint." );
	AssertEx( IsDefined( string ), "Set a string for the hint string. This is the string you want to appear when the trigger is hit." );
	AssertEx( !isdefined( level.trigger_hint_string[ name ] ), "Tried to redefine hint " + name );

	level.trigger_hint_string[ name ] = string;
	PreCacheString( string );
	if ( IsDefined( optionalFunc ) )
	{
		level.trigger_hint_func[ name ] = optionalFunc;
	}
}

show_hint( struct )
{
	AssertEx( IsDefined( struct.string ), "Need a localized string associated with the hint" );
	thread ShowHintPrint_struct( struct );
}

hide_hint( struct )
{
	struct.timeout = true;
}

fire_radius( origin, radius )
{
	/#
	if ( level.createFX_enabled )
		return;
	#/

	trigger = Spawn( "trigger_radius", origin, 0, radius, 48 );

	for ( ;; )
	{
		trigger waittill( "trigger", other );
		AssertEx( IsPlayer( other ), "Tried to burn a non player in a fire" );
		level.player DoDamage( 5, origin );
	}
}

clearThreatBias( group1, group2 )
{
	SetThreatBias( group1, group2, 0 );
	SetThreatBias( group2, group1, 0 );
}

scr_println( msg )
{
	// so println can be called from a function pointer
	PrintLn( msg );
}

// use in moderation!
ThrowGrenadeAtPlayerASAP()
{
	animscripts\combat_utility::ThrowGrenadeAtPlayerASAP_combat_utility();
}



array_combine_keys( array1, array2 )// mashes them in. array 2 will overwrite like keys, this works for what I'm using it for - Nate.
{
	if ( !array1.size )
		return array2;
	keys = GetArrayKeys( array2 );
	for ( i = 0; i < keys.size; i++ )
		array1[ keys[ i ] ] = array2[ keys[ i ] ];
	return array1;
}


set_ignoreSuppression( val )
{
	self.ignoreSuppression = val;
}


set_goalradius( radius )
{
	self.goalradius = radius;
}

try_forever_spawn()
{
	export = self.export;
	for ( ;; )
	{
		AssertEx( IsDefined( self ), "Spawner with export " + export + " was deleted." );
		guy = self DoSpawn();
		if ( spawn_failed( guy ) )
		{
			wait( 1 );
			continue;
		}
		return guy;
	}
}


set_allowdeath( val )
{
	self.allowdeath = val;
}


set_run_anim( anime, alwaysRunForward )
{
	AssertEx( IsDefined( anime ), "Tried to set run anim but didn't specify which animation to ues" );
	AssertEx( IsDefined( self.animname ), "Tried to set run anim on a guy that had no anim name" );
	AssertEx( IsDefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set run anim but the anim was not defined in the maps _anim file" );

	//this is good for slower run animations like patrol walks
	if ( IsDefined( alwaysRunForward ) )
		self.alwaysRunForward = alwaysRunForward;
	else
		self.alwaysRunForward = true;

	self disable_turnAnims();
	self.run_overrideanim = level.scr_anim[ self.animname ][ anime ];
	self.walk_overrideanim = self.run_overrideanim;
}


set_dog_walk_anim()
{
	AssertEx( self.type == "dog" );

	self.a.movement = "walk";
	self.disablearrivals = true;
	self.disableexits = true;
	self.script_nobark = 1;
}



set_combat_stand_animset( fire_anim, aim_straight, idle_anim, reload_anim )
{
	self animscripts\animset::init_animset_custom_stand( fire_anim, aim_straight, idle_anim, reload_anim );
}



set_move_animset( move_mode, move_anim, sprint_anim )
{
	AssertEx( IsDefined( anim.animsets.move[ move_mode ] ), "Default anim set is not defined" );

	// init with defaults
	animset = anim.animsets.move[ move_mode ];

	if ( IsArray( move_anim ) )
	{
		Assert( move_anim.size == 4 );

		animset[ "straight" ] = move_anim[ 0 ];

		animset[ "move_f" ] = move_anim[ 0 ];
		animset[ "move_l" ] = move_anim[ 1 ];
		animset[ "move_r" ] = move_anim[ 2 ];
		animset[ "move_b" ] = move_anim[ 3 ];
	}
	else
	{
		animset[ "straight" ] = move_anim;
		animset[ "move_f" ] = move_anim;
	}

	if ( IsDefined( sprint_anim ) )
		animset[ "sprint" ] = sprint_anim;

	self.customMoveAnimSet[ move_mode ] = animset;
}



set_generic_idle_anim( anime )
{
	AssertEx( IsDefined( anime ), "Tried to set generic idle but didn't specify which animation to ues" );
	AssertEx( IsDefined( level.scr_anim[ "generic" ][ anime ] ), "Tried to set generic run anim but the anim was not defined in the maps _anim file" );

	idleAnim = level.scr_anim[ "generic" ][ anime ];

	if ( IsArray( idleAnim ) )
		self.specialIdleAnim = idleAnim;
	else
		self.specialIdleAnim[ 0 ] = idleAnim;
}


set_idle_anim( anime )
{
	AssertEx( IsDefined( self.animname ), "No animname!" );
	AssertEx( IsDefined( anime ), "Tried to set idle anim but didn't specify which animation to ues" );
	AssertEx( IsDefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set generic run anim but the anim was not defined in the maps _anim file" );

	idleAnim = level.scr_anim[ self.animname ][ anime ];

	if ( IsArray( idleAnim ) )
		self.specialIdleAnim = idleAnim;
	else
		self.specialIdleAnim[ 0 ] = idleAnim;
}



clear_generic_idle_anim()
{
	self.specialIdleAnim = undefined;
	self notify( "stop_specialidle" );
}



set_generic_run_anim( anime, alwaysRunForward )
{
	AssertEx( IsDefined( anime ), "Tried to set generic run anim but didn't specify which animation to ues" );
	AssertEx( IsDefined( level.scr_anim[ "generic" ][ anime ] ), "Tried to set generic run anim but the anim was not defined in the maps _anim file" );

	self notify( "movemode" );

	//this is good for slower run animations like patrol walks
	if ( !isdefined( alwaysRunForward ) || alwaysRunForward )
		self.alwaysRunForward = true;
	else
		self.alwaysRunForward = undefined;

	self disable_turnAnims();
	self.run_overrideanim = level.scr_anim[ "generic" ][ anime ];
	self.walk_overrideanim = self.run_overrideanim;
}



set_generic_run_anim_array( anime, weights, alwaysRunForward )
{
	AssertEx( IsDefined( anime ), "Tried to set generic run anim but didn't specify which animation to ues" );
	AssertEx( IsDefined( level.scr_anim[ "generic" ][ anime ] ), "Tried to set generic run anim but the anim was not defined in the maps _anim file" );

	self notify( "movemode" );

	//this is good for slower run animations like patrol walks
	if ( !isdefined( alwaysRunForward ) || alwaysRunForward )
		self.alwaysRunForward = true;
	else
		self.alwaysRunForward = undefined;

	self disable_turnAnims();
	self.run_overrideanim = level.scr_anim[ "generic" ][ anime ];
	self.walk_overrideanim = self.run_overrideanim;

	if ( IsDefined( weights ) )
	{
		self.run_override_weights = level.scr_anim[ "generic" ][ weights ];
		self.walk_override_weights = self.run_override_weights;
	}
	else
	{
		self.run_override_weights = undefined;
		self.walk_override_weights = undefined;
	}
}


set_run_anim_array( anime, weights, alwaysRunForward )
{
	AssertEx( IsDefined( anime ), "Tried to set generic run anim but didn't specify which animation to ues" );
	AssertEx( IsDefined( self.animname ), "Tried to set run anim on a guy that had no anim name" );
	AssertEx( IsDefined( level.scr_anim[ self.animname ][ anime ] ), "Tried to set run anim but the anim was not defined in the maps _anim file" );
	self notify( "movemode" );

	//this is good for slower run animations like patrol walks
	if ( !isdefined( alwaysRunForward ) || alwaysRunForward )
		self.alwaysRunForward = true;
	else
		self.alwaysRunForward = undefined;

	self disable_turnAnims();
	self.run_overrideanim = level.scr_anim[ self.animname ][ anime ];
	self.walk_overrideanim = self.run_overrideanim;

	if ( IsDefined( weights ) )
	{
		self.run_override_weights = level.scr_anim[ self.animname ][ weights ];
		self.walk_override_weights = self.run_override_weights;
	}
	else
	{
		self.run_override_weights = undefined;
		self.walk_override_weights = undefined;
	}
}



clear_run_anim()
{
	self notify( "clear_run_anim" );
	self notify( "movemode" );

	if ( self.type == "dog" )
	{
		self.a.movement = "run";
		self.disablearrivals = false;
		self.disableexits = false;
		self.script_nobark = undefined;
		return;
	}

	if ( !isdefined( self.casual_killer ) )
		self enable_turnAnims();

	self.alwaysRunForward = undefined;
	self.run_overrideanim = undefined;
	self.walk_overrideanim = undefined;

	self.run_override_weights = undefined;
	self.walk_override_weights = undefined;
}

debugvar( msg, timer )
{
	SetDvarIfUninitialized( msg, timer );
	return GetDvarFloat( msg );
}

physicsjolt_proximity( outer_radius, inner_radius, force )
{
	// Usage: <entity > thread physicjolt_proximity( 400, 256, ( 0, 0, 0.1 ) );

	self endon( "death" );
	self endon( "stop_physicsjolt" );

	if ( !isdefined( outer_radius ) || !isdefined( inner_radius ) || !isdefined( force ) )
	{
		outer_radius = 400;
		inner_radius = 256;
		force = ( 0, 0, 0.075 );	// no direction on this one.
	}

	fade_distance = outer_radius * outer_radius;

	fade_speed = 3;
	base_force = force;

	while ( true )
	{
		wait 0.1;

		force = base_force;

		if ( self.code_classname == "script_vehicle" )
		{
			speed = self Vehicle_GetSpeed();
			if ( speed < fade_speed )
			{
				scale = speed / fade_speed;
				force = vector_multiply( base_force, scale );
			}
		}

		dist = DistanceSquared( self.origin, level.player.origin );
		scale = fade_distance / dist;
		if ( scale > 1 )
			scale = 1;
		force = vector_multiply( force, scale );
		total_force = force[ 0 ] + force[ 1 ] + force[ 2 ];

		if ( total_force > 0.025 )
			PhysicsJitter( self.origin, outer_radius, inner_radius, force[ 2 ], force[ 2 ] * 2.0 );
	}
}


set_goal_entity( ent )
{
	self SetGoalEntity( ent );
}


activate_trigger( name, type, triggeringEnt )
{
	if ( !isdefined( name ) )
		self activate_trigger_process( triggeringEnt );
	else
		array_thread( GetEntArray( name, type ), ::activate_trigger_process, triggeringEnt );
}

activate_trigger_process( triggeringEnt )
{
	AssertEx( !isdefined( self.trigger_off ), "Tried to activate trigger that is OFF( either from trigger_off or from flags set on it through shift - G menu" );

	if ( IsDefined( self.script_color_allies ) )
	{
		// so we don't run activate_color_trigger twice, we set this var
		self.activated_color_trigger = true;
		maps\_colors::activate_color_trigger( "allies" );
	}

	if ( IsDefined( self.script_color_axis ) )
	{
		// so we don't run activate_color_trigger twice, we set this var
		self.activated_color_trigger = true;
		maps\_colors::activate_color_trigger( "axis" );
	}

	self notify( "trigger", triggeringEnt );

	
}

  
self_delete()
{
	self Delete();
}

remove_noColor_from_array( ai )
{
	newarray = [];
	for ( i = 0; i < ai.size; i++ )
	{
		guy = ai[ i ];
		if ( guy has_color() )
			newarray[ newarray.size ] = guy;
	}

	return newarray;
}

has_color()
{
	// can lose color during the waittillframeend in left_color_node
	if ( self maps\_colors::get_team() == "axis" )
	{
		return IsDefined( self.script_color_axis ) || IsDefined( self.script_forcecolor );
	}

	return IsDefined( self.script_color_allies ) || IsDefined( self.script_forcecolor );
}

clear_colors()
{
	clear_team_colors( "axis" );
	clear_team_colors( "allies" );
}

clear_team_colors( team )
{
	level.currentColorForced[ team ][ "r" ] = undefined;
	level.currentColorForced[ team ][ "b" ] = undefined;
	level.currentColorForced[ team ][ "c" ] = undefined;
	level.currentColorForced[ team ][ "y" ] = undefined;
	level.currentColorForced[ team ][ "p" ] = undefined;
	level.currentColorForced[ team ][ "o" ] = undefined;
	level.currentColorForced[ team ][ "g" ] = undefined;
}



get_script_palette()
{
	rgb = [];
	rgb[ "r" ] = ( 1, 0, 0 );
	rgb[ "o" ] = ( 1, 0.5, 0 );
	rgb[ "y" ] = ( 1, 1, 0 );
	rgb[ "g" ] = ( 0, 1, 0 );
	rgb[ "c" ] = ( 0, 1, 1 );
	rgb[ "b" ] = ( 0, 0, 1 );
	rgb[ "p" ] = ( 1, 0, 1 );
	return rgb;
}

  
notify_delay( sNotifyString, fDelay )
{
	Assert( IsDefined( self ) );
	Assert( IsDefined( sNotifyString ) );
	Assert( IsDefined( fDelay ) );

	self endon( "death" );
	if ( fDelay > 0 )
		wait fDelay;
	if ( !isdefined( self ) )
		return;
	self notify( sNotifyString );
}

  
gun_remove()
{
	if ( IsAI( self ) )		// regular AI
		self animscripts\shared::placeWeaponOn( self.weapon, "none" );
	else					// Drone
		self Detach( GetWeaponModel( self.weapon ), "tag_weapon_right" );
}


  
gun_recall()
{
	if ( IsAI( self ) )		// regular AI
		self animscripts\shared::placeWeaponOn( self.weapon, "right" );
	else					// Drone
		self Attach( GetWeaponModel( self.weapon ), "tag_weapon_right" );
}


  
 place_weapon_on( weapon, location )
 {
	Assert( IsAI( self ) );

	if ( !AIHasWeapon( weapon ) )
		animscripts\init::initWeapon( weapon );

	animscripts\shared::placeWeaponOn( weapon, location );
 }


  
forceUseWeapon( newWeapon, targetSlot )
{
	Assert( IsDefined( newWeapon ) );
	Assert( newWeapon != "none" );
	Assert( IsDefined( targetSlot ) );
	AssertEx( ( targetSlot == "primary" ) || ( targetSlot == "secondary" ) || ( targetSlot == "sidearm" ), "Target slot is either primary, secondary or sidearm." );

	// Setup the weaponInfo if it wasn't already done
	if ( !animscripts\init::isWeaponInitialized( newWeapon ) )
		animscripts\init::initWeapon( newWeapon );

	// Figure out whether the current and target weapons are side arms, and which slot to go to
	hasWeapon = ( self.weapon != "none" );
	isCurrentSideArm = usingSidearm();
	isNewSideArm = ( targetSlot == "sidearm" );
	isNewSecondary = ( targetSlot == "secondary" );

	// If we have a weapon and we're not replacing it with one of the same "type", we need to hoslter it first
	if ( hasWeapon && ( isCurrentSideArm != isNewSideArm ) )
	{
		Assert( self.weapon != newWeapon );

		// Based on the current weapon - Hide side arms completely, and holster based on the new target otherwise
		if ( isCurrentSideArm )
			holsterTarget = "none";
		else if ( isNewSecondary )
			holsterTarget = "back";
		else
			holsterTarget = "chest";
		animscripts\shared::placeWeaponOn( self.weapon, holsterTarget );

		// Remember we switched out of that weapon
		self.lastWeapon = self.weapon;
	}
	else
	{
		// We didn't have a weapon before, or we're going to loose the one we had, so reset the lastWeapon.
		self.lastWeapon = newWeapon;
	}

	// Put the new weapon in hand
	animscripts\shared::placeWeaponOn( newWeapon, "right" );

	// Replace the equipped weapon slot of the same type with the new weapon ( could stay the same, too )
	// If the AI was using a secondary, replace that slot instead of primary
	if ( isNewSideArm )
		self.sideArm = newWeapon;
	else if ( isNewSecondary )
		self.secondaryweapon = newWeapon;
	else
		self.primaryweapon = newWeapon;

	// Set our current weapon to the new one
	self.weapon = newWeapon;
	self.bulletsinclip = WeaponClipSize( self.weapon );
	self notify( "weapon_switch_done" );
}


 

lerp_player_view_to_tag( player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc )
{
	lerp_player_view_to_tag_internal( player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, false );
}

 

lerp_player_view_to_tag_and_hit_geo( player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc )
{
	lerp_player_view_to_tag_internal( player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true );
}

  

lerp_player_view_to_position( origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo, player )
{
	player = get_player_from_self();

	linker = Spawn( "script_origin", ( 0, 0, 0 ) );
	linker.origin = player.origin;
	linker.angles = player GetPlayerAngles();

	if ( IsDefined( hit_geo ) && hit_geo )
	{
		player PlayerLinkTo( linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo );
	}
	else
	if ( IsDefined( right_arc ) )
	{
		player PlayerLinkTo( linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc );
	}
	else
	if ( IsDefined( fraction ) )
	{
		player PlayerLinkTo( linker, "", fraction );
	}
	else
	{
		player PlayerLinkTo( linker );
	}

	linker MoveTo( origin, lerptime, lerptime * 0.25 );
	linker RotateTo( angles, lerptime, lerptime * 0.25 );
	wait( lerptime );
	linker Delete();
}


 
lerp_player_view_to_tag_oldstyle( player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc )
{
	lerp_player_view_to_tag_oldstyle_internal( player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, false );
}

  

lerp_player_view_to_position_oldstyle( origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo )
{
	player = get_player_from_self();

	linker = Spawn( "script_origin", ( 0, 0, 0 ) );
	linker.origin = player get_player_feet_from_view();
	linker.angles = player GetPlayerAngles();

	if ( IsDefined( hit_geo ) )
	{
		player PlayerLinkToDelta( linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo );
	}
	else
	if ( IsDefined( right_arc ) )
	{
		player PlayerLinkToDelta( linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc );
	}
	else
	if ( IsDefined( fraction ) )
	{
		player PlayerLinkToDelta( linker, "", fraction );
	}
	else
	{
		player PlayerLinkToDelta( linker );
	}

	linker MoveTo( origin, lerptime, lerptime * 0.25 );
	linker RotateTo( angles, lerptime, lerptime * 0.25 );
	wait( lerptime );
	linker Delete();
}

// can't make a function pointer out of a code command
timer( time )
{
	wait( time );
}


  

player_moves( dist )
{
	org = level.player.origin;
	for ( ;; )
	{
		if ( Distance( org, level.player.origin ) > dist )
			break;
		wait( 0.05 );
	}
}


  

waittill_either_function( func1, parm1, func2, parm2 )
{
	ent = SpawnStruct();
	thread waittill_either_function_internal( ent, func1, parm1 );
	thread waittill_either_function_internal( ent, func2, parm2 );
	ent waittill( "done" );
}


waittill_msg( msg )
{
	self waittill( msg );
}


  
display_hint( hint, parm1, parm2, parm3 )
{
	player = get_player_from_self();

	// hint triggers have an optional function they can boolean off of to determine if the hint will occur
	// such as not doing the NVG hint if the player is using NVGs already
	if ( IsDefined( level.trigger_hint_func[ hint ] ) )
	{
		if ( player [[ level.trigger_hint_func[ hint ] ]]() )
			return;

		player thread HintPrint( level.trigger_hint_string[ hint ], level.trigger_hint_func[ hint ], parm1, parm2, parm3, 30 );
	}
	else
	{
		player thread HintPrint( level.trigger_hint_string[ hint ], undefined, undefined, undefined, undefined, 30 );
	}
}

 
display_hint_timeout( hint, timeout, parm1, parm2, parm3 )
{
	player = get_player_from_self();


	AssertEx( IsDefined( level.trigger_hint_func[ hint ] ), "Can't have a hint with a timeout if is has no break function, because hints without break functions display for a set period of time." );

	// hint triggers have an optional function they can boolean off of to determine if the hint will occur
	// such as not doing the NVG hint if the player is using NVGs already
	if ( player [[ level.trigger_hint_func[ hint ] ]]() )
		return;

	player thread HintPrint( level.trigger_hint_string[ hint ], level.trigger_hint_func[ hint ], parm1, parm2, parm3, timeout );
}


getGenericAnim( anime )
{
	AssertEx( IsDefined( level.scr_anim[ "generic" ][ anime ] ), "Generic anim " + anime + " was not defined in your _anim file." );
	return level.scr_anim[ "generic" ][ anime ];
}

 
enable_careful()
{
	AssertEx( IsAI( self ), "Tried to make an ai careful but it wasn't called on an AI" );
	self.script_careful = true;
}

 
disable_careful()
{
	AssertEx( IsAI( self ), "Tried to unmake an ai careful but it wasn't called on an AI" );
	self.script_careful = false;
	self notify( "stop_being_careful" );
}

 
enable_sprint()
{
	AssertEx( IsAI( self ), "Tried to make an ai sprint but it wasn't called on an AI" );
	self.sprint = true;
}

 
disable_sprint()
{
	AssertEx( IsAI( self ), "Tried to unmake an ai sprint but it wasn't called on an AI" );
	self.sprint = undefined;
}


disable_bulletwhizbyreaction()
{
	self.disableBulletWhizbyReaction = true;
}


enable_bulletwhizbyreaction()
{
	self.disableBulletWhizbyReaction = undefined;
}

clear_dvar( msg )
{
	SetDvar( msg, "" );
}


mission( name )
{
	return level.script == name;
}


set_fixednode_true()
{
	self.fixednode = true;
}


set_fixednode_false()
{
	self.fixednode = false;
}



spawn_ai( bForceSpawn )
{
	if ( IsDefined( self.script_delay_spawn ) )
	{
		self endon( "death" );
		wait( self.script_delay_spawn );
	}
	spawnedGuy = undefined;

	dontShareEnemyInfo = ( IsDefined( self.script_stealth ) && flag( "_stealth_enabled" ) && !flag( "_stealth_spotted" ) );

	if ( ( IsDefined( self.script_forcespawn ) ) || ( IsDefined( bForceSpawn ) ) )
	{
		if ( !isdefined( self.script_drone ) )
			spawnedGuy = self StalingradSpawn( dontShareEnemyInfo );
		else
			spawnedGuy = dronespawn( self );
	}

	else
	{
		if ( !isdefined( self.script_drone ) )
			spawnedGuy = self DoSpawn( dontShareEnemyInfo );
		else
			spawnedGuy = dronespawn( self );
	}

	if ( !isdefined( self.script_drone ) )
		spawn_failed( spawnedGuy );
	//this assert should still be here - but the functions calling this (pyramid spawner for example ) don't care if
	//the guy is actually spawned or not...seems to be more of an issue with pyramid spawner ( why is trying to spawn guys )
	//and not caring about the consiquences...tracked it down to this function being called twice on the same spawner in the same frame
	//in bog B, maybe further evaluation should be taken of pyramid spawner and why it's trying to do that - but for now - just commenting out
	//the assert and assuming we don't care why we can't spawn 2 guys in the same frame...  -MO
	//assert( IsDefined( spawnedGuy ) );

	return spawnedGuy;
}

 
function_stack( func, param1, param2, param3, param4, param5 )
{
	//self might die - but if we endon( "death" ) this function will return without a bool, which is bad.
	//self endon( "death" );

	localentity = SpawnStruct();
	localentity thread function_stack_proc( self, func, param1, param2, param3, param4, param5 );

	return self function_stack_wait_finish( localentity );
}


function_stack_timeout( timeout, func, param1, param2, param3, param4, param5 )
{
	//self might die - but if we endon( "death" ) this function will return without a bool, which is bad.
	//self endon( "death" );

	localentity = SpawnStruct();
	localentity thread function_stack_proc( self, func, param1, param2, param3, param4, param5 );

	if ( IsDefined( localentity.function_stack_func_begun ) || ( localentity waittill_any_timeout( timeout, "function_stack_func_begun" ) != "timeout" ) )
	{
		return self function_stack_wait_finish( localentity );
	}
	else
	{
		localentity notify( "death" );
		return false;
	}
}


function_stack_clear()
{
	newstack = [];
	if ( IsDefined( self.function_stack[ 0 ] ) && IsDefined( self.function_stack[ 0 ].function_stack_func_begun ) )
		newstack[ 0 ] = self.function_stack[ 0 ];

	//clear the stack and stop further processes
	self.function_stack = undefined;
	self notify( "clear_function_stack" );

	//the notify ends a function in the stack process waiting it's turn...it checks to 
	//see if there is a function_stack on self to either run the function or just quit
	//in rare cases if you clear the stack and start piling stuff onto a new one, you'll
	//create the new stack before the process has a chance to check if the stack is undefined
	//and then all your functions run at once instead of being actually cleared...this 
	//waittillframeend makes sure that doesn't happen
	waittillframeend;

	if ( !newstack.size )
		return;

	if ( !newstack[ 0 ].function_stack_func_begun )
		return;

	self.function_stack = newstack;
}



geo_off()
{
	if ( IsDefined( self.geo_off ) )
		return;

	self.realorigin = self GetOrigin();
	self MoveTo( self.realorigin + ( 0, 0, -10000 ), .2 );

	self.geo_off = true;
}


geo_on()
{
	if ( !isDefined( self.geo_off ) )
		return;

	self MoveTo( self.realorigin, .2 );
	self waittill( "movedone" );
	self.geo_off = undefined;
}


disable_exits()
{
	self.disableexits = true;
}


enable_exits()
{
	self.disableexits = undefined;
}


disable_turnAnims()
{
	self.noTurnAnims = true;
}


enable_turnAnims()
{
	self.noTurnAnims = undefined;
}


disable_arrivals()
{
	self.disablearrivals = true;
}


enable_arrivals()
{
	self endon( "death" );
	// wait until after anim_reach has turned arrivals off
	waittillframeend;
	self.disablearrivals = undefined;
}

 
set_blur( magnitude, time )
{
	SetBlur( magnitude, time );
}

 
set_goal_radius( radius )
{
	self.goalradius = radius;
}

 
set_goal_node( node )
{
	self.last_set_goalnode 	 = node;
	self.last_set_goalpos 	 = undefined;
	self.last_set_goalent 	 = undefined;

	self SetGoalNode( node );
}

 
set_goal_node_targetname( targetname )
{
	Assert( IsDefined( targetname ) );
	node = GetNode( targetname, "targetname" );
	Assert( IsDefined( node ) );

	self set_goal_node( node );
}

 
set_goal_pos( origin )
{
	self.last_set_goalnode 	 = undefined;
	self.last_set_goalpos 	 = origin;
	self.last_set_goalent 	 = undefined;

	self SetGoalPos( origin );
}


set_goal_ent( target )
{
	set_goal_pos( target.origin );
	self.last_set_goalent 	 = target;
}


objective_complete( obj )
{
	Objective_State( obj, "done" );
	level notify( "objective_complete" + obj );
}



handsignal( xanim, waitAnimDone, ender, waiter )
{
	returnImmediate = true;
	if ( IsDefined( waitAnimDone ) )
		returnImmediate = !waitAnimDone;

	if ( IsDefined( ender ) )
		level endon( ender );

	if ( IsDefined( waiter ) )
		level waittill( waiter );

	animName = "signal_" + xanim;

	if ( self.a.pose == "crouch" )
		animName = animName + "_crouch";
	else if ( self.script == "cover_right" )
		animName = animName + "_coverR";
	else if ( self isCQBWalking() )
		animName = animName + "_cqb";

	if ( returnImmediate )
		self SetAnimRestart( getGenericAnim( animName ), 1, 0, 1.1 );
	else
		self maps\_anim::anim_generic( self, animName );
}


get_guy_with_script_noteworthy_from_spawner( script_noteworthy )
{
	spawner = GetEntArray( script_noteworthy, "script_noteworthy" );
	AssertEx( spawner.size == 1, "Tried to get guy from spawner but there were zero or multiple spawners" );
	guys = array_spawn( spawner );
	return guys[ 0 ];
}


get_guy_with_targetname_from_spawner( targetname )
{
	spawner = GetEntArray( targetname, "targetname" );
	AssertEx( spawner.size == 1, "Tried to get guy from spawner but there were zero or multiple spawners" );
	guys = array_spawn( spawner );
	return guys[ 0 ];
}


get_guys_with_targetname_from_spawner( targetname )
{
	spawners = GetEntArray( targetname, "targetname" );
	AssertEx( spawners.size > 0, "Tried to get guy from spawner but there were zero spawners" );
	return array_spawn( spawners );
}


array_spawn( spawners, bForceSpawn )
{
	guys = [];
	foreach ( spawner in spawners )
	{
		spawner.count = 1;

		if ( GetSubStr( spawner.classname, 7, 10 ) == "veh" )
		{
			guy = spawner spawn_vehicle();

			/#
			if ( IsDefined( spawner.export ) )
				AssertEx( IsAlive( guy ), "Vehicle with export " + spawner.export + " failed to spawn." );
			else
				AssertEx( IsAlive( guy ), "Vehicle at " + spawner.origin + " failed to spawn." );
			#/
			if ( IsDefined( guy.target ) )
				guy thread maps\_vehicle::gopath();
			guys[ guys.size ] = guy;
		}
		else
		{
			guy = spawner spawn_ai( bForceSpawn );

			AssertEx( IsAlive( guy ), "Guy with export " + spawner.export + " failed to spawn." );
			guys[ guys.size ] = guy;
		}
	}

	AssertEx( guys.size == spawners.size, "Didnt spawn correct number of guys" );

	return guys;
}


array_spawn_targetname( targetname )
{
	spawners = GetEntArray( targetname, "targetname" );
	AssertEx( spawners.size, "Tried to spawn spawners with targetname " + targetname + " but there are no spawners" );
	return array_spawn( spawners );
}


array_spawn_noteworthy( noteworthy )
{
	spawners = GetEntArray( noteworthy, "script_noteworthy" );
	AssertEx( spawners.size, "Tried to spawn spawners with targetname " + noteworthy + " but there are no spawners" );
	return array_spawn( spawners );
}



spawn_script_noteworthy( script_noteworthy, bForceSpawn )
{
	spawner = GetEnt( script_noteworthy, "script_noteworthy" );
	AssertEx( IsDefined( spawner ), "Spawner with script_noteworthy " + script_noteworthy + " does not exist." );

	guy = spawner spawn_ai( bForceSpawn );
	return guy;
}


spawn_targetname( targetname, bForceSpawn )
{
	spawner = GetEnt( targetname, "targetname" );
	AssertEx( IsDefined( spawner ), "Spawner with targetname " + targetname + " does not exist." );

	guy = spawner spawn_ai( bForceSpawn );
	return guy;
}


add_dialogue_line( name, msg, name_color )
{
	if ( GetDvarInt( "loc_warnings", 0 ) )
		return;// I'm not localizing your damn temp dialog lines - Nate.

	if ( !isdefined( level.dialogue_huds ) )
	{
		level.dialogue_huds = [];
	}

	for ( index = 0; ; index++ )
	{
		if ( !isdefined( level.dialogue_huds[ index ] ) )
			break;
	}
	color = "^3";

	if ( IsDefined( name_color ) )
	{
		switch( name_color )
		{
			case "r":
			case "red":
				color = "^1";
				break;
			case "g":
			case "green":
				color = "^2";
				break;
			case "y":
			case "yellow":
				color = "^3";
				break;
			case "b":
			case "blue":
				color = "^4";
				break;
			case "c":
			case "cyan":
				color = "^5";
				break;
			case "p":
			case "purple":
				color = "^6";
				break;
			case "w":
			case "white":
				color = "^7";
				break;
			case "bl":
			case "black":
				color = "^8";
				break;
		}
	}

	level.dialogue_huds[ index ] = true;

	hudelem = maps\_hud_util::createFontString( "default", 1.5 );
	hudelem.location = 0;
	hudelem.alignX = "left";
	hudelem.alignY = "top";
	hudelem.foreground = 1;
	hudelem.sort = 20;

	hudelem.alpha = 0;
	hudelem FadeOverTime( 0.5 );
	hudelem.alpha = 1;
	hudelem.x = 40;
	hudelem.y = 260 + index * 18;
	hudelem.label = " " + color + "< " + name + " > ^7" + msg;
	hudelem.color = ( 1, 1, 1 );

	wait( 2 );
	timer = 2 * 20;
	hudelem FadeOverTime( 6 );
	hudelem.alpha = 0;

	for ( i = 0; i < timer; i++ )
	{
		hudelem.color = ( 1, 1, 0 / ( timer - i ) );
		wait( 0.05 );
	}
	wait( 4 );

	hudelem Destroy();

	level.dialogue_huds[ index ] = undefined;
}


destructible_disable_explosion()
{
	self common_scripts\_destructible::disable_explosion();
}


destructible_force_explosion()
{
	self common_scripts\_destructible::force_explosion();
}

set_grenadeammo( count )
{
	self.grenadeammo = count;
}


get_player_feet_from_view()
{
	Assert( IsPlayer( self ) );

	tagorigin = self.origin;
	upvec = AnglesToUp( self GetPlayerAngles() );
	height = self GetPlayerViewHeight();

	player_eye = tagorigin + ( 0, 0, height );
	player_eye_fake = tagorigin + vector_multiply( upvec, height );

	diff_vec = player_eye - player_eye_fake;

	fake_origin = tagorigin + diff_vec;
	return fake_origin;
}



set_baseaccuracy( val )
{
	self.baseaccuracy = val;
}


set_console_status()
{
	if ( !isdefined( level.Console ) )
		level.Console = GetDvar( "consoleGame" ) == "true";
	else
		AssertEx( level.Console == ( GetDvar( "consoleGame" ) == "true" ), "Level.console got set incorrectly." );

	if ( !isdefined( level.xenon ) )
		level.xenon = GetDvar( "xenonGame" ) == "true";
	else
		AssertEx( level.xenon == ( GetDvar( "xenonGame" ) == "true" ), "Level.xenon got set incorrectly." );

	if ( !isdefined( level.ps3 ) )
		level.ps3 = GetDvar( "ps3Game" ) == "true";
	else
		AssertEx( level.ps3 == ( GetDvar( "ps3Game" ) == "true" ), "Level.ps3 got set incorrectly." );
}


autosave_now( suppress_print )
{
	return maps\_autosave::_autosave_game_now( suppress_print );
}


autosave_now_silent()
{
	return maps\_autosave::_autosave_game_now( true );
}


set_generic_deathanim( deathanim )
{
	self.deathanim = getGenericAnim( deathanim );
}


set_deathanim( deathanim )
{
	self.deathanim = getanim( deathanim );
}


clear_deathanim()
{
	self.deathanim = undefined;
}


hunted_style_door_open( soundalias )
{
	wait( 1.75 );

	if ( IsDefined( soundalias ) )
		self PlaySound( soundalias );
	else
		self PlaySound( "door_wood_slow_open" );

	self RotateTo( self.angles + ( 0, 70, 0 ), 2, .5, 0 );
	self ConnectPaths();
	self waittill( "rotatedone" );
	self RotateTo( self.angles + ( 0, 40, 0 ), 2, 0, 2 );
}


palm_style_door_open( soundalias )
{
	wait( 1.35 );

	if ( IsDefined( soundalias ) )
		self PlaySound( soundalias );
	else
		self PlaySound( "door_wood_slow_open" );

	self RotateTo( self.angles + ( 0, 70, 0 ), 2, .5, 0 );
	self ConnectPaths();
	self waittill( "rotatedone" );
	self RotateTo( self.angles + ( 0, 40, 0 ), 2, 0, 2 );
}





lerp_fov_overtime( time, destfov )
{
	basefov = GetDvarFloat( "cg_fov" );
	incs = Int( time / .05 );

	incfov = ( destfov - basefov ) / incs ;
	currentfov = basefov;
	for ( i = 0; i < incs; i++ )
	{
		currentfov += incfov;
		SetSavedDvar( "cg_fov", currentfov );
		wait .05;
	}
	//fix up the little bit of rounding error. not that it matters much .002, heh
	SetSavedDvar( "cg_fov", destfov );

}


lerp_fovscale_overtime( time, destfovscale )
{
	basefov = GetDvarFloat( "cg_fovscale" );
	incs = Int( time / .05 );

	incfov = ( destfovscale - basefov ) / incs ;
	currentfov = basefov;
	for ( i = 0; i < incs; i++ )
	{
		currentfov += incfov;
		SetSavedDvar( "cg_fovscale", currentfov );
		wait .05;
	}

	SetSavedDvar( "cg_fovscale", destfovscale );
}



putGunAway()
{
	animscripts\shared::placeWeaponOn( self.weapon, "none" );
	self.weapon = "none";
}


apply_fog()
{
	maps\_load::set_fog_progress( 0 );
}


apply_end_fog()
{
	maps\_load::set_fog_progress( 1 );
}



anim_stopanimscripted()
{
	self StopAnimScripted();
	self notify( "stop_loop" );// default ender.
	self notify( "single anim", "end" );
	self notify( "looping anim", "end" );
}


disable_pain()
{
	AssertEx( IsAI( self ), "Tried to disable pain on a non ai" );
	self.a.disablePain = true;
	self.allowPain = false;
}


enable_pain()
{
	AssertEx( IsAI( self ), "Tried to enable pain on a non ai" );
	self.a.disablePain = false;
	self.allowPain = true;
}


_delete()
{
	self Delete();
}


_kill()
{
	self Kill();
}


kill_wrapper()
{
	// Only do special checking in special ops for now, and only on players.
	// Players are put into invulnerable states that are unpredictable in co-op Special Ops which can result in 
	// attempts to call kill() directly to assert. If the special op has already terminated just exit out. If the 
	// player is downed force invulnerability off so the kill will be able to succeed.
	if ( isplayer( self ) && is_coop() )
	{
		if ( flag( "special_op_terminated" ) )
		{
			return false;
		}

		if ( is_player_down( self ) )
		{
			self disableinvulnerability();
		}
	}

	self Kill();
	return true;
}


_setentitytarget( target )
{
	self SetEntityTarget( target );
}


_ClearEntityTarget()
{
	self ClearEntityTarget();
}


_unlink()
{
	self Unlink();
}



disable_oneshotfx_with_noteworthy( noteworthy )
{
	AssertEx( IsDefined( level._global_fx_ents[ noteworthy ] ), "No _global_fx ents have noteworthy " + noteworthy );
	keys = GetArrayKeys( level._global_fx_ents[ noteworthy ] );
	for ( i = 0; i < keys.size; i++ )
	{
		level._global_fx_ents[ noteworthy ][ keys[ i ] ].looper Delete();
		level._global_fx_ents[ noteworthy ][ keys[ i ] ] = undefined;
	}
}



_setLightIntensity( val )
{
	self SetLightIntensity( val );
}



_linkto( targ, tag, org, angles )
{
	if ( IsDefined( angles ) )
	{
		self LinkTo( targ, tag, org, angles );
		return;
	}
	if ( IsDefined( org ) )
	{
		self LinkTo( targ, tag, org );
		return;
	}
	if ( IsDefined( tag ) )
	{
		self LinkTo( targ, tag );
		return;
	}
	self LinkTo( targ );
}


array_wait( array, msg, timeout )
{
	keys = GetArrayKeys( array );
	structs = [];
	for ( i = 0; i < keys.size; i++ )
	{
		key = keys[ i ];

	}

	for ( i = 0; i < keys.size; i++ )
	{
		key = keys[ i ];
		structs[ key ] = SpawnStruct();
		structs[ key ]._array_wait = true;

		structs[ key ] thread array_waitlogic1( array[ key ], msg, timeout );
	}

	for ( i = 0; i < keys.size; i++ )
	{
		key = keys[ i ];
		if ( IsDefined( array[ key ] ) && structs[ key ]._array_wait )
			structs[ key ] waittill( "_array_wait" );
	}
}


die()
{
	self Kill( ( 0, 0, 0 ) );
}


getmodel( str )
{
	AssertEx( IsDefined( level.scr_model[ str ] ), "Tried to getmodel on model " + str + " but level.scr_model[ " + str + " was not defined." );
	return level.scr_model[ str ];
}


isADS()
{
	Assert( IsPlayer( self ) );
	return( self PlayerAds() > 0.5 );
}



enable_auto_adjust_threatbias()
{
	// this needs to be made to work again, broke when coop difficulty was done
	// (sorry)

	level.auto_adjust_threatbias = true;

	if ( level.gameskill >= 2 )
	{
		// hard and vet use locked values
		level.player.threatbias = Int( maps\_gameskill::get_locked_difficulty_val_player( "threatbias", 1 ) );
		return;
	}

	// set the threatbias based on the current difficulty frac
	level.auto_adjust_difficulty_frac = GetDvarInt( "autodifficulty_frac" );
	current_frac = level.auto_adjust_difficulty_frac * 0.01;
	level.player.threatbias = Int( maps\_gameskill::get_blended_difficulty( "threatbias", current_frac ) );
}



disable_auto_adjust_threatbias()
{
	level.auto_adjust_threatbias = false;
}


disable_replace_on_death()
{
	self.replace_on_death = undefined;
	self notify( "_disable_reinforcement" );
}


waittill_player_lookat( dot, timer, dot_only, timeout, ignore_ent, player )
{
	if ( !isdefined( player ) )
		player = level.player;
		
	timeoutEnt = SpawnStruct();
	if ( IsDefined( timeout ) )
		timeoutEnt thread notify_delay( "timeout", timeout );
	timeoutEnt endon( "timeout" );

	if ( !isdefined( dot ) )
		dot = 0.92;

	if ( !isdefined( timer ) )
		timer = 0;

	base_time = Int( timer * 20 );
	count = base_time;
	self endon( "death" );
	ai_guy = IsAI( self );
	org = undefined;
	for ( ;; )
	{
		if ( ai_guy )
			org = self GetEye();
		else
			org = self.origin;

		if ( player player_looking_at( org, dot, dot_only, ignore_ent ) )
		{
			count--;
			if ( count <= 0 )
				return true;
		}
		else
		{
			count = base_time;
		}
		wait( 0.05 );
	}
}


waittill_player_lookat_for_time( timer, dot, dot_only, ignore_ent )
{
	AssertEx( IsDefined( timer ), "Tried to do waittill_player_lookat_for_time with no time parm." );
	waittill_player_lookat( dot, timer, dot_only, undefined, ignore_ent );
}


player_looking_at( start, dot, dot_only, ignore_ent )
{
	if ( !isdefined( dot ) )
		dot = 0.8;
	player = get_player_from_self();

	end = player GetEye();

	angles = VectorToAngles( start - end );
	forward = AnglesToForward( angles );
	player_angles = player GetPlayerAngles();
	player_forward = AnglesToForward( player_angles );

	new_dot = VectorDot( forward, player_forward );
	if ( new_dot < dot )
	{
		return false;
	}

	if ( IsDefined( dot_only ) )
	{
		AssertEx( dot_only, "dot_only must be true or undefined" );
		return true;
	}

	trace = BulletTrace( start, end, false, ignore_ent );
	return trace[ "fraction" ] == 1;
}



players_looking_at( org, dot, dot_only, ignore_ent )
{
	for ( i = 0; i < level.players.size; i++ )
	{
		if ( !level.players[ i ] player_looking_at( org, dot, dot_only, ignore_ent ) )
			return false;
	}
	return true;
}


either_player_looking_at( org, dot, dot_only, ignore_ent )
{
	for ( i = 0; i < level.players.size; i++ )
	{
		if ( level.players[ i ] player_looking_at( org, dot, dot_only, ignore_ent ) )
			return true;
	}
	return false;
}



player_can_see_ai( ai )
{
	feetOrigin = ai.origin;
	if ( player_can_see_origin( feetOrigin ) )
		return true;

	midOrigin = ai GetTagOrigin( "J_SpineLower" );
	if ( player_can_see_origin( midOrigin ) )
		return true;

	eyeOrigin = ai GetEye();
	if ( player_can_see_origin( eyeOrigin ) )
		return true;

	return false;
}

player_can_see_origin( origin )
{
	// if not in FOV, return false
	if ( !level.player animscripts\battlechatter::pointInFov( origin ) )
	{
		return false;
	}

	// if in FOV but sight trace fails, return false
	if ( !SightTracePassed( level.player GetEye(), origin, true, level.player ) )
	{
		return false;
	}

	// if in FOV with successful trace, return true
	return true;
}


players_within_distance( fDist, org )
{
	fDistSquared = fDist * fDist;
	for ( i = 0; i < level.players.size; i++ )
	{
		if ( DistanceSquared( org, level.players[ i ].origin ) < fDistSquared )
			return true;
	}
	return false;
}

AI_delete_when_out_of_sight( aAI_to_delete, fDist )
{
	if ( !isdefined( aAI_to_delete ) )
		return;

	off_screen_dot = 0.75;
	if ( IsSplitScreen() )
	{
		off_screen_dot = 0.65;
	}

	while ( aAI_to_delete.size > 0 )
	{
		wait( 1 );

		for ( i = 0; i < aAI_to_delete.size; i++ )
		{
						
			if ( ( !isdefined( aAI_to_delete[ i ] ) ) || ( !isalive( aAI_to_delete[ i ] ) ) )
			{
				aAI_to_delete = array_remove( aAI_to_delete, aAI_to_delete[ i ] );
				continue;
			}
			
			if ( players_within_distance( fDist, aAI_to_delete[ i ].origin ) )
				continue;
			if ( either_player_looking_at( aAI_to_delete[ i ].origin + ( 0, 0, 48 ), off_screen_dot, true ) )
				continue;
			
			if ( IsDefined( aAI_to_delete[ i ].magic_bullet_shield ) )
				aAI_to_delete[ i ] stop_magic_bullet_shield();
			aAI_to_delete[ i ] Delete();
			aAI_to_delete = array_remove( aAI_to_delete, aAI_to_delete[ i ] );
		}
	}
}

add_wait( func, parm1, parm2, parm3 )
{
	/#
	thread add_wait_asserter();
	#/

	ent = SpawnStruct();

	ent.caller = self;
	ent.func = func;
	ent.parms = [];
	if ( IsDefined( parm1 ) )
	{
		ent.parms[ ent.parms.size ] = parm1;
	}
	if ( IsDefined( parm2 ) )
	{
		ent.parms[ ent.parms.size ] = parm2;
	}
	if ( IsDefined( parm3 ) )
	{
		ent.parms[ ent.parms.size ] = parm3;
	}

	level.wait_any_func_array[ level.wait_any_func_array.size ] = ent;
}

add_abort( func, parm1, parm2, parm3 )
{
	/#
	thread add_wait_asserter();
	#/

	ent = SpawnStruct();

	ent.caller = self;
	ent.func = func;
	ent.parms = [];
	if ( IsDefined( parm1 ) )
	{
		ent.parms[ ent.parms.size ] = parm1;
	}
	if ( IsDefined( parm2 ) )
	{
		ent.parms[ ent.parms.size ] = parm2;
	}
	if ( IsDefined( parm3 ) )
	{
		ent.parms[ ent.parms.size ] = parm3;
	}

	level.abort_wait_any_func_array[ level.abort_wait_any_func_array.size ] = ent;
}


add_func( func, parm1, parm2, parm3, parm4, parm5 )
{
	/#
	thread add_wait_asserter();
	#/

	ent = SpawnStruct();

	ent.caller = self;
	ent.func = func;
	ent.parms = [];
	if ( IsDefined( parm1 ) )
	{
		ent.parms[ ent.parms.size ] = parm1;
	}
	if ( IsDefined( parm2 ) )
	{
		ent.parms[ ent.parms.size ] = parm2;
	}
	if ( IsDefined( parm3 ) )
	{
		ent.parms[ ent.parms.size ] = parm3;
	}
	if ( IsDefined( parm4 ) )
	{
		ent.parms[ ent.parms.size ] = parm4;
	}
	if ( IsDefined( parm5 ) )
	{
		ent.parms[ ent.parms.size ] = parm5;
	}

	level.run_func_after_wait_array[ level.run_func_after_wait_array.size ] = ent;
}


add_call( func, parm1, parm2, parm3, parm4, parm5 )
{
	/#
	thread add_wait_asserter();
	#/

	ent = SpawnStruct();

	ent.caller = self;
	ent.func = func;
	ent.parms = [];
	if ( IsDefined( parm1 ) )
	{
		ent.parms[ ent.parms.size ] = parm1;
	}
	if ( IsDefined( parm2 ) )
	{
		ent.parms[ ent.parms.size ] = parm2;
	}
	if ( IsDefined( parm3 ) )
	{
		ent.parms[ ent.parms.size ] = parm3;
	}
	if ( IsDefined( parm4 ) )
	{
		ent.parms[ ent.parms.size ] = parm4;
	}
	if ( IsDefined( parm5 ) )
	{
		ent.parms[ ent.parms.size ] = parm5;
	}

	level.run_call_after_wait_array[ level.run_call_after_wait_array.size ] = ent;
}


add_noself_call( func, parm1, parm2, parm3, parm4, parm5 )
{
	/#
	thread add_wait_asserter();
	#/

	ent = SpawnStruct();

	ent.func = func;
	ent.parms = [];
	if ( IsDefined( parm1 ) )
	{
		ent.parms[ ent.parms.size ] = parm1;
	}
	if ( IsDefined( parm2 ) )
	{
		ent.parms[ ent.parms.size ] = parm2;
	}
	if ( IsDefined( parm3 ) )
	{
		ent.parms[ ent.parms.size ] = parm3;
	}
	if ( IsDefined( parm4 ) )
	{
		ent.parms[ ent.parms.size ] = parm4;
	}
	if ( IsDefined( parm5 ) )
	{
		ent.parms[ ent.parms.size ] = parm5;
	}

	level.run_noself_call_after_wait_array[ level.run_noself_call_after_wait_array.size ] = ent;
}


add_endon( name )
{
	/#
	thread add_wait_asserter();
	#/

	ent = SpawnStruct();
	ent.caller = self;
	ent.ender = name;

	level.do_wait_endons_array[ level.do_wait_endons_array.size ] = ent;
}


do_wait_any()
{
	AssertEx( IsDefined( level.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
	AssertEx( level.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first" );
	do_wait( level.wait_any_func_array.size - 1 );
}


do_wait( count_to_reach )
{
	if ( !isdefined( count_to_reach ) )
		count_to_reach = 0;

	/#
	level notify( "kill_add_wait_asserter" );
	#/

	AssertEx( IsDefined( level.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
	ent = SpawnStruct();
	array 		 = level.wait_any_func_array;
	endons 		 = level.do_wait_endons_array;
	after_array = level.run_func_after_wait_array;
	call_array	 = level.run_call_after_wait_array;
	nscall_array = level.run_noself_call_after_wait_array;
	abort_array = level.abort_wait_any_func_array;

 	level.wait_any_func_array 		 = [];
 	level.run_func_after_wait_array = [];
 	level.do_wait_endons_array 		 = [];
 	level.abort_wait_any_func_array = [];
 	level.run_call_after_wait_array = [];
 	level.run_noself_call_after_wait_array = [];

	ent.count = array.size;

	ent array_levelthread( array, ::waittill_func_ends, endons );
	ent thread do_abort( abort_array );

	ent endon( "any_funcs_aborted" );

	for ( ;; )
	{
		if ( ent.count <= count_to_reach )
			break;
		ent waittill( "func_ended" );
	}
	ent notify( "all_funcs_ended" );

	array_levelthread( after_array, ::exec_func, [] );
	array_levelthread( call_array, ::exec_call );
	array_levelthread( nscall_array, ::exec_call_noself );
}


do_funcs()
{
	/#
	level notify( "kill_add_wait_asserter" );
	#/

	AssertEx( IsDefined( level.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
	ent = SpawnStruct();

	AssertEx( !level.wait_any_func_array.size, "Don't use add_wait and do_funcs together." );
	AssertEx( !level.do_wait_endons_array.size, "Don't use add_endon and do_funcs together." );
	AssertEx( !level.run_call_after_wait_array.size, "Don't use add_call and do_funcs together." );
	AssertEx( !level.run_noself_call_after_wait_array.size, "Don't use add_call and do_funcs together." );
	AssertEx( !level.abort_wait_any_func_array.size, "Do_funcs doesn't support add_abort." );

	after_array = level.run_func_after_wait_array;

 	level.run_func_after_wait_array = [];

 	foreach ( func_struct in after_array )
 	{
 		level exec_func( func_struct, [] );
 	}

	ent notify( "all_funcs_ended" );
}


is_default_start()
{
	if ( IsDefined( level.default_start_override ) && level.default_start_override == level.start_point )
		return true;

	if ( IsDefined( level.default_start ) )
		return level.start_point == "default";

	if ( level_has_start_points() )
		return level.start_point == level.start_functions[ 0 ][ "name" ];

	return level.start_point == "default";
}



is_first_start()
{
	if ( !level_has_start_points() )
		return true;

	return level.start_point == level.start_functions[ 0 ][ "name" ];
}



_Earthquake( scale, duration, source, radius )
{
	Earthquake( scale, duration, source, radius );
}


waterfx( endflag )
{
// currently using these devraw fx:
//	level._effect[ "water_stop" ]						= LoadFX( "misc/parabolic_water_stand" );
//	level._effect[ "water_movement" ]					= LoadFX( "misc/parabolic_water_movement" );

	self endon( "death" );

	if ( IsDefined( endflag ) )
	{
		flag_assert( endflag );
		level endon( endflag );
	}
	for ( ;; )
	{
		wait( RandomFloatRange( 0.15, 0.3 ) );
		start = self.origin + ( 0, 0, 150 );
		end = self.origin - ( 0, 0, 150 );
		trace = BulletTrace( start, end, false, undefined );
		if ( trace[ "surfacetype" ] != "water" )
			continue;

		fx = "water_movement";
		if ( IsPlayer( self ) )
		{
			if ( Distance( self GetVelocity(), ( 0, 0, 0 ) ) < 5 )
			{
				fx = "water_stop";
			}
		}
		else
		if ( IsDefined( level._effect[ "water_" + self.a.movement ] ) )
		{
			fx = "water_" + self.a.movement;
		}

		water_fx = getfx( fx );
		start = trace[ "position" ];
		//angles = vectortoangles( trace[ "normal" ] );
		angles = (0,self.angles[1],0);
		forward = anglestoforward( angles );
		up = anglestoup( angles );
		PlayFX( water_fx, start, up, forward );
	}
}


playerSnowFootsteps( endflag )
{
// currently using these devraw fx:
//	level._effect[ "footstep_snow_small" ]				= LoadFX( "impacts/footstep_snow_small" );
//	level._effect[ "footstep_snow" ]					= LoadFX( "impacts/footstep_snow" );

	if ( IsDefined( endflag ) )
	{
		flag_assert( endflag );
		level endon( endflag );
	}

	for ( ;; )
	{
		wait( RandomFloatRange( 0.25, .5 ) );
		start = self.origin + ( 0, 0, 0 );
		end = self.origin - ( 0, 0, 5 );
		trace = BulletTrace( start, end, false, undefined );
		forward = AnglesToForward( self.angles );
		mydistance = Distance( self GetVelocity(), ( 0, 0, 0 ) );
		if ( IsDefined( self.vehicle ) )
			continue;
		if ( trace[ "surfacetype" ] != "snow" )
			continue;
		if ( mydistance <= 10 )
			continue;
		fx = "snow_movement";
		//iprintlnbold( "Moved" + mydistance );
		if ( Distance( self GetVelocity(), ( 0, 0, 0 ) ) <= 154 )
		{
			PlayFX( getfx( "footstep_snow_small" ), trace[ "position" ], trace[ "normal" ], forward );
		}
		if ( Distance( self GetVelocity(), ( 0, 0, 0 ) ) > 154 )
		{
			PlayFX( getfx( "footstep_snow" ), trace[ "position" ], trace[ "normal" ], forward );
		}
	}
}



mix_up( sound )
{
	timer = 3 * 20;
	for ( i = 0; i < timer; i++ )
	{
		self SetSoundBlend( sound, sound + "_off", ( timer - i ) / timer );
		wait( 0.05 );
	}
}


mix_down( sound )
{
	timer = 3 * 20;
	for ( i = 0; i < timer; i++ )
	{
		self SetSoundBlend( sound, sound + "_off", i / timer );
		wait( 0.05 );
	}
}


manual_linkto( entity, offset )
{
	entity endon( "death" );
	self endon( "death" );
	// for entities that don't support linkto, like soundblend entities
	if ( !isdefined( offset ) )
	{
		offset = ( 0, 0, 0 );
	}

	for ( ;; )
	{
		self.origin = entity.origin + offset;
		self.angles = entity.angles;
		wait( 0.05 );
	}
}



nextmission()
{
	maps\_endmission::_nextmission();
}


make_array( index1, index2, index3, index4, index5 )
{
	AssertEx( IsDefined( index1 ), "Need to define index 1 at least" );
	array = [];
	array[ array.size ] = index1;
	if ( IsDefined( index2 ) )
	{
		array[ array.size ] = index2;
	}

	if ( IsDefined( index3 ) )
	{
		array[ array.size ] = index3;
	}

	if ( IsDefined( index4 ) )
	{
		array[ array.size ] = index4;
	}

	if ( IsDefined( index5 ) )
	{
		array[ array.size ] = index5;
	}

	return array;
}



fail_on_friendly_fire()
{
	level.failOnFriendlyFire = true;
}


normal_friendly_fire_penalty()
{
	level.failOnFriendlyFire = false;
}


getPlayerClaymores()
{
	Assert( IsPlayer( self ) );

	heldweapons = self GetWeaponsListAll();
	stored_ammo = [];
	for ( i = 0; i < heldweapons.size; i++ )
	{
		weapon = heldweapons[ i ];
		stored_ammo[ weapon ] = self GetWeaponAmmoClip( weapon );
	}


	claymoreCount = 0;
	if ( IsDefined( stored_ammo[ "claymore" ] ) && stored_ammo[ "claymore" ] > 0 )
	{
		claymoreCount = stored_ammo[ "claymore" ];
	}
	return claymoreCount;
}


getPlayerC4()
{
	Assert( IsPlayer( self ) );

	heldweapons = self GetWeaponsListAll();
	stored_ammo = [];
	for ( i = 0; i < heldweapons.size; i++ )
	{
		weapon = heldweapons[ i ];
		stored_ammo[ weapon ] = self GetWeaponAmmoClip( weapon );
	}


	c4Count = 0;
	if ( IsDefined( stored_ammo[ "c4" ] ) && stored_ammo[ "c4" ] > 0 )
	{
		c4Count = stored_ammo[ "c4" ];
	}
	return c4Count;
}


_wait( timer )
{
	wait( timer );
}


_waittillmatch( msg, match )
{
	self waittillmatch( msg, match );
}


_setsaveddvar( var, val )
{
	SetSavedDvar( var, val );
}


lerp_savedDvar( name, value, time )
{
	curr = 	GetDvarFloat( name );

	range = value - curr;

	interval = .05;
	count = Int( time / interval );

	delta = range / count;

	while ( count )
	{
		curr += delta;
		SetSavedDvar( name, curr );

		wait interval;
		count--;
	}

	SetSavedDvar( name, value );
}


giveachievement_wrapper( achievement )
{		
	if( level.script == "ending" && isdefined( level.level_mode ) && level.level_mode == "free" )//char museum 
		return;
		
	foreach ( player in level.players )
	{
		player GiveAchievement( achievement );
	}
	
	/#
		println( "ACHIEVEMENT: " + achievement );
	#/
}


player_giveachievement_wrapper( achievement )
{
	if( level.script == "ending" && isdefined( level.level_mode ) && level.level_mode == "free" )//char museum 
		return;
		
	self GiveAchievement( achievement );
	
	/#
		println( "ACHIEVEMENT: " + achievement );
	#/
}


add_jav_glow( optional_glow_delete_flag )
{
	jav_glow = Spawn( "script_model", ( 0, 0, 0 ) );
	jav_glow SetContents( 0 );
	jav_glow SetModel( "weapon_javelin_obj" );

	jav_glow.origin = self.origin;
	jav_glow.angles = self.angles;

	self add_wait( ::delete_on_not_defined );
	if ( IsDefined( optional_glow_delete_flag ) )
	{
		flag_assert( optional_glow_delete_flag );
		add_wait( ::flag_wait, optional_glow_delete_flag );
	}

	do_wait_any();

	jav_glow Delete();
}


add_c4_glow( optional_glow_delete_flag )
{
	c4_glow = Spawn( "script_model", ( 0, 0, 0 ) );
	c4_glow SetContents( 0 );
	c4_glow SetModel( "weapon_c4_obj" );

	c4_glow.origin = self.origin;
	c4_glow.angles = self.angles;

	self add_wait( ::delete_on_not_defined );
	if ( IsDefined( optional_glow_delete_flag ) )
	{
		flag_assert( optional_glow_delete_flag );
		add_wait( ::flag_wait, optional_glow_delete_flag );
	}

	do_wait_any();

	c4_glow Delete();
}


delete_on_not_defined()
{
	for ( ;; )
	{
		if ( !isdefined( self ) )
			return;
		wait( 0.05 );
	}
}





slowmo_start()
{
}


slowmo_end()
{
}


slowmo_setspeed_slow( speed )
{
	level.slowmo.speed_slow = speed;
}


slowmo_setspeed_norm( speed )
{
	level.slowmo.speed_norm = speed;
}


slowmo_setlerptime_in( time )
{
	level.slowmo.lerp_time_in = time;
}


slowmo_setlerptime_out( time )
{
	level.slowmo.lerp_time_out = time;
}


slowmo_lerp_in()
{
	SetSlowMotion( level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in );
	//setslowmotionview( level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in ); //changed  for slomo breach
}


slowmo_lerp_out()
{
	setslowmotion( level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out );

}


add_earthquake( name, mag, duration, radius )
{
	level.earthquake[ name ][ "magnitude" ] = mag;
	level.earthquake[ name ][ "duration" ] = duration;
	level.earthquake[ name ][ "radius" ] = radius;
}


arcadeMode_kill( origin, damage_type, amount )
{
	if ( GetDvar( "arcademode" ) != "1" )
		return;
	thread maps\_arcademode::arcadeMode_add_points( origin, true, damage_type, amount );
}


arcadeMode_damage( origin, damage_type, amount )
{
	if ( GetDvar( "arcademode" ) != "1" )
		return;
	thread maps\_arcademode::arcadeMode_add_points( origin, false, damage_type, amount );
}


arcademode_checkpoint( time_remaining, unique_id )
{
	if ( 1 )
		return;
	if ( GetDvar( "arcademode" ) != "1" )
		return;

	id = maps\_arcadeMode::arcademode_checkpoint_getid( unique_id );
	if ( !isdefined( id ) )
	{
		id = level.arcadeMode_checkpoint_dvars.size;
		// add the unique_id to the list if it doesn't exist yet
		level.arcadeMode_checkpoint_dvars[ level.arcadeMode_checkpoint_dvars.size ] = unique_id;
		AssertEx( level.arcadeMode_checkpoint_dvars.size <= level.arcadeMode_checkpoint_max, "Exceeded max number of arcademode checkpoints." );
	}

	// make sure we don't do the same checkpoint twice
	if ( GetDvar( "arcademode_checkpoint_" + id ) == "1" )
		return;

	SetDvar( "arcademode_checkpoint_" + id, "1" );

	if ( GetDvar( "arcademode_full" ) == "1" )
	{
		if ( level.gameskill == 2 )
			time_remaining *= 2.0;
		if ( level.gameskill == 3 )
			time_remaining *= 2.5;
	}

	// save the remaining time to add it back on at the end
	// then set the remaining time to the new time_remaining
	remaining_time = GetDvarInt( "arcademode_time" );
	stored_time = GetDvarInt( "arcademode_stored_time" );
	stored_time += remaining_time;
	SetDvar( "arcademode_stored_time", stored_time );
	SetDvar( "arcademode_time", time_remaining * 60 );

	start_offset = 800;
	movetime = 0.8;

	level.player thread play_sound_in_space( "arcademode_checkpoint", level.player GetEye() );

	thread maps\_arcademode::draw_checkpoint( start_offset, movetime, 1 );
	thread maps\_arcademode::draw_checkpoint( start_offset, movetime, -1 );
}



arcadeMode()
{
	return GetDvar( "arcademode" ) == "1";
}


arcadeMode_stop_timer()
{
 	if ( !isdefined( level.arcadeMode_hud_timer ) )
 		return;

 	level notify( "arcadeMode_remove_timer" );
 	level.arcademode_stoptime = GetTime();

	level.arcadeMode_hud_timer Destroy();
	level.arcadeMode_hud_timer = undefined;
}



MusicPlayWrapper( song, timescale, overrideCheat )
{
	level.last_song = song;
	if ( !arcadeMode() || !flag( "arcadeMode_multiplier_maxed" ) )
	{
		if ( !isdefined( timescale ) )
			timescale = true;
		if ( !isdefined( overrideCheat ) )
			overrideCheat = false;
		
		MusicStop( 0 );
		MusicPlay( song, timescale, overrideCheat );
	}
}


music_loop( name, time, fade_time, timescale, overrideCheat )
{
	thread music_loop_internal( name, time, fade_time, timescale, overrideCheat );
}


music_loop_stealth( name, length, fade_time, timescale, overrideCheat )
{
	thread music_loop_internal( name, length, fade_time, timescale, overrideCheat, true );
}


music_play( name, fade_time, timescale, overrideCheat )
{
	if ( IsDefined( fade_time ) && fade_time > 0 )
	{
		thread music_play_internal_stop_with_fade_then_call( name, fade_time, timescale, overrideCheat );
		return;
	}
	music_stop();

	MusicPlayWrapper( name, timescale, overrideCheat );
}


music_stop( fade_time )
{
	if ( !isdefined( fade_time ) || fade_time <= 0 )
		MusicStop();
	else
		MusicStop( fade_time );
	level notify( "stop_music" );
}


player_is_near_live_grenade()
{
	grenades = GetEntArray( "grenade", "classname" );
	for ( i = 0; i < grenades.size; i++ )
	{
		grenade = grenades[ i ];
		if ( grenade.model == "weapon_claymore" )
			continue;

		for ( playerIndex = 0; playerIndex < level.players.size; playerIndex++ )
		{
			player = level.players[ playerIndex ];
			if ( DistanceSquared( grenade.origin, player.origin ) < ( 275 * 275 ) )// grenade radius is 256
			{
				/# maps\_autosave::AutoSavePrint( "autosave failed: live grenade too close to player" ); #/
				return true;
			}
		}
	}
	return false;
}


player_died_recently()
{
	return GetDvarInt( "player_died_recently", "0" ) > 0;
}

  
all_players_istouching( eVolume )
{
	AssertEx( IsDefined( eVolume ), "eVolume parameter not defined" );
	foreach ( player in level.players )
	{
		if ( !player IsTouching( eVolume ) )
			return false;
	}
	return true;
}

  
any_players_istouching( eVolume )
{
	AssertEx( IsDefined( eVolume ), "eVolume parameter not defined" );
	foreach ( player in level.players )
	{
		if ( player IsTouching( eVolume ) )
			return true;
	}
	return false;
}

  

get_ent_closest_to_flag_trig( sFlagName, aEnts )
{
	AssertEx( IsDefined( sFlagName ), "You need to specify the name of the script_flag key for this function" );
	AssertEx( IsDefined( aEnts ), "You need to specify the array of entities you want to check" );
	AssertEx( aEnts.size > 0, "The array passed is empty" );
	if ( aEnts.size == 1 )
		return aEnts[ 0 ];

	flag_trig = undefined;
	eEnt = undefined;
	trigs = GetEntArray( "trigger_multiple", "classname" );
	for ( i = 0; i < trigs.size; i++ )
	{
		if ( ( IsDefined( trigs[ i ].script_flag ) ) && ( trigs[ i ].script_flag == sFlagName ) )
		{
			flag_trig = trigs[ i ];
			break;
		}
	}
	AssertEx( IsDefined( flag_trig ), "Cannot find a flag trigger with the script_flag name of :" + sFlagName );
	eEnt = getClosest( flag_trig.origin, aEnts );
	AssertEx( IsDefined( eEnt ), "Could not determine which entity was closest to flag trigger " + sFlagName );
	return eEnt;
}

is_legacy_map()
{
	return level.is_legacy_map;
}

getDifficulty()
{
	Assert( IsDefined( level.gameskill ) );
	if ( level.gameskill < 1 )
		return "easy";
	if ( level.gameskill < 2 )
		return "medium";
	if ( level.gameskill < 3 )
		return "hard";
	return "fu";
}

  

hide_players( qBool )
{
	for ( i = 0; i < level.players.size; i++ )
	{
		if ( qBool == true )
			level.players[ i ] Hide();
		else
			level.players[ i ] Show();
	}
}


SetModelFunc( modelFunc, starts_off )
{
	if ( !isdefined( starts_off ) )
		starts_off = false;
	thread maps\_loadout::UpdateModel( modelFunc );
}



 
isPlayerDown()
{
	Assert( IsPlayer( self ) );

	if ( is_coop() && flag( "coop_revive" ) )
	{
		if ( self ent_flag( "coop_downed" ) )
			return true;
	}

	return !isAlive( self );
}

 
getAveragePlayerOrigin()
{
	averageOrigin_x = 0;
	averageOrigin_y = 0;
	averageOrigin_z = 0;
	foreach ( player in level.players )
	{
		averageOrigin_x += player.origin[ 0 ];
		averageOrigin_y += player.origin[ 1 ];
		averageOrigin_z += player.origin[ 2 ];
	}
	averageOrigin_x = averageOrigin_x / level.players.size;
	averageOrigin_y = averageOrigin_y / level.players.size;
	averageOrigin_z = averageOrigin_z / level.players.size;
	return( averageOrigin_x, averageOrigin_y, averageOrigin_z );
}


get_average_origin( array )
{
	origin = ( 0, 0, 0 );
	foreach ( member in array )
		origin += member.origin;

	return vector_multiply( origin, ( 1.0 / array.size ) );
}






add_damage_function( func )
{
	self.damage_functions[ self.damage_functions.size ] = func;
}


remove_damage_function( damage_func )
{
	new_array = [];
	foreach ( func in self.damage_functions )
	{
		if ( func == damage_func )
			continue;
		new_array[ new_array.size ] = func;
	}
	self.damage_functions = new_array;
}



giveXp( type, value )
{
	self maps\_rank::updatePlayerScore( type, value );
}



giveMoney( type, amount, attacker )
{
	self maps\_money::updatePlayerMoney( type, amount, attacker );
}



playLocalSoundWrapper( alias )
{
	Assert( IsDefined( alias ) );
	self PlayLocalSound( alias );
}



enablePlayerWeapons( bool )
{
	AssertEx( IsDefined( bool ), "Need to pass either 'true' or 'false' to enable/disable weapons" );
	if ( level.players.size < 1 )
		return;
	foreach ( player in level.players )
	{
		if ( bool == true )
			player EnableWeapons();
		else
			player DisableWeapons();
	}
}


teleport_players( aNodes )
{
	//->not supporting coop in SP anymore
	//assertEx( aNodes.size == 2, "An array of exactly 2 nodes is required to teleport 2 coop players" );

	player1node = undefined;
	player2node = undefined;
	eNode = undefined;
	foreach ( node in aNodes )
	{
		if ( ( IsDefined( node.script_noteworthy ) ) && ( node.script_noteworthy == "player1" ) )
			player1node = node;
		else if ( ( IsDefined( node.script_noteworthy ) ) && ( node.script_noteworthy == "player2" ) )
			player2node = node;
		else
		{
			if ( !isdefined( player1node ) )
				player1node = node;
			if ( !isdefined( player2node ) )
				player2node = node;
		}
	}
	foreach ( player in level.players )
	{
		if ( player == level.player )
			eNode = player1node;
		else if ( player == level.player2 )
			eNode = player2node;
		player SetOrigin( eNode.origin );
		player SetPlayerAngles( eNode.angles );
	}
}



teleport_player( object )
{
	level.player SetOrigin( object.origin );
	level.player SetPlayerAngles( object.angles );
}


hide_player_model()
{

	if ( !is_coop() )
		return;

	self.is_hidden 	 = true;
	AssertEx( IsDefined( self.last_modelfunc ), "can't Hide player model on a player that hasn't been through maps\_loadout::UpdateModel()" );
	thread maps\_loadout::UpdateModel( undefined );
}



show_player_model()
{
	if ( !is_coop() )
		return;
	self.is_hidden 	 = false;
	AssertEx( IsDefined( self.last_modelfunc ), "can't Show player model on a player that hasn't been through maps\_loadout::UpdateModel()" );
	thread maps\_loadout::UpdateModel( self.last_modelfunc );
}




translate_local()
{
	entities = [];
	if ( IsDefined( self.entities ) )
		entities = self.entities;
	if ( IsDefined( self.entity ) )
	entities[ entities.size ] = self.entity;

	AssertEx( entities.size > 0, "Tried to do translate_local without any entities" );
	array_levelthread( entities, ::translate_local_on_ent );
}



open_up_fov( time, player_rig, tag, arcRight, arcLeft, arcTop, arcBottom )
{
	level.player endon( "stop_opening_fov" );
	wait( time );
	level.player PlayerLinkToDelta( player_rig, tag, 1, arcRight, arcLeft, arcTop, arcBottom, true );
}




get_ai_touching_volume( sTeam, species, bGetDrones )
{
	if ( !isdefined( sTeam ) )
		sTeam = "all";

	if ( !isdefined( species ) )
		species = "all";

	aTeam = GetAISpeciesArray( sTeam, species );

	aGuysTouchingVolume = [];
	foreach ( guy in aTeam )
	{
		AssertEx( IsAlive( guy ), "Got ai array yet got a dead guy!" );
		if ( guy IsTouching( self ) )
			aGuysTouchingVolume[ aGuysTouchingVolume.size ] = guy;
	}

	return aGuysTouchingVolume;
}


get_drones_touching_volume( sTeam )
{
	if ( !isdefined( sTeam ) )
		sTeam = "all";

	aDrones = [];
	if ( sTeam == "all" )
	{
		aDrones = array_merge( level.drones[ "allies" ].array, level.drones[ "axis" ].array );
		aDrones = array_merge( aDrones, level.drones[ "neutral" ].array );
	}
	else
		aDrones = level.drones[ sTeam ].array;

	aDronesToReturn = [];
	foreach ( drone in aDrones )
	{
		if ( !isdefined( drone ) )
			continue;
		if ( drone IsTouching( self ) )
			aDronesToReturn[ aDronesToReturn.size ] = drone;
	}
	return aDronesToReturn;
}



get_drones_with_targetname( sTargetname )
{
	aDrones = array_merge( level.drones[ "allies" ].array, level.drones[ "axis" ].array );
	aDrones = array_merge( aDrones, level.drones[ "neutral" ].array );
	aDronesToReturn = [];
	foreach ( drone in aDrones )
	{
		if ( !isdefined( drone ) )
			continue;
		if ( ( IsDefined( drone.targetname ) ) && ( drone.targetname == sTargetname ) )
			aDronesToReturn[ aDronesToReturn.size ] = drone;
	}
	return aDronesToReturn;
}


get_other_player( player )
{
	Assert( is_coop() );
	Assert( isdefined( player ) && isplayer( player ) );
	
	foreach ( other_player in level.players )
	{
		if ( player == other_player )
			continue;
		return other_player;
	}

	AssertMsg( "get_other_player() tried to get other player but there is no other player." );
}


is_other_player_downed( player )
{
	Assert( is_coop() );
	Assert( isdefined( player ) && isplayer( player ) );

	other_player = get_other_player( player );
	Assert( IsDefined( other_player ) );

	return( other_player ent_flag_exist( "coop_downed" ) && other_player ent_flag( "coop_downed" ) );
}


set_count( count )
{
	/#
	AssertEx( IsDefined( self ), "Spawner wasn't defined!" );
	AssertEx( !isalive( self ), "Spawner was alive!" );
	#/
	self.count = count;
}
follow_path( node, require_player_dist, arrived_at_node_func )
{
	self notify( "_utility::follow_path" );
	self endon( "_utility::follow_path" );
	self endon( "death" );

	goal_type = undefined;
	//only nodes and structs dont have classnames - ents do
	if ( !isdefined( node.classname ) )
	{
		//only structs don't have types, nodes do
		if ( !isdefined( node.type ) )
			goal_type = "struct";
		else
			goal_type = "node";
	}
	else
		goal_type = "entity";

	if ( !isdefined( require_player_dist ) )
		require_player_dist = 300;

	//set this so the radius doesn't explode.
	oldforcegoal = self.script_forcegoal;
	self.script_forcegoal = 1;

	self maps\_spawner::go_to_node( node, goal_type, arrived_at_node_func, require_player_dist );

	self.script_forcegoal = oldforcegoal;
}


enable_dynamic_run_speed( pushdist, sprintdist, stopdist, jogdist, group, dontChangeMovePlaybackRate )
{
	AssertEx( IsDefined( level.scr_anim[ "generic" ][ "DRS_sprint" ] ), " - -- -- -- -- -- -- add this line: 'maps\_dynamic_run_speed::main();' AFTER maps\\\_load::main(); -- -- -- -- -- -- - " );
	if ( !isdefined( pushdist ) )
		pushdist = 250;

	if ( !isdefined( sprintdist ) )
		sprintdist = 100;

	if ( !isdefined( stopdist ) )
		stopdist = pushdist * 2;

	if ( !isdefined( jogdist ) )
		jogdist = pushdist * 1.25;
	if ( !isdefined( dontChangeMovePlaybackRate ) )
		dontChangeMovePlaybackRate = false;

	self.dontChangeMovePlaybackRate = dontChangeMovePlaybackRate;

	self thread dynamic_run_speed_proc( pushdist, sprintdist, stopdist, jogdist, group );
}


disable_dynamic_run_speed()
{
	self notify( "stop_dynamic_run_speed" );
}


player_seek_enable()
{
	self endon( "death" );
	self endon( "stop_player_seek" );
	g_radius = 1200;
	if ( self has_shotgun() )
		g_radius = 250;

	newGoalRadius = Distance( self.origin, level.player.origin );
	for ( ;; )
	{
		wait 2;
		self.goalradius = newGoalRadius;
		player = get_closest_player( self.origin );
		self SetGoalEntity( player );
		newGoalRadius -= 175;
		if ( newGoalRadius < g_radius )
		{
			newGoalRadius = g_radius;
			return;
		}
	}
}


player_seek_disable()
{
	self notify( "stop_player_seek" );
}


waittill_entity_in_range_or_timeout( entity, range, timeout )
{
	self endon( "death" );
	entity endon( "death" );
	if ( !isdefined( timeout ) )
		timeout = 5;
	timeout_time = GetTime() + ( timeout * 1000 );
	while ( IsDefined( entity ) )
	{
		if ( Distance( entity.origin, self.origin ) <= range )
			break;
		if ( GetTime() > timeout_time )
			break;
		wait .1;
	}
}


waittill_entity_in_range( entity, range )
{
	self endon( "death" );
	entity endon( "death" );
	while ( IsDefined( entity ) )
	{
		if ( Distance( entity.origin, self.origin ) <= range )
			break;
		wait .1;
	}
}

waittill_entity_out_of_range( entity, range )
{
	self endon( "death" );
	entity endon( "death" );
	while ( IsDefined( entity ) )
	{
		if ( Distance( entity.origin, self.origin ) > range )
			break;
		wait .1;
	}
}


has_shotgun()
{
	self endon( "death" );
	if ( !isdefined( self.weapon ) )
		return false;
	if ( self.weapon == "winchester1200" || self.weapon == "m1014" || self.weapon == "striker" || self.weapon == "ranger" || self.weapon == "aa12" )
		return true;
	else
		return false;
}


player_has_thermal()
{
	weapons = self GetWeaponsListAll();
	if ( !isdefined( weapons ) )
		return false;
	foreach ( weapon in weapons )
	{
		if ( IsSubStr( weapon, "thermal" ) )
			return true;
	}
	return false;
}


waittill_true_goal( origin, radius )
{
	self endon( "death" );

	if ( !isdefined( radius ) )
		radius = self.goalradius;

	while ( 1 )
	{
		self waittill( "goal" );
		if ( Distance( self.origin, origin ) < radius + 10 )// give a little leeway
			break;
	}
}


player_speed_percent( percent, time )
{
	currspeed = Int( GetDvar( "g_speed" ) );
	if ( !isdefined( level.player.g_speed ) )
		level.player.g_speed = currspeed;

	goalspeed = Int( level.player.g_speed * percent * .01 );

	level.player player_speed_set( goalspeed, time );
}


blend_movespeedscale_percent( percent, time )
{
	player = self;
	if ( !isplayer( player ) )
		player = level.player;

	if ( !isdefined( player.movespeedscale ) )
		player.movespeedscale = 1.0;

	goalscale = percent * .01;

	player blend_movespeedscale( goalscale, time );
}


player_speed_set( speed, time )
{
	currspeed = Int( GetDvar( "g_speed" ) );
	if ( !isdefined( level.player.g_speed ) )
		level.player.g_speed = currspeed;

	get_func = ::g_speed_get_func;
	set_func = ::g_speed_set_func;
	level.player thread player_speed_proc( speed, time, get_func, set_func, "player_speed_set" );
}


blend_movespeedscale( scale, time )
{
	player = self;
	if ( !isplayer( player ) )
		player = level.player;

	if ( !isdefined( player.movespeedscale ) )
		player.movespeedscale = 1.0;

	get_func = ::movespeed_get_func;
	set_func = ::movespeed_set_func;
	player thread player_speed_proc( scale, time, get_func, set_func, "blend_movespeedscale" );
}

player_speed_proc( speed, time, get_func, set_func, ender )
{
	self notify( ender );
	self endon( ender );

	currspeed = [[ get_func ]]();
	goalspeed = speed;

	if ( IsDefined( time ) )
	{
		range = goalspeed - currspeed;
		interval = .05;
		numcycles = time / interval;
		fraction = range / numcycles;

		while ( abs( goalspeed - currspeed ) > abs( fraction * 1.1 ) )
		{
			currspeed += fraction;
			[[ set_func ]]( currspeed );
			wait interval;
		}
	}

	[[ set_func ]]( goalspeed );
}


player_speed_default( time )
{
	if ( !isdefined( level.player.g_speed ) )
		return;

	level.player player_speed_set( level.player.g_speed, time );

	waittillframeend;
	level.player.g_speed = undefined;
}


blend_movespeedscale_default( time )
{
	player = self;
	if ( !isplayer( player ) )
		player = level.player;

	if ( !isdefined( player.movespeedscale ) )
		return;

	player blend_movespeedscale( 1.0, time );

	waittillframeend;
	player.movespeedscale = undefined;
}


drop_to_ground( pos, updist, downdist )
{
	if ( !isdefined( updist ) )
		updist = 1500;
	if ( !isdefined( downdist ) )
		downdist = -12000;

	return PhysicsTrace( pos + ( 0, 0, updist ), pos + ( 0, 0, downdist ) );
}


teleport_ent( ent )
{
	if ( IsPlayer( self ) )
	{
		self SetOrigin( ent.origin );
		self SetPlayerAngles( ent.angles );
	}
	else
	{
		self ForceTeleport( ent.origin, ent.angles );
	}
}



teleport_ai( eNode )
{
	AssertEx( IsAI( self ), "Function teleport_ai can only be called on an AI entity" );
	AssertEx( IsDefined( eNode ), "Need to pass a node entity to function teleport_ai" );
	self ForceTeleport( eNode.origin, eNode.angles );
	self SetGoalPos( self.origin );
	self SetGoalNode( eNode );
}




move_all_fx( vec )
{
	foreach ( fx in level.createFXent )
	{
		fx.v[ "origin" ] += vec;
	}
}


IsSliding()
{
	return IsDefined( self.slideModel );
}


BeginSliding( velocity, allowedAcceleration, dampening )
{
	Assert( IsPlayer( self ) );
	player = self;


	player thread play_sound_on_entity( "foot_slide_plr_start" );
	player thread play_loop_sound_on_tag( "foot_slide_plr_loop" );

	override_link_method = IsDefined( level.custom_linkto_slide );

	if ( !isDefined( velocity ) )
		velocity = player GetVelocity() + ( 0, 0, -10 );
	if ( !isDefined( allowedAcceleration ) )
		allowedAcceleration = 10;
	if ( !isDefined( dampening ) )
		dampening = .035;

	Assert( !isDefined( player.slideModel ) );
	// in the future, slideModel will actually be a script_model of legs
	slideModel = Spawn( "script_origin", player.origin );
	slideModel.angles = player.angles;
	player.slideModel = slideModel;

	slideModel MoveSlide( ( 0, 0, 15 ), 15, velocity );

	if ( override_link_method )
	{
		player PlayerLinkToBlend( slideModel, undefined, 1 );
	}
	else
	{
		player PlayerLinkTo( slideModel );
	}

	player DisableWeapons();
	player AllowProne( false );
	player AllowCrouch( true );
	player AllowStand( false );

	player thread DoSlide( slideModel, allowedAcceleration, dampening );
}



EndSliding()
{
	Assert( IsPlayer( self ) );
	player = self;

	Assert( IsDefined( player.slideModel ) );

	player notify( "stop sound" + "foot_slide_plr_loop" );
	player thread play_sound_on_entity( "foot_slide_plr_end" );
	player Unlink();
	player SetVelocity( player.slidemodel.slideVelocity );
 	player.slideModel Delete();
 	player EnableWeapons();
	player AllowProne( true );
	player AllowCrouch( true );
	player AllowStand( true );

	player notify( "stop_sliding" );
}



spawn_vehicle()
{
	/#
	// dev comments so we can catch the local variable in the debugger
	vehicle = maps\_vehicle::vehicle_spawn( self );
	return vehicle;
	#/

	// to conform with the style that AI are spawned;
	return maps\_vehicle::vehicle_spawn( self );
}


getEntWithFlag( flag )
{
	trigger_classes = maps\_load::get_load_trigger_classes();

	triggers = [];

	foreach ( class, _ in trigger_classes )
	{
		if ( !IsSubStr( class, "flag" ) )
			continue;
		other_triggers = GetEntArray( class, "classname" );
		triggers = array_combine( triggers, other_triggers );
	}

	trigger_funcs = maps\_load::get_load_trigger_funcs();

	foreach ( func, _ in trigger_funcs )
	{
		if ( !IsSubStr( func, "flag" ) )
			continue;
		other_triggers = GetEntArray( func, "targetname" );
		triggers = array_combine( triggers, other_triggers );
	}

	found_trigger = undefined;
	/#
	foreach ( trigger in triggers )
	{
		AssertEx( IsDefined( trigger.script_flag ), "Flag trigger at " + trigger.origin + " has no script_flag" );

		if ( trigger.script_flag == flag )
		{
			AssertEx( !isdefined( found_trigger ), "Did getEntWithFlag on flag " + flag + " but found multiple entities with that flag" );
			found_trigger = trigger;
		}
	}

	//AssertEx( IsDefined( found_trigger ), "Tried to find entity with flag " + flag + " but found none" );
	//if ( 1 ) return found_trigger;
	#/

	foreach ( trigger in triggers )
	{
		if ( trigger.script_flag == flag )
		{
			return trigger;
		}
	}
}


getEntArrayWithFlag( flag )
{
	trigger_classes = maps\_load::get_load_trigger_classes();

	triggers = [];

	foreach ( class, _ in trigger_classes )
	{
		if ( !IsSubStr( class, "flag" ) )
			continue;
		other_triggers = GetEntArray( class, "classname" );
		triggers = array_combine( triggers, other_triggers );
	}

	trigger_funcs = maps\_load::get_load_trigger_funcs();

	foreach ( func, _ in trigger_funcs )
	{
		if ( !IsSubStr( func, "flag" ) )
			continue;
		other_triggers = GetEntArray( func, "targetname" );
		triggers = array_combine( triggers, other_triggers );
	}

	found_triggers = [];
	/#
	foreach ( trigger in triggers )
	{
		AssertEx( IsDefined( trigger.script_flag ), "Flag trigger at " + trigger.origin + " has no script_flag" );

		if ( trigger.script_flag == flag )
		{
			found_triggers[ found_triggers.size ] = trigger;
		}
	}

	AssertEx( found_triggers.size, "Tried to find entity with flag " + flag + " but found none" );
	if ( 1 ) return found_triggers;
	#/

	foreach ( trigger in triggers )
	{
		if ( trigger.script_flag == flag )
		{
			found_triggers[ found_triggers.size ] = trigger;
		}
	}
	return found_triggers;
}


set_z( vec, z )
{
	return( vec[ 0 ], vec[ 1 ], z );
}


set_y( vec, y )
{
	return( vec[ 0 ], y, vec[ 2 ] );
}


set_x( vec, x )
{
	return( x, vec[ 1 ], vec[ 2 ] );
}


player_using_missile()
{
	weapon = self GetCurrentWeapon();

	if ( !isdefined( weapon ) )
		return false;

	if ( IsSubStr( ToLower( weapon ), "rpg" ) )
		return true;

	if ( IsSubStr( ToLower( weapon ), "stinger" ) )
		return true;

	if ( IsSubStr( ToLower( weapon ), "at4" ) )
		return true;

	if ( IsSubStr( ToLower( weapon ), "javelin" ) )
		return true;

	return false;
}


doingLongDeath()
{
	Assert( IsAI( self ) );
	return IsDefined( self.a.doingLongDeath );
}


get_rumble_ent( rumble )
{
	if ( is_coop() )
		PrintLn( "^3Warning! Using get_rumble_ent will cause the same rumbles to apply to all of the coop players!" );

	player = get_player_from_self();
	if ( !IsDefined( rumble ) )
		rumble = "steady_rumble";
	ent = Spawn( "script_origin", player.origin );
	ent.intensity = 1;
	ent PlayRumbleLoopOnEntity( rumble );
	ent thread update_rumble_intensity( player );
	return ent;
}

set_rumble_intensity( intensity )
{
	AssertEx( intensity >= 0 && intensity <= 1, "Intensity must be between 0 and 1" );
	self.intensity = intensity;
}


rumble_ramp_on( time )
{
	thread rumble_ramp_to( 1, time );
}


rumble_ramp_off( time )
{
	thread rumble_ramp_to( 0, time );
}


rumble_ramp_to( dest, time )
{
	self notify( "new_ramp" );
	self endon( "new_ramp" );
	self endon( "death" );

	frames = time * 20;
	dif = dest - self.intensity;
	slice = dif / frames;

	for ( i = 0; i < frames; i++ )
	{
		self.intensity += slice;
		wait( 0.05 );
	}
	self.intensity = dest;
}


get_player_from_self()
{
	if ( IsDefined( self ) )
	{
		if ( !is_in_array( level.players, self ) )
			return level.player;
		else
			return self;
	}
	else
		return level.player;
}


get_player_gameskill()
{
	AssertEx( IsPlayer( self ), "get_player_gameskill() can only be called on a player." );
	return Int( self GetPlayerSetting( "gameskill" ) );
}


glow( model )
{
	if ( IsDefined( self.non_glow_model ) )
		return;

	self.non_glow_model = self.model;

	if ( !isdefined( model ) )
		model = self.model + "_obj";
	self SetModel( model );
}


stopGlow( model )
{
	if ( !isdefined( self.non_glow_model ) )
		return;

	self SetModel( self.non_glow_model );
	self.non_glow_model = undefined;
}


array_delete_evenly( array, delete_size, set_size )
{
	AssertEx( delete_size > 0, "Save size must be at least 1" );
	AssertEx( set_size > 0, "Removal size must be at least 1" );
	AssertEx( delete_size < set_size, "Save size must be less than removal size" );
	removal = [];
	delete_size = set_size - delete_size;
	foreach ( entry in array )
	{
		removal[ removal.size ] = entry;
		if ( removal.size == set_size )
		{
			// remove 2 of every 3 entrys
			removal = array_randomize( removal );
			for ( i = delete_size; i < removal.size; i++ )
			{
				removal[ i ] Delete();
			}
			removal = [];
		}
	}

	new_array = [];
	foreach ( entry in array )
	{
		if ( !isdefined( entry ) )
			continue;
		new_array[ new_array.size ] = entry;
	}

	return new_array;
}


waittill_in_range( origin, range )
{
	self endon( "death" );
	while ( IsDefined( self ) )
	{
		if ( Distance( origin, self.origin ) <= range )
			break;
		wait .5;
	}
}



add_trace_fx( name )
{
	ent = SpawnStruct();
	ent thread add_trace_fx_proc( name );
	return ent;
}


traceFX_on_tag( fx_name, tag, trace_depth )
{
	origin = self GetTagOrigin( tag );
	angles = self GetTagAngles( tag );
	traceFx( fx_name, origin, angles, trace_depth );
}



traceFx( fx_name, origin, angles, trace_depth )
{
	// plays an effect based off surface type then deletes the tag that called it
	AssertEx( IsDefined( level.trace_fx[ fx_name ] ), "No level.trace_fx with name " + fx_name );
	AssertEx( IsDefined( level.trace_fx[ fx_name ][ "default" ] ), "No default fx defined for " + fx_name );


	forward = AnglesToForward( angles );
	trace = BulletTrace( origin, origin + forward * trace_depth, false, undefined );

	if ( trace[ "fraction" ] >= 1 )
	{
		/#
		if ( GetDvarInt( "debug_tracefx" ) )
			Line( origin, origin + forward * trace_depth, ( 1, 0, 0 ), 1, 0, 500 );
		#/
		// didn't hit anything
		return;
	}

	surface = trace[ "surfacetype" ];
	if ( !isdefined( level.trace_fx[ fx_name ][ surface ] ) )
		surface = "default";

	fx_info = level.trace_fx[ fx_name ][ surface ];

	if ( IsDefined( fx_info[ "fx" ] ) )
	{
		PlayFX( fx_info[ "fx" ], trace[ "position" ], trace[ "normal" ] );
	}

	if ( IsDefined( fx_info[ "fx_array" ] ) )
	{
		foreach ( fx in fx_info[ "fx_array" ] )
		{
			PlayFX( fx, trace[ "position" ], trace[ "normal" ] );
		}
	}

	if ( IsDefined( fx_info[ "sound" ] ) )
	{
		level thread play_sound_in_space( fx_info[ "sound" ], trace[ "position" ] );
	}

	if ( IsDefined( fx_info[ "rumble" ] ) )
	{
		player = get_player_from_self();
		player PlayRumbleOnEntity( fx_info[ "rumble" ] );
	}
}



disable_surprise()
{
	self.newEnemyReactionDistSq = 0;
}


enable_surprise()
{
	self.newEnemyReactionDistSq = squared( 512 );
}


enable_heat_behavior( shoot_while_moving )
{
	self.heat = true;
	self.no_pistol_switch = true;
	self.useCombatScriptAtCover = true;

	if ( !isdefined( shoot_while_moving ) || !shoot_while_moving )
	{
		self.dontshootwhilemoving = true;
		self.maxfaceenemydist = 64;
		self.pathenemylookahead = 2048;
		self disable_surprise();
	}

	self.specialReloadAnimFunc = animscripts\animset::heat_reload_anim;

	self.customMoveAnimSet[ "run" ] = anim.animsets.move[ "heat_run" ];
}



disable_heat_behavior()
{
	self.heat = undefined;
	self.no_pistol_switch = undefined;
	self.dontshootwhilemoving = undefined;
	self.useCombatScriptAtCover = false;
	self.maxfaceenemydist = 512;
	self.specialReloadAnimFunc = undefined;

	self.customMoveAnimSet = undefined;
}



getVehicleArray()
{
	return Vehicle_GetArray();
}


hint( string, timeOut, zoffset )
{
	if ( !isdefined( zoffset ) )
		zoffset = 0;

	hintfade = 0.5;

	level endon( "clearing_hints" );

	if ( IsDefined( level.hintElement ) )
		level.hintElement maps\_hud_util::destroyElem();

	level.hintElement = maps\_hud_util::createFontString( "default", 1.5 );
	level.hintElement maps\_hud_util::setPoint( "MIDDLE", undefined, 0, 30 + zoffset );
	level.hintElement.color = ( 1, 1, 1 );
	level.hintElement SetText( string );
	level.hintElement.alpha = 0;
	level.hintElement FadeOverTime( 0.5 );
	level.hintElement.alpha = 1;
	wait( 0.5 );
	level.hintElement endon( "death" );

	if ( IsDefined( timeOut ) )
		wait( timeOut );
	else
		return;

	level.hintElement FadeOverTime( hintfade );
	level.hintElement.alpha = 0;
	wait( hintfade );

	level.hintElement maps\_hud_util::destroyElem();
}



hint_fade()
{
	hintfade = 1;
	if ( IsDefined( level.hintElement ) )
	{
		level notify( "clearing_hints" );
		level.hintElement FadeOverTime( hintfade );
		level.hintElement.alpha = 0;
		wait( hintfade );
	}
}


kill_deathflag( theFlag, time )
{
	//assertex( IsDefined( level.flag[ theFlag ] ), "Tried to kill_deathFlag on a flag " + theFlag + " which does not exist." );
	if ( !isdefined( level.flag[ theFlag ] ) )
		return;

	if ( !isdefined( time ) )
		time = 0;

	foreach ( deathTypes in level.deathFlags[ theFlag ] )
	{
		foreach ( element in deathTypes )
		{
			if ( IsAlive( element ) )
			{
				element thread kill_deathflag_proc( time );
			}
			else
			{
				element Delete();
			}
		}
	}
}


get_player_view_controller( model, tag, originoffset )
{
	if ( !isdefined( originoffset ) )
		originoffset = ( 0, 0, 0 );
	origin = model GetTagOrigin( tag );
	player_view_controller = SpawnTurret( "misc_turret", origin, "player_view_controller" );
	player_view_controller.angles = model GetTagAngles( tag );
	player_view_controller SetModel( "tag_turret" );
	player_view_controller LinkTo( model, tag, originoffset, ( 0, 0, 0 ) );
	player_view_controller MakeUnusable();
	player_view_controller Hide();
	player_view_controller SetMode( "manual" );
	
	return player_view_controller;
}


blend_dof( start, end, time )
{
	blend = level create_blend( ::blend_default_dof, start, end );
	blend.time = time;
}



create_blend( func, var1, var2, var3 )
{
	ent = SpawnStruct();
	ent childthread process_blend( func, self, var1, var2, var3 );
	return ent;
}



store_players_weapons( scene )
{
	if ( !isdefined( self.stored_weapons ) )
	{
		self.stored_weapons = [];
	}

	array = [];
	weapons = self GetWeaponsListAll();
	foreach ( weapon in weapons )
	{
		array[ weapon ] = [];
		array[ weapon ][ "clip_left" ] = self GetWeaponAmmoClip( weapon, "left" );
		array[ weapon ][ "clip_right" ] = self GetWeaponAmmoClip( weapon, "right" );
		array[ weapon ][ "stock" ] = self GetWeaponAmmoStock( weapon );
	}

	if ( !isdefined( scene ) )
		scene = "default";

	self.stored_weapons[ scene ] = [];
	self.stored_weapons[ scene ][ "current_weapon" ] = self GetCurrentWeapon();
	self.stored_weapons[ scene ][ "inventory" ] = array;
}


restore_players_weapons( scene )
{
	if ( !isdefined( scene ) )
		scene = "default";

	if ( !isdefined( self.stored_weapons ) || !isdefined( self.stored_weapons[ scene ] ) )
	{
		PrintLn( "^3Warning! Tried to restore weapons for scene " + scene + " but they weren't stored" );
		return;
	}

	self TakeAllWeapons();
	foreach ( weapon, array in self.stored_weapons[ scene ][ "inventory" ] )
	{
		// We cannot give "alt-fire" weapons
		if ( WeaponInventoryType( weapon ) != "altmode" )
		{
			self GiveWeapon( weapon );
		}

		self SetWeaponAmmoClip( weapon, array[ "clip_left" ], "left" );
		self SetWeaponAmmoClip( weapon, array[ "clip_right" ], "right" );
		self SetWeaponAmmoStock( weapon, array[ "stock" ] );
	}

	current_weapon = self.stored_weapons[ scene ][ "current_weapon" ];
	if ( current_weapon != "none" )
		self SwitchToWeapon( current_weapon );
}


hide_entity()
{

	switch( self.code_classname )
	{
		case "light_spot":
		case "script_vehicle":
		case "script_model":
			self Hide();
			break;
		case "script_brushmodel":
			self Hide();
			self NotSolid();
			if ( self.spawnflags & 1 )
				self ConnectPaths();
			break;
		case "trigger_radius":
		case "trigger_multiple":
		case "trigger_use":
		case "trigger_use_touch":
		case "trigger_multiple_flag_set":
		case "trigger_multiple_breachIcon":
		case "trigger_multiple_flag_lookat":
		case "trigger_multiple_flag_looking":
			self trigger_off();
			break;
		default:
			AssertMsg( "Unable to hide entity at " + self.origin + ". Need to define a method for handling entities of classname " + self.code_classname );
	}
}


show_entity()
{
	switch( self.code_classname )
	{
		case "light_spot":
		case"script_vehicle":
		case"script_model":
			self Show();
			break;
		case "script_brushmodel":
			self Show();
			self Solid();
			if ( self.spawnflags & 1 )
				self DisconnectPaths();
			break;
		case "trigger_radius":
		case "trigger_multiple":
		case "trigger_use":
		case "trigger_use_touch":
		case "trigger_multiple_flag_set":
		case "trigger_multiple_breachIcon":
		case "trigger_multiple_flag_lookat":
		case "trigger_multiple_flag_looking":
			self trigger_on();
			break;
		default:
			AssertMsg( "Unable to show entity at " + self.origin + ". Need to define a method for handling entities of classname " + self.code_classname );
	}
}

_rotateyaw( yaw_angle, time, acc_time, dec_time )
{
	if ( IsDefined( dec_time ) )
		self RotateYaw( yaw_angle, time, acc_time, dec_time );
	else
	if ( IsDefined( acc_time ) )
		self RotateYaw( yaw_angle, time, acc_time );
	else
		self RotateYaw( yaw_angle, time );
}


set_moveplaybackrate( rate, time )
{
	self notify( "set_moveplaybackrate" );
	self endon( "set_moveplaybackrate" );

	if ( IsDefined( time ) )
	{
		range = rate - self.moveplaybackrate;
		interval = .05;
		numcycles = time / interval;
		fraction = range / numcycles;

		while ( abs( rate - self.moveplaybackrate ) > abs( fraction * 1.1 ) )
		{
			self.moveplaybackrate += fraction;
			wait interval;
		}
	}

	self.moveplaybackrate = rate;
}


array_spawn_function( array, func, param1, param2, param3, param4 )
{
	AssertEx( IsDefined( array ), "That isn't an array!" );
	AssertEx( IsArray( array ), "That isn't an array!" );
	AssertEx( array.size, "That array is empty!" );
	foreach ( spawner in array )
	{
		AssertEx( IsSpawner( spawner ), "This isn't a spawner!" );
		spawner thread add_spawn_function( func, param1, param2, param3, param4 );
	}
}


array_spawn_function_targetname( key, func, param1, param2, param3, param4 )
{
	array = GetEntArray( key, "targetname" );
	array_spawn_function( array, func, param1, param2, param3, param4 );
}



array_spawn_function_noteworthy( key, func, param1, param2, param3, param4 )
{
	array = GetEntArray( key, "script_noteworthy" );
	array_spawn_function( array, func, param1, param2, param3, param4 );
}





enable_dontevershoot()
{
	self.dontEverShoot = true;
}


disable_dontevershoot()
{
	self.dontEverShoot = undefined;
}


create_vision_set_fog( fogset )
{
	if ( !isdefined( level.vision_set_fog ) )
		level.vision_set_fog = [];
	ent = SpawnStruct();
	ent.name = fogset;

	level.vision_set_fog[ fogset ] = ent;
	return ent;
}


get_vision_set_fog( fogset )
{
	if ( !isdefined( level.vision_set_fog ) )
		level.vision_set_fog = [];

	ent = level.vision_set_fog[ fogset ];
	//assertex( IsDefined( ent ), "visiont set fog: " + fogset + "does not exist, use create_vision_set_fog( " + fogset + " ) in your level_fog.gsc." );
	return ent;
}




create_fog( fogset )
{
	if ( !isdefined( level.fog_set ) )
		level.fog_set = [];
	ent = SpawnStruct();
	ent.name = fogset;

	level.fog_set[ fogset ] = ent;
	return ent;
}


get_fog( fogset )
{
	if ( !isdefined( level.fog_set ) )
		level.fog_set = [];

	ent = level.fog_set[ fogset ];
	//assertex( IsDefined( ent ), "fog set: " + fogset + "does not exist, use create_fog( " + fogset + " ) in your level_fog.gsc." );
	return ent;
}


fog_set_changes( fog_set, transition_time )
{
	if ( !isdefined( level.fog_transition_ent ) )
	{
		level.fog_transition_ent = SpawnStruct();
		level.fog_transition_ent.fogset = "";
		level.fog_transition_ent.time = 0;
	}


	if ( !isdefined( level.fog_set ) )
		level.fog_set = [];

	ent = level.fog_set[ fog_set ];
	if ( !isdefined( ent ) )
	{
		AssertEx( IsDefined( level.vision_set_fog ), "Fog set:" + fog_set + " does not exist, use create_fog( " + fog_set + " ) or create_vision_set_fog( " + fog_set + " ); in your /createart/level_fog.gsc" );
		ent = level.vision_set_fog[ fog_set ];
	}

	AssertEx( IsDefined( ent ), "Fog set:" + fog_set + " does not exist, use create_fog( " + fog_set + " ) or create_vision_set_fog( " + fog_set + " ); in your /createart/level_fog.gsc" );

	//if ( !isdefined( ent ) )
	//	return;

	// transition time override
	if ( !isdefined( transition_time ) )
		transition_time = ent.transitiontime;
	AssertEx( IsDefined( transition_time ), "Fog set: " + fog_set + " does not have a transition_time defined and a time was not specified in the function call." );

	// this the same fog set we're already doing?
	if ( level.fog_transition_ent.fogset == fog_set && level.fog_transition_ent.time == transition_time )
		return;

	if ( IsDefined( ent.sunRed ) )
	{
		SetExpFog(
		ent.startDist,
		ent.halfwayDist,
		ent.red,
		ent.green,
		ent.blue,
		ent.maxOpacity,
		transition_time,
		ent.sunRed,
		ent.sunGreen,
		ent.sunBlue,
		ent.sunDir,
		ent.sunBeginFadeAngle,
		ent.sunEndFadeAngle,
		ent.normalFogScale );
	}
	else
	{
		SetExpFog(
		ent.startDist,
		ent.halfwayDist,
		ent.red,
		ent.green,
		ent.blue,
		ent.maxOpacity,
		transition_time );
	}

	level.fog_transition_ent.fogset = fog_set;
	level.fog_transition_ent.time = transition_time;
}


vision_set_fog_changes( vision_set, transition_time )
{
	do_fog = vision_set_changes( vision_set, transition_time );
	if ( do_fog && IsDefined( get_vision_set_fog( vision_set ) ) )
		fog_set_changes( vision_set, transition_time );
}



vision_set_changes( vision_set, transition_time )
{
	if ( !isdefined( level.vision_set_transition_ent ) )
	{
		level.vision_set_transition_ent = SpawnStruct();
		level.vision_set_transition_ent.vision_set = "";
		level.vision_set_transition_ent.time = 0;
	}

	// this the same vision set we're already doing?
	if ( level.vision_set_transition_ent.vision_set == vision_set && level.vision_set_transition_ent.time == transition_time )
		return false;// no fog

	level.vision_set_transition_ent.vision_set = vision_set;
	level.vision_set_transition_ent.time = transition_time;

	VisionSetNaked( vision_set, transition_time );

	//iprintlnbold( vision_set );
	SetDvar( "vision_set_current", vision_set );

	return true;// do fog
}


enable_teamflashbangImmunity()
{
	self thread enable_teamflashbangImmunity_proc();
}

enable_teamflashbangImmunity_proc()
{
	self endon( "death" );

	while ( 1 )
	{
		self.teamFlashbangImmunity = true;
		wait .05;
	}
}


disable_teamflashbangImmunity()
{
	self.teamFlashbangImmunity = undefined;
}


_radiusdamage( origin, range, maxdamage, mindamage, attacker )
{
	if ( !isdefined( attacker ) )
		RadiusDamage( origin, range, maxdamage, mindamage );
	else
		RadiusDamage( origin, range, maxdamage, mindamage, attacker );
}




mask_interactives_in_volumes( volumes )
{
	tvs = GetEntArray( "interactive_tv", "targetname" );

	foreach ( volume in volumes )
	{
		volume.interactives = [];
	}

	foreach ( tv in tvs )
	{
		foreach ( volume in volumes )
		{
			if ( !volume IsTouching( tv ) )
				continue;

			volume put_interactive_in_volume( tv );
			break;
		}
	}
}


activate_interactives_in_volume()
{
	if ( !isdefined( self.interactives ) )
		return;

	foreach ( ent in self.interactives )
	{
		toy = Spawn( "script_model", ( 0, 0, 0 ) );

		toy SetModel( ent.toy_model );
		toy.origin = ent.origin;
		toy.angles = ent.angles;
		toy.script_noteworthy = ent.script_noteworthy;
		toy.target = ent.target;
		toy.targetname = ent.targetname;

		toy thread maps\_interactive_objects::tv_logic();
	}

	self.interactives = [];
}


mask_destructibles_in_volumes( volumes )
{
	destructible_toy = GetEntArray( "destructible_toy", "targetname" );
	foreach ( volume in volumes )
	{
		volume.destructibles = [];
	}

	foreach ( toy in destructible_toy )
	{
		foreach ( volume in volumes )
		{
			if ( !volume IsTouching( toy ) )
				continue;

			volume put_toy_in_volume( toy );
			break;
		}
	}
}


activate_destructibles_in_volume()
{
	if ( !isdefined( self.destructibles ) )
		return;

	foreach ( ent in self.destructibles )
	{
		toy = Spawn( "script_model", ( 0, 0, 0 ) );

		toy SetModel( ent.toy_model );
		toy.origin = ent.origin;
		toy.angles = ent.angles;
		toy.script_noteworthy = ent.script_noteworthy;
		toy.target = ent.target;
		toy.destructible_type = ent.destructible_type;
		toy.script_noflip = ent.script_noflip;

		toy common_scripts\_destructible::setup_destructibles( true );// true meaning don't precache
	}

	self.destructibles = [];
}


setFlashbangImmunity( immune )
{
	self.flashBangImmunity = immune;
}



flashBangGetTimeLeftSec()
{
	Assert( IsDefined( self ) );
	Assert( IsDefined( self.flashEndTime ) );

	// duration is the flash time left
	durationMs = self.flashEndTime - GetTime();
	if ( durationMs < 0 )
		return 0;

	// return the duration in seconds
	return( durationMs * 0.001 );
}



flashBangIsActive()
{
	return( flashBangGetTimeLeftSec() > 0 );
}



flashBangStart( duration )
{
	Assert( IsDefined( self ) );
	Assert( IsDefined( duration ) );

	if ( IsDefined( self.flashBangImmunity ) && self.flashbangImmunity )
		return;

	// If we're alreayd flashing, update the time to the one that would last the longest
	newFlashEndTime = GetTime() + ( duration * 1000.0 );

	if ( IsDefined( self.flashendtime ) )
		self.flashEndTime = max( self.flashendtime, newFlashEndTime );
	else
		self.flashendtime = newFlashEndTime;

	self notify( "flashed" );
	self SetFlashBanged( true );
}


waittill_volume_dead()
{
	for ( ;; )
	{
		ai = GetAISpeciesArray( "axis", "all" );

		found_guy = false;
		foreach ( guy in ai )
		{
			if ( !isalive( guy ) )
				continue;
			if ( guy IsTouching( self ) )
			{
				found_guy = true;
				break;
			}

			// check all the time, 4 guys per frame
			wait( 0.0125 );
		}
		if ( !found_guy )
		{
			// do one more complete check
			aHostiles = self get_ai_touching_volume( "axis" );
			if ( !aHostiles.size )
				break;
		}
		wait( 0.05 );

		//aHostiles = self get_ai_touching_volume( "axis" );
		//if ( !aHostiles.size )
		//	break;
		//wait( 
		//waittill_dead( aHostiles );
	}
}


waittill_volume_dead_or_dying()
{
	ever_found_guy = false;
	for ( ;; )
	{
		ai = GetAISpeciesArray( "axis", "all" );

		found_guy = false;
		foreach ( guy in ai )
		{
			if ( !isalive( guy ) )
				continue;
			if ( guy IsTouching( self ) )
			{
				if ( guy doingLongDeath() )
					continue;

				found_guy = true;
				ever_found_guy = true;
				break;
			}

			// check all the time, 4 guys per frame
			wait( 0.0125 );
		}
		if ( !found_guy )
		{
			// do one more complete check
			aHostiles = self get_ai_touching_volume( "axis" );
			if ( !aHostiles.size )
			{
				break;
			}
			else
			{
				ever_found_guy = true;
			}
		}
		wait( 0.05 );

		//aHostiles = self get_ai_touching_volume( "axis" );
		//if ( !aHostiles.size )
		//	break;
		//wait( 
		//waittill_dead( aHostiles );
	}
	return ever_found_guy;
}


waittill_volume_dead_then_set_flag( sFlag )
{
	self waittill_volume_dead();
	flag_set( sFlag );
}


waittill_targetname_volume_dead_then_set_flag( targetname, msg )
{
	volume = GetEnt( targetname, "targetname" );
	AssertEx( IsDefined( volume ), "No volume for targetname " + targetname );
	volume waittill_volume_dead_then_set_flag( msg );
}


player_can_be_shot()
{
	level.player ent_flag_clear( "player_zero_attacker_accuracy" );
	level.player.IgnoreRandomBulletDamage = false;
	level.player maps\_gameskill::update_player_attacker_accuracy();
}


player_cant_be_shot()
{
	level.player ent_flag_set( "player_zero_attacker_accuracy" );
	level.player.attackeraccuracy = 0;
	level.player.IgnoreRandomBulletDamage = true;
}


set_player_attacker_accuracy( val )
{
	// sets player attackeraccuracy
	player = get_player_from_self();
	player.gs.player_attacker_accuracy = val;
	player maps\_gameskill::update_player_attacker_accuracy();
}


array_index_by_parameters( old_array )
{
	array = [];
	foreach ( item in old_array )
	{
		array[ item.script_parameters ] = item;
	}
	return array;
}


array_index_by_classname( old_array )
{
	array = [];
	foreach ( item in old_array )
	{
		array[ item.classname ] = item;
	}
	return array;
}


array_index_by_script_index( array )
{
	// sort ents by order of script_index
	newarray = [];
	foreach ( ent in array )
	{
		index = ent.script_index;
		if ( IsDefined( index ) )
		{
			AssertEx( !isdefined( newarray[ index ] ), "Multiple ents had the same script_index of " + index );

			newarray[ index ] = ent;
		}
	}

	return newarray;
}




add_target_pivot( ent )
{
	if ( IsDefined( ent ) )
	{
		self.pivot = ent;
	}
	else
	{
		AssertEx( IsDefined( self.target ), "Tried to add pivot to an entity but it has no target." );
		self.pivot = GetEnt( self.target, "targetname" );
		AssertEx( IsDefined( self.pivot ), "Tried to add pivot but there was no pivot entity. Must be a script mover, like a script_origin not script_struct." );
	}

	self LinkTo( self.pivot );
}


get_color_volume_from_trigger()
{
	info = self get_color_info_from_trigger();
	team = info[ "team" ];

	foreach ( code in info[ "codes" ] )
	{
		volume = level.arrays_of_colorCoded_volumes[ team ][ code ];
		if ( IsDefined( volume ) )
			return volume;
	}

	return undefined;
}


get_color_nodes_from_trigger()
{
	info = self get_color_info_from_trigger();
	team = info[ "team" ];

	foreach ( code in info[ "codes" ] )
	{
		nodes = level.arrays_of_colorCoded_nodes[ team ][ code ];
		if ( IsDefined( nodes ) )
			return nodes;
	}

	return undefined;
}



flashBangStop()
{
	self.flashendtime = undefined;
	self SetFlashBanged( false );
}


getent_or_struct( param1, param2 )
{
	ent = GetEnt( param1, param2 );
	if ( IsDefined( ent ) )
		return ent;
	return getstruct( param1, param2 );
}


grenade_earthQuake()
{
	// grenades die when they explode so we wait until the end of the frame before killing the thread.
	// not doing so would kill the thread before the fx could happen.
	self thread endOnDeath();
	self endon( "end_explode" );

	self waittill( "explode", position );
	
	dirt_on_screen_from_position( position );
}



dirt_on_screen_from_position( position )
{
	PlayRumbleOnPosition( "grenade_rumble", position );
	Earthquake( 0.3, 0.5, position, 400 );

	foreach ( player in level.players )
	{
		if ( Distance( position, player.origin ) > 600 )
			continue;

		if ( player DamageConeTrace( position ) )
			player thread dirtEffect( position );
	}
}


player_rides_shotgun_in_humvee( right, left, up, down )
{
	level.player AllowCrouch( false );
	level.player AllowProne( false );
	level.player DisableWeapons();

	org = spawn_tag_origin();
	org LinkTo( self, "tag_passenger", ( -5, 10, -34 ), ( 0, 0, 0 ) );
	org.player_dismount = spawn_tag_origin();
	org.player_dismount LinkTo( self, "tag_body", ( -8, -90, -12.6 ), ( 0, 0, 0 ) );
	//org.player_dismount thread maps\_debug::drawOrgForever( (1, 0, 0 ));

	if ( !isdefined( right ) )
		right = 90;
	if ( !isdefined( left ) )
		left = 90;
	if ( !isdefined( up ) )
		up = 40;
	if ( !isdefined( down ) )
		down = 40;

	level.player DisableWeapons();
	level.player PlayerLinkTo( org, "tag_origin", 0.8, right, left, up, down );

	return org;
}

player_leaves_humvee()
{
	self Unlink();
	move_time = 0.6;
	self MoveTo( self.player_dismount.origin, move_time, move_time * 0.5, move_time * 0.5 );
	wait( move_time );
	level.player Unlink();
	level.player EnableWeapons();
	level.player AllowCrouch( true );
	level.player AllowProne( true );
	self.player_dismount Delete();
	self Delete();
}

endOnDeath()
{
	self waittill( "death" );
	waittillframeend;
	self notify( "end_explode" );
}


dirtEffect( position )
{
	forwardVec = VectorNormalize( AnglesToForward( self.angles ) );
	rightVec = VectorNormalize( AnglesToRight( self.angles ) );
	grenadeVec = VectorNormalize( position - self.origin );

	fDot = VectorDot( grenadeVec, forwardVec );
	rDot = VectorDot( grenadeVec, rightVec );

	dirt_effects = [];

	if ( fDot > 0 && fDot > 0.5 && self GetCurrentWeapon() != "riotshield" )
		dirt_effects[ "bottom_b" ] = true;

	if ( abs( fDot ) < 0.866 )
	{
		if ( rDot > 0 )
			dirt_effects[ "right" ] = true;
		else
			dirt_effects[ "left" ] = true;
	}

	foreach ( type, _ in dirt_effects )
	{
		self thread maps\_gameskill::grenade_dirt_on_screen( type );
	}
}


pathrandompercent_set( value )
{
	if ( !isdefined( self.old_pathrandompercent ) )
		self.old_pathrandompercent = self.pathrandompercent;
	self.pathrandompercent = value;
}


pathrandompercent_zero()
{
	if ( IsDefined( self.old_pathrandompercent ) )
		return;

	self.old_pathrandompercent = self.pathrandompercent;
	self.pathrandompercent = 0;
}


pathrandompercent_reset()
{
	Assert( IsDefined( self.old_pathrandompercent ) );

	self.pathrandompercent = self.old_pathrandompercent;
	self.old_pathrandompercent = undefined;
}


walkdist_zero()
{
	if ( IsDefined( self.old_walkDistFacingMotion ) )
		return;

	self.old_walkDist 				 = self.walkDist;
	self.old_walkDistFacingMotion 	 = self.walkDistFacingMotion;

	self.walkdist 				 = 0;
	self.walkDistFacingMotion 	 = 0;
}


walkdist_reset()
{
	Assert( IsDefined( self.old_walkDist ) );
	Assert( IsDefined( self.old_walkDistFacingMotion ) );

	self.walkdist 				 = self.old_walkDist;
	self.walkDistFacingMotion 	 = self.old_walkDistFacingMotion;

	self.old_walkDist 				 = undefined;
	self.old_walkDistFacingMotion 	 = undefined;
}


enable_ignorerandombulletdamage_drone()
{
	//threading internally so script doesn't stop here...most our enable/disable utility code doesn't stop script.
	self thread ignorerandombulletdamage_drone_proc();
}

ignorerandombulletdamage_drone_proc()
{
	AssertEx( !IsSentient( self ), "AI tried to run enable_ignorerandombulletdamage_drone" );

	self endon( "disable_ignorerandombulletdamage_drone" );
	self endon( "death" );

	//just an easy variable we can check for debugging - doesn't actually do anything in code.
	self.IgnoreRandomBulletDamage = true;
	self.fakehealth = self.health;
	self.health = 1000000;

	while ( 1 )
	{
		self waittill( "damage", damage, attacker );

		if ( !isplayer( attacker ) && IsSentient( attacker ) )
		{
			if ( IsDefined( attacker.enemy ) && attacker.enemy != self )
				continue;
		}

		self.fakehealth -= damage;

		if ( self.fakehealth <= 0 )
			break;
	}

	self Kill();
}


hide_notsolid()
{
	if ( !isdefined( self.oldContents ) )
	{
		self.oldContents = self SetContents( 0 );
	}

	self Hide();
}


show_solid()
{
	if ( !isai( self ) )
		self Solid();
	
	if ( IsDefined( self.oldContents ) )
	{
		self SetContents( self.oldContents );
	}

	self Show();
}


set_brakes( num )
{
	self.veh_brake = num;
}



disable_ignorerandombulletdamage_drone()
{
	if ( !isalive( self ) )
		return;
	if ( !isdefined( self.IgnoreRandomBulletDamage ) )
		return;

	self notify( "disable_ignorerandombulletdamage_drone" );
	self.IgnoreRandomBulletDamage = undefined;
	self.health = self.fakehealth;
}

timeOutEnt( timeOut )
{
    ent = SpawnStruct();
    ent delayThread( timeOut, ::send_notify, "timeout" );
    return ent;
}



 
delayThread( timer, func, param1, param2, param3, param4, param5 )
{
	// to thread it off
	thread delayThread_proc( func, timer, param1, param2, param3, param4, param5 );
}



enable_danger_react( duration )
{
	duration *= 1000;

	Assert( IsAI( self ) );
	self.doDangerReact = true;
	self.dangerReactDuration = duration;
	self.neverSprintForVariation = undefined;
}



disable_danger_react()
{
	Assert( IsAI( self ) );
	self.doDangerReact = false;
	self.neverSprintForVariation = true;
}



set_group_advance_to_enemy_parameters( interval, group_size )
{
	level.advanceToEnemyInterval = interval;		// how often AI will try to run directly to their enemy if the enemy is not visible
	level.advanceToEnemyGroupMax = group_size;		// group size for AI running to their enemy
}



reset_group_advance_to_enemy_timer( team )
{
	Assert( IsDefined( level.lastAdvanceToEnemyTime[ team ] ) );
	level.lastAdvanceToEnemyTime[ team ] = GetTime();
}


set_custom_gameskill_func( func )
{
	Assert( IsDefined( func ) );
	level.custom_gameskill_func = func;

	// reset so it takes effect
	thread maps\_gameskill::resetSkill();
}


clear_custom_gameskill_func()
{
	level.custom_gameskill_func = undefined;

	// reset so it takes effect
	thread maps\_gameskill::resetSkill();
}


set_wind( weight, rate, variance )
{
	Assert( IsDefined( weight ) );
	Assert( IsDefined( rate ) );
	maps\_animatedmodels::init_wind_if_uninitialized();
	if ( IsDefined( variance ) )
		level.wind.variance = variance;
	level.wind.rate = rate;
	level.wind.weight = weight;
	level notify( "windchange", "strong" );
}


string_is_single_digit_integer( str )
{
	if ( str.size > 1 )
	{
		return false;
	}

	arr = [];
	arr[ "0" ] = true;
	arr[ "1" ] = true;
	arr[ "2" ] = true;
	arr[ "3" ] = true;
	arr[ "4" ] = true;
	arr[ "5" ] = true;
	arr[ "6" ] = true;
	arr[ "7" ] = true;
	arr[ "8" ] = true;
	arr[ "9" ] = true;

	if ( IsDefined( arr[ str ] ) )
	{
		return true;
	}

	return false;
}


set_battlechatter_variable( team, val )
{
	// used internally
	level.battlechatter[ team ] = val;
	update_battlechatter_hud();
}


objective_clearAdditionalPositions( objective_number )
{
	// can have up to 8 positions, so clear them all
	for ( i = 0; i < 8; i++ )
	{
		objective_additionalposition( objective_number, i, (0,0,0) );
	}
}



get_minutes_and_seconds( milliseconds )
{
	time = [];
	time[ "minutes" ] = 0;
	time[ "seconds" ] = Int( milliseconds / 1000 );

	while ( time[ "seconds" ] >= 60 )
	{
		time[ "minutes" ]++;
		time[ "seconds" ] -= 60;
	}
	if ( time[ "seconds" ] < 10 )
		time[ "seconds" ] = "0" + time[ "seconds" ];

	return time;
}


player_has_weapon( weap )
{
	weaponList = level.player GetWeaponsListPrimaries();
	foreach ( weapon in weaponList )
	{
		if ( weapon == weap )
			return true;
	}
	return false;
}


obj( msg )
{
	if ( !isdefined( level.obj_array ) )
	{
		level.obj_array = [];
	}
	
	if ( !isdefined( level.obj_array[ msg ] ) )
	{
		level.obj_array[ msg ] = level.obj_array.size + 1; // cause objs start at 1 not 0
	}
	
	return level.obj_array[ msg ];
}


MusicLoop( alias, delay_between_tracks )
{
	if ( !isdefined( delay_between_tracks ) )
		delay_between_tracks = 0;
				
	time = musicLength( alias );

	assertex( time + delay_between_tracks > 0, "No time for delay" );
	
	level notify( "stop_music" );
	level endon( "stop_music" );
	for ( ;; )
	{
		MusicPlayWrapper( alias );
		wait time;
		wait delay_between_tracks;
		
	}
}


player_mount_vehicle( vehicle )
{
	assert( isplayer( self ) );
	self MountVehicle( vehicle );
	self.drivingVehicle = vehicle;
}


player_dismount_vehicle()
{
	assert( isplayer( self ) );
	self DismountVehicle();
	self.drivingVehicle = undefined;
}



graph_position( v, min_x, min_y, max_x, max_y )
{
	rise = max_y - min_y;
	run = max_x - min_x;
	assertex( run != 0, "max and min x must be different, or you havent defined any graph space." );
	slope = rise / run;

	v -= max_x;

	v = slope * v;

	v += max_y;

	return v;
}





enable_achievement_harder_they_fall()
{
	self.rappeller = true;
}


disable_achievement_harder_they_fall()
{
	self.rappeller = undefined;
}

enable_achievement_harder_they_fall_guy( guy )
{
	guy enable_achievement_harder_they_fall();
}

disable_achievement_harder_they_fall_guy( guy )
{
	guy disable_achievement_harder_they_fall();
}

musicLength( alias )
{
	time = TableLookup( "sound/soundlength.csv", 0, alias, 1 );
	if ( !isdefined( time ) )
	{
		assertmsg( "No time stored in sound/soundlength.csv for " + alias );
		return -1;
	}
	
	time = int( time );
	assertex( time > 0, "Music alias " + alias + " had zero time." );
	time *= 0.001;
	return time;
}

is_command_bound( cmd )
{
	binding = GetKeyBinding( cmd );
	return binding[ "count" ];
}


set_hud_element_color( hud, color, glowcolor )
{
	hud.color = color;
	hud.glowcolor = glowcolor;
}

roundNumber( value, places, style )
{
	if ( !isdefined( style ) )
		style = "nearest";
	
	modifier = 1;
	for ( i = 0; i < places; i++ )
		modifier *= 10;
	
	newValue = value * modifier;
	
	if ( style == "up" )
		roundedValue = ceil( newValue );
	else if ( style == "down" )
		roundedValue = floor( newValue ); 	
	else
		roundedValue = newvalue + 0.5;	
		
	newvalue = Int( roundedValue );
	newvalue = newvalue / modifier;
	
	return newvalue;
}

get_hud_pos()
{

	hud_pos = GetDvar( "hud_pos", "top_right" );

	switch ( hud_pos )
	{
	case "top_right":
		xpos = -72;
		ypos = -60;
		break;
	case "top_left":
		xpos = -690;
		ypos = -60;
		break;
	case "bottom_right":
		xpos = -72;
		ypos = 210;
	case "bottom_left":
		xpos = -690;
		ypos = 210;
	case "middle":
		xpos = -360;
		ypos = 180;
		break;
	case "left":
		xpos = -690;
		ypos = 0;
		break;
	default:
		xpos = -72;
		ypos = -60;
		break;
	}

	x_offset = GetDvarInt( "hud_x_offset", 0 );
	y_offset = GetDvarInt( "hud_y_offset", 0 );

	xpos += x_offset;
	ypos += y_offset;

	// Clamp values
	xmin = -690;
	xmax = -25;
	ymin = -165;
	ymax = 285;

	if ( GetDVar( "hud_hide_label" ) == "1" )
		xmin = -780;

	xpos = clamp(xpos, xmin, xmax);
	ypos = clamp(ypos, ymin, ymax);

	pos = [];
	pos[0] = xpos;
	pos[1] = ypos;

	return pos;
}

GREEN = ( 0.6, 1, 0.6 );
GREEN_GLOW = ( 0.4, 0.7, 0.4 );
LIME = ( 0.8, 1, 0.6 );
LIME_GLOW = ( 0.6, 0.7, 0.4 );
YELLOW = ( 1, 1, 0.6 );
YELLOW_GLOW = ( 0.7, 0.7, 0.4 );
LEMON = ( 1, 0.8, 0.4 );
LEMON_GLOW = ( 0.7, 0.6, 0.2 );
ORANGE = ( 1, 0.6, 0.2 );
ORANGE_GLOW = ( 0.7, 0.4, 0.1 );
RED = ( 1, 0.2, 0 );
RED_GLOW = ( 0.7, 0.1, 0 );
DARK_RED = ( 0.6, 0, 0 );
DARK_RED_GLOW = ( 0.3, 0, 0 );

velocity_tracker( hud )
{
	while ( true )
	{
		wait 0.005;
		vel = self GetVelocity();
		velocity = Distance( ( vel[ 0 ], vel[ 1 ], 0 ), ( 0, 0, 0 ) );

		places = GetDvarInt("hud_velocity_decimal_places", 3);
		places = clamp(places, 0, 3);
		velocity = roundNumber(velocity, places);

		if ( velocity < 330 )
			set_hud_element_color( hud, GREEN, GREEN_GLOW );
		else if ( velocity <= 340 )
			set_hud_element_color( hud, LIME, LIME_GLOW );
		else if ( velocity <= 350 )
			set_hud_element_color( hud, YELLOW, YELLOW_GLOW );
		else if ( velocity <= 360 )
			set_hud_element_color( hud, LEMON, LEMON_GLOW );
		else if ( velocity <= 370 )
			set_hud_element_color( hud, ORANGE, ORANGE_GLOW );
		else if ( velocity <= 380 )
			set_hud_element_color( hud, RED,RED_GLOW );
		else
			set_hud_element_color( hud, DARK_RED, DARK_RED_GLOW );

		hud setValue( velocity );
	}
}

difficulty_tracker( hud )
{
    while( true )
    {
		switch(level.gameskill)
		{
        case 0:
            hud.label = "Recruit";
            set_hud_element_color(hud, GREEN, GREEN_GLOW);
			break;
        case 1:
            hud.label = "Regular";
            set_hud_element_color(hud, YELLOW, YELLOW_GLOW);
			break;
        case 2:
            hud.label = "Hardened";
            set_hud_element_color(hud, ORANGE, ORANGE_GLOW);
			break;
        case 3:
            hud.label = "Veteran";
            set_hud_element_color(hud, RED, RED_GLOW);
			break;
		default:
            hud.label = "Recruit";
            set_hud_element_color(hud, GREEN, GREEN_GLOW);
			break;
		}


        wait 5;
    }
}

fov_loop()
{
	while(true)
	{
		cur_fov = GetDVarInt("cg_fov");
		fov = GetDVarInt("sv_fov", -1);

		if (cur_fov != fov && fov > 0)
		{
			vel = self GetVelocity();
			velocity = Distance( ( vel[ 0 ], vel[ 1 ], 0 ), ( 0, 0, 0 ) );
			
			if (velocity > 0)
				SetSavedDvar("cg_fov", fov);
		}

		wait 0.05;
	}
}

position_huds(velocity_hud, difficulty_hud, velocity_label_hud, difficulty_label_hud)
{
	while (true)
	{
		hide_label = GetDVar( "hud_hide_label" ) == "1";
		decouple = GetDVar( "hud_decouple" ) == "1";
		hud_pos = get_hud_pos();
		xpos = hud_pos[0];
		ypos = hud_pos[1] / 15;

		if (hide_label)
		{
			velocity_label = "";
			difficulty_label = "";
		}
		else
		{
			velocity_label = "Velocity: ";
			difficulty_label = "Difficulty: ";
		}

		if (decouple)
		{
			difficulty_label_hud.x = -72;
			difficulty_label_hud.y = -115;
			difficulty_label_hud.label = "Difficulty: ";
			difficulty_hud.x = -72;
			difficulty_hud.y = -115;
		}
		else
		{
			difficulty_label_hud.x = xpos;
			difficulty_label_hud.y = -100 + (15 * ypos);
			difficulty_label_hud.label = difficulty_label;
			difficulty_hud.x = xpos;
			difficulty_hud.y = -100 + (15 * ypos);
		}


		velocity_label_hud.x = xpos;
		velocity_label_hud.y = -100 + (15 * (ypos + 1));
		velocity_label_hud.label = velocity_label;
		velocity_hud.x = xpos;
		velocity_hud.y = -100 + (15 * (ypos + 1));

		wait 0.1;
	}
}

enable_huds( )
{
	hud_pos = get_hud_pos();
	xpos = hud_pos[0];
	ypos = hud_pos[1] / 15;

	hide_label = GetDVar( "hud_hide_label" ) == "1";
	decouple = GetDVar( "hud_decouple" ) == "1";
	fov = GetDVarInt("sv_fov", -1);

	foreach (player in level.players)
	{
		difficulty_label_hud = maps\_specialops::so_create_hud_item( -1, -72, "Difficulty: ", player );
		difficulty_hud = maps\_specialops::so_create_hud_item( -1, -72, "", player );
		velocity_label_hud = maps\_specialops::so_create_hud_item( 0, -72, "Velocity: ", player );
		velocity_hud = maps\_specialops::so_create_hud_item( 0, -72, "", player );
		difficulty_hud.alignX = "left";
		velocity_hud.alignX = "left";

		player thread position_huds(velocity_hud, difficulty_hud, velocity_label_hud, difficulty_label_hud);
		player thread difficulty_tracker( difficulty_hud );
		player thread velocity_tracker( velocity_hud );

		if(fov > 0)
		{
			SetSavedDvar("cg_fov", fov);
			player thread fov_loop();
		}
	}
}