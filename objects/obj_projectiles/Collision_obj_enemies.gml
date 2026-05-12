if (other.alive)
{
	other.life -= damage;
	instance_destroy(self);
}

scr_pop_damage(self, other);