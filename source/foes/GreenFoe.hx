package foes;

class GreenFoe extends Foe {
	public function new (player:Player, tabble:Tabble)
	{
		super(player, tabble, "green");
		speed = 1;
	}
}