package;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var char:String = 'bf';
	public var isPlayer:Bool = false;
	public var isOldIcon:Bool = false;

	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var defaultIconScale:Float = 1;
	public var iconScale:Float = 1;
	public var iconSize:Float;

	public function new(?char:String = "bf", ?isPlayer:Bool = false)
	{
		super();

		this.char = char;
		this.isPlayer = isPlayer;

		isPlayer = isOldIcon = false;

		antialiasing = FlxG.save.data.antialiasing;

		changeIcon(char);
		scrollFactor.set();
	}

	public function changeIcon(char:String)
	{
		frames = Paths.getSparrowAtlas('iconAssets', 'preload');
		

		if (isPlayer)
		{

			antialiasing = true;
			
			animation.addByPrefix('loss', 'Boyfriend Fail Icon', 24, false, isPlayer);
			animation.addByPrefix('normal', 'Boyfriend Health Icon', 24, false, isPlayer);
			animation.addByPrefix('win', 'Boyfriend Health Icon', 24, false, isPlayer);
		}
		else
		{

			antialiasing = true;

			animation.addByPrefix('loss', 'Space Face Damaged', 24, false, isPlayer);
			animation.addByPrefix('normal', 'Space Face Static', 24, false, isPlayer);
			animation.addByPrefix('win', 'Space Face Static', 24, false, isPlayer);
			flipX = true;
		}

		animation.play('normal', true);

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		setGraphicSize(Std.int(iconSize * iconScale));
		updateHitbox();

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}