package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;
import Math;
import Util;

class Shot extends FlxSprite
{
	public static var shotDelay(default,default) = 5;
	public static var shotWait(default,default) = 0;
	public static var speed(default,default) = 10;

	public var point : Point;

	public function new ()
	{
		super(FlxG.width / 2, FlxG.height / 2, Assets.getBitmapData("assets/shot.png"));
	}

	public function setFly(ix:Float, iy:Float, mx:Float, my:Float):Void
	{
		x = ix;
		y = iy;

		point = Util.calcProgressPoint(ix, iy, mx, my);
	}

	public function doFly(speed:Int):Void
	{
		x += speed * point.x;
		y += speed * point.y;
	}
	
	override public function update():Void 
	{
		super.update();
	}
}