var cam = view_get_camera(0);
camera_set_view_pos(cam, player.mPosition.x - 400, player.mPosition.y - 300);

draw_set_color(c_green);
draw_rectangle(-200000,groundLevel,200000,10000,false);
draw_set_color(c_white);

for(var i=0; i<ds_list_size(particles); i+=1){
	var alpha = particles[|i].mCurrentTimer/particles[|i].mTimer;
	var rotation = (particles[|i].mCurrentTimer*4) mod 360;
	draw_sprite_ext(spr_sparkle,0,particles[|i].mPosition.x, particles[|i].mPosition.y, 2, 2, rotation, particles[|i].mColor, alpha);
}

var animation = player.mAnimations[player.mCurrentAnimationState];
draw_sprite_ext(animation.mSprite,animation.mIndex,player.mPosition.x,player.mPosition.y,player.mScale.x,player.mScale.y,0,-1,1);