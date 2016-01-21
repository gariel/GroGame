package;

class Point {

	//FlxPoint?

	public var x : Float;
	public var y : Float;

	public function new(xx:Float, yy:Float)
	{
		x = xx;
		y = yy;
	}

	function toString() : String
	{
		return "x: " + x + " - y: " + y;
	}
}