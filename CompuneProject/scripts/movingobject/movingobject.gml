#macro groundLevel 2000

function MovingObject() constructor{
	
	mOldPosition = new Vector2();
	mPosition = new Vector2();
	
	mOldSpeed = new Vector2();
	mSpeed = new Vector2();
	
	mScale = new Vector2(1,1);
	
	mAABB = new AABB(new Vector2(),new Vector2());
	mAABBOffset = new Vector2();
	
	mPushedRightWall = false;
	mPushesRightWall = false;
	
	mPushedLeftWall = false;
	mPushesLeftWall = false;
	
	mWasOnGround = false;
	mOnGround = false;
	
	mWasAtCeiling = false;
	mAtCeiling = false;
	
	function UpdatePhysics(){
		mOldPosition = mPosition;
		mOldSpeed = mSpeed;
		
		mWasOnGround = mOnGround;
		mPushedRightWall = mPushesRightWall;
		mPushedLeftWall = mPushesLeftWall;
		mWasAtCeiling = mAtCeiling;
		
		mPosition = mPosition.Add(mSpeed.Multiply(delta_time));
		
		if(mPosition.y >= groundLevel){
			mPosition.y = groundLevel;
			mOnGround = true;
		} else{
			mOnGround = false;
		}
		
		mAABB.center = mPosition.Add(mAABBOffset);
		
		
	}
}