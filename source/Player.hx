package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;

class Player extends FlxSprite
{
	public var speed(default,default) = 5;
	public var tabble(default, default):Tabble;

	public function new (tabble:Tabble)
	{
		super(FlxG.width / 2, FlxG.height / 2, Assets.getBitmapData("assets/player.png"));
		this.tabble = tabble;
	}
	
	override public function update(elasped:Float):Void 
	{
		super.update(elasped);
	}

	public function move(p:Point):Void
	{
		x += speed * p.x;
		y += speed * p.y;

		if (x < tabble.Min_X)  			x = tabble.Min_X;
		if (x + width > tabble.Max_X) 	x = tabble.Max_X - width;
		if (y < tabble.Min_Y)  			y = tabble.Min_Y;
		if (y + height > tabble.Max_Y)  y = tabble.Max_Y - height;

		if (p.x != 0 || p.y != 0)
			angle = Util.radiansToDegrees(Math.atan2(p.x, -p.y));
	}
}