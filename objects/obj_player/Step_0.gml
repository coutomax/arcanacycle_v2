//obstacle		= instance_place(x, y, obj_test_ramp);

//if(obstacle !=noone)
//{
//	scr_slope_collision(self, obstacle);
//}
//move.on_step(self);

//scr_jump(self);


//Get inputs
var _keyRight = keyboard_check(vk_right);
var _keyLeft = keyboard_check(vk_left);
var _keyJump = keyboard_check_pressed(vk_space);

slopeOn = keyboard_check(vk_control);

//Work out where to move horizontally
hsp = (_keyRight - _keyLeft) * 2;

//Work out where to move vertically
vsp = vsp + grv;

//Work out if we should jump
if (canJump-- > 0) && (_keyJump)
{
	vsp = vspJump;
	canJump = 0;
}

//Are we on the ground?
onGround = place_meeting(x,y+1,obj_test);

//Horizontal move & collide
var _hCol = move_and_collide(hsp, 0, obj_test, abs(hsp))

//Walk down slope
if (onGround) && (place_meeting(x,y + abs(hsp) + 1 ,obj_test)) && (vsp >= 0)
{	
	vsp += abs(hsp) + 1;
}

//Vertical move & collide
var _vCol = move_and_collide(0, vsp, obj_test, abs(vsp)+1 , hsp, vsp, hsp, vsp)
if (array_length(_vCol)  > 0)
{
	if (vsp > 0) canJump = 10;
	vsp = 0;
}