package;

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

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var logoBl:FlxSprite;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'options', 'credits'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool = true;
	var disc:FlxSprite = new FlxSprite(1299, 460);

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "ALPHA" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Scrolling through the menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('spaceMenu'));
		bg.frames = Paths.getSparrowAtlas('spaceMenu');
		bg.animation.addByPrefix('bump', 'Space?', 24, true);
		bg.animation.play('bump');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.15;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.15;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFF974FD6;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(5, 60 + (i * 160));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			// menuItem.screenCenter(X);
			// NO CENTERING!! fuck centering!!!!!!!!!!!!!!!
			menuItems.add(menuItem);
			menuItem.scrollFactor.set(0.05, 0.05);
			menuItem.setGraphicSize(Std.int(menuItem.width / 1.3));
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Fruit Punch Engine ~ VS. Ethen Full Week", 0);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		FlxTween.tween(disc,{x:1009, y:460}, 1, {ease:FlxEase.expoInOut});

		logoBl = new FlxSprite(1299, 260);
		logoBl.scrollFactor.set(0,0);
		logoBl.scale.set(0.6, 0.6);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin', 'preload');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'Eef Full Title', 24);
		logoBl.animation.play('bump');
		logoBl.scrollFactor.set(0, 0.25);
		logoBl.updateHitbox();
		add(logoBl);

		new FlxTimer().start(0.29, function(swagtimer:FlxTimer)
		{
			// FlxTween.tween(menuItems,{x:20, y:60}, 1, {ease:FlxEase.expoInOut});

			FlxTween.tween(logoBl,{x:859, y:390}, 1, {ease:FlxEase.expoInOut});
		});

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		#if debug
		if (FlxG.keys.justPressed.R)
		{
			new FlxTimer().start(0.05, function(tmr:FlxTimer)
			{
				trace("reset!");
				_kingsave.data.weekUnlocked = [true, true, false, false, false];
				trace(_kingsave.data.weekUnlocked);
				_kingsave.flush();
			});
		}
		if (FlxG.keys.justPressed.T)
		{
			new FlxTimer().start(0.05, function(tmr:FlxTimer)
			{
				trace("t!");
				_kingsave.data.weekUnlocked = [true, true, true, true, true];
				trace(_kingsave.data.weekUnlocked);
				_kingsave.flush();
			});
		}
		#end

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			//This part below keeps crashing the game, so lets not, why don't we?
			// if (controls.BACK)
			// {
			// 	FlxG.switchState(new TitleState());
			// }

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
					#else
					FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
					#end
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					FlxTween.tween(logoBl,{x:1499, y:260}, 1, {ease:FlxEase.expoInOut});
					FlxTween.tween(disc,{x:1499, y:560}, 1, {ease:FlxEase.expoInOut});
					new FlxTimer().start(1, function(swagTimer:FlxTimer){
						remove(logoBl);
					});
					

					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		// menuItems.forEach(function(spr:FlxSprite)
		// {
		// 	spr.screenCenter(X);
		// });
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'options':
				FlxG.switchState(new OptionsMenu());
			case 'credits':
				FlxG.switchState(new CreditsMenuState());
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}