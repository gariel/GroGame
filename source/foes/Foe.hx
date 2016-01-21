package foes;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;

class Foe extends FlxSprite
{
	public static var playing = true;

	public var speed(default,default):Int;
	public var tabble(default, default):Tabble;
	public var player(default, default):Player;

	public function new (player:Player, tabble:Tabble, foeName:String)
	{
		super(FlxG.width / 2, FlxG.height / 2, Assets.getBitmapData("assets/" + foeName + ".png"));
		this.tabble = tabble;
		this.player = player;
		speed = 0;
	}
	
	override public function update():Void 
	{
		super.update();

		if (playing) 
		{
			var p = Util.calcProgressPoint(x, y, player.x, player.y);
			x += speed * p.x;
			y += speed * p.y;
		}
	}
}