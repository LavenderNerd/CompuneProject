function AABB(_center,_halfsize) constructor{
	center = _center;
	halfSize = _halfsize;
	
	function Overlaps(_other){
		if(abs(center.x - _other.center.x) > halfSize.x + _other.halfSize.x){ return false; }
		if(abs(center.y - _other.center.y) > halfSize.y + _other.halfSize.y){ return false; }
		return true;
	}
}