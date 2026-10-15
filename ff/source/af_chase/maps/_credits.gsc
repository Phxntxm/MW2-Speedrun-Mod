#include common_scripts\utility;
#include maps\_utility;

initCredits( type )
{
	flag_init( "atvi_credits_go" );
	level.linesize = 1.35;
	level.headingsize = 1.75;
	level.linelist = [];
	level.credits_speed = 22.5;
	level.credits_spacing = -120;
	
	set_console_status();
	if( !isdefined( type ) )
		type = "all";
		
	switch( type )
	{
		case "iw":
			initIWCredits();
			break;
		case "atvi":
			initActivisionCredits();
			break;
		case "all":
			initIWCredits();
			initActivisionCredits();
			break;
	}
}

initIWCredits()
{
	precachestring( &"CREDIT_DEVELOPED_BY" );
	
	initIWCredits_part1();
	initIWCredits_part2();
	initIWCredits_qa();
	initIWCredits_voice();
	initIWCredits_music();
	initIWCredits_music2();
	initIWCredits_spav();
	initIWCredits_add();
	initIWCredits_baby();	
	initWindowsStoreCredits();
	initOutrunCredits();
}

initIWCredits_part1()
{
	addImageIW( "logo_infinityward", 256, 128, 4.375 );
	addspace();
	
	
// Project Lead
	// JASON WEST
	addTitleNameIW( &"CREDIT_DIRECTED_BY", &"CREDIT_JASON_WEST" );
	addGap();
	
	
// Engineering Leads
	// RICHARD BAKER	
	addTitleNameIW( &"CREDIT_ENGINEERING_LEADS", &"CREDIT_RICHARD_BAKER" );
	// ROBERT FIELD
	addNameIW( &"CREDIT_ROBERT_FIELD" );
	// FRANCESCO GIGLIOTTI
	addNameIW( &"CREDIT_FRANCESCO_GIGLIOTTI" );
	// EARL HAMMON, JR
	addNameIW( &"CREDIT_EARL_HAMMON_JR" );
	addSpaceTitle();
	
// Engineering
	// CHAD BARB
	addTitleNameIW( &"CREDIT_ENGINEERING", &"CREDIT_CHAD_BARB" );
	// ALESSANDRO BARTOLUCCI
	addNameIW( &"CREDIT_ALESSANDRO_BARTOLUCCI" );
	// Simon Cournoyer
	addNameIW( &"CREDIT_Simon_Cournoyer" );
	// JON DAVIS
	addNameIW( &"CREDIT_JON_DAVIS" );
	// JOEL GOMPERT
	addNameIW( &"CREDIT_JOEL_GOMPERT" );
	// JOHN HAGGERTY
	addNameIW( &"CREDIT_JOHN_HAGGERTY" );
	// Chris Lambert
	addNameIW( &"CREDIT_Chris_Lambert" );
	// JON SHIRING
	addNameIW( &"CREDIT_JON_SHIRING" );
	// JIESANG SONG
	addNameIW( &"CREDIT_JIESANG_SONG" );
	// RAYME C VINSON
	addNameIW( &"CREDIT_RAYME_C_VINSON" );
	// ANDREW WANG
	addNameIW( &"CREDIT_ANDREW_WANG" );
	addGap();
	
	
// Design Leads
	// TODD ALDERMAN
	addTitleNameIW( &"CREDIT_DESIGN_LEADS", &"CREDIT_TODD_ALDERMAN" );
	// STEVE FUKUDA
	addNameIW( &"CREDIT_STEVE_FUKUDA" );
	// MACKEY MCCANDLISH
	addNameIW( &"CREDIT_MACKEY_MCCANDLISH" );
	// ZIED RIEKE
	addNameIW( &"CREDIT_ZIED_RIEKE" );
	addSpaceTitle();
	
// Design and Scripting
	// ROGER ABRAHAMSSON
	addTitleNameIW( &"CREDIT_DESIGN_AND_SCRIPTING", &"CREDIT_ROGER_ABRAHAMSSON" );
	// MOHAMMAD ALAVI
	addNameIW( &"CREDIT_MOHAMMAD_ALAVI" );
	// KEITH BELL
	addNameIW( &"CREDIT_KEITH_NED_BELL" );
	// Mike Denny
	addNameIW( &"CREDIT_Mike_Denny" );
	//Christopher Dionne
	addNameIW( &"CREDIT_Christopher_Dionne" );
	// PRESTON GLENN
	addNameIW( &"CREDIT_PRESTON_GLENN" );
	// CHAD GRENIER
	addNameIW( &"CREDIT_CHAD_GRENIER" );
	//Jordan Hirsh
	addNameIW( &"CREDIT_Jordan_Hirsh" );
	// JAKE KEATING
	addNameIW( &"CREDIT_JAKE_KEATING" );
	// JULIAN LUO
	addNameIW( &"CREDIT_JULIAN_LUO" );
	//Jason McCord
	addNameIW( &"CREDIT_Jason_McCord" );
	// BRENT MCLEOD
	addNameIW( &"CREDIT_BRENT_MCLEOD" );
	// JON PORTER
	addNameIW( &"CREDIT_JON_PORTER" );
	// ALEXANDER ROYCEWICZ
	addNameIW( &"CREDIT_ALEXANDER_ROYCEWICZ" );
	//Paul Sandler
	addNameIW( &"CREDIT_Paul_Sandler" );
	// NATHAN SILVERS
	addNameIW( &"CREDIT_NATHAN_SILVERS" );
	//Sean Slayback
	addNameIW( &"CREDIT_Sean_Slayback" );
	// GEOFFREY SMITH
	addNameIW( &"CREDIT_GEOFFREY_SMITH" );
	//Charlie Wiederhold
	addNameIW( &"CREDIT_Charlie_Wiederhold" );
	addGap();
	
	
// Art Director
	// RICHARD KRIEGLER	
	addTitleNameIW( &"CREDIT_ART_DIRECTOR", &"CREDIT_RICHARD_KRIEGLER" );
	addSpaceTitle();
	
// MICHAEL BOON
	// Technical Art Director
	addTitleNameIW( &"CREDIT_TECHNICAL_ART_DIRECT", &"CREDIT_MICHAEL_A_BOON" );
	addSpaceTitle();
	
// Art Leads
	// CHRIStopher CHERUBINI
	addTitleNameIW( &"CREDIT_ART_LEADS", &"CREDIT_CHRISTOPHER_CHERUBIN" );	
	// JOEL EMSLIE
	addNameIW( &"CREDIT_JOEL_EMSLIE" );
	// ROBERT GAINES
	addNameIW( &"CREDIT_ROBERT_GAINES" );
	addSpaceTitle();

// Art
	// BRAD ALLEN
	addTitleNameIW( &"CREDIT_ART", &"CREDIT_BRAD_ALLEN" );
	// PETER CHEN
	addNameIW( &"CREDIT_PETER_CHEN" );
	// William Cho
	addNameIW( &"CREDIT_William_Cho" );
	// Derric Eady
	addNameIW( &"CREDIT_Derric_Eady" );
	// Steven Giesler
	addNameIW( &"CREDIT_Steven_Giesler" );
	// JEFF HEATH
	addNameIW( &"CREDIT_JEFF_HEATH" );
	// David Johnson
	addNameIW( &"CREDIT_David_Johnson" );
	// RYAN LASTIMOSA
	addNameIW( &"CREDIT_RYAN_M_LASTIMOSA" );
	// OSCAR LOPEZ
	addNameIW( &"CREDIT_OSCAR_LOPEZ" );
	// Tim McGrath
	addNameIW( &"CREDIT_Tim_McGrath" );
	// TAEHOON OH
	addNameIW( &"CREDIT_TAEHOON_OH" );
	// SAMI ONUR
	addNameIW( &"CREDIT_SAMI_ONUR" );
	// VELINDA PELAYO
	addNameIW( &"CREDIT_VELINDA_PELAYO" );
	// Serozh Sarkisyan
	addNameIW( &"CREDIT_Serozh_Sarkisyan" );
	// RICHARD SMITH
	addNameIW( &"CREDIT_RICHARD_N_SMITH" );
	// THEERAPOL SRISUPHAN
	addNameIW( &"CREDIT_THEERAPOL_SRISUPHAN" );
	// TODD SUE
	addNameIW( &"CREDIT_TODD_SUE" );
	addGap();
	
	
// Animation Leads
	// MARK GRIGSBY
	addTitleNameIW( &"CREDIT_ANIMATION_LEADS", &"CREDIT_MARK_GRIGSBY" );	
	// PAUL MESSERLY
	addNameIW( &"CREDIT_PAUL_MESSERLY" );
	addSpaceTitle();

// Animation
	//Bruce Ferriz
	addTitleNameIW( &"CREDIT_ANIMATION", &"CREDIT_Bruce_Ferriz" );
	// CHANCE GLASCO
	addNameIW( &"CREDIT_CHANCE_GLASCO" );
	// ZACH VOLKER
	addNameIW( &"CREDIT_ZACH_VOLKER" );
	// LEI YANG
	addNameIW( &"CREDIT_LEI_YANG" );	
	addSpaceTitle();

//Motion Capture Integration
	//MARIO PEREZ
	addTitleNameIW( &"CREDIT_MOTION_CAPTURE_INTEG", &"CREDIT_MARIO_PEREZ" );
	addSpaceTitle();

// Technical Animation Lead
	// ERIC PIERCE
	addTitleNameIW( &"CREDIT_TECHNICAL_ANIMATION_LEAD", &"CREDIT_ERIC_PIERCE" );
	addSpaceTitle();
	
// Technical Animation
	// NEEL KAR
	addTitleNameIW( &"CREDIT_TECHNICAL_ANIMATION", &"CREDIT_NEEL_KAR" );
	// CHENG LOR
	addNameIW( &"CREDIT_CHENG_LOR" );		
	addGap();
	
	
// Audio Lead
	// MARK GANUS
	addTitleNameIW( &"CREDIT_AUDIO_LEAD", &"CREDIT_MARK_GANUS" );
	addSpaceTitle();

// Audio
	// CHRISSY ARYA
	addTitleNameIW( &"CREDIT_AUDIO", &"CREDIT_CHRISSY_ARYA" );
	// STEPHEN MILLER
	addNameIW( &"CREDIT_STEPHEN_MILLER" );
	addGap();
}

initIWCredits_part2()
{	
	
// Written by
	// JESSE STERN
	addTitleNameIW( &"CREDIT_WRITTEN_BY", &"CREDIT_JESSE_STERN" );
	addSpaceTitle();
	
// Additional Writing	
	// STEVE FUKUDA
	addTitleNameIW( &"CREDIT_ADDITIONAL_WRITING", &"CREDIT_STEVE_FUKUDA" );
	addSpaceTitle();
	
// Story by
	// TODD ALDERMAN
	addTitleNameIW( &"CREDIT_STORY_BY", &"CREDIT_TODD_ALDERMAN" );
	// STEVE FUKUDA
	addNameIW( &"CREDIT_STEVE_FUKUDA" );
	// MACKEY MCCANDLISH
	addNameIW( &"CREDIT_MACKEY_MCCANDLISH" );
	// ZIED RIEKE
	addNameIW( &"CREDIT_ZIED_RIEKE" );
	// JESSE STERN
	addNameIW( &"CREDIT_JESSE_STERN" );
	// JASON WEST
	addNameIW( &"CREDIT_JASON_WEST" );
	addSpaceTitle();
	
// Writer's Assistant
	// Aaron Tracy
	addTitleNameIW( &"CREDIT_WRITERS_ASSISTANT", &"CREDIT_Aaron_Tracy" );	
	addGap();	
	
	
// CEO / CFO
	//VINCE ZAMPELLA
	addTitleNameIW( &"CREDIT_CEO_CFO", &"CREDIT_VINCE_ZAMPELLA" );
	addSpaceTitle();
			
// Producer
	// MARK RUBIN
	addTitleNameIW( &"CREDIT_PRODUCER", &"CREDIT_MARK_A_RUBIN" );
	addSpaceTitle();
	
// Associate Producers
	// PETE BLUMEL
	addTitleNameIW( &"CREDIT_ASSOCIATE_PRODUCERS", &"CREDIT_PETE_BLUMEL" );
	// John Wasilczyk
	addNameIW( &"CREDIT_John_Wasilczyk" );
	addSpaceTitle();
			
// Office Manager
	// JANICE TURNER
	addTitleNameIW( &"CREDIT_OFFICE_MANAGER", &"CREDIT_JANICE_LOHR_TURNER" );
	addSpaceTitle();
	
// Human Resources Generalist
	// KRISTIN COTTERELL
	addTitleNameIW( &"CREDIT_HUMAN_RESOURCES_GENE", &"CREDIT_KRISTIN_COTTERELL" );
	addSpaceTitle();

// Executive Assistant
	// Carly Gillis
	addTitleNameIW( &"CREDIT_EXECUTIVE_ASSISTANT", &"CREDIT_CARLY_GILLIS" );
	addNameIW( &"CREDIT_CATHIE_ICHIGE" );	
	addSpaceTitle();
	
// Administrative Assistant
	// Lisa Stone
	addTitleNameIW( &"CREDIT_RECEPTION", &"CREDIT_Lisa_Stone" );
	addSpaceTitle();

// Community Relations Manager
	// ROBERT BOWLING
	addTitleNameIW( &"CREDIT_CREATIVE_STRATEGIST", &"CREDIT_ROBERT_BOWLING" );
	addSpaceTitle();
	
// PR Director, Owned Properties
	// MIKE MANTARRO
	addTitleNameIW( &"CREDIT_PR_DIRECTOR", &"CREDIT_MIKE_MANTARRO" );
	addSpaceTitle();
	
// DIRECTOR OF MARKETING
	// BYRON BEEDE
	addTitleNameIW( &"CREDIT_DIRECTOR_OF_MARKETIN_ATVI", &"CREDIT_BYRON_BEEDE");	
	addSpaceTitle();
	
//PRESIDENT / CCO	
	// JASON WEST  
	addTitleNameIW( &"CREDIT_PRESIDENT_CCO", &"CREDIT_JASON_WEST" );	
	addGap();	
	
// IT Manager
	// BRYAN KUHN
	addTitleNameIW( &"CREDIT_IT_MANAGER", &"CREDIT_BRYAN_KUHN" );
	addSpaceTitle();
	
// System Administrator
	// DREW MCCOY
	addTitleNameIW( &"CREDIT_System_Administrator", &"CREDIT_DREW_MCCOY" );
	addSpaceTitle();
	
//Information Systems Analyst
	// Chris Lai
	addTitleNameIW( &"CREDIT_INFORMATION_SYSTEMS_", &"CREDIT_Chris_Lai" );
	addSpaceTitle();
	
//Unix Systems Architect
	// ROBERT A. DYE
	addTitleNameIW( &"CREDIT_UNIX_SYSTEMS_ARCHITE", &"CREDIT_ROBERT_A_DYE" );
	addGap();


//Concept Art
	addTitleNameIW( &"CREDIT_CONCEPT_ART", &"CREDIT_RICHARD_KRIEGLER" );
	addNameIW( &"CREDIT_BRAD_ALLEN" );
	addNameIW( &"CREDIT_JOEL_EMSLIE" );
	addNameIW( &"CREDIT_RICHARD_N_SMITH" );
	addNameIW( &"CREDIT_NEEL_KAR" );
	addGap();


//extra
	addTitleNameIW( &"CREDIT_BATTLECHATTER_DIALOGUE", &"CREDIT_Sean_Slayback" );
	addSpaceTitle();
	addTitleNameIW( &"CREDIT_ADDITIONAL_MENU_SCRIPT", &"CREDIT_JULIAN_LUO" );
	addNameIW( &"CREDIT_BRENT_MCLEOD" );
	addGap();
}

initIWCredits_qa()
{
	//	Quality Assurance Manager
	// Mike Seal
	addTitleNameIW( &"CREDIT_QUALITY_ASSURANCE_MA", &"CREDIT_Mike_Seal" );
	addSpaceTitle();

//	Quality Assurance Floor Leads
	// Ed Harmer
	addTitleNameIW( &"CREDIT_QUALITY_ASSURANCE_FL", &"CREDIT_Ed_Harmer" );
	// Justin Harris
	addNameIW( &"CREDIT_Justin_Harris" );
	addSpaceTitle();

//	Quality Assurance
	// Mary Benitez
	addTitleNameIW( &"CREDIT_QUALITY_ASSURANCE", &"CREDIT_Mary_Benitez" );	
	// Chelsy Berry
	addNameIW( &"CREDIT_Chelsy_Berry" );	
	// Candice Capen
	addNameIW( &"CREDIT_Candice_Capen" );	
	// Terran Casey
	addNameIW( &"CREDIT_Terran_Casey" );	
	// Michael Penrod
	addNameIW( &"CREDIT_Michael_Penrod" );	
	// Anthony Rubin
	addNameIW( &"CREDIT_Anthony_Rubin" );	
	// Georgeina Schaller
	addNameIW( &"CREDIT_Georgeina_Schaller" );	
	// Chris Shepherd
	addNameIW( &"CREDIT_Chris_Shepherd" );	
	// John Theodore
	addNameIW( &"CREDIT_John_Theodore" );	
	// Daniel Wapner
	addNameIW( &"CREDIT_Daniel_Wapner" );	
	addGap();
}

initIWCredits_music()
{
// Main Themes By
	addTitleNameIW( &"CREDIT_MAIN_THEMES_BY", &"CREDIT_HANS_ZIMMER" );
	addSpaceTitle();	
	
// Music Produced by
	addTitleNameIW( &"CREDIT_MUSIC_PRODUCED_BY", &"CREDIT_HANS_ZIMMER" );	
	addNameIW( &"CREDIT_LORNE_BALFE" );
	addSpaceTitle();
		
// Music Composed By
	addTitleNameIW( &"CREDIT_MUSIC_COMPOSED_BY", &"CREDIT_LORNE_BALFE" );	
	addSpaceTitle();

// Additional Music 
	addTitleNameIW( &"CREDIT_ADDITIONAL_MUSIC_", &"CREDIT_MARK_MANCINA" );	
	addNameIW( &"CREDIT_NICK_PHOENIX" );
	addNameIW( &"CREDIT_THOMAS_BERGERSEN" );
	addNameIW( &"CREDIT_DAVE_METZGER" );	
	addNameIW( &"CREDIT_JACOB_SHEA" );	
	addNameIW( &"CREDIT_NOAH_SOROTA" );	
	addNameIW( &"CREDIT_ATLI_ORVARSSON" );	
	addSpaceTitle();
	
// Additional Arranging and Programming
	addTitleNameIW( &"CREDIT_ADDITIONAL_ARRANGING", &"CREDIT_BART_HENDRICKSON" );	
	addNameIW( &"CREDIT_CLAY_DUNCAN" );	
	addNameIW( &"CREDIT_RYELAND_ALLISON" );	
	addNameIW( &"CREDIT_ANDREW_KAWCZYNSKI" );	
	addNameIW( &"CREDIT_TOM_BRODERICK" );	
	addSpaceTitle();

// Music Editor
	addTitleNameIW( &"CREDIT_MUSIC_EDITOR", &"CREDIT_DAN_PINDER" );	
	addSpaceTitle();	

// Music Production Services 
	addTitleNameIW( &"CREDIT_MUSIC_PRODUCTION_SER", &"CREDIT_STEVEN_KOFSKY" );	
	addSpaceTitle();	

//Music Supervisor                           
	addTitleNameIW( &"CREDIT_MUSIC_SUPERVISOR", &"CREDIT_TOM_BRODERICK" );	
	addSpaceTitle();	

//Score Wrangler                               
	addTitleNameIW( &"CREDIT_SCORE_WRANGLER", &"CREDIT_BOB_BADAMI_2" );	
	addSpaceTitle();	
	
// Soloists - Guitar 
	addTitleNameIW( &"CREDIT_SOLOISTS_GUITAR", &"CREDIT_TOM_BRODERICK" );
	addSpaceTitle();

// Percussion
	addTitleNameIW( &"CREDIT_PERCUSSION", &"CREDIT_SATNAM_RAMGOTRA" );
	addNameIW( &"CREDIT_RYELAND_ALLISON" );
	addSpaceTitle();

// Violin          
	addTitleNameIW( &"CREDIT_VIOLIN", &"CREDIT_NOAH_SOROTA" );
	addSpaceTitle();

// Music Mixed by
	addTitleNameIW( &"CREDIT_MUSIC_MIXED_BY", &"CREDIT_ALAN_MEYERSON" );	
	addSpaceTitle();
	
// Additional Engineering
	addTitleNameIW( &"CREDIT_ADDITIONAL_ENGINEERI", &"CREDIT_KATIA_LEWIN_PALOMO" );
	addNameIW( &"CREDIT_SLAMM_ANDREWS" );
	addNameIW( &"CREDIT_JEFF_BIGGERS" );	
	addSpaceTitle();
	
// Assistant Engineer
	addTitleNameIW( &"CREDIT_ASSISTANT_ENGINEER", &"CREDIT_ADAM_SCHMIDT" );	
	addSpaceTitle();

// Production Coordinator for Hans Zimmer	
	addTitleNameIW( &"CREDIT_PROD_CORD_HANS_ZIMMER", &"CREDIT_ANDREW_ZACK" );	
	addGap();
		
//Music Mixed at REMOTE CONTROL PRODUCTIONS, INC             
	addTitleIW( &"CREDIT_MUSIC_MIXED_ATREMOT" );	
	addGap();
}

initIWCredits_voice()
{
	// Voice Talent
	
	addTitleIW( &"CREDIT_CAST_CAST" );
	addSpaceSmall();
	addcastIW( &"CREDIT_Lance_Henriksen", 	&"CREDIT_CAST_GENERAL_SHEPHERD", 	&"CREDIT_CAST_Lance_Henriksen" );
	addcastIW( &"CREDIT_Keith_David", 		&"CREDIT_CAST_SERGEANT_FOLEY",		&"CREDIT_CAST_Keith_David" );
	addcastIW( &"CREDIT_Barry_Pepper", 		&"CREDIT_CAST_CORPORAL_DUNN",		&"CREDIT_CAST_Barry_Pepper" );
	//addcastIW( &"CREDIT_Glen_Morshower", 	&"CREDIT_CAST_OVERLORD",			&"CREDIT_CAST_GLENN_MORSHOWER" );
	addcastIW( &"CREDIT_Kevin_McKidd", 		&"CREDIT_CAST_SOAP_MACTAVISH", 		&"CREDIT_CAST_Kevin_McKidd" );
	addcastIW( &"CREDIT_Roman_Varshavsky", 	&"CREDIT_CAST_MAKAROV",				&"CREDIT_CAST_Roman_Varshavsky" );
	addcastIW( &"CREDIT_CRAIG_FAIRBRASS", 	&"CREDIT_CAST_GHOST",				&"CREDIT_CAST_CRAIG_FAIRBRASS" );
	addcastIW( &"CREDIT_Sven_Holmberg",		&"CREDIT_CAST_NIKOLAI",				&"CREDIT_CAST_Sven_Holmberg" );	
	addcastIW( &"CREDIT_BILLY_MURRAY", 		&"CREDIT_CAST_CAPTAIN_PRICE", 		&"CREDIT_CAST_BILLY_MURRAY" );
	
	addSpace();
	
	addTitleNameIW( &"CREDIT_ADDITIONAL_VOICE_TALENT", &"CREDIT_Gabrielle_Al_Rajhi" );	
	addNameIW( &"CREDIT_Eugene_Alpers" );
	addNameIW( &"CREDIT_Will_Arnett" );
	addNameIW( &"CREDIT_Troy_Baker" );
	addNameIW( &"CREDIT_Brian_Bloom" );
	addNameIW( &"CREDIT_Alex_Bronquette" );
	addNameIW( &"CREDIT_Coy_Clark" );
	addNameIW( &"CREDIT_Michael_Cudlitz" );
	addNameIW( &"CREDIT_Enayat_Delawary" );
	addNameIW( &"CREDIT_Josh_Gilman" );
	addNameIW( &"CREDIT_Daniel_Gamburg" );
	addNameIW( &"CREDIT_Anna_Graves" );
	addNameIW( &"CREDIT_Mark_Grigsby" );
	addNameIW( &"CREDIT_Curtis_Jackson" );
	addNameIW( &"CREDIT_Boris_Kievsky" );
	addNameIW( &"CREDIT_Kristof_Konrad" );
	addNameIW( &"CREDIT_Mauricio_Lange" );
	addNameIW( &"CREDIT_Eugene_Lazareb" );
	addNameIW( &"CREDIT_Matt_Lindquist" );
	addNameIW( &"CREDIT_David_Lodge" );
	addNameIW( &"CREDIT_Graham_McTavish" );
	addNameIW( &"CREDIT_Dave_Mallow" );
	addNameIW( &"CREDIT_Jordan_Marder" );
	addNameIW( &"CREDIT_Matt_Mercer" );
	addNameIW( &"CREDIT_Glen_Morshower" );
	addNameIW( &"CREDIT_Sam_Sako" );
	addNameIW( &"CREDIT_Randy_Stonitsch" );
	addNameIW( &"CREDIT_Fred_Tatasciore" );
	addNameIW( &"CREDIT_Justin_Theroux" );
	addNameIW( &"CREDIT_Kirk_Thornton" );
	addNameIW( &"CREDIT_Fred_Toma" );
	addNameIW( &"CREDIT_Alex_Veadov" );
	addNameIW( &"CREDIT_Jim_Ward" );
	addNameIW( &"CREDIT_Kai_Wulf" );
	addGap();	
}

initIWCredits_spav()
{
// Cinematic movies provided by:
	addTitleIW( &"CREDIT_CINEMATIC_MOVIES_PRO" );	
	addSpaceSmall();
	
	// Spov (Design and Moving Image)
		addSubTitleNameIW( &"CREDIT_SPOVTV", &"CREDIT_Allen_Leitch" );
		addSubNameIW( &"CREDIT_Yugen_Blake" );
		addSubNameIW( &"CREDIT_Miles_Christensen" );
		addSubNameIW( &"CREDIT_Paul_Hunt" );
		addSubNameIW( &"CREDIT_David_Hicks" );
		addSubNameIW( &"CREDIT_Julio_Dean" );
		addSubNameIW( &"CREDIT_Gemma_Thompson" );
		addSubNameIW( &"CREDIT_Rhiwallon_Leadbeater" );
		addSubNameIW( &"CREDIT_Rob_Millington" );
		addSubNameIW( &"CREDIT_Steve_Townrow" );
		addSubNameIW( &"CREDIT_Vincent_Kane" );
		addSpaceTitle();
		
	//Spov Production Babies:
		addSubTitleNameIW( &"CREDIT_SPOV_PROD_BABIES", &"CREDIT_JACOB_HARTLEY_BLAKE" );
		addSubNameIW( &"CREDIT_BEATRICE_VB_L" );
		addSubNameIW( &"CREDIT_ELSPETH_MA_L" );
		addGap();
	
	
// additional art provided by	
	addTitleIW( &"CREDIT_TITLE_SEQUENCE" );	
	addSpaceSmall();
	
	// THE ANT FARM
	addsubTitleIW( &"CREDIT_THE_ANT_FARM" );
	addSpaceTitle();
		
		addSubTitleNameIW( &"CREDIT_PRODUCER", &"CREDIT_SCOTT_CARSON" );
		addSpaceTitle();
		
		addSubTitleNameIW( &"CREDIT_EXECUTIVE_CREATIVE_DIRECTOR", &"CREDIT_ROB_TROY" );
		addSpaceTitle();
		
		addSubTitleNameIW( &"CREDIT_ANT_FARM_PROD_BABIES", &"CREDIT_MARLEY_TROY" );
		addGap();	
}

initIWCredits_music2()
{
	if( getdvar( "ui_char_museum_mode" ) != "credits_black" )
	{	
		addTitleIW( &"CREDIT_CRIME_WAVE" );	
		addNameIW( &"CREDIT_CRIME_WAVE_LINE1" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE2" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE3" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE4" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE5" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE6" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE7" );
		addNameIW( &"CREDIT_CRIME_WAVE_LINE8" );
		addSpace();
		
		addTitleIW( &"CREDIT_SURVIVAL_SKILLS" );	
		addNameIW( &"CREDIT_SURVIVAL_SKILLS_LINE0" );
		addNameIW( &"CREDIT_SURVIVAL_SKILLS_LINE1" );
		addNameIW( &"CREDIT_SURVIVAL_SKILLS_LINE2" );
		addNameIW( &"CREDIT_SURVIVAL_SKILLS_LINE3" );
		addNameIW( &"CREDIT_SURVIVAL_SKILLS_LINE4" );
		addSpace();
		
		addTitleIW( &"CREDIT_DANGER" );	
		addNameIW( &"CREDIT_DANGER_LINE1" );
		addNameIW( &"CREDIT_DANGER_LINE2" );
		addNameIW( &"CREDIT_DANGER_LINE3" );
		addNameIW( &"CREDIT_DANGER_LINE4" );
		addSpace();
		
		addTitleIW( &"CREDIT_NEW_NEW" );	
		addNameIW( &"CREDIT_NEW_NEW_LINE1" );
		addNameIW( &"CREDIT_NEW_NEW_LINE2" );
		addNameIW( &"CREDIT_NEW_NEW_LINE3" );
		addNameIW( &"CREDIT_NEW_NEW_LINE4" );		
		addGap();
	}
	else
	{
		addCenterHeading( &"CREDIT_CRIME_WAVE" );	
		addSpaceSmall();
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE1" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE2" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE3" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE4" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE5" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE6" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE7" );
		addCenterHeading( &"CREDIT_CRIME_WAVE_LINE8" );
		addSpace();
		
		addCenterHeading( &"CREDIT_SURVIVAL_SKILLS" );	
		addSpaceSmall();
		addCenterHeading( &"CREDIT_SURVIVAL_SKILLS_LINE0" );
		addCenterHeading( &"CREDIT_SURVIVAL_SKILLS_LINE1" );
		addCenterHeading( &"CREDIT_SURVIVAL_SKILLS_LINE2" );
		addCenterHeading( &"CREDIT_SURVIVAL_SKILLS_LINE3" );
		addCenterHeading( &"CREDIT_SURVIVAL_SKILLS_LINE4" );
		addSpace();
		
		addCenterHeading( &"CREDIT_DANGER" );	
		addSpaceSmall();
		addCenterHeading( &"CREDIT_DANGER_LINE1" );
		addCenterHeading( &"CREDIT_DANGER_LINE2" );
		addCenterHeading( &"CREDIT_DANGER_LINE3" );
		addCenterHeading( &"CREDIT_DANGER_LINE4" );
		addSpace();
		
		addCenterHeading( &"CREDIT_NEW_NEW" );	
		addSpaceSmall();
		addCenterHeading( &"CREDIT_NEW_NEW_LINE1" );
		addCenterHeading( &"CREDIT_NEW_NEW_LINE2" );
		addCenterHeading( &"CREDIT_NEW_NEW_LINE3" );
		addCenterHeading( &"CREDIT_NEW_NEW_LINE4" );		
		addGap();
	}
}

initIWCredits_add()
{
//	Additional Sound Design, audio implementation and cinematic sound production provided by:
	addTitleIW( &"CREDIT_ADDITIONAL_SOUND_DES1" );
	if( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addTitleIW( &"CREDIT_ADDITIONAL_SOUND_DES3" );
	else
		addTitleIW( &"CREDIT_ADDITIONAL_SOUND_DES2" );
	addSpaceSmall();
	addSubTitleIW( &"CREDIT_EARBASH_AUDIO_INC" );
	addGap();
		
//Additional Voice Editing/Integration
	addTitleNameIW( &"CREDIT_ADDITIONAL_VOICE_EDI", &"CREDIT_JEREMY_SIMPSON" );
	addNameIW( &"CREDIT_Nakia_Harris" );
	addSpaceTitle();
	
// Additional Art provided by:
	addTitleNameIW( &"CREDIT_ADDITIONAL_ART", &"CREDIT_SHADOWS_IN_DARKNESS" );
	addNameIW( &"CREDIT_VYKARIAN" );
	addGap();


// Voice Recording Facilities in Los Angeles provided by
	addTitleIW( &"CREDIT_VOICE_RECORDING_FACI" );
	addSpaceSmall();

	addSubTitleIW( &"CREDIT_PCB_PRODUCTIONS_ENC" );	
	addSubTitleIW( &"CREDIT_SIDE_UK_LONDON_UK" );
	addSpaceTitle();	

	// Voice Direction/Dialog Engineering
	addSubTitleNameIW( &"CREDIT_VOICE_DIRECTION_DIAL", &"CREDIT_KEITH_AREM" );
	addSpaceTitle();

	// Additional Voice Direction
	addSubTitleNameIW( &"CREDIT_ADDITIONAL_VOICE_DIR", &"CREDIT_Steve_Fukuda" );
	//addSubNameIW( &"CREDIT_Mackey_McCandlish" );
	addGap();


// Sound Effects Recording
	addTitleNameIW( &"CREDIT_SOUND_EFFECTS_RECORD", &"CREDIT_JOHN_PAUL_FASAL" );
	addSpaceTitle();

// Video Editing
	addTitleNameIW( &"CREDIT_VIDEO_EDITING", &"CREDIT_Drew_McCoy" );
	addGap();
	

//Motion Capture provided by Neversoft Entertainment
	addTitleIW( &"CREDIT_MOTION_CAPTURE_PROVI" );
	addSpaceSmall();
	
	//Motion Capture Lead
	addSubTitleNameIW( &"CREDIT_MOTION_CAPTURE_LEAD", &"CREDIT_Kristina_Adelmeyer" );
	addSpaceTitle();
	
	// Motion Capture Technicians
	addSubTitleNameIW( &"CREDIT_MOTION_CAPTURE_TECHN", &"CREDIT_Anet_Hambarsumian" );
	addSubNameIW( &"CREDIT_Justin_Parish" );
	addSubNameIW( &"CREDIT_Sean_Watson" );
	addGap();
	
	
// Stunt Action designed by 87eleven Action Film Co.
	addTitleIW( &"CREDIT_STUNT_ACTION_DESIGNE" );
	addSpaceSmall();
	addTitleIW( &"CREDIT_WWW87ELEVENCOM" );
	addSpaceTitle();
	
	// Stunt Coordinator
	addSubTitleNameIW( &"CREDIT_STUNT_COORDINATOR", &"CREDIT_DANNY_HERNANDEZ" );
	addSpaceTitle();
	
	//Stunts/Motion Capture Actors
	addSubTitleNameIW( &"CREDIT_STUNTS_MOTION_CAPTUR", &"CREDIT_CLAYTON_BARBER" );
	addSubNameIW( &"CREDIT_Danny_Hernandez" );
	addSubNameIW( &"CREDIT_Allen_Jo" );
	addSubNameIW( &"CREDIT_Ralf_Koch" );
	addSubNameIW( &"CREDIT_Kenny_Richards" );
	addSubNameIW( &"CREDIT_Jackson_Spidell" );
	addSubNameIW( &"CREDIT_Jake_Swallow" );
	addSubNameIW( &"CREDIT_Don_Theerathada" );
	addSubNameIW( &"CREDIT_Justin_Williams" );
	addSubNameIW( &"CREDIT_Kofi_Yiadom" );
	addGap();
	
	
// Additional Design
	addTitleNameIW( &"CREDIT_ADDITIONAL_DESIGN", &"CREDIT_STEVE_MASSEY" );
	addSpaceTitle();

// Additional Art
	addTitleNameIW( &"CREDIT_ADDITIONAL_ART", &"CREDIT_JOE_SIMANELLO" );
	addGap();
	

// Military Technical Advisors
	// LT COL HANK KEIRSEY US ARMY (RET.)
	addTitleNameIW( &"CREDIT_MILITARY_TECHNICAL_A", &"CREDIT_LT_COL_HANK_KEIRSEY_" );
	// EMILIO CUESTA USMC
	addNameIW( &"CREDIT_EMILIO_CUESTA_USMC" );
	addGap();
	
	
// Weapons provided by
	addTitleNameIW( &"CREDIT_WEAPONS_PROVIDED_BY", &"CREDIT_INDEPENDENT_STUDIO_S" );
	addSpaceTitle();

// Armorer
	addTitleNameIW( &"CREDIT_ARMORER", &"CREDIT_LARRY_ZANOFF" );
	addGap();	
	
// Translations
	addTitleNameIW( &"CREDIT_TRANSLATIONS", &"CREDIT_GABRIELLE_AL_RAJHI" );
	addNameIW( &"CREDIT_ALEXANDRE_BRONQUETE" );
	addNameIW( &"CREDIT_ANTONINA_THOMPSON" );
	addNameIW( &"CREDIT_LEONELA_B_WAHRICK" );
	addGap();


// PREDATOR IS A U.S. REGISTERED TRADEMARK OF GENERAL ATOMICS AERONAUTICAL SYSTEMS, INC.
	addTitleIW( &"CREDIT_PREDATOR_IS_A_US_REG" );
	addTitleIW( &"CREDIT_PREDATOR_IS_A_US_REG2" );
	addSpace();

// SATELLITE IMAGERY PROVIDED BY GEOEYE. (WWW.GEOEYE.COM)"	
	addTitleIW( &"CREDIT_SATELLITE_IMAGERY_PR" );
	addTitleIW( &"CREDIT_SATELLITE_IMAGERY_PR2" );
	addgap();	
}

initIWCredits_baby()
{
// Production Babies
	addTitleIW( &"CREDIT_PRODUCTION_BABIES" );
	addSpaceSmall();
	addSubTitleIW( &"CREDIT_BABY_MARLEY_BLUMEL_A" );
	addSubTitleIW( &"CREDIT_BABY_HENRY_MICHAEL_B" );
	addSubTitleIW( &"CREDIT_BABY_CORALINE_BOWLIN" );
	addSubTitleIW( &"CREDIT_BABY_GREG_MCCOY_AND_" );
	addSubTitleIW( &"CREDIT_BABY_AUDREY_MCLEOD_A" );
	addSubTitleIW( &"CREDIT_BABY_SHANNON_SEOYEON" );
	addSubTitleIW( &"CREDIT_BABY_MARLEE_HENDRIX_" );
	addSubTitleIW( &"CREDIT_BABY_EMILY_JOYCE_POR" );
	addSubTitleIW( &"CREDIT_BABY_COOPER_RIEKE_AN" );
	addSubTitleIW( &"CREDIT_BABY_LUKE_SMITH_AND_" );
	addSubTitleIW( &"CREDIT_BABY_SONG_EJOOK_AND_" );
	addSubTitleIW( &"CREDIT_BABY_HUDSON_GEOFF_VO" );
	addGap();
	
//INFINITY WARD SPECIAL THANKS	
	addTitleIW( &"CREDIT_INFINITY_WARD_SPECIA" );
	addSpaceSmall();
	addSubTitleIW( &"CREDIT_LAWRENCE_GREEN" );
	addSubTitleIW( &"CREDIT_BENJAMIN_HECKENDORN" );
	addSubTitleIW( &"CREDIT_JOSHUA_LACROSS" );
	addSubTitleIW( &"CREDIT_NAVY_SEALS" );
	addGap();
}

addLeftTitle( title, textscale )
{
	precacheString( title );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "lefttitle";
	temp.title = title;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addLeftName( name, textscale )
{
	precacheString( name );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "leftname";
	temp.name = name;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addSubLeftTitle( title, textscale )
{
	addLeftName( title, textscale );
}

addSubLeftName( name, textscale )
{
	precacheString( name );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "subleftname";
	temp.name = name;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addRightTitle( title, textscale )
{
	precacheString( title );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "righttitle";
	temp.title = title;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addRightName( name, textscale )
{
	precacheString( name );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "rightname";
	temp.name = name;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addCenterHeading( heading, textscale )
{
	precacheString( heading );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "centerheading";
	temp.heading = heading;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addCenterSubtitle( heading, textscale )
{
	addCenterHeading( heading, textscale );
}

addCastName( name, title, textscale )
{
	precacheString( title );
	precacheString( name );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "castname";
	temp.title = title;
	temp.name = name;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addCenterName( name, textscale )
{
	precacheString( name );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "centername";
	temp.name = name;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addCenterNameDouble( name1, name2, textscale )
{
	precacheString( name1 );
	precacheString( name2 );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "centernamedouble";
	temp.name1 = name1;
	temp.name2 = name2;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addCenterDual( title, name, textscale )
{
	precacheString( title );
	precacheString( name );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "centerdual";
	temp.title = title;
	temp.name = name;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addCenterTriple( name1, name2, name3, textscale )
{
	precacheString( name1 );
	precacheString( name2 );
	precacheString( name3 );

	if ( !isdefined( textscale ) )
		textscale = level.linesize;

	temp = spawnstruct();
	temp.type = "centertriple";
	temp.name1 = name1;
	temp.name2 = name2;
	temp.name3 = name3;
	temp.textscale = textscale;

	level.linelist[ level.linelist.size ] = temp;
}

addSpace()
{
	temp = spawnstruct();
	temp.type = "space";

	level.linelist[ level.linelist.size ] = temp;
}

addSpaceSmall()
{
	temp = spawnstruct();
	temp.type = "spacesmall";

	level.linelist[ level.linelist.size ] = temp;
}

addCenterImage( image, width, height, delay )
{
	precacheShader( image );

	temp = spawnstruct();
	temp.type = "centerimage";
	temp.image = image;
	temp.width = width;
	temp.height = height;
	temp.sort = 2;

	if ( isdefined( delay ) )
		temp.delay = delay;

	level.linelist[ level.linelist.size ] = temp;
}

addLeftImage( image, width, height, delay )
{
	precacheShader( image );

	temp = spawnstruct();
	temp.type = "leftimage";
	temp.image = image;
	temp.width = width;
	temp.height = height;
	temp.sort = 2;

	if ( isdefined( delay ) )
		temp.delay = delay;

	level.linelist[ level.linelist.size ] = temp;
}

playCredits()
{
	VisionSetNaked( "", 0 );
	
	mode =  getdvar( "ui_char_museum_mode" );
	
	if( isdefined( mode ) && mode == "credits_1" )
	{
		hudelem = NewHudElem();
		hudelem.x = 0;
		hudelem.y = 0;
		hudelem.alignX = "center";
		hudelem.alignY = "middle";
		hudelem.horzAlign = "center";
		hudelem.vertAlign = "middle";
		hudelem.sort = 3;
		hudelem.foreground = true;
		hudelem SetText( &"CREDIT_DEVELOPED_BY" );
	//	hudelem.alpha = 0;
	//	hudelem FadeOverTime( 0.2 );
		hudelem.alpha = 1;
	
		hudelem.hidewheninmenu = false;
		hudelem.fontScale = 1.7;// was 1.6 and 2.4, larger font change
		hudelem.color = ( 0.8, 1.0, 0.8 );
		hudelem.font = "objective";
		hudelem.glowColor = ( 0.3, 0.6, 0.3 );
		hudelem.glowAlpha = 1;
		duration = 3000;
		hudelem SetPulseFX( 0, duration, 700 );// something, decay start, decay duration
		
		wait 3;
		hudelem delaycall( 1, ::destroy );
		wait 0.5;
	}	
	
	for ( i = 0; i < level.linelist.size; i++ )
	{
		delay = 0.5;// 0.4
		type = level.linelist[ i ].type;

		if ( type == "centerimage" )
		{
			if( isdefined( mode ) && mode != "credits_black" )
				flag_wait( "atvi_credits_go" );
				
			image = level.linelist[ i ].image;
			width = level.linelist[ i ].width;
			height = level.linelist[ i ].height;

			temp = newHudElem();
			temp SetShader( image, width, height );
			temp.alignX = "center";
			temp.horzAlign = "center";
			temp.x = 0;
			temp.y = 480;
			temp.sort = 2;
			temp.foreground = true;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;

			if ( isdefined( level.linelist[ i ].delay ) )
				delay = level.linelist[ i ].delay;
			else
				delay = ( ( 0.037 * height ) );
				//delay = ( ( 0.0296 * height ) );
		}
		else if ( type == "leftimage" )
		{
			image = level.linelist[ i ].image;
			width = level.linelist[ i ].width;
			height = level.linelist[ i ].height;

			temp = newHudElem();
			temp SetShader( image, width, height );
			temp.alignX = "center";
			temp.horzAlign = "left";
			temp.x = 128;
			temp.y = 480;
			temp.sort = 2;
			temp.foreground = true;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;

			delay = ( ( 0.037 * height ) );
			//delay = ( ( 0.0296 * height ) );
		}
		else if ( type == "lefttitle" )
		{
			title = level.linelist[ i ].title;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( title );
			temp.alignX = "left";
			temp.horzAlign = "left";
			temp.x = 28;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;		
			
			temp thread pulse_fx();
		}
		else if ( type == "leftname" )
		{
			name = level.linelist[ i ].name;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( name );
			temp.alignX = "left";
			temp.horzAlign = "left";
			temp.x = 60;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;
			
			temp thread pulse_fx();
		}
		else if ( type == "castname" )
		{
			title = level.linelist[ i ].title;
			name = level.linelist[ i ].name;
			textscale = level.linelist[ i ].textscale;
			
			temp1 = newHudElem();
			temp1 setText( title );
			temp1.alignX = "left";
			temp1.horzAlign = "left";
			temp1.x = 60;
			temp1.y = 480;

			if ( !level.console )
				temp1.font = "default";
			else
				temp1.font = "small";

			temp1.fontScale = textscale;
			temp1.sort = 2;
			temp1.glowColor = ( 0.3, 0.6, 0.3 );
			temp1.glowAlpha = 1;
			

			temp2 = newHudElem();
			temp2 setText( name );
			temp2.alignX = "right";
			temp2.horzAlign = "left";
			temp2.x = 275;
			temp2.y = 480;

			if ( !level.console )
				temp2.font = "default";
			else
				temp2.font = "small";

			temp2.fontScale = textscale;
			temp2.sort = 2;
			temp2.glowColor = ( 0.3, 0.6, 0.3 );
			temp2.glowAlpha = 1;
			
			

			temp1 thread delayDestroy( level.credits_speed );
			temp1 moveOverTime( level.credits_speed );
			temp1.y = level.credits_spacing;

			temp2 thread delayDestroy( level.credits_speed );
			temp2 moveOverTime( level.credits_speed );
			temp2.y = level.credits_spacing;
			
			temp1 thread pulse_fx();
			temp2 thread pulse_fx();
		}
		else if ( type == "subleftname" )
		{
			name = level.linelist[ i ].name;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( name );
			temp.alignX = "left";
			temp.horzAlign = "left";
			temp.x = 92;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;
			
			temp thread pulse_fx();
		}
		else if ( type == "righttitle" )
		{
			title = level.linelist[ i ].title;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( title );
			temp.alignX = "left";
			temp.horzAlign = "right";
			temp.x = -132;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;
			
			//temp thread pulse_fx();
		}
		else if ( type == "rightname" )
		{
			name = level.linelist[ i ].name;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( name );
			temp.alignX = "left";
			temp.horzAlign = "right";
			temp.x = -100;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;
			
			//temp thread pulse_fx();
		}
		else if ( type == "centerheading" )
		{
			heading = level.linelist[ i ].heading;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( heading );
			temp.alignX = "center";
			temp.horzAlign = "center";
			temp.x = 0;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;
			
			//temp thread pulse_fx();
		}
		else if ( type == "centerdual" )
		{
			title = level.linelist[ i ].title;
			name = level.linelist[ i ].name;
			textscale = level.linelist[ i ].textscale;

			temp1 = newHudElem();
			temp1 setText( title );
			temp1.alignX = "right";
			temp1.horzAlign = "center";
			temp1.x = -8;
			temp1.y = 480;

			if ( !level.console )
				temp1.font = "default";
			else
				temp1.font = "small";

			temp1.fontScale = textscale;
			temp1.sort = 2;
			temp1.glowColor = ( 0.3, 0.6, 0.3 );
			temp1.glowAlpha = 1;

			temp2 = newHudElem();
			temp2 setText( name );
			temp2.alignX = "left";
			temp2.horzAlign = "center";
			temp2.x = 8;
			temp2.y = 480;

			if ( !level.console )
				temp2.font = "default";
			else
				temp2.font = "small";

			temp2.fontScale = textscale;
			temp2.sort = 2;
			temp2.glowColor = ( 0.3, 0.6, 0.3 );
			temp2.glowAlpha = 1;

			temp1 thread delayDestroy( level.credits_speed );
			temp1 moveOverTime( level.credits_speed );
			temp1.y = level.credits_spacing;

			temp2 thread delayDestroy( level.credits_speed );
			temp2 moveOverTime( level.credits_speed );
			temp2.y = level.credits_spacing;
			
			//temp1 thread pulse_fx();
			//temp2 thread pulse_fx();
		}
		else if ( type == "centertriple" )
		{
			name1 = level.linelist[ i ].name1;
			name2 = level.linelist[ i ].name2;
			name3 = level.linelist[ i ].name3;
			textscale = level.linelist[ i ].textscale;

			temp1 = newHudElem();
			temp1 setText( name1 );
			temp1.alignX = "center";
			temp1.horzAlign = "center";
			temp1.x = -160;
			temp1.y = 480;

			if ( !level.console )
				temp1.font = "default";
			else
				temp1.font = "small";

			temp1.fontScale = textscale;
			temp1.sort = 2;
			temp1.glowColor = ( 0.3, 0.6, 0.3 );
			temp1.glowAlpha = 1;

			temp2 = newHudElem();
			temp2 setText( name2 );
			temp2.alignX = "center";
			temp2.horzAlign = "center";
			temp2.x = 0;
			temp2.y = 480;

			if ( !level.console )
				temp2.font = "default";
			else
				temp2.font = "small";

			temp2.fontScale = textscale;
			temp2.sort = 2;
			temp2.glowColor = ( 0.3, 0.6, 0.3 );
			temp2.glowAlpha = 1;

			temp3 = newHudElem();
			temp3 setText( name3 );
			temp3.alignX = "center";
			temp3.horzAlign = "center";
			temp3.x = 160;
			temp3.y = 480;

			if ( !level.console )
				temp3.font = "default";
			else
				temp3.font = "small";

			temp3.fontScale = textscale;
			temp3.sort = 2;
			temp3.glowColor = ( 0.3, 0.6, 0.3 );
			temp3.glowAlpha = 1;

			temp1 thread delayDestroy( level.credits_speed );
			temp1 moveOverTime( level.credits_speed );
			temp1.y = level.credits_spacing;

			temp2 thread delayDestroy( level.credits_speed );
			temp2 moveOverTime( level.credits_speed );
			temp2.y = level.credits_spacing;

			temp3 thread delayDestroy( level.credits_speed );
			temp3 moveOverTime( level.credits_speed );
			temp3.y = level.credits_spacing;
			
			//temp1 thread pulse_fx();
			//temp2 thread pulse_fx();
			//temp3 thread pulse_fx();			
		}
		else if ( type == "centername" )
		{
			name = level.linelist[ i ].name;
			textscale = level.linelist[ i ].textscale;

			temp = newHudElem();
			temp setText( name );
			temp.alignX = "left";
			temp.horzAlign = "center";
			temp.x = 8;
			temp.y = 480;

			if ( !level.console )
				temp.font = "default";
			else
				temp.font = "small";

			temp.fontScale = textscale;
			temp.sort = 2;
			temp.glowColor = ( 0.3, 0.6, 0.3 );
			temp.glowAlpha = 1;

			temp thread delayDestroy( level.credits_speed );
			temp moveOverTime( level.credits_speed );
			temp.y = level.credits_spacing;
			
			//temp thread pulse_fx();
		}
		else if ( type == "centernamedouble" )
		{
			name1 = level.linelist[ i ].name1;
			name2 = level.linelist[ i ].name2;
			textscale = level.linelist[ i ].textscale;

			temp1 = newHudElem();
			temp1 setText( name1 );
			temp1.alignX = "center";
			temp1.horzAlign = "center";
			temp1.x = -80;
			temp1.y = 480;

			if ( !level.console )
				temp1.font = "default";
			else
				temp1.font = "small";

			temp1.fontScale = textscale;
			temp1.sort = 2;
			temp1.glowColor = ( 0.3, 0.6, 0.3 );
			temp1.glowAlpha = 1;

			temp2 = newHudElem();
			temp2 setText( name2 );
			temp2.alignX = "center";
			temp2.horzAlign = "center";
			temp2.x = 80;
			temp2.y = 480;

			if ( !level.console )
				temp2.font = "default";
			else
				temp2.font = "small";

			temp2.fontScale = textscale;
			temp2.sort = 2;
			temp2.glowColor = ( 0.3, 0.6, 0.3 );
			temp2.glowAlpha = 1;

			temp1 thread delayDestroy( level.credits_speed );
			temp1 moveOverTime( level.credits_speed );
			temp1.y = level.credits_spacing;

			temp2 thread delayDestroy( level.credits_speed );
			temp2 moveOverTime( level.credits_speed );
			temp2.y = level.credits_spacing;
			
			//temp1 thread pulse_fx();
			//temp2 thread pulse_fx();
		}
		else if ( type == "spacesmall" )
			delay = 0.1875;// 0.15
		else
			assert( type == "space" );

		//wait 0.65;
		wait delay * ( level.credits_speed/ 22.5 );
	}

}

delayDestroy( duration )
{
	wait duration;
	self destroy();
}

pulse_fx()
{
	self.alpha = 0;
	wait level.credits_speed * .08;
	
	self FadeOverTime( 0.2 );
	self.alpha = 1;
	self SetPulseFX( 50, int( level.credits_speed * .6 * 1000 ), 500 );	
}

addSubLeftTitleNameSpace( title, name )
{
	addSubLeftTitle( title );
	addSpaceSmall();
	addSubLeftName( name );
	addSpace();
}

addLeftTitleNameSpace( title, name )
{
	addLeftTitle( title );
	addSpaceSmall();
	addLeftName( name );
	addSpace();
}

addLeftTitleName( title, name )
{
	addLeftTitle( title );
	addSpaceSmall();
	addLeftName( name );
}
	
addSubLeftTitleName( title, name )
{
	addSubLeftTitle( title );
	addSpaceSmall();
	addSubLeftName( name );
}	

addLeftNameName( name1, name2 )
{
	addLeftName( name1 );
	addLeftName( name2 );
}

addSubLeftNameName( name1, name2 )
{
	addSubLeftName( name1 );
	addSubLeftName( name2 );
}

addSubLeftNameNameName( name1, name2, name3 )
{
	addSubLeftName( name1 );
	addSubLeftName( name2 );
	addSubLeftName( name3 );
}

addImageIW( image, width, height, delay )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addLeftImage( image, width, height, delay );
	else
		addCenterImage( image, width, height, delay );
}

addTitleIW( title )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addLeftTitle( title );
	else
		addCenterHeading( title );
}

addSubTitleIW( title )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addSubLeftTitle( title );
	else
		addCenterHeading( title );
}

addTitleNameIW( title, name )
{	
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
	{
		addLeftTitle( title );
		addSpaceSmall();
		addLeftName( name );
	}
	else
		addCenterDual( title, name );
}

addSubTitleNameIW( title, name )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
	{
		addSubLeftTitle( title );
		addSpaceSmall();
		addSubLeftName( name );
	}
	else
		addCenterDual( title, name );
}

addcastIW( name, title, combo )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addCastName( name, title );
	else
		addCenterHeading( name );
}

addNameIW( name )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addLeftName( name );
	else
		addCenterName( name );
}

addSubNameIW( name )
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addSubLeftName( name );
	else
		addCenterName( name );
}

addSpaceTitle()
{
	if ( getdvar( "ui_char_museum_mode" ) != "credits_black" )
		addSpace();
	else	
		addSpaceSmall();
}

addGap()
{
	addSpace();
	addSpace();
}


initActivisionCredits()
{
	initATVICredits_atvi();
	initATVICredits_pr();
	initATVICredits_europe();
	initATVICredits_central_tech();
	initATVICredits_blade();
	initATVICredits_demonware();
	initATVICredits_global();
	initATVICredits_business();
	initATVICredits_qa1();
	initATVICredits_qa2();
	initATVICredits_qa3();
	initATVICredits_qa4();
	initATVICredits_end();
}

initATVICredits_atvi()
{
	addCenterImage( "logo_activision", 256, 128, 3.875 );// 3.1
	addSpace();
	addSpace();
			
	// Production
	addCenterHeading( &"CREDIT_PRODUCTION" );
	addSpaceSmall();
	// Producer
	// CHRIS WILLIAMS
	addCenterDual( &"CREDIT_PRODUCER", &"CREDIT_CHRIS_WILLIAMS" );
	addSpaceSmall();
	// Associate Producers
	// VINCENT FENNEL
	addCenterDual( &"CREDIT_ASSOCIATE_PRODUCERS", &"CREDIT_VINCENT_FENNEL" );
	// TAYLOR LIVINGSTON
	addCenterName( &"CREDIT_TAYLOR_LIVINGSTON" );
	// DEREK RACCA
	addCenterName( &"CREDIT_DEREK_RACCA" );
	addSpaceSmall();
	// Production Coordinator
	// ADRIENNE ARRASMITH
	addCenterDual( &"CREDIT_PRODUCTION_COORDINAT", &"CREDIT_ADRIENNE_ARRASMITH" );
	addSpaceSmall();
	
	// Additional Production
	//RHETT CHASSEREAU
	addCenterDual( &"CREDIT_ADDITIONAL_PRODUCTIO", &"CREDIT_RHETT_CHASSEREAU");
	addSpaceSmall();
	// Senior Executive Producer
	// MARCUS IREMONGER
	addCenterDual( &"CREDIT_SENIOR_EXECUTIVE_PRO", &"CREDIT_MARCUS_IREMONGER" );
	addSpaceSmall();
	// Vice President, Production
	// STEVE ACKRICH
	addCenterDual( &"CREDIT_HEAD_OF_PRODUCTION", &"CREDIT_STEVE_ACKRICH" );
	addGap();
}
	
initATVICredits_pr()
{		
	// Public Relations
	addCenterHeading( &"CREDIT_PUBLIC_RELATIONS" );
	addSpaceSmall();
	// Director, Owned Properties
	// MIKE MANTARRO
	addCenterDual( &"CREDIT_DIRECTOR_OWNED_PROPE", &"CREDIT_MIKE_MANTARRO" );
	addSpaceSmall();
	// PR Manager	
	// JOHN RAFACZ
	addCenterDual( &"CREDIT_PR_MANAGER", &"CREDIT_JOHN_RAFACZ" );
	addSpaceSmall();
	// Junior Publicist
	// MONICA PONTRELLI
	addCenterDual( &"CREDIT_JUNIOR_PUBLICIST", &"CREDIT_MONICA_PONTRELLI" );
	// JOSHUA SELINGER
	addCenterName( &"CREDIT_JOSHUA_SELINGER");
	addSpaceSmall();
	//European PR Director
	// NICK GRANGE
	addCenterDual( &"CREDIT_EUROPEAN_PR_DIRECTOR", &"CREDIT_NICK_GRANGE");

	addGap();
}

initATVICredits_europe()
{		
	// Production Services - Europe
	addCenterHeading( &"CREDIT_PRODUCTION_SERVICES_");
	addSpaceSmall();
	// Senior Director of Production Services - Europe
	// BARRY KEHOE
	addCenterDual( &"CREDIT_SENIOR_DIRECTOR_OF_P", &"CREDIT_BARRY_KEHOE" );
	addSpaceSmall();
	// Localization Manager
	// FIONA EBBS
	addCenterDual( &"CREDIT_LOCALISATION_MANAGER", &"CREDIT_FIONA_EBBS" );		
	addSpaceSmall();
	// Senior Localization Project Manager
	// ANNETTE LEE
	addCenterDual( &"CREDIT_SENIOR_LOCALIZATION_", &"CREDIT_ANNETTE_LEE" );				
	addSpaceSmall();
	// Localization Project Manager
	// JACK O'HARA
	addCenterDual( &"CREDIT_LOCALISATION_PROJECT", &"CREDIT_JACK_OHARA" );		
	addSpaceSmall();			
	// Localization QA Manager
	// DAVID HICKEY
	addCenterDual( &"CREDIT_LOCALISATION_QA_MANA", &"CREDIT_DAVID_HICKEY" );			
	addSpaceSmall();
	
	// Localization Assistant QA Manager
	// YVONNE COSTELLO		
	addCenterDual( &"CREDIT_LOCALISATION_ASSISTA", &"CREDIT_YVONNE_COSTELLO" );		
	addGap();
	
	
	//Localization QA Testers
	addCenterHeading( &"CREDIT_LOCALIZATION_QA_TEST");	
	addSpaceSmall();			
	// LUIS HERNANDEZ DALMAU 
	// VINCENZO FERRARA
	addCenterNameDouble( &"CREDIT_LUIS_HERNANDEZ_DALMA", &"CREDIT_VINCENZO_FERRARA_" );	
	// LARA SOLA GALLEGO
	// JEREMY LEVI		
	addCenterNameDouble( &"CREDIT_LARA_SOLA_GALLEGO", &"CREDIT_JEREMY_LEVI_" );		
	// SEBASTIEN MAZZERBO 
	// DARIO MILONE		
	addCenterNameDouble( &"CREDIT_SEBASTIEN_MAZZERBO_", &"CREDIT_DARIO_MILONE_" );	
	// KERILL MEIER O’BRIEN
	// MARCELL WITEK			
	addCenterNameDouble( &"CREDIT_KERILL_MEIER_OBRIEN", &"CREDIT_MARCELL_WITEK_" );				
	addSpace();
	
	//IT Network Technician
	// FERGUS LINDSAY 
	addCenterDual( &"CREDIT_IT_NETWORK_TECHNICIA", &"CREDIT_FERGUS_LINDSAY_" );	
	addGap();
	
	
	// LOCALIZATION TOOLS & SUPPORT PROVIDED BY STEPHANIE DEMING & XLOC INC.
	addCenterHeading( &"CREDIT_LOCALIZATION_TOOLS_");				
	addGap();
}

initATVICredits_central_tech()
{
	// Central Technology					
	addCenterHeading( &"CREDIT_CENTRAL_TECHNOLOGY");
	addSpaceSmall();

	// VP Art Production
	// ALESSANDRO TENTO
	addCenterDual( &"CREDIT_VP_ART_PRODUCTION", &"CREDIT_ALESSANDRO_TENTO_");
	addSpace();	
	
	addCenterHeading( &"CREDIT_ENGINEERING" );
	addSpaceSmall();
	// VP of Online
	// JOHN BOJORQUEZ
	addCenterDual( &"CREDIT_VP_OF_ONLINE_", &"CREDIT_JOHN_BOJORQUEZ");		
	addSpaceSmall();	
	// Managing Director, Demonware
	// PAT GRIFFITH
	addCenterDual( &"CREDIT_MANAGING_DIRECTOR_DE", &"CREDIT_PAT_GRIFFITH_");	
	addSpaceSmall();
	// Technical Director
	// WADE BRAINERD
	addCenterDual( &"CREDIT_TECHNICAL_DIRECTOR", &"CREDIT_WADE_BRAINERD_");
	addSpace();
	
	// Studio Central - Outsourcing	
	addCenterHeading( &"CREDIT_STUDIO_CENTRAL_OUT");				
	addSpaceSmall();	
	// Director Art Production
	// RICCARD LINDE
	addCenterDual( &"CREDIT_DIRECTOR_ART_PRODUCT", &"CREDIT_RICCARD_LINDE");	
	addSpaceSmall();
			
	// BERNARDO ANTONIAZZI
	addCenterDual( &"CREDIT_TECHNICAL_ART_DIRECT", &"CREDIT_BERNARDO_ANTONIAZZI");	
	addCenterName( &"CREDIT_MITCH_BOWLER");	
	addSpaceSmall();
	
	// Production Manager
	// Michael Restifo
	addCenterDual( &"CREDIT_PRODUCTION_MANAGER", &"CREDIT_MICHAEL_RESTIFO");				
	addSpaceSmall();
	// CHRISTOPHER CODDING	
	addCenterDual( &"CREDIT_PRODUCTION_COORDINAT", &"CREDIT_CHRISTOPHER_CODDING");				
	addGap();
}

initATVICredits_blade()
{
	// Blade Games World, Inc.
	addCenterDual( &"CREDIT_ADDITIONAL_ART", &"CREDIT_BLADE_GAMES_WORLD_IN" );	
	addGap();
}		

initATVICredits_demonware()
{
	// Demonware
	addCenterHeading( &"CREDIT_DEMONWARE");	
	addSpaceSmall();
	addCenterNameDouble( &"CREDIT_MICHAEL_COLLINS", &"CREDIT_PAUL_FROESE");	
	addCenterNameDouble( &"CREDIT_JOHN_KIRK", &"CREDIT_EMMANUEL_STONE");
	addCenterNameDouble( &"CREDIT_JASON_WEI", "");
	addGap();
}

initATVICredits_global()
{		
	// GLOBAL BRAND MANAGEMENT
	addCenterHeading( &"CREDIT_GLOBAL_BRAND_MANAGEM");
	addSpaceSmall();
	// DIRECTOR OF MARKETING
	// ROB KOSTICH
	addCenterDual( &"CREDIT_VICE_PRESIDENT_OF_MA", &"CREDIT_ROB_KOSTICH");		
	addSpaceSmall();
	// DIRECTOR OF MARKETING
	// BYRON BEEDE
	addCenterDual( &"CREDIT_DIRECTOR_OF_MARKETIN", &"CREDIT_BYRON_BEEDE");	
	addSpaceSmall();
	// GLOBAL BRAND MANAGER
	// GEOFF_CARROLL	
	addCenterDual( &"CREDIT_GLOBAL_BRAND_MANAGER", &"CREDIT_GEOFF_CARROLL");			
	addSpaceSmall();
	// ASSOCIATE BRAND MANAGERS
	// JOE KORSMO
	addCenterDual( &"CREDIT_ASSOCIATE_BRAND_MANA", &"CREDIT_JOE_KORSMO");	
	// MIKE SCHAEFER
	addCenterName( &"CREDIT_MIKE_SCHAEFER");	
	// DAVID WANG		
	addCenterName( &"CREDIT_DAVID_WANG");		
	addGap();
	
	
	// Art Services
	addCenterHeading( &"CREDIT_ART_SERVICES");	
	addSpaceSmall();
	// Art Services Lead
	// Chris Reinhart
	addCenterDual( &"CREDIT_ART_SERVICES_LEAD", &"CREDIT_CHRIS_REINHART");					
	addGap();	
}

initATVICredits_business()
{
	// Business and Legal Affairs		
	addCenterHeading( &"CREDIT_BUSINESS_AND_LEGAL_A");
	addSpaceSmall();
	// GREG DEUTSCH
	// JANE ELMS			
	addCenterNameDouble( &"CREDIT_GREG_DEUTSCH", &"CREDIT_JANE_ELMS");	
	// KAP KANG
	// KATE OGOSTA					
	addCenterNameDouble( &"CREDIT_KATE_OGOSTA_", &"CREDIT_AMANDA_OKEEFE");	
	// AMANDA O'KEEFE			
	// TRAVIS STANSBURY
	addCenterNameDouble( &"CREDIT_TRAVIS_STANSBURY", &"CREDIT_PHIL_TERZIAN");				
	// PHIL TERZIAN
	//MARY TUCK
	addCenterNameDouble( &"CREDIT_MARY_TUCK", "");		
	addGap();
		
		
	// Talent and Audio Management Group
	addCenterHeading( &"CREDIT_TALENT_AND_AUDIO_MAN");
	addSpaceSmall();
	// Talent Acquisition Manager
	// MARCHELE HARDIN
	addCenterDual( &"CREDIT_TALENT_ACQUISITION_M", &"CREDIT_MARCHELE_HARDIN");	
	addSpaceSmall();
	// Talent Associate
	// NOAH SARID
	addCenterDual( &"CREDIT_TALENT_ASSOCIATE", &"CREDIT_NOAH_SARID");					
	addSpaceSmall();
	// Talent Coordinator
	// STEFANI JONES
	addCenterDual( &"CREDIT_TALENT_COORDINATOR", &"CREDIT_STEFANI_JONES");								
	addGap();	
	
	
	addCenterHeading( &"CREDIT_FINANCE");
	addSpaceSmall();
	// VP of Studio Finance and Royalties
	// RAJ SAIN
	addCenterDual( &"CREDIT_VP_OF_STUDIO_FINANCE", &"CREDIT_RAJ_SAIN");	
	addSpaceSmall();
	// Finance Manager
	// CLINTON ALLEN
	addCenterDual( &"CREDIT_FINANCE_MANAGER", &"CREDIT_CLINTON_ALLEN");	
	addCenterName( &"CREDIT_HARJINDER_SINGH");
	addSpaceSmall();	
	// Sr. Financial Analyst
	// JASON JORDAN
	addCenterDual( &"CREDIT_SR_FINANCIAL_ANALYST", &"CREDIT_JASON_JORDAN");								
	addSpaceSmall();	
	// Finance Analyst
	// ADRIAN GOMEZ	
	addCenterDual( &"CREDIT_FINANCE_ANALYST", &"CREDIT_ADRIAN_GOMEZ");	
//	addCenterName( &"CREDIT_JASON_JORDAN");		
	addCenterName( &"CREDIT_FRANSISCA_TAN");		
	addGap();
	
		
	// Activision Special Thanks
	addCenterHeading( &"CREDIT_ACTIVISION_SPECIAL_T");	
	addSpaceSmall();
	addCenterHeading( &"CREDIT_MIKE_GRIFFITH_BRIAN_");		
	addGap();
}	
	
initATVICredits_qa1()
{		
	addCenterHeading( &"CREDIT_QUALITY_ASSURANCE_ATVI");	
	addSpaceSmall();
	// VP Quality Assurance/Customer Service
	// PAUL STERNGOLD
	addCenterDual( &"CREDIT_VP_QUALITY_ASSURANCE", &"CREDIT_PAUL_STERNGOLD");
	addSpace();
	
	// QA Project Lead
	//	Sean Berrett	
	addCenterDual( &"CREDIT_QUALITY_ASSURANCE_LEAD_ATVI", &"CREDIT_SEAN_BERRETT");	
	addSpaceSmall();
	// QA Floor Lead
	// Jay Menconi
	addCenterDual( &"CREDIT_QA_FLOOR_LEAD", &"CREDIT_JAY_MENCONI");		
	addSpaceSmall();	
	addCenterDual( &"CREDIT_QA_SENIOR_PROJECT_LE", &"CREDIT_HENRY_P_VILLANUEVA");	
	addSpaceSmall();
	addCenterDual( &"CREDIT_QA_MANAGER", &"CREDIT_GLENN_VISTANTE");	
	addSpaceSmall();		
	// Project Lead
	addCenterDual( &"CREDIT_PROJECT_LEAD", &"CREDIT_ERIK_MELEN_");	
	addSpace();
	
	// QA Testers
	addCenterHeading( &"CREDIT_QA_TESTERS");	
	addSpaceSmall();	
	addCenterTriple( &"CREDIT_CHAD_SCHMIDT_", &"CREDIT_ADAM_SMITH_", &"CREDIT_DAVION_FARRIS_");						
	addCenterTriple( &"CREDIT_JOHN_GOLDSWORTHY_", &"CREDIT_NATE_KINNEY_", &"CREDIT_RYAN_TRONDSEN_");
	addCenterTriple( &"CREDIT_TARIKH_BROWN_", &"CREDIT_PETE_ROMULO_PEDROZ", &"CREDIT_CHARLES_DAVIS_");	
	addCenterTriple( &"CREDIT_GABE_NOTO_", &"CREDIT_ULYSSES_HOLGUIN_", &"CREDIT_JOHN_ESTIOKO_");				
	addCenterTriple( &"CREDIT_XIAOHU_ALCOCER_", &"CREDIT_KEVIN_CHESTER_", &"CREDIT_DANIEL_HERSCHER_");
	addCenterTriple( &"CREDIT_LEVETT_WASHINGTON_", &"CREDIT_BRIAN_BAKER", &"CREDIT_MARK_RUZICKA");
	addCenterTriple( &"CREDIT_MATT_WELLMAN_", &"CREDIT_ANTHONY_MORENO_", &"CREDIT_CORY_FURLOW_");
	addCenterTriple( &"CREDIT_BRIAN_POST_", &"CREDIT_ANDREW_GRASS_", &"CREDIT_QUENTIN_TREMAYNE_C");
	addCenterTriple( &"CREDIT_ANDREW_GULOTTA_", &"CREDIT_RICH_BERNOT_", &"CREDIT_TABARI_JEFFRIES_");
	addCenterTriple( &"CREDIT_MICHAEL_MONTOYA_", &"CREDIT_CRAIG_NELSON_", &"CREDIT_BRANDON_ARONSON_");
	addCenterTriple( &"CREDIT_GREG_SANDS_", &"CREDIT_CARLOS_MORAN_", &"CREDIT_SEAN_MOLINE_");
	addCenterTriple( &"CREDIT_LOU_STUDDERT_", &"CREDIT_ROBERT_CHAPLAN_", &"CREDIT_JOSE_VEGA_");
	addCenterTriple( &"CREDIT_MIKE_ARDEN_", &"CREDIT_JOE_CHAVEZ_", &"CREDIT_BRADON_MILLER_");
	addGap();	
}

initATVICredits_qa2()
{				
	// Director, QA
	// CHRISTOPHER WILSON
	addCenterDual( &"CREDIT_DIRECTOR_QA", &"CREDIT_CHRISTOPHER_WILSON");		
	addSpaceSmall();
	// QA CRG Project Lead
	// MATT RYAN
	addCenterDual( &"CREDIT_QA_CRG_PROJECT_LEAD", &"CREDIT_MATT_RYAN");		
	addSpaceSmall();
	// QA CRG Floor Lead
	// JONATHAN MACK
	addCenterDual( &"CREDIT_QA_CRGFLOOR_LEAD", &"CREDIT_JONATHAN_MACK");		
	addSpaceSmall();
	// QA CRG Testers
	// CHRISTIAN VASCO
	addCenterDual( &"CREDIT_QA_CRG_TESTERS", &"CREDIT_CHRISTIAN_VASCO");		
	addSpace();
	
	// QA Network Lab
	addCenterHeading( &"CREDIT_QA_NETWORK_LAB");		
	addSpaceSmall();
	// Manager, QA Operations
	// CHRIS KEIM
	addCenterDual( &"CREDIT_MANAGER_QA_OPERATION", &"CREDIT_CHRIS_KEIM");		
	addSpaceSmall();	
	// QA Network Lab Project Leads
	// JESSIE JONES
	// LEONARD RODRIGUEZ			
	addCenterDual( &"CREDIT_QA_NETWORK_LAB_PROJE", &"CREDIT_JESSIE_JONES");	
	addCenterName( &"CREDIT_LEONARD_RODRIGUEZ");			
	addSpaceSmall();
	// QA Network Lab Tester
	// BRYAN CHICE
	addCenterDual( &"CREDIT_QA_NETWORK_LAB_TESTE", &"CREDIT_BRYAN_CHICE");	
	addSpace();
			
	addCenterHeading( &"CREDIT_QA_COMPATABILITY_LAB");	
	addSpaceSmall();
	addCenterDual( &"CREDIT_QACL_LAB_PROJECT_LE", &"CREDIT_ROBERT_FENOGLIO");	
	addCenterName( &"CREDIT_FARID_KAZIMI");												
	addCenterName( &"CREDIT_AUSTIN_KIENZLE");		
	addSpaceSmall();	
	addCenterDual( &"CREDIT_QACL_LAB_TESTERS", &"CREDIT_ALBERT_LEE");	
	addCenterName( &"CREDIT_WILLIAM_WHALEY");	
	addSpace();
}		

initATVICredits_qa3()
{		
	//QA AUDIO VISUAL LAB
	addCenterHeading( &"CREDIT_QA_AV_LAB");	
	addSpaceSmall();
	
	//QA AV Lab Senior Project Lead
	//Victor Durling
	addCenterDual( &"CREDIT_QA_AV_LAB_SR_PR_LEAD", &"CREDIT_VICTOR_DURLING");	
	addSpaceSmall();
	
	//QA AV Lab Senior Tester
	//Cliff Hooper
	addCenterDual( &"CREDIT_QA_AV_LAB_SR_TESTER", &"CREDIT_CLIFF_HOOPER");	
	addSpaceSmall();
	
	
	//QA AV Lab Testers
	//Delven Rutledge
	//Ryan Visteen
	addCenterDual( &"CREDIT_QA_AV_LAB_TESTERS", &"CREDIT_DELVEN_RUTLEDGE");
	addCenterName( &"CREDIT_RYAN_VISTEEN");			
	addSpace();

	// QA Mastering Lab
	addCenterHeading( &"CREDIT_QA_MASTERING_LAB");	
	addSpaceSmall();
			
	// Mastering Lab Supervisor
	// JOHN DONNELLY
	addCenterDual( &"CREDIT_MASTERING_LAB_SUPERV", &"CREDIT_JOHN_DONNELLY");	
	addSpaceSmall();
	
	// Lead Mastering Lab Technician
	// SEAN KIM
	addCenterDual( &"CREDIT_LEAD_MASTERING_LAB_T", &"CREDIT_SEAN_KIM");	
	addSpaceSmall();
	
	// Senior Mastering Lab Technician
	// DANNY FENG			
	addCenterDual( &"CREDIT_SENIOR_MASTERING_LAB", &"CREDIT_DANNY_FENG_");								
	addSpace();
	
	// Mastering Lab Technicians
	addCenterHeading( &"CREDIT_MASTERING_LAB_TECHNI");	
	addSpaceSmall();		
	addCenterTriple( &"CREDIT_TYREE_DERAMUS", &"CREDIT_JOSE_HERNANDEZ", &"CREDIT_KAI_HSU");	
	addCenterTriple( &"CREDIT_RODRIGO_MAGANA", &"CREDIT_STEVEN_RODRIGUEZ", &"CREDIT_LEEJAY_RONQUILLO");
	addCenterTriple( &"CREDIT_ORBEL_SHAKHMALIAN", &"CREDIT_GARY_WASHINGTON", &"");
	addSpace();
}		

initATVICredits_qa4()
{
	// Customer Support
	addCenterHeading( &"CREDIT_CUSTOMER_SUPPORT");						
	addSpaceSmall();
	// Customer Support Managers
	// Gary Bolduc
	// Michael Hill
	addCenterDual( &"CREDIT_CUSTOMER_SUPPORT_MAN", &"CREDIT_GARY_BOLDUC");							
	addCenterName( &"CREDIT_MICHAEL_HILL");		
	addGap();	
}	

initATVICredits_end()
{
	// Manual designed by Ignited Minds, LLC
	addCenterDual( &"CREDIT_MANUAL_DESIGN", &"CREDIT_IGNITED_MINDS_LLC");	
	addGap();		
	
	
	// Packaging Design by Hamagami/Carroll, Inc.
	addCenterDual( &"CREDIT_PACKAGING_DESIGN_BY", &"CREDIT_RICHARD_KRIEGLER");	
	addCenterName( &"CREDIT_HAMAGAMI");												
	addGap();
	
	
	// Fonts licensed from Monotype 
	// T26
	addCenterDual( &"CREDIT_FONTS_LICENSED_FROM", &"CREDIT_MONOTYPE");					
	addCenterName( &"CREDIT_T26");		
	addGap();
	

	// Uses Bink Video. Copyright © 1997-2007 by RAD Game Tools, Inc.
	addCenterHeading( &"CREDIT_USES_BINK_VIDEO_COPYRIGHT" );
	addSpace();
		
	// Uses Miles Sound System. Copyright © 1991-2007 by RAD Game Tools, Inc.
	addCenterHeading( &"CREDIT_USES_MILES_SOUND_SYSTEM" );// PC and 360 only
	addGap();
	addGap();
	addGap();
	
	
	// The characters and events depicted in this game are fictitious.
	addCenterHeading( &"CREDIT_THE_CHARACTERS_AND_EVENTS1" );
	// Any similarity to actual persons, living or dead, is purely coincidental.
	addCenterHeading( &"CREDIT_THE_CHARACTERS_AND_EVENTS2" );

}

initWindowsStoreCredits()
{
	addSpaceSmall();

	addSpaceSmall();

	//Windows Store Version 2024
	addCenterHeading( &"CREDITS_MSSTORE_WINDOWS_STORE_VERSION_2024" );

	addSpace();

	//Infinity Ward
	addCenterHeading( &"CREDITS_MSSTORE_INFINITY_WARD" );

	addSpaceSmall();

	//Dan Nelson
	addCenterTriple( "", &"CREDITS_MSSTORE_DAN_NELSON", "");

	//Rulon Raymond
	addCenterTriple( "", &"CREDITS_MSSTORE_RULON_RAYMOND", "");

	//Adam Gold
	addCenterTriple( "", &"CREDITS_MSSTORE_ADAM_GOLD", "");

	//Elliott Ehlig
	addCenterTriple( "", &"CREDITS_MSSTORE_ELLIOTT_EHLIG", "");

	//Mitch Sanborn
	addCenterTriple( "", &"CREDITS_MSSTORE_MITCH_SANBORN", "");

	//Simon Cournoyer
	addCenterTriple( "", &"CREDITS_MSSTORE_SIMON_COURNOYER", "");

	//Meghan House
	addCenterTriple( "", &"CREDITS_MSSTORE_MEGHAN_HOUSE", "");

	addSpace();
	
	//Sledgehammer Games
	addCenterHeading( &"CREDITS_MSSTORE_SLEDGEHAMMER_GAMES" );

	addSpaceSmall();
	
	//Jason Bell
	addCenterTriple( "", &"CREDITS_MSSTORE_JASON_BELL", "");
	
	addSpace();

	//Activision Publishing
	addCenterHeading( &"CREDITS_MSSTORE_ACTIVISION_PUBLISHING" );

	addSpaceSmall();

	//Senior Director
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_DIRECTOR" );

	//Christopher Wilson
	addCenterTriple( "", &"CREDITS_MSSTORE_CHRISTOPHER_WILSON", "");

	addSpaceSmall();

	//Producer
	addCenterSubtitle( &"CREDITS_MSSTORE_PRODUCER" );

	//David Lara
	addCenterTriple( "", &"CREDITS_MSSTORE_DAVID_LARA", "");

	addSpaceSmall();

	//Emerging Franchises
	addCenterSubtitle( &"CREDITS_MSSTORE_EMERGING_FRANCHISES" );

	//Jason Finn
	addCenterTriple( "", &"CREDITS_MSSTORE_JASON_FINN", "");

	//Becca Verstraete
	addCenterTriple( "", &"CREDITS_MSSTORE_BECCA_VERSTRAETE", "");

	//William De La Torre
	addCenterTriple( "", &"CREDITS_MSSTORE_WILLIAM_DE_LA_TORRE", "");

	//Kenny Lennon
	addCenterTriple( "", &"CREDITS_MSSTORE_KENNY_LENNON", "");

	//Ben Perry
	addCenterTriple( "", &"CREDITS_MSSTORE_BEN_PERRY", "");

	addSpace();
	
	//Beenox
	addCenterHeading( &"CREDITS_MSSTORE_BEENOX" );

	addSpaceSmall();

	//Lead Producer
	addCenterSubtitle( &"CREDITS_MSSTORE_LEAD_PRODUCER" );

	//Nicolas Bourgault
	addCenterTriple( "", &"CREDITS_MSSTORE_NICOLAS_BOURGAULT", "");

	addSpaceSmall();

	//Senior Production Coordinator
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_PRODUCTION_COORDINATOR" );

	//Gabriel Dion
	addCenterTriple( "", &"CREDITS_MSSTORE_GABRIEL_DION", "");

	addSpaceSmall();

	//Technical Director
	addCenterSubtitle( &"CREDITS_MSSTORE_TECHNICAL_DIRECTOR" );

	//Philippe Troie
	addCenterTriple( "", &"CREDITS_MSSTORE_PHILIPPE_TROIE", "");

	addSpaceSmall();

	//Lead Programmer
	addCenterSubtitle( &"CREDITS_MSSTORE_LEAD_PROGRAMMER" );

	//Benjamin Descamps
	addCenterTriple( "", &"CREDITS_MSSTORE_BENJAMIN_DESCAMPS", "");

	addSpaceSmall();

	//Expert Programmer
	addCenterSubtitle( &"CREDITS_MSSTORE_EXPERT_PROGRAMMER" );

	//Richard Harvey-Levert
	addCenterTriple( "", &"CREDITS_MSSTORE_RICHARD_HARVEYLEVERT", "");

	addSpace();

	//QA - Minnesota
	addCenterHeading( &"CREDITS_MSSTORE_QA__MINNESOTA" );

	addSpaceSmall();
	
	//Project Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_PROJECT_LEAD" );

	//Simon Wolfe
	addCenterTriple( "", &"CREDITS_MSSTORE_SIMON_WOLFE", "");

	addSpaceSmall();

	//Associate Project Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_ASSOCIATE_PROJECT_LEAD" );

	//Nicholas Littlefield
	addCenterTriple( "", &"CREDITS_MSSTORE_NICHOLAS_LITTLEFIELD", "");

	addSpaceSmall();

	//Senior Tester
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_TESTER" );

	//Gabriel Barott
	addCenterTriple( "", &"CREDITS_MSSTORE_GABRIEL_BAROTT", "");

	addSpaceSmall();

	//QA Tester
	addCenterSubtitle( &"CREDITS_MSSTORE_QA_TESTER" );

	//Alex Fox
	addCenterTriple( "", &"CREDITS_MSSTORE_ALEX_FOX", "");

	//Cason Lyons
	addCenterTriple( "", &"CREDITS_MSSTORE_CASON_LYONS", "");

	//Chue Vue
	addCenterTriple( "", &"CREDITS_MSSTORE_CHUE_VUE", "");

	//Emily Danko
	addCenterTriple( "", &"CREDITS_MSSTORE_EMILY_DANKO", "");

	//Eric Stites
	addCenterTriple( "", &"CREDITS_MSSTORE_ERIC_STITES", "");

	//Ian Hickel
	addCenterTriple( "", &"CREDITS_MSSTORE_IAN_HICKEL", "");

	//Kole Buscher
	addCenterTriple( "", &"CREDITS_MSSTORE_KOLE_BUSCHER", "");

	//Logan Klopp
	addCenterTriple( "", &"CREDITS_MSSTORE_LOGAN_KLOPP", "");

	//Michael Leonard
	addCenterTriple( "", &"CREDITS_MSSTORE_MICHAEL_LEONARD", "");

	//Michael Rauser
	addCenterTriple( "", &"CREDITS_MSSTORE_MICHAEL_RAUSER", "");

	//Michael Sullivan
	addCenterTriple( "", &"CREDITS_MSSTORE_MICHAEL_SULLIVAN", "");

	//Yai Chang
	addCenterTriple( "", &"CREDITS_MSSTORE_YAI_CHANG", "");

	addSpace();
	
	//Technical Requirements Group
	addCenterHeading( &"CREDITS_MSSTORE_TECHNICAL_REQUIREMENTS_GROUP" );

	addSpaceSmall();

	//Sr. TRG Platform Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_SR_TRG_PLATFORM_LEAD" );

	//Brian Bensi
	addCenterTriple( "", &"CREDITS_MSSTORE_BRIAN_BENSI", "");

	//Nicholas Blanchard
	addCenterTriple( "", &"CREDITS_MSSTORE_NICHOLAS_BLANCHARD", "");

	addSpaceSmall();

	//Platform Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_PLATFORM_LEAD" );

	//Kenneth Curtis
	addCenterTriple( "", &"CREDITS_MSSTORE_KENNETH_CURTIS", "");

	//Oliver Hsia
	addCenterTriple( "", &"CREDITS_MSSTORE_OLIVER_HSIA", "");

	//Donny Laws
	addCenterTriple( "", &"CREDITS_MSSTORE_DONNY_LAWS", "");

	//Alden Paguia
	addCenterTriple( "", &"CREDITS_MSSTORE_ALDEN_PAGUIA", "");

	addSpaceSmall();

	//Associate Project Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_ASSOCIATE_PROJECT_LEAD" );

	//Fin Burbey
	addCenterTriple( "", &"CREDITS_MSSTORE_FIN_BURBEY", "");

	//Colin Kawakami
	addCenterTriple( "", &"CREDITS_MSSTORE_COLIN_KAWAKAMI", "");

	//Dannette Salinas
	addCenterTriple( "", &"CREDITS_MSSTORE_DANNETTE_SALINAS", "");

	//Hunter Stokes
	addCenterTriple( "", &"CREDITS_MSSTORE_HUNTER_STOKES", "");

	//Jonathan Wood
	addCenterTriple( "", &"CREDITS_MSSTORE_JONATHAN_WOOD", "");

	addSpaceSmall();
	
	//Technical Requirements Specialist
	addCenterSubtitle( &"CREDITS_MSSTORE_TECHNICAL_REQUIREMENTS_SPECIAL" );

	//Zach Alicaway
	addCenterTriple( "", &"CREDITS_MSSTORE_ZACH_ALICAWAY", "");

	//Eric Castillo
	addCenterTriple( "", &"CREDITS_MSSTORE_ERIC_CASTILLO", "");

	//Kyle Cloos
	addCenterTriple( "", &"CREDITS_MSSTORE_KYLE_CLOOS", "");

	//David Delanty
	addCenterTriple( "", &"CREDITS_MSSTORE_DAVID_DELANTY", "");

	//Peter Doan
	addCenterTriple( "", &"CREDITS_MSSTORE_PETER_DOAN", "");

	//Andrea Livingston
	addCenterTriple( "", &"CREDITS_MSSTORE_ANDREA_LIVINGSTON", "");

	//Damien Miller
	addCenterTriple( "", &"CREDITS_MSSTORE_DAMIEN_MILLER", "");

	//Tom Shelley
	addCenterTriple( "", &"CREDITS_MSSTORE_TOM_SHELLEY", "");

	//Sara Valdez
	addCenterTriple( "", &"CREDITS_MSSTORE_SARA_VALDEZ", "");

	addSpaceSmall();

	//Sr. Requirements Tester
	addCenterSubtitle( &"CREDITS_MSSTORE_SR_REQUIREMENTS_TESTER" );

	//Tyler Perez
	addCenterTriple( "", &"CREDITS_MSSTORE_TYLER_PEREZ", "");

	//Tevin Wilkerson
	addCenterTriple( "", &"CREDITS_MSSTORE_TEVIN_WILKERSON", "");

	addSpaceSmall();

	//Technical Requirements Tester
	addCenterSubtitle( &"CREDITS_MSSTORE_TECHNICAL_REQUIREMENTS_TESTER" );

	//Kevin Baxter
	addCenterTriple( "", &"CREDITS_MSSTORE_KEVIN_BAXTER", "");

	//Brian Dionne
	addCenterTriple( "", &"CREDITS_MSSTORE_BRIAN_DIONNE", "");

	//Tim Fox
	addCenterTriple( "", &"CREDITS_MSSTORE_TIM_FOX", "");

	//Chris Tomlinson
	addCenterTriple( "", &"CREDITS_MSSTORE_CHRIS_TOMLINSON", "");

	addSpace();
	
	//QA - Labs
	addCenterHeading( &"CREDITS_MSSTORE_QA__LABS" );

	addSpaceSmall();

	//Senior Project Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_PROJECT_LEAD" );

	//Donovan Byrnes
	addCenterTriple( "", &"CREDITS_MSSTORE_DONOVAN_BYRNES", "");

	addSpaceSmall();

	//Associate Project Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_ASSOCIATE_PROJECT_LEAD" );

	//John Purdham
	addCenterTriple( "", &"CREDITS_MSSTORE_JOHN_PURDHAM", "");

	//Zach Hayes
	addCenterTriple( "", &"CREDITS_MSSTORE_ZACH_HAYES", "");

	//Nick Ingerson
	addCenterTriple( "", &"CREDITS_MSSTORE_NICK_INGERSON", "");

	addSpaceSmall();

	//Senior Tester
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_TESTER" );

	//Damien Poncel
	addCenterTriple( "", &"CREDITS_MSSTORE_DAMIEN_PONCEL", "");

	//Alex Schindeldecker
	addCenterTriple( "", &"CREDITS_MSSTORE_ALEX_SCHINDELDECKER", "");

	addSpaceSmall();

	//QA Tester
	addCenterSubtitle( &"CREDITS_MSSTORE_QA_TESTER" );

	//Brendan Wilson
	addCenterTriple( "", &"CREDITS_MSSTORE_BRENDAN_WILSON", "");

	//Jac Mateja
	addCenterTriple( "", &"CREDITS_MSSTORE_JAC_MATEJA", "");

	//Jace Floyd
	addCenterTriple( "", &"CREDITS_MSSTORE_JACE_FLOYD", "");

	//Samuel Grausam
	addCenterTriple( "", &"CREDITS_MSSTORE_SAMUEL_GRAUSAM", "");

	addSpace();

	//PRODUCTION SERVICES - EUROPE
	addCenterHeading( &"CREDITS_MSSTORE_PRODUCTION_SERVICES__EUROPE" );

	addSpaceSmall();
	
	//Worldwide Localization VP
	addCenterSubtitle( &"CREDITS_MSSTORE_WORLDWIDE_LOCALIZATION_VP" );

	//Barry Kehoe
	addCenterTriple( "", &"CREDITS_MSSTORE_BARRY_KEHOE", "");

	addSpaceSmall();

	//Localisation Director
	addCenterSubtitle( &"CREDITS_MSSTORE_LOCALISATION_DIRECTOR" );

	//Fiona Ebbs
	addCenterTriple( "", &"CREDITS_MSSTORE_FIONA_EBBS", "");

	addSpaceSmall();

	//Localisation QA Manager
	addCenterSubtitle( &"CREDITS_MSSTORE_LOCALISATION_QA_MANAGER" );

	//Mannix Kelly
	addCenterTriple( "", &"CREDITS_MSSTORE_MANNIX_KELLY", "");

	addSpaceSmall();

	//Assistant QA Manager
	addCenterSubtitle( &"CREDITS_MSSTORE_ASSISTANT_QA_MANAGER" );

	//Franck Morisseau
	addCenterTriple( "", &"CREDITS_MSSTORE_FRANCK_MORISSEAU", "");

	//Igor Mantovani
	addCenterTriple( "", &"CREDITS_MSSTORE_IGOR_MANTOVANI", "");

	addSpaceSmall();

	//Localisation Senior QA Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_LOCALISATION_SENIOR_QA_LEAD" );

	//Werner Nemetz
	addCenterTriple( "", &"CREDITS_MSSTORE_WERNER_NEMETZ", "");

	addSpaceSmall();

	//Localisation QA Lead
	addCenterSubtitle( &"CREDITS_MSSTORE_LOCALISATION_QA_LEAD" );

	//Tomasz Wojtkiewicz
	addCenterTriple( "", &"CREDITS_MSSTORE_TOMASZ_WOJTKIEWICZ", "");

	//Lily Dashkevich
	addCenterTriple( "", &"CREDITS_MSSTORE_LILY_DASHKEVICH", "");

	//Ricky Chen
	addCenterTriple( "", &"CREDITS_MSSTORE_RICKY_CHEN", "");

	addSpaceSmall();

	//Localisation Testers
	addCenterSubtitle( &"CREDITS_MSSTORE_LOCALISATION_TESTERS" );

	//Alex Enea Siddi
	addCenterTriple( "", &"CREDITS_MSSTORE_ALEX_ENEA_SIDDI", "");

	//Aurelien Taraud
	addCenterTriple( "", &"CREDITS_MSSTORE_AURELIEN_TARAUD", "");

	//Daniela Uribe
	addCenterTriple( "", &"CREDITS_MSSTORE_DANIELA_URIBE", "");

	//Jule Loescher
	addCenterTriple( "", &"CREDITS_MSSTORE_JULE_LOESCHER", "");

	//Martyna Golas
	addCenterTriple( "", &"CREDITS_MSSTORE_MARTYNA_GOLAS", "");

	//Simon Salvatierra L.
	addCenterTriple( "", &"CREDITS_MSSTORE_SIMON_SALVATIERRA_L", "");

	//Julia Schimanski
	addCenterTriple( "", &"CREDITS_MSSTORE_JULIA_SCHIMANSKI", "");

	//Jesus Echeverria
	addCenterTriple( "", &"CREDITS_MSSTORE_JESUS_ECHEVERRIA", "");

	//Victor Jimenez
	addCenterTriple( "", &"CREDITS_MSSTORE_VICTOR_JIMENEZ", "");

	addSpaceSmall();

	//Senior IT Network Technician
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_IT_NETWORK_TECHNICIAN" );

	//Fergus Lindsay
	addCenterTriple( "", &"CREDITS_MSSTORE_FERGUS_LINDSAY", "");

	addSpaceSmall();

	//Senior IT Administrator
	addCenterSubtitle( &"CREDITS_MSSTORE_SENIOR_IT_ADMINISTRATOR" );

	//Ciaran O'Shea
	addCenterTriple( "", &"CREDITS_MSSTORE_CIARAN_OSHEA", "");

	addSpaceSmall();

	//Localisation Tools & Support
	addCenterSubtitle( &"CREDITS_MSSTORE_LOCALISATION_TOOLS__SUPPORT" );

	//Provided by Stephanie Deming & XLOC, inc
	addCenterTriple( "", &"CREDITS_MSSTORE_PROVIDED_BY_STEPHANIE_DEMING__", "");

	addSpace();
	
	//Demonware
	addCenterSubtitle( &"CREDITS_MSSTORE_DEMONWARE" );

	//Jordan Abbatiello
	//Cristina Lester
	addCenterDual( &"CREDITS_MSSTORE_JORDAN_ABBATIELLO", &"CREDITS_MSSTORE_CRISTINA_LESTER");

	//Elijah Abram
	//Anthony Leung
	addCenterDual( &"CREDITS_MSSTORE_ELIJAH_ABRAM", &"CREDITS_MSSTORE_ANTHONY_LEUNG");

	//George Adyrhaiev
	//Zoey Liao
	addCenterDual( &"CREDITS_MSSTORE_GEORGE_ADYRHAIEV", &"CREDITS_MSSTORE_ZOEY_LIAO");

	//Ria Agarwal
	//Zhi Han Lim
	addCenterDual( &"CREDITS_MSSTORE_RIA_AGARWAL", &"CREDITS_MSSTORE_ZHI_HAN_LIM");

	//Caitlin Ah Sing
	//Daniel Lin ????
	addCenterDual( &"CREDITS_MSSTORE_CAITLIN_AH_SING", &"CREDITS_MSSTORE_DANIEL_LIN");

	//Sameer Ahmed
	//Jessica Lin
	addCenterDual( &"CREDITS_MSSTORE_SAMEER_AHMED", &"CREDITS_MSSTORE_JESSICA_LIN");

	//Alaa Al-Ramly
	//Derek Lindahl
	addCenterDual( &"CREDITS_MSSTORE_ALAA_ALRAMLY", &"CREDITS_MSSTORE_DEREK_LINDAHL");

	//Cameron Altenhof-Long
	//Will Liu
	addCenterDual( &"CREDITS_MSSTORE_CAMERON_ALTENHOFLONG", &"CREDITS_MSSTORE_WILL_LIU");

	//Ryad Ammar
	//Sampson Liu
	addCenterDual( &"CREDITS_MSSTORE_RYAD_AMMAR", &"CREDITS_MSSTORE_SAMPSON_LIU");

	//Andreas Anglin
	//Aaron LIU
	addCenterDual( &"CREDITS_MSSTORE_ANDREAS_ANGLIN", &"CREDITS_MSSTORE_AARON_LIU");

	//Bassel Ashi
	//Steve Loken
	addCenterDual( &"CREDITS_MSSTORE_BASSEL_ASHI", &"CREDITS_MSSTORE_STEVE_LOKEN");

	//Segal Au
	//Daniella Almeida
	addCenterDual( &"CREDITS_MSSTORE_SEGAL_AU", &"CREDITS_MSSTORE_DANIELLA_ALMEIDA");

	//Vladimir Avram
	//Zach Lorimer
	addCenterDual( &"CREDITS_MSSTORE_VLADIMIR_AVRAM", &"CREDITS_MSSTORE_ZACH_LORIMER");

	//Noah Baker
	//Laurent Loubiere
	addCenterDual( &"CREDITS_MSSTORE_NOAH_BAKER", &"CREDITS_MSSTORE_LAURENT_LOUBIERE");

	//Graeme Baker
	//Yunjia Lu
	addCenterDual( &"CREDITS_MSSTORE_GRAEME_BAKER", &"CREDITS_MSSTORE_YUNJIA_LU");

	//David Ballano-Fernandez
	//Francis Lu
	addCenterDual( &"CREDITS_MSSTORE_DAVID_BALLANOFERNANDEZ", &"CREDITS_MSSTORE_FRANCIS_LU");

	//Gaurav Baney
	//Pat Lynam
	addCenterDual( &"CREDITS_MSSTORE_GAURAV_BANEY", &"CREDITS_MSSTORE_PAT_LYNAM");

	//Pooja Bansal
	//Andrei Vladimirovich Lysov
	addCenterDual( &"CREDITS_MSSTORE_POOJA_BANSAL", &"CREDITS_MSSTORE_ANDREI_VLADIMIROVICH_LYSOV");

	//Rob Baron
	//Rohith Madamshetty
	addCenterDual( &"CREDITS_MSSTORE_ROB_BARON", &"CREDITS_MSSTORE_ROHITH_MADAMSHETTY");

	//Ally Barra
	//Robin Mahony
	addCenterDual( &"CREDITS_MSSTORE_ALLY_BARRA", &"CREDITS_MSSTORE_ROBIN_MAHONY");

	//Patrick Barrington
	//Bruno de Lima Marques
	addCenterDual( &"CREDITS_MSSTORE_PATRICK_BARRINGTON", &"CREDITS_MSSTORE_BRUNO_DE_LIMA_MARQUES");

	//Graeme Bates
	//Damien Marshall
	addCenterDual( &"CREDITS_MSSTORE_GRAEME_BATES", &"CREDITS_MSSTORE_DAMIEN_MARSHALL");

	//Edgar Baudry
	//Asako Matsuoka
	addCenterDual( &"CREDITS_MSSTORE_EDGAR_BAUDRY", &"CREDITS_MSSTORE_ASAKO_MATSUOKA");

	//Alberto Bautista
	//Meabh McCarthy
	addCenterDual( &"CREDITS_MSSTORE_ALBERTO_BAUTISTA", &"CREDITS_MSSTORE_MEABH_MCCARTHY");

	//Kavish Bhathija
	//Emma McCarthy
	addCenterDual( &"CREDITS_MSSTORE_KAVISH_BHATHIJA", &"CREDITS_MSSTORE_EMMA_MCCARTHY");

	//Sushil Bhojwani
	//Martin McGovern
	addCenterDual( &"CREDITS_MSSTORE_SUSHIL_BHOJWANI", &"CREDITS_MSSTORE_MARTIN_MCGOVERN");

	//Rishav Bhowmick
	//Chris McKnight
	addCenterDual( &"CREDITS_MSSTORE_RISHAV_BHOWMICK", &"CREDITS_MSSTORE_CHRIS_MCKNIGHT");

	//Robin Bjorklin
	//Pat McKnight
	addCenterDual( &"CREDITS_MSSTORE_ROBIN_BJORKLIN", &"CREDITS_MSSTORE_PAT_MCKNIGHT");

	//Amanda Black
	//Emily Mecke
	addCenterDual( &"CREDITS_MSSTORE_AMANDA_BLACK", &"CREDITS_MSSTORE_EMILY_MECKE");

	//Jordan Black
	//Adit Mehta
	addCenterDual( &"CREDITS_MSSTORE_JORDAN_BLACK", &"CREDITS_MSSTORE_ADIT_MEHTA");

	//Cormac Blackwell
	//Tal Melamed
	addCenterDual( &"CREDITS_MSSTORE_CORMAC_BLACKWELL", &"CREDITS_MSSTORE_TAL_MELAMED");

	//Alex Blackwell
	//Arthur Mencke
	addCenterDual( &"CREDITS_MSSTORE_ALEX_BLACKWELL", &"CREDITS_MSSTORE_ARTHUR_MENCKE");

	//Katarzyna (Kat) Boddy
	//Enrique Mendoza
	addCenterDual( &"CREDITS_MSSTORE_KATARZYNA_KAT_BODDY", &"CREDITS_MSSTORE_ENRIQUE_MENDOZA");

	//Dustin Boersma
	//Matt Mercer
	addCenterDual( &"CREDITS_MSSTORE_DUSTIN_BOERSMA", &"CREDITS_MSSTORE_MATT_MERCER");

	//Andrea Boonyarungsrit
	//Carlo Messere
	addCenterDual( &"CREDITS_MSSTORE_ANDREA_BOONYARUNGSRIT", &"CREDITS_MSSTORE_CARLO_MESSERE");

	//Xander Botha
	//Deives Michellis
	addCenterDual( &"CREDITS_MSSTORE_XANDER_BOTHA", &"CREDITS_MSSTORE_DEIVES_MICHELLIS");

	//Will Bowers
	//Alex Miller
	addCenterDual( &"CREDITS_MSSTORE_WILL_BOWERS", &"CREDITS_MSSTORE_ALEX_MILLER");

	//Alex Boyd
	//George Miller
	addCenterDual( &"CREDITS_MSSTORE_ALEX_BOYD", &"CREDITS_MSSTORE_GEORGE_MILLER");

	//Suzanne Boylan
	//Kalah Mingo
	addCenterDual( &"CREDITS_MSSTORE_SUZANNE_BOYLAN", &"CREDITS_MSSTORE_KALAH_MINGO");

	//Morgan Brickley
	//Andrew Mitchell
	addCenterDual( &"CREDITS_MSSTORE_MORGAN_BRICKLEY", &"CREDITS_MSSTORE_ANDREW_MITCHELL");

	//Dmitri Burakov
	//Pranay Mithaigari
	addCenterDual( &"CREDITS_MSSTORE_DMITRI_BURAKOV", &"CREDITS_MSSTORE_PRANAY_MITHAIGARI");

	//Luke Burden
	//Robin Mizreh
	addCenterDual( &"CREDITS_MSSTORE_LUKE_BURDEN", &"CREDITS_MSSTORE_ROBIN_MIZREH");

	//Mark Burmeister
	//Yawar Mohammad Khan
	addCenterDual( &"CREDITS_MSSTORE_MARK_BURMEISTER", &"CREDITS_MSSTORE_YAWAR_MOHAMMAD_KHAN");

	//Kyle Burnette
	//Derick Moncado
	addCenterDual( &"CREDITS_MSSTORE_KYLE_BURNETTE", &"CREDITS_MSSTORE_DERICK_MONCADO");

	//Gemma Butterly
	//Jennifer Morehead
	addCenterDual( &"CREDITS_MSSTORE_GEMMA_BUTTERLY", &"CREDITS_MSSTORE_JENNIFER_MOREHEAD");

	//Will Cagney Murphy
	//Jen Muller
	addCenterDual( &"CREDITS_MSSTORE_WILL_CAGNEY_MURPHY", &"CREDITS_MSSTORE_JEN_MULLER");

	//Grant Cahill
	//David Munton
	addCenterDual( &"CREDITS_MSSTORE_GRANT_CAHILL", &"CREDITS_MSSTORE_DAVID_MUNTON");

	//Vinicius Caixeta dos Santos
	//Visalakshi Murugappan
	addCenterDual( &"CREDITS_MSSTORE_VINICIUS_CAIXETA_DOS_SANTOS", &"CREDITS_MSSTORE_VISALAKSHI_MURUGAPPAN");

	//Josh Campbell
	//James Nagel
	addCenterDual( &"CREDITS_MSSTORE_JOSH_CAMPBELL", &"CREDITS_MSSTORE_JAMES_NAGEL");

	//Daniel Casari
	//Sivateja Nalluri
	addCenterDual( &"CREDITS_MSSTORE_DANIEL_CASARI", &"CREDITS_MSSTORE_SIVATEJA_NALLURI");

	//Neil Eldridge
	//Dave Neary
	addCenterDual( &"CREDITS_MSSTORE_NEIL_ELDRIDGE", &"CREDITS_MSSTORE_DAVE_NEARY");

	//Luca Castoro
	//Trung Nguyen
	addCenterDual( &"CREDITS_MSSTORE_LUCA_CASTORO", &"CREDITS_MSSTORE_TRUNG_NGUYEN");

	//Gabriele Cerami
	//Darrin Nguyen
	addCenterDual( &"CREDITS_MSSTORE_GABRIELE_CERAMI", &"CREDITS_MSSTORE_DARRIN_NGUYEN");

	//Frederico Cerqueira Alves
	//Chenyang Nie
	addCenterDual( &"CREDITS_MSSTORE_FREDERICO_CERQUEIRA_ALVES", &"CREDITS_MSSTORE_CHENYANG_NIE");

	//Pratik Chakravorty
	//Vadzim Novikau
	addCenterDual( &"CREDITS_MSSTORE_PRATIK_CHAKRAVORTY", &"CREDITS_MSSTORE_VADZIM_NOVIKAU");

	//Henry Chan
	//Shaunee OBrien
	addCenterDual( &"CREDITS_MSSTORE_HENRY_CHAN", &"CREDITS_MSSTORE_SHAUNEE_OBRIEN");

	//Karan Chaudhary
	//John O'Donnell
	addCenterDual( &"CREDITS_MSSTORE_KARAN_CHAUDHARY", &"CREDITS_MSSTORE_JOHN_ODONNELL");

	//Liang Chen
	//Cathal O'Halloran
	addCenterDual( &"CREDITS_MSSTORE_LIANG_CHEN", &"CREDITS_MSSTORE_CATHAL_OHALLORAN");

	//Mike Chi
	//Stephen O'Neill
	addCenterDual( &"CREDITS_MSSTORE_MIKE_CHI", &"CREDITS_MSSTORE_STEPHEN_ONEILL");

	//Vito Francisco Chiarella
	//Kevin O'Sullivan
	addCenterDual( &"CREDITS_MSSTORE_VITO_FRANCISCO_CHIARELLA", &"CREDITS_MSSTORE_KEVIN_OSULLIVAN");

	//Richard Chien
	//Monica Mota Ocariz
	addCenterDual( &"CREDITS_MSSTORE_RICHARD_CHIEN", &"CREDITS_MSSTORE_MONICA_MOTA_OCARIZ");

	//Luca Chiossi
	//Jacob Odulio
	addCenterDual( &"CREDITS_MSSTORE_LUCA_CHIOSSI", &"CREDITS_MSSTORE_JACOB_ODULIO");

	//Olivia Chung
	//Rich Oh
	addCenterDual( &"CREDITS_MSSTORE_OLIVIA_CHUNG", &"CREDITS_MSSTORE_RICH_OH");

	//Amy Collins
	//Hyeree Oh
	addCenterDual( &"CREDITS_MSSTORE_AMY_COLLINS", &"CREDITS_MSSTORE_HYEREE_OH");

	//Ivan Company Avi
	//Ayokunle Onamusi
	addCenterDual( &"CREDITS_MSSTORE_IVAN_COMPANY_AVI", &"CREDITS_MSSTORE_AYOKUNLE_ONAMUSI");

	//Conor Conroy
	//Curtis Onuczko
	addCenterDual( &"CREDITS_MSSTORE_CONOR_CONROY", &"CREDITS_MSSTORE_CURTIS_ONUCZKO");

	//Sean Cortes
	//Gilberto Ortiz
	addCenterDual( &"CREDITS_MSSTORE_SEAN_CORTES", &"CREDITS_MSSTORE_GILBERTO_ORTIZ");

	//Etienne Cournoyer
	//Andrei Pampukha
	addCenterDual( &"CREDITS_MSSTORE_ETIENNE_COURNOYER", &"CREDITS_MSSTORE_ANDREI_PAMPUKHA");

	//Keith Crosby
	//Pritish Panda
	addCenterDual( &"CREDITS_MSSTORE_KEITH_CROSBY", &"CREDITS_MSSTORE_PRITISH_PANDA");

	//Colin Cyr
	//Gabor Pardi-Kis
	addCenterDual( &"CREDITS_MSSTORE_COLIN_CYR", &"CREDITS_MSSTORE_GABOR_PARDIKIS");

	//Rebecca Czaicka
	//Tirth Patel
	addCenterDual( &"CREDITS_MSSTORE_REBECCA_CZAICKA", &"CREDITS_MSSTORE_TIRTH_PATEL");

	//Tim Czerniak
	//Julilla Paul
	addCenterDual( &"CREDITS_MSSTORE_TIM_CZERNIAK", &"CREDITS_MSSTORE_JULILLA_PAUL");

	//Darius Darida
	//Adam Penner
	addCenterDual( &"CREDITS_MSSTORE_DARIUS_DARIDA", &"CREDITS_MSSTORE_ADAM_PENNER");

	//Kris Davidsohn
	//Amy Perdiew
	addCenterDual( &"CREDITS_MSSTORE_KRIS_DAVIDSOHN", &"CREDITS_MSSTORE_AMY_PERDIEW");

	//James Davidson
	//Dan Pereira
	addCenterDual( &"CREDITS_MSSTORE_JAMES_DAVIDSON", &"CREDITS_MSSTORE_DAN_PEREIRA");

	//Mauro de Carvalho
	//Jithin P
	addCenterDual( &"CREDITS_MSSTORE_MAURO_DE_CARVALHO", &"CREDITS_MSSTORE_JITHIN_P");

	//Emily DeLisle
	//Julio Cesar Pescuite Goncalves Batista
	addCenterDual( &"CREDITS_MSSTORE_EMILY_DELISLE", &"CREDITS_MSSTORE_JULIO_CESAR_PESCUITE_GONCALVES");

	//Thayer Dennison
	//Andy Phillips
	addCenterDual( &"CREDITS_MSSTORE_THAYER_DENNISON", &"CREDITS_MSSTORE_ANDY_PHILLIPS");

	//Hamad Deshmukh
	//Byron Pile
	addCenterDual( &"CREDITS_MSSTORE_HAMAD_DESHMUKH", &"CREDITS_MSSTORE_BYRON_PILE");

	//Avery Devlin
	//Clark Polo
	addCenterDual( &"CREDITS_MSSTORE_AVERY_DEVLIN", &"CREDITS_MSSTORE_CLARK_POLO");

	//Esteban Diaz
	//Ery Polovina
	addCenterDual( &"CREDITS_MSSTORE_ESTEBAN_DIAZ", &"CREDITS_MSSTORE_ERY_POLOVINA");

	//Julian Ding
	//Owen Poon
	addCenterDual( &"CREDITS_MSSTORE_JULIAN_DING", &"CREDITS_MSSTORE_OWEN_POON");

	//Andre Campos
	//Glen Powley
	addCenterDual( &"CREDITS_MSSTORE_ANDRE_CAMPOS", &"CREDITS_MSSTORE_GLEN_POWLEY");

	//Juan Domenech Fernandez
	//Rashmi Prasad
	addCenterDual( &"CREDITS_MSSTORE_JUAN_DOMENECH_FERNANDEZ", &"CREDITS_MSSTORE_RASHMI_PRASAD");

	//Dylan Dowling
	//Neil Prasad
	addCenterDual( &"CREDITS_MSSTORE_DYLAN_DOWLING", &"CREDITS_MSSTORE_NEIL_PRASAD");

	//Malcolm Dowse
	//Dara Price
	addCenterDual( &"CREDITS_MSSTORE_MALCOLM_DOWSE", &"CREDITS_MSSTORE_DARA_PRICE");

	//Martynas Drazdziulis
	//Yifei Qu
	addCenterDual( &"CREDITS_MSSTORE_MARTYNAS_DRAZDZIULIS", &"CREDITS_MSSTORE_YIFEI_QU");

	//Tom Dryer
	//Gary Quan
	addCenterDual( &"CREDITS_MSSTORE_TOM_DRYER", &"CREDITS_MSSTORE_GARY_QUAN");

	//Mitch Duffield
	//Kenneth Quibuyen
	addCenterDual( &"CREDITS_MSSTORE_MITCH_DUFFIELD", &"CREDITS_MSSTORE_KENNETH_QUIBUYEN");

	//J.R. Dunn
	//Attheera Rachkeeree
	addCenterDual( &"CREDITS_MSSTORE_JR_DUNN", &"CREDITS_MSSTORE_ATTHEERA_RACHKEEREE");

	//Steven Eareast
	//Sindhoora Rangineni
	addCenterDual( &"CREDITS_MSSTORE_STEVEN_EAREAST", &"CREDITS_MSSTORE_SINDHOORA_RANGINENI");

	//Terrence Earle
	//Rajeev Ranjan
	addCenterDual( &"CREDITS_MSSTORE_TERRENCE_EARLE", &"CREDITS_MSSTORE_RAJEEV_RANJAN");

	//Mike Edwards
	//Pariya Raoufi
	addCenterDual( &"CREDITS_MSSTORE_MIKE_EDWARDS", &"CREDITS_MSSTORE_PARIYA_RAOUFI");

	//Stanislava Egorova
	//Froilan Regueiro Noguera
	addCenterDual( &"CREDITS_MSSTORE_STANISLAVA_EGOROVA", &"CREDITS_MSSTORE_FROILAN_REGUEIRO_NOGUERA");

	//Edwin Elisia
	//Andrew Reiser
	addCenterDual( &"CREDITS_MSSTORE_EDWIN_ELISIA", &"CREDITS_MSSTORE_ANDREW_REISER");

	//Robin Ellsworth
	//Tom Remoleur
	addCenterDual( &"CREDITS_MSSTORE_ROBIN_ELLSWORTH", &"CREDITS_MSSTORE_TOM_REMOLEUR");

	//Farzin Faghihi
	//Maksym Reva
	addCenterDual( &"CREDITS_MSSTORE_FARZIN_FAGHIHI", &"CREDITS_MSSTORE_MAKSYM_REVA");

	//Shawn Feeney
	//Gabe Reyes
	addCenterDual( &"CREDITS_MSSTORE_SHAWN_FEENEY", &"CREDITS_MSSTORE_GABE_REYES");

	//Kevin Fei
	//Eric Ripa
	addCenterDual( &"CREDITS_MSSTORE_KEVIN_FEI", &"CREDITS_MSSTORE_ERIC_RIPA");

	//Julie Ferguson
	//Stephen Roantree
	addCenterDual( &"CREDITS_MSSTORE_JULIE_FERGUSON", &"CREDITS_MSSTORE_STEPHEN_ROANTREE");

	//Brendan Fields
	//Julian Rocha
	addCenterDual( &"CREDITS_MSSTORE_BRENDAN_FIELDS", &"CREDITS_MSSTORE_JULIAN_ROCHA");

	//Patrick Filion
	//Seamus Rooney
	addCenterDual( &"CREDITS_MSSTORE_PATRICK_FILION", &"CREDITS_MSSTORE_SEAMUS_ROONEY");

	//Sergei Fomin
	//Roman Rose
	addCenterDual( &"CREDITS_MSSTORE_SERGEI_FOMIN", &"CREDITS_MSSTORE_ROMAN_ROSE");

	//Steven Foster
	//Tanner Roundy
	addCenterDual( &"CREDITS_MSSTORE_STEVEN_FOSTER", &"CREDITS_MSSTORE_TANNER_ROUNDY");

	//Eric Frank
	//Andrew Rowe
	addCenterDual( &"CREDITS_MSSTORE_ERIC_FRANK", &"CREDITS_MSSTORE_ANDREW_ROWE");

	//Steve Fraser
	//David Rux
	addCenterDual( &"CREDITS_MSSTORE_STEVE_FRASER", &"CREDITS_MSSTORE_DAVID_RUX");

	//Kurt Gabrick
	//David Ryan
	addCenterDual( &"CREDITS_MSSTORE_KURT_GABRICK", &"CREDITS_MSSTORE_DAVID_RYAN");

	//Michael Gale
	//Jaskaren Saini
	addCenterDual( &"CREDITS_MSSTORE_MICHAEL_GALE", &"CREDITS_MSSTORE_JASKAREN_SAINI");

	//Rob Gallagher
	//Luca Salfi
	addCenterDual( &"CREDITS_MSSTORE_ROB_GALLAGHER", &"CREDITS_MSSTORE_LUCA_SALFI");

	//Samson Gama
	//Vinita Samnani
	addCenterDual( &"CREDITS_MSSTORE_SAMSON_GAMA", &"CREDITS_MSSTORE_VINITA_SAMNANI");

	//Vidhi Gandhi
	//Art Santos
	addCenterDual( &"CREDITS_MSSTORE_VIDHI_GANDHI", &"CREDITS_MSSTORE_ART_SANTOS");

	//Omi Gao
	//Angela D Scott
	addCenterDual( &"CREDITS_MSSTORE_OMI_GAO", &"CREDITS_MSSTORE_ANGELA_D_SCOTT");

	//Michael Geary
	//Kameshwara Sekar
	addCenterDual( &"CREDITS_MSSTORE_MICHAEL_GEARY", &"CREDITS_MSSTORE_KAMESHWARA_SEKAR");

	//Taylor Geery
	//Sanyami Shah
	addCenterDual( &"CREDITS_MSSTORE_TAYLOR_GEERY", &"CREDITS_MSSTORE_SANYAMI_SHAH");

	//Ayush Ghai
	//Kushal Shah
	addCenterDual( &"CREDITS_MSSTORE_AYUSH_GHAI", &"CREDITS_MSSTORE_KUSHAL_SHAH");

	//Maarten Goldstein
	//Jason Shao
	addCenterDual( &"CREDITS_MSSTORE_MAARTEN_GOLDSTEIN", &"CREDITS_MSSTORE_JASON_SHAO");

	//Daria Golubova
	//Hessamoddin Sharifpour
	addCenterDual( &"CREDITS_MSSTORE_DARIA_GOLUBOVA", &"CREDITS_MSSTORE_HESSAMODDIN_SHARIFPOUR");

	//Luis Gomez
	//Aaron Sharkey
	addCenterDual( &"CREDITS_MSSTORE_LUIS_GOMEZ", &"CREDITS_MSSTORE_AARON_SHARKEY");

	//David Grant
	//Matthew Shaw
	addCenterDual( &"CREDITS_MSSTORE_DAVID_GRANT", &"CREDITS_MSSTORE_MATTHEW_SHAW");

	//Jeff Greene
	//Pavel Shchurov
	addCenterDual( &"CREDITS_MSSTORE_JEFF_GREENE", &"CREDITS_MSSTORE_PAVEL_SHCHUROV");

	//Bjorn Gronesjo
	//Rob Sherman
	addCenterDual( &"CREDITS_MSSTORE_BJORN_GRONESJO", &"CREDITS_MSSTORE_ROB_SHERMAN");

	//Stephen Guan
	//Jordan Siaw
	addCenterDual( &"CREDITS_MSSTORE_STEPHEN_GUAN", &"CREDITS_MSSTORE_JORDAN_SIAW");

	//Manek Gujral
	//Jeff Siegel
	addCenterDual( &"CREDITS_MSSTORE_MANEK_GUJRAL", &"CREDITS_MSSTORE_JEFF_SIEGEL");

	//Artur Gukasian
	//Frances Sin
	addCenterDual( &"CREDITS_MSSTORE_ARTUR_GUKASIAN", &"CREDITS_MSSTORE_FRANCES_SIN");

	//Alex Guo
	//Chaudhary Guroosh Singh
	addCenterDual( &"CREDITS_MSSTORE_ALEX_GUO", &"CREDITS_MSSTORE_CHAUDHARY_GUROOSH_SINGH");

	//Varun Gupta
	//Hugo Slabbert
	addCenterDual( &"CREDITS_MSSTORE_VARUN_GUPTA", &"CREDITS_MSSTORE_HUGO_SLABBERT");

	//James Hall
	//Marek Slabicki
	addCenterDual( &"CREDITS_MSSTORE_JAMES_HALL", &"CREDITS_MSSTORE_MAREK_SLABICKI");

	//Alan Hall
	//Cormac Smartt
	addCenterDual( &"CREDITS_MSSTORE_ALAN_HALL", &"CREDITS_MSSTORE_CORMAC_SMARTT");

	//Marcus Hall
	//Greg Smith
	addCenterDual( &"CREDITS_MSSTORE_MARCUS_HALL", &"CREDITS_MSSTORE_GREG_SMITH");

	//Josh Hall
	//Adham Sorour
	addCenterDual( &"CREDITS_MSSTORE_JOSH_HALL", &"CREDITS_MSSTORE_ADHAM_SOROUR");

	//Padraic Hallinan
	//Alexis Braga Sotto Maior
	addCenterDual( &"CREDITS_MSSTORE_PADRAIC_HALLINAN", &"CREDITS_MSSTORE_ALEXIS_BRAGA_SOTTO_MAIOR");

	//Jack Halpin
	//Flavie Soudant
	addCenterDual( &"CREDITS_MSSTORE_JACK_HALPIN", &"CREDITS_MSSTORE_FLAVIE_SOUDANT");

	//John Hamill
	//Roland-Ovidiu Stefani
	addCenterDual( &"CREDITS_MSSTORE_JOHN_HAMILL", &"CREDITS_MSSTORE_ROLANDOVIDIU_STEFANI");

	//Dermot Hanley
	//Nive Subas
	addCenterDual( &"CREDITS_MSSTORE_DERMOT_HANLEY", &"CREDITS_MSSTORE_NIVE_SUBAS");

	//Luke Hansen
	//Jiawei Sun
	addCenterDual( &"CREDITS_MSSTORE_LUKE_HANSEN", &"CREDITS_MSSTORE_JIAWEI_SUN");

	//Ida Hashemi
	//Matthew Taggart
	addCenterDual( &"CREDITS_MSSTORE_IDA_HASHEMI", &"CREDITS_MSSTORE_MATTHEW_TAGGART");

	//Bowen He
	//Christopher Tan
	addCenterDual( &"CREDITS_MSSTORE_BOWEN_HE", &"CREDITS_MSSTORE_CHRISTOPHER_TAN");

	//Cheryl Hepas
	//Steve Thiakos
	addCenterDual( &"CREDITS_MSSTORE_CHERYL_HEPAS", &"CREDITS_MSSTORE_STEVE_THIAKOS");

	//Rory Higgins
	//Keenan Tims
	addCenterDual( &"CREDITS_MSSTORE_RORY_HIGGINS", &"CREDITS_MSSTORE_KEENAN_TIMS");

	//Paul Hoefgen
	//Vlad Titov
	addCenterDual( &"CREDITS_MSSTORE_PAUL_HOEFGEN", &"CREDITS_MSSTORE_VLAD_TITOV");

	//Thomas Holland
	//Michael Tom-Wing
	addCenterDual( &"CREDITS_MSSTORE_THOMAS_HOLLAND", &"CREDITS_MSSTORE_MICHAEL_TOMWING");

	//Luke Hollinda
	//Mark Tong
	addCenterDual( &"CREDITS_MSSTORE_LUKE_HOLLINDA", &"CREDITS_MSSTORE_MARK_TONG");

	//Nick Hopewell
	//Carlos Torres
	addCenterDual( &"CREDITS_MSSTORE_NICK_HOPEWELL", &"CREDITS_MSSTORE_CARLOS_TORRES");

	//Mykola Hrebenyuk
	//Camy Tran
	addCenterDual( &"CREDITS_MSSTORE_MYKOLA_HREBENYUK", &"CREDITS_MSSTORE_CAMY_TRAN");

	//Yiming Huang
	//Stella Tran
	addCenterDual( &"CREDITS_MSSTORE_YIMING_HUANG", &"CREDITS_MSSTORE_STELLA_TRAN");

	//Karlo Hurtado
	//Mike Trienis
	addCenterDual( &"CREDITS_MSSTORE_KARLO_HURTADO", &"CREDITS_MSSTORE_MIKE_TRIENIS");

	//Abe Hwang
	//An-Chih Tsai
	addCenterDual( &"CREDITS_MSSTORE_ABE_HWANG", &"CREDITS_MSSTORE_ANCHIH_TSAI");

	//Albert Hynek
	//Tim Tschirner
	addCenterDual( &"CREDITS_MSSTORE_ALBERT_HYNEK", &"CREDITS_MSSTORE_TIM_TSCHIRNER");

	//Adam Hynek
	//Oleksandr Tymchyshyn
	addCenterDual( &"CREDITS_MSSTORE_ADAM_HYNEK", &"CREDITS_MSSTORE_OLEKSANDR_TYMCHYSHYN");

	//Omar Ishkintana
	//Rashid Umar
	addCenterDual( &"CREDITS_MSSTORE_OMAR_ISHKINTANA", &"CREDITS_MSSTORE_RASHID_UMAR");

	//Ashrey Jairath
	//Mithun Krishnan Umesan
	addCenterDual( &"CREDITS_MSSTORE_ASHREY_JAIRATH", &"CREDITS_MSSTORE_MITHUN_KRISHNAN_UMESAN");

	//Ebby Jeyapaul
	//Ravi Vadlamudi
	addCenterDual( &"CREDITS_MSSTORE_EBBY_JEYAPAUL", &"CREDITS_MSSTORE_RAVI_VADLAMUDI");

	//Will Ji
	//Ali Vakilzade
	addCenterDual( &"CREDITS_MSSTORE_WILL_JI", &"CREDITS_MSSTORE_ALI_VAKILZADE");

	//Fan Jia
	//Vikrant Vikrant
	addCenterDual( &"CREDITS_MSSTORE_FAN_JIA", &"CREDITS_MSSTORE_VIKRANT_VIKRANT");

	//Roy Jiang
	//David Villatoro
	addCenterDual( &"CREDITS_MSSTORE_ROY_JIANG", &"CREDITS_MSSTORE_DAVID_VILLATORO");

	//Jean-Philippe Jodoin
	//Max Vizard
	addCenterDual( &"CREDITS_MSSTORE_JEANPHILIPPE_JODOIN", &"CREDITS_MSSTORE_MAX_VIZARD");

	//Nick Johnson
	//Francis Wan
	addCenterDual( &"CREDITS_MSSTORE_NICK_JOHNSON", &"CREDITS_MSSTORE_FRANCIS_WAN");

	//Jagadish Kagitala
	//Jun Wang
	addCenterDual( &"CREDITS_MSSTORE_JAGADISH_KAGITALA", &"CREDITS_MSSTORE_JUN_WANG");

	//Animesh Kanabar
	//Yuke Wang
	addCenterDual( &"CREDITS_MSSTORE_ANIMESH_KANABAR", &"CREDITS_MSSTORE_YUKE_WANG");

	//Samir Karki
	//Angela Wang
	addCenterDual( &"CREDITS_MSSTORE_SAMIR_KARKI", &"CREDITS_MSSTORE_ANGELA_WANG");

	//Shadae Kawaguchi
	//Eden Wang
	addCenterDual( &"CREDITS_MSSTORE_SHADAE_KAWAGUCHI", &"CREDITS_MSSTORE_EDEN_WANG");

	//Romin Kayani
	//Jason Wei
	addCenterDual( &"CREDITS_MSSTORE_ROMIN_KAYANI", &"CREDITS_MSSTORE_JASON_WEI");

	//Valery Kayukov
	//William Wei
	addCenterDual( &"CREDITS_MSSTORE_VALERY_KAYUKOV", &"CREDITS_MSSTORE_WILLIAM_WEI");

	//Anastasia Kim
	//Jacob Wessa
	addCenterDual( &"CREDITS_MSSTORE_ANASTASIA_KIM", &"CREDITS_MSSTORE_JACOB_WESSA");

	//Chris Kimberley
	//Mike Whitty
	addCenterDual( &"CREDITS_MSSTORE_CHRIS_KIMBERLEY", &"CREDITS_MSSTORE_MIKE_WHITTY");

	//Karolina Kluska
	//Patrik Wihlke
	addCenterDual( &"CREDITS_MSSTORE_KAROLINA_KLUSKA", &"CREDITS_MSSTORE_PATRIK_WIHLKE");

	//Chris Knee
	//Josh Williams
	addCenterDual( &"CREDITS_MSSTORE_CHRIS_KNEE", &"CREDITS_MSSTORE_JOSH_WILLIAMS");

	//Casey Knutson
	//Clint Willmore
	addCenterDual( &"CREDITS_MSSTORE_CASEY_KNUTSON", &"CREDITS_MSSTORE_CLINT_WILLMORE");

	//Vijendar Komalla
	//Cara Wills
	addCenterDual( &"CREDITS_MSSTORE_VIJENDAR_KOMALLA", &"CREDITS_MSSTORE_CARA_WILLS");

	//Yurii Konovaliuk
	//Nic Wolf
	addCenterDual( &"CREDITS_MSSTORE_YURII_KONOVALIUK", &"CREDITS_MSSTORE_NIC_WOLF");

	//Vincent Koo
	//Sean Wu
	addCenterDual( &"CREDITS_MSSTORE_VINCENT_KOO", &"CREDITS_MSSTORE_SEAN_WU");

	//Dustin Koupal
	//Ruiyuan Xia
	addCenterDual( &"CREDITS_MSSTORE_DUSTIN_KOUPAL", &"CREDITS_MSSTORE_RUIYUAN_XIA");

	//Vlad Kovacik
	//Jeffery Xiao
	addCenterDual( &"CREDITS_MSSTORE_VLAD_KOVACIK", &"CREDITS_MSSTORE_JEFFERY_XIAO");

	//Ivan Kovalkovskyi
	//Jake Xu
	addCenterDual( &"CREDITS_MSSTORE_IVAN_KOVALKOVSKYI", &"CREDITS_MSSTORE_JAKE_XU");

	//Yevhen Kovtun
	//Woody Yang
	addCenterDual( &"CREDITS_MSSTORE_YEVHEN_KOVTUN", &"CREDITS_MSSTORE_WOODY_YANG");

	//Harsha Krishne Gowda
	//Steven Yang
	addCenterDual( &"CREDITS_MSSTORE_HARSHA_KRISHNE_GOWDA", &"CREDITS_MSSTORE_STEVEN_YANG");

	//Kendra Krzywicki
	//Iris Yao
	addCenterDual( &"CREDITS_MSSTORE_KENDRA_KRZYWICKI", &"CREDITS_MSSTORE_IRIS_YAO");

	//Omkar Kulkarni
	//Otto Yiu
	addCenterDual( &"CREDITS_MSSTORE_OMKAR_KULKARNI", &"CREDITS_MSSTORE_OTTO_YIU");

	//Joseph Kulnis
	//Jason You
	addCenterDual( &"CREDITS_MSSTORE_JOSEPH_KULNIS", &"CREDITS_MSSTORE_JASON_YOU");

	//Allan Kumka
	//Andrew Yu
	addCenterDual( &"CREDITS_MSSTORE_ALLAN_KUMKA", &"CREDITS_MSSTORE_ANDREW_YU");

	//Maksym Kuts
	//Sky Yuan
	addCenterDual( &"CREDITS_MSSTORE_MAKSYM_KUTS", &"CREDITS_MSSTORE_SKY_YUAN");

	//Jesse Labate
	//Andrew Yuen
	addCenterDual( &"CREDITS_MSSTORE_JESSE_LABATE", &"CREDITS_MSSTORE_ANDREW_YUEN");

	//Aidan Lambe
	//Reza Zarebidaky
	addCenterDual( &"CREDITS_MSSTORE_AIDAN_LAMBE", &"CREDITS_MSSTORE_REZA_ZAREBIDAKY");

	//David Landau
	//Allen Zhang
	addCenterDual( &"CREDITS_MSSTORE_DAVID_LANDAU", &"CREDITS_MSSTORE_ALLEN_ZHANG");

	//Klaudia Landicho
	//Yi Zhang
	addCenterDual( &"CREDITS_MSSTORE_KLAUDIA_LANDICHO", &"CREDITS_MSSTORE_YI_ZHANG");

	//Ian Laue
	//Pete Zhang
	addCenterDual( &"CREDITS_MSSTORE_IAN_LAUE", &"CREDITS_MSSTORE_PETE_ZHANG");

	//Alan Lavery
	//Chuan Zhang
	addCenterDual( &"CREDITS_MSSTORE_ALAN_LAVERY", &"CREDITS_MSSTORE_CHUAN_ZHANG");

	//Jasmine Lea
	//Minchang Zhang
	addCenterDual( &"CREDITS_MSSTORE_JASMINE_LEA", &"CREDITS_MSSTORE_MINCHANG_ZHANG");

	//Imre Leen
	//Jessica Zhao
	addCenterDual( &"CREDITS_MSSTORE_IMRE_LEEN", &"CREDITS_MSSTORE_JESSICA_ZHAO");

	//Karina Lei
	//Yicong Zhou
	addCenterDual( &"CREDITS_MSSTORE_KARINA_LEI", &"CREDITS_MSSTORE_YICONG_ZHOU");

	//Jason Lei
	//Xinqi Zhu
	addCenterDual( &"CREDITS_MSSTORE_JASON_LEI", &"CREDITS_MSSTORE_XINQI_ZHU");

	addSpaceSmall();
	addSpaceSmall();
}

initOutrunCredits()
{
	//The Multiplayer Group
	addCenterHeading( &"CREDITS_OTRN_MPG_COMP" );
	addSpaceSmall();

	//2024 PC Team
	addCenterHeading( &"CREDITS_OTRN_MPG_PROJ" );
	addSpaceSmall();
	addSpaceSmall();

	//MPG_ALEKSANDAR_DIMITRIJEVIC
	//MPG_IAN_SWEENY
	addCenterDual( &"CREDITS_OTRN_MPG_ALEKSANDAR_DIMITRIJEVIC", &"CREDITS_OTRN_MPG_IAN_SWEENY");

	//MPG_ALFONSO_MIRAGLIES
	//MPG_IULIAN_COSTACHE
	addCenterDual( &"CREDITS_OTRN_MPG_ALFONSO_MIRAGLIES", &"CREDITS_OTRN_MPG_IULIAN_COSTACHE");

	//MPG_ANDREW_COPLAND
	//MPG_JAMES_REYNOLDS
	addCenterDual( &"CREDITS_OTRN_MPG_ANDREW_COPLAND", &"CREDITS_OTRN_MPG_JAMES_REYNOLDS");

	//MPG_ANDY_ALLEN
	//MPG_JIRI_BOLDYS
	addCenterDual( &"CREDITS_OTRN_MPG_ANDY_ALLEN", &"CREDITS_OTRN_MPG_JIRI_BOLDYS");

	//MPG_ANTONY_SCARPINATA
	//MPG_JON_EDGAR
	addCenterDual( &"CREDITS_OTRN_MPG_ANTONY_SCARPINATA", &"CREDITS_OTRN_MPG_JON_EDGAR");

	//MPG_BALAZS_HITKA
	//MPG_JOSH_OGILVIE
	addCenterDual( &"CREDITS_OTRN_MPG_BALAZS_HITKA", &"CREDITS_OTRN_MPG_JOSH_OGILVIE");

	//MPG_BEAU_NORMAN
	//MPG_KARADJORDJE_PETROVIC
	addCenterDual( &"CREDITS_OTRN_MPG_BEAU_NORMAN", &"CREDITS_OTRN_MPG_KARADJORDJE_PETROVIC");

	//MPG_BOGDAN_CATALIN_MARCU
	//MPG_KRISTEN_KEATING
	addCenterDual( &"CREDITS_OTRN_MPG_BOGDAN_CATALIN_MARCU", &"CREDITS_OTRN_MPG_KRISTEN_KEATING");

	//MPG_BRANDON_PHILLIPS
	//MPG_MARK_FITT
	addCenterDual( &"CREDITS_OTRN_MPG_BRANDON_PHILLIPS", &"CREDITS_OTRN_MPG_MARK_FITT");

	//MPG_CARLO_MONGIELLO
	//MPG_MARK_WYNN_GARCIA
	addCenterDual( &"CREDITS_OTRN_MPG_CARLO_MONGIELLO", &"CREDITS_OTRN_MPG_MARK_WYNN_GARCIA");

	//MPG_CHRIS_KIRBY
	//MPG_MIGUEL_ALONSO_REQUENA
	addCenterDual( &"CREDITS_OTRN_MPG_CHRIS_KIRBY", &"CREDITS_OTRN_MPG_MIGUEL_ALONSO_REQUENA");

	//MPG_CIPRIAN_APRODU
	//MPG_MOLLY_SCUTT
	addCenterDual( &"CREDITS_OTRN_MPG_CIPRIAN_APRODU", &"CREDITS_OTRN_MPG_MOLLY_SCUTT");

	//MPG_DANIEL_HART
	//MPG_PETER_SZABO
	addCenterDual( &"CREDITS_OTRN_MPG_DANIEL_HART", &"CREDITS_OTRN_MPG_PETER_SZABO");

	//MPG_DANNY_MCKEOWN
	//MPG_RAFAEL_HAGEN_HORBACH
	addCenterDual( &"CREDITS_OTRN_MPG_DANNY_MCKEOWN", &"CREDITS_OTRN_MPG_RAFAEL_HAGEN_HORBACH");

	//MPG_DARIUSZ_KROK
	//MPG_ROCCO_LOSCALZO
	addCenterDual( &"CREDITS_OTRN_MPG_DARIUSZ_KROK", &"CREDITS_OTRN_MPG_ROCCO_LOSCALZO");

	//MPG_DARREN_FERRIE
	//MPG_ROGER_CHEUNG
	addCenterDual( &"CREDITS_OTRN_MPG_DARREN_FERRIE", &"CREDITS_OTRN_MPG_ROGER_CHEUNG");

	//MPG_DERMOT_GALLAGHER
	//MPG_SILVANA_BANEGAS
	addCenterDual( &"CREDITS_OTRN_MPG_DERMOT_GALLAGHER", &"CREDITS_OTRN_MPG_SILVANA_BANEGAS");

	//MPG_GAR_JUN_LAM
	//MPG_TAMAS_CSEFALVAY
	addCenterDual( &"CREDITS_OTRN_MPG_GAR_JUN_LAM", &"CREDITS_OTRN_MPG_TAMAS_CSEFALVAY");

	//MPG_IAN_REYNOLDS
	//MPG_ZACHARY_MARKHAM
	addCenterDual( &"CREDITS_OTRN_MPG_IAN_REYNOLDS", &"CREDITS_OTRN_MPG_ZACHARY_MARKHAM");

	addSpaceSmall();
	addSpaceSmall();
}