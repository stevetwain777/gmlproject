enum side {
	none    = 0,
	left		= $1,
	right		= $2,
	top			= $4,
	bottom	= $8,
	
	// Values to test for horizontal sides or vertical sides.
	horizontal = $C, // Top & Bottom
	vertical	 = $3, // Left & Right
}

enum tile_type {
	empty       = 0,
	solid				= 1,
	oneway			= 2,
	ice					= 3,
}

enum facing_direction {
	right = 1,
	left = -1,
}