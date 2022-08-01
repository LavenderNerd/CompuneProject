function Vector2(_x=0,_y=0) constructor{
	x = _x;
	y = _y;
	
	function Add(_other){
		return new Vector2(x+_other.x, y+_other.y);
	}
	
	function Multiply(_scalar){
		return new Vector2(x*_scalar,y*_scalar);
	}
	
	function VectorZero(){
		x = 0;
		y = 0;
	}
	
	function VectorOne(){
		x = 1;
		y = 1;
	}
}