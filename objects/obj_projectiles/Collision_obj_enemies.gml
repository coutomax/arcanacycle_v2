if (other.data.flag.alive && !data.flag.is_enemy)
{
	other.data.stats.life -= data.stats.damage;
	if (data.audio.collide_sound != noone)
	{
		audio_play_sound(data.audio.collide_sound, 0, false, 0.04);
	}
	pop_damage(self, other);
	instance_destroy(self);
}

