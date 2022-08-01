function Animation(_sprite,_frames,_scale,_timerLimit) constructor{
	mSprite = _sprite;
	mFrames = _frames;
	mScale = _scale;
	mTimerLimit = _timerLimit;
	mTimer = mTimerLimit;
	
	mIndex = 0;
	
	function Update(){
		mTimer -= 1;
		if(mTimer <= 0){
			mIndex += 1;
			if(mIndex >= array_length(mFrames)){
				mIndex = 0;
			}
			
			mTimer = mTimerLimit;
		}
	}
}