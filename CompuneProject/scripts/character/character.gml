#macro cGravity 0.000000008
#macro cWalkSpeed 0.00075
#macro cJumpSpeed -.002
#macro cMaxFallingSpeed 0.005
#macro cMinJumpSpeed -0.0005
#macro cJumpAmount 4
#macro cHalfSizeY 20
#macro cHalfSizeX 6

function Character(): MovingObject() constructor{
	mInputs = [];
	mPrevInputs = [];
	
	mCurrentState = CharacterState.Stand;
	mCurrentAnimationState = CharacterAnimationState.IdleRight;
	mPrevAnimationState = mCurrentAnimationState;
	
	mJumpSpeed = 0;
	mWalkSpeed = 0;
	mJumpAmount = 0;
	
	mAnimations[CharacterAnimationState.IdleRight] = new Animation(spr_playerIdle, [0], new Vector2(1,1), 4);
	mAnimations[CharacterAnimationState.IdleLeft] = new Animation(spr_playerIdle, [0], new Vector2(-1,1), 4);
	mAnimations[CharacterAnimationState.WalkRight] = new Animation(spr_playerRunning, [0,1,2,3,4,5,6], new Vector2(1,1), 4);
	mAnimations[CharacterAnimationState.WalkLeft] = new Animation(spr_playerRunning, [0,1,2,3,4,5,6], new Vector2(-1,1), 4);
	mAnimations[CharacterAnimationState.JumpRight] = new Animation(spr_playerJumping, [0], new Vector2(1,1), 4);
	mAnimations[CharacterAnimationState.JumpLeft] = new Animation(spr_playerJumping, [0], new Vector2(-1,1), 4);
	
	function Released(_key){
		return (!mInputs[_key] && mPrevInputs[_key]);
	}

	function KeyState(_key){
		return (mInputs[_key]);
	}

	function Pressed(_key){
		return (mInputs[_key] && !mPrevInputs[_key]);
	}
	
	function UpdatePrevInputs(){
		var count = KeyInput.Count;
		
		for(var i=0; i<count; i+=1){
			mPrevInputs[i] = mInputs[i];
		}
	}
	
	function CharacterInit(_inputs,_prevInputs){
		mAABB.halfSize = new Vector2(cHalfSizeX,cHalfSizeY);
		mAABBOffset.y = mAABB.halfSize.y;
		
		mInputs = _inputs;
		mPrevInputs = _prevInputs;
		
		mJumpSpeed = cJumpSpeed;
		mWalkSpeed = cWalkSpeed;
		mJumpAmount = cJumpAmount;
		
		mScale.VectorOne();
	}
	
	function CharacterUpdate(){
		switch(mCurrentState){
			case CharacterState.Stand:
				
				if(mPrevAnimationState == CharacterAnimationState.IdleRight || mPrevAnimationState == CharacterAnimationState.WalkRight || mPrevAnimationState == CharacterAnimationState.JumpRight){
					mCurrentAnimationState = CharacterAnimationState.IdleRight;
				} else{
					mCurrentAnimationState = CharacterAnimationState.IdleLeft;
				}
				
				
				mSpeed.VectorZero();
				mJumpAmount = cJumpAmount;
				
				if(!mOnGround){
					mCurrentState = CharacterState.Jump;
				}
				
				if(KeyState(KeyInput.GoRight) != KeyState(KeyInput.GoLeft)){
					mCurrentState = CharacterState.Walk;
					break;
				} 
				
				if(KeyState(KeyInput.Jump)){
					mSpeed.y = mJumpSpeed;
					mJumpAmount -= 1;
					mCurrentState = CharacterState.Jump;
					break;
				}
				break;
			case CharacterState.Walk:
				
				mJumpAmount = cJumpAmount;
				
				if (KeyState(KeyInput.GoRight) == KeyState(KeyInput.GoLeft)){
				    mCurrentState = CharacterState.Stand;
				    mSpeed.VectorZero();
				    break;
				} else if (KeyState(KeyInput.GoRight)){
					mCurrentAnimationState = CharacterAnimationState.WalkRight;
				    if (mPushesRightWall){
				        mSpeed.x = 0;
					}
				    else{
				        mSpeed.x = mWalkSpeed;
					}
				    mScale.x = abs(mScale.x);
				} else if (KeyState(KeyInput.GoLeft)){
					mCurrentAnimationState = CharacterAnimationState.WalkLeft;
				    if (mPushesLeftWall){
				        mSpeed.x = 0;
					}
				    else{
				        mSpeed.x = -mWalkSpeed;
					}
				    mScale.x = -abs(mScale.x);
				}
				
				if (KeyState(KeyInput.Jump)){
				    mSpeed.y = mJumpSpeed;
					mJumpAmount -= 1;
				    mCurrentState = CharacterState.Jump;
				    break;
				} else if (!mOnGround){
				    mCurrentState = CharacterState.Jump;
				    break;
				}
				break;
			case CharacterState.Jump:
				
				mCurrentAnimationState = CharacterAnimationState.JumpRight;
				mSpeed.y += cGravity * delta_time;
				mSpeed.y = min(mSpeed.y,cMaxFallingSpeed);
				
				if(!KeyState(KeyInput.Jump) && mSpeed.y < 0){
					mSpeed.y = max(mSpeed.y,cMinJumpSpeed);
				}
				
				if(Pressed(KeyInput.Jump) && mJumpAmount > 0){
					mSpeed.y = mJumpSpeed;
					mJumpAmount -= 1;
				}
				
				if (KeyState(KeyInput.GoRight) == KeyState(KeyInput.GoLeft)){
				    mSpeed.x = 0;
				} else if (KeyState(KeyInput.GoRight)){
				    if (mPushesRightWall){
				        mSpeed.x = 0;
					}
				    else{
				        mSpeed.x = mWalkSpeed*0.8;
					}
				    mScale.x = abs(mScale.x);
				} else if (KeyState(KeyInput.GoLeft)){
					mCurrentAnimationState = CharacterAnimationState.JumpLeft;
				    if (mPushesLeftWall){
				        mSpeed.x = 0;
					}
				    else{
				        mSpeed.x = -mWalkSpeed*0.8;
					}
				    mScale.x = -abs(mScale.x);
				}
				
				if(mOnGround){
					if (KeyState(KeyInput.GoRight) == KeyState(KeyInput.GoLeft)){
						mCurrentState = CharacterState.Stand;
						mSpeed.VectorZero();
					} else{
						mCurrentState = CharacterState.Walk;
						mSpeed.y = 0;
					}
				}
				break;
			case CharacterState.GrabLedge:
				
				break;
		}
		
		mAnimations[mCurrentAnimationState].Update();
		
		mPrevAnimationState = mCurrentAnimationState;
		
		UpdatePhysics();
		UpdatePrevInputs();
	}
}