package;

#if desktop
import Discord.DiscordClient;
#end
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import Main._kingsave;
//kinge :swag:

class CreditsMenuState extends MusicBeatState
{
    var logoBl:FlxSprite;
	var usingtheMouse:Bool = false;
	var selected:Bool = false;
	var bksp:FlxSprite;
	var iconRPC:String = "";
	
	

   override public function create()
	{       //this is for the main credits animation and discord rpc
        DiscordClient.changePresence("Peepin' the Credits Menu", iconRPC);

		FlxG.mouse.visible = true;

        logoBl = new FlxSprite(-40, -45);
		logoBl.scrollFactor.set(0,0);
		logoBl.frames = Paths.getSparrowAtlas('Credits', 'shared');
		//shared, again, fuck you haxeflixel
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'Loop Showcase', 24, true);
		logoBl.animation.play('bump');
		logoBl.setGraphicSize(Std.int(logoBl.width / 2.1));
		logoBl.updateHitbox(); //technically doesnt need to be here but for safety reasons it will stay
		logoBl.screenCenter();
		add(logoBl);

		//this is for the backspace to exit animation setup
		//im still gonna comment on the antialiasing chucklenuts
		bksp = new FlxSprite(-500, 0);
		bksp.scrollFactor.set(0, 0);
		bksp.frames = Paths.getSparrowAtlas('theBackspace', 'shared');
		bksp.antialiasing = true;
		bksp.animation.addByPrefix('idle', 'bksp IDLE', 24, true);
		bksp.animation.addByPrefix('pressed', 'bksp PRESSED', 24, false);
		bksp.animation.play('idle');
		bksp.setGraphicSize(Std.int(bksp.width / 1.3));
		bksp.updateHitbox();
		FlxTween.tween(bksp,{x:0, y:0}, 1, {ease:FlxEase.expoInOut});
		add(bksp);
    }
    //hey ecto
	//balls
	override function update(elapsed:Float) // hi ember
	{
		super.update(elapsed);
        //god help you if you dont got a backspace button
		
		if (FlxG.mouse.pressed)
		{
			{
				// [hyperlink blocked?]
				#if linux
				Sys.command('/usr/bin/xdg-open', ["https://twitter.com/BizarreEthen", "&"]); // fuck you if you use linux
				#else
				FlxG.openURL('https://twitter.com/BizarreEthen');
				FlxG.openURL('https://twitter.com/carmine_father');
				FlxG.openURL('https://twitter.com/omatssu');
				FlxG.openURL('https://twitter.com/heartlxcket');
				FlxG.openURL('https://twitter.com/Kye_VL');
				FlxG.openURL('https://twitter.com/BizarreEthen');
				FlxG.openURL('https://twitter.com/BizarreEthen');
				FlxG.openURL('https://twitter.com/BizarreEthen');
				FlxG.openURL('https://twitter.com/BizarreEthen');
				FlxG.openURL('https://twitter.com/BizarreEthen');
				#end
				// holy shit!?!?! spamtong refance!!!!
			}
		}
		   	

		if (FlxG.keys.pressed.ANY)
		{
			bksp.animation.play('pressed');
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.mouse.visible = false; // so that your mouse doesnt appear in the menu, since this statement is global for some fucking reason
			
			new FlxTimer().start(0.33, function(swagtimer:FlxTimer)
			{
			FlxG.switchState(new MainMenuState());
			});
		}
	}
}


