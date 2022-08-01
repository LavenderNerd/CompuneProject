player.mInputs[KeyInput.GoRight] = keyboard_check(ord("D"));
player.mInputs[KeyInput.GoLeft] = keyboard_check(ord("A"));
player.mInputs[KeyInput.GoDown] = keyboard_check(ord("S"));
player.mInputs[KeyInput.Jump] = keyboard_check(vk_space);

player.CharacterUpdate();

particleTimer -= 1;
gameTimer += 1;
if(particleTimer <= 0 && player.mCurrentState == CharacterState.Jump){
	ds_list_add(particles, new Particle(
		gameTimer,new Vector2(player.mPosition.x, player.mPosition.y-32), new Vector2(0,0), 80+irandom(60), make_color_rgb(random(255),random(255),random(255)), 5+random(5)));
	particleTimer = particleTimerLimit;
}

var deleteList = ds_list_create();
for(var i=0; i<ds_list_size(particles); i+=1){
	particles[|i].Update();
	if(particles[|i].mCurrentTimer == 0){
		ds_list_add(deleteList,particles[|i].mID);
	}
}
for(var i=0; i<ds_list_size(deleteList); i+=1){
	var index = -1;
	
	for(var j=0; j<ds_list_size(particles); j+=1){
		if(particles[|j].mID == deleteList[|i]){
			index = j;
		}
	}
	
	ds_list_delete(particles,index);
}


