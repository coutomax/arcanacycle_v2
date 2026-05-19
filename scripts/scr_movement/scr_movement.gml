function movement_apply (object)
{
	object.x			+= round(object.data.move.xspd);
	object.y			+= round(object.data.move.yspd);
}