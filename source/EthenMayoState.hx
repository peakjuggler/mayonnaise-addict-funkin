package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxObject;
import Controls.KeyboardScheme;

class Galaxy
{
	var galaxy = new FlxSprite(-450, -300).loadGraphic(Paths.image('space/galaxyWoeoe', 'shared'));
}

