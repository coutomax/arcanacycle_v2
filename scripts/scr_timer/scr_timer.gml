function scr_timer(seconds){
	
	var _steps	= seconds * room_speed;
	
	return {
		duration	: _steps,
		current		: 0,
		active		: false,
		
		start		: function ()
		{
			self.current	= self.duration;
			self.active		= true;
		},
		
		update		: function ()
		{
			if (self.active && self.current > 0)
			{
				self.current		-= 1;
				if (self.current <= 0)
				{
					self.active		= false
				}
			}
		},
		
		is_done		: function ()
		{
			return !self.active;
		},
		
		reset		: function ()
		{
			self.current		= 0;
			self.active			= false;
		}
	}
}