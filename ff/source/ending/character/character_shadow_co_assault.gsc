// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("body_shadow_co_assault");
	codescripts\character::attachHead( "alias_shad_co_heads", xmodelalias\alias_shad_co_heads::main() );
	self.voice = "shadowcompany";
}

precache()
{
	precacheModel("body_shadow_co_assault");
	codescripts\character::precacheModelArray(xmodelalias\alias_shad_co_heads::main());
}
