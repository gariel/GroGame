package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class HUD extends FlxGroup
{
	public static var playing = true;

	private var txtScore:FlxText;
	private var txtLives:FlxText;
	private var txtTime:FlxText;

	public var background:FlxSprite;

	public var score = 0;
	public var lives = 0;
	private var time = 0;

	public function new()
	{
		super();

		background = new FlxSprite(10000 -50, -175);
		background.makeGraphic(300, 360, 0x0);
		add(background);

		txtScore = new FlxText(10006, 10, 200);
		formatTxt(txtScore);
		add(txtScore);

		txtLives = new FlxText(10006, 30, 200);
		formatTxt(txtLives);
		add(txtLives);

		txtTime = new FlxText(10006, 50, 200);
		formatTxt(txtTime);
		add(txtTime);
	}

	public function formatTxt(txt:FlxText)
	{
		txt.setFormat(null, 16, 0x55FF55);
	}

	public override function update()
	{
		if(playing)
		{
			txtScore.text = "Score: " + score;
			txtLives.text = "Lives: " + lives;

			var m = "" + Std.int(time / 3600);
			if(m.length == 1) 
			{
				m = "0" + m;
			}
			var s = "0" + (Std.int(time / 60) % 60);
			txtTime.text  = "Time: " + m + ":" + s.substring(s.length - 2);
			time ++;
		}
	}
}