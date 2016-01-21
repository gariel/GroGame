package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;

class Mouse extends FlxSprite
{
	public function new ()
	{
		super(FlxG.width / 2, FlxG.height / 2, Assets.getBitmapData("assets/aim.png"));
	}
	
	override public function update():Void 
	{
		super.update();
		x = FlxG.mouse.x;
		y = FlxG.mouse.y;
	}
}