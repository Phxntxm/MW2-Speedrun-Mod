// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("body_opforce_merc_smg_c");
	codescripts\character::attachHead( "alias_opforce_merc_heads", xmodelalias\alias_opforce_merc_heads::main() );
	if ( issubstr( self.headModel, "hat" ) )
	{
		self.hatModel = "hat_opforce_merc_b";
		self attach(self.hatModel);
	}
	self.voice = "russian";
}

precache()
{
	precacheModel("body_opforce_merc_smg_c");
	codescripts\character::precacheModelArray(xmodelalias\alias_opforce_merc_heads::main());
	precacheModel("hat_opforce_merc_b");
}
