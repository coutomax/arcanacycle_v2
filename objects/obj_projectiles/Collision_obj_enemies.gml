if (other.data.flag.alive)
{
	other.data.stats.life -= data.stats.damage;
	instance_destroy(self);
}

pop_damage(self, other);