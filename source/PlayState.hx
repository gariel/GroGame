package;

import flash.display.BitmapData;
import flash.Lib;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.Assets;

import foes.Foe;
import foes.GreenFoe;

class PlayState extends FlxState
{
	private var tabble:Tabble;
	private var shots:Array<Shot>;
	private var foes:Array<Foe>;
	private var player:Player;
	private var mouse:Mouse;
	private var overlayCamera:FlxCamera;
	private var hud:HUD;

	private var startDelay = 0;
	private var fi = 0;
	private var ff = 60;

	override public function create():Void 
	{
		tabble = new Tabble();
		tabble.Min_X = -Lib.current.stage.stageWidth;
		tabble.Max_X = Lib.current.stage.stageWidth;
		tabble.Min_Y = -Lib.current.stage.stageHeight;
		tabble.Max_Y = Lib.current.stage.stageHeight;
		
		super.create();
		createFloor();
		
		FlxG.mouse.visible = false;
		
		shots = new Array<Shot>();
		foes = new Array<Foe>();
		player = new Player(tabble);
		mouse = new Mouse();
		hud = new HUD();

		add(player);
		add(mouse);
		add(hud);
		setCamera();

		hud.lives = 5;
		begin();
	}

	private function begin()
	{
		player.x = 0;
		player.y = 0;
		startDelay = 30;
	}

	private function die()
	{
		if(hud.lives > 0) 
		{
			for (s in shots) 
			{
				removeShot(s);
			}
			for (f in foes)
			{
				removeFoe(f);
			}

			hud.lives -= 1;
			begin();
		}
		else
		{
			Foe.playing = false;
			HUD.playing = false;
			hud.lives = -1;

			// Game Over
			var go = new FlxText(player.x - 100, player.y - 100, 300, "Game Over");
			go.setFormat(null, 72, FlxColor.WHITE);
			add(go);
		}
	}

	private function setCamera()
	{
		var hudCam = new FlxCamera(0, 0, 200, 180);
		hudCam.bgColor = 0x0;
		hudCam.follow(hud.background);
		FlxG.cameras.add(hudCam);

		
		FlxG.camera.setScrollBoundsRect(tabble.Min_X * 1.5,
							tabble.Min_Y *1.5,
							(tabble.Max_X + Math.abs(tabble.Min_X)) * 1.5,
							 (tabble.Max_Y + Math.abs(tabble.Min_Y)) * 1.5,
							 true);
		FlxG.camera.follow(player, FlxCameraFollowStyle.LOCKON, 1);
	}

	private function createFloor() 
	{
		var	FloorImg = Assets.getBitmapData("assets/background.png");
		var ImgWidth = FloorImg.width;
		var ImgHeight = FloorImg.height;
		var i = tabble.Min_X; 
		var j = tabble.Min_Y;

		while (i <= tabble.Max_X)  
		{
			j = tabble.Min_Y;
			while (j <= tabble.Max_Y)
			{
				var spr = new FlxSprite(i, j, FloorImg);
				add(spr);
				j += ImgHeight;
			}
			i += ImgWidth;
		}
		
		tabble.Max_Y = j;
		tabble.Max_X = i;
	}
	
	override public function update(elasped:Float):Void 
	{	
		super.update(elasped);

		if (hud.lives < 0) 
		{
			return;
		}

		readKeys();
		controlShots();

		if(fi == 0)
		{
			fi = ff;
			if(ff > 30)
				ff--;

			var f = new GreenFoe(player, tabble);
			var r = Std.random(100);
			var p = Math.floor(foes.length % 4) + 1;

			if (p % 2 != 0) 
				f.y = tabble.Min_Y + (r / 100) * (tabble.Max_Y - tabble.Min_Y);
			else
				f.x = tabble.Min_X + (r / 100) * (tabble.Max_X - tabble.Min_X);

			if(p == 1) { f.x = tabble.Min_X; }
			if(p == 2) { f.y = tabble.Min_Y; }
			if(p == 3) { f.x = tabble.Max_X - f.width; }
			if(p == 4) { f.y = tabble.Max_Y - f.height; }

			foes.push(f);
			add(f);
		}
		fi --;

		if (startDelay > 0)
			startDelay --;
	}

	private function readKeys():Void
	{
		var p = new Point(0, 0);
		var ps = new Point(0, 0);

		if (FlxG.keys.anyPressed(["A"])) p.x -= 1;
		if (FlxG.keys.anyPressed(["S"])) p.y += 1;
		if (FlxG.keys.anyPressed(["D"])) p.x += 1;
		if (FlxG.keys.anyPressed(["W"])) p.y -= 1;

		if (FlxG.keys.anyPressed(["LEFT"])) ps.x -= 10;
		if (FlxG.keys.anyPressed(["DOWN"])) ps.y += 10;
		if (FlxG.keys.anyPressed(["RIGHT"])) ps.x += 10;
		if (FlxG.keys.anyPressed(["UP"])) ps.y -= 10;

		// pode fazer tratamento pra direcional com angulo

		player.move(Util.calcProgressPoint(0, 0, p.x, p.y));

		if (FlxG.mouse.pressed) 
			makeShot(FlxG.mouse.x, FlxG.mouse.y);

		if (ps.x != 0 || ps.y != 0)
			makeShot((player.x + player.width / 2) + ps.x, (player.y + player.height / 2) + ps.y );

		//TODO:mover pra shot
		if (Shot.shotWait > 0)
			Shot.shotWait--;
	}

	private function controlShots():Void
	{
		for (shot in shots) 
		{
			if(shot != null)
			{
				shot.doFly(Shot.speed);
				if(!Util.isInsideTabble(tabble, shot.x, shot.y))
					removeShot(shot);
			}
		}
		for (foe in foes)
		{
			for (shot in shots)
			{
				if(Util.isInside(shot, foe))
				{
					removeFoe(foe);
					removeShot(shot);
					hud.score += 10;
				}
			}
			if (Util.isInside(foe, player))
				die();
		}
	}

	public function makeShot(x:Float, y:Float)
	{
		//TODO:criar métodos dentro de Shot
		if(Shot.shotWait == 0 && startDelay == 0) 
		{
			var shot = new Shot();
			var sh = shot.height / 2;
			var sw = shot.width / 2;
			shot.setFly(player.x + player.width / 2 - sw, player.y + player.height / 2 - sh, x - sw, y - sh);
			shots.push(shot);
			add(shot);
			Shot.shotWait = Shot.shotDelay;
		}
	}

	public function removeShot(shot:Shot) 
	{
		shots.remove(shot);
		remove(shot);
	}

	public function removeFoe(foe:Foe) 
	{
		foes.remove(foe);
		remove(foe);
	}
}