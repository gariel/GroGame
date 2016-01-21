package;

import flixel.FlxSprite;

class Util {

	public static function sinD(v:Float) : Float
	{
		return Math.sin(degreesToRadians(v));
	}

	public static function cosD(v:Float) : Float
	{
		return Math.cos(degreesToRadians(v));
	}

	public static function degreesToRadians(degrees:Float):Float 
	{
		return degrees * Math.PI / 180;
	}

	public static function radiansToDegrees(radians:Float):Float
	{
		return radians * 180 / Math.PI;
	}

	public static function calcProgressPoint(ix:Float, iy:Float, mx:Float, my:Float):Point
	{
		var dx = mx - ix;
		var dy = my - iy;
		var q = Math.abs(dx) + Math.abs(dy);

		var px = 0.0;
		var py = 0.0;

		if(q > 0)
		{
			px = (Math.abs(dx) / q) * (dx > 0 ? 1 : -1);
			py = (Math.abs(dy) / q) * (dy > 0 ? 1 : -1);

			px += 0.2 * sinD(Math.abs(px) * 180) * (px > 0 ? 1 : -1);
			py += 0.2 * sinD(Math.abs(py) * 180) * (py > 0 ? 1 : -1);
		}

		return new Point(px, py);
	}

	public static function isInsideTabble(tabble:Tabble, x:Float, y:Float):Bool
	{
		//TODO: inverter
		return !(x > tabble.Max_X || x < tabble.Min_X || y > tabble.Max_Y || y < tabble.Min_Y);
	}

	public static function isInside(a1:FlxSprite, a2:FlxSprite):Bool
	{
		return a1.x + a1.width >= a2.x && a1.x <= a2.x + a2.width
			&& a1.y + a1.height >= a2.y && a1.y <= a2.y + a2.height;
	}
}