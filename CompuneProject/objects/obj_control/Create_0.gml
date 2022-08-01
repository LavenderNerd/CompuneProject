player = new Character();

inputs = array_create(KeyInput.Count);
prevInputs = array_create(KeyInput.Count);

player.CharacterInit(inputs,prevInputs);

player.mPosition.x = 400;
player.mPosition.y = 20;

highestPoint = 0;

particles = ds_list_create();

gameTimer = 0;
particleTimer = 2;
particleTimerLimit = particleTimer;