function Particle(_ID,_position,_speed,_timer=-1,_color=c_white,_size=1) constructor{
	mID = _ID;
	mPosition = _position;
	mSpeed = _speed;
	mTimer = _timer
	mColor = _color;
	mSize = _size;
	mCurrentTimer = mTimer;
	
	function Update(){
		mPosition = mPosition.Add(mSpeed);
		if(mCurrentTimer > 0){
			mCurrentTimer -= 1;
		}
	}
}