if (other.alive)
{
	other.life -= damage;
	instance_destroy(self);
}