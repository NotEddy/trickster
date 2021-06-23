package;

import flixel.math.FlxMath;
import Song.SwagSong;
import lime.utils.Assets;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<FlxText>;

	var menuItems:Array<String> = ['Resume', 'Restart Song', 'Exit to menu'];
	var curSelected:Int = 0;

	var gapSizeY:Float = 120;
	var gapSizeX:Float = 20;

	// var pauseMusic:FlxSound;
	var daSong:SwagSong;

	// public function new(x:Float, y:Float)
	// {
	// 	super();
	// }

	override function create()
	{
		#if debug
		menuItems.push("Skip Song");
		#end

		// pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		// pauseMusic.volume = 0;
		// pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		// FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		/*var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
			levelInfo.text += daSong.song;
			levelInfo.scrollFactor.set();
			levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
			levelInfo.updateHitbox();
			add(levelInfo); */

		// var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		/*levelDifficulty.text += CoolUtil.difficultyString();
			levelDifficulty.scrollFactor.set();
			levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
			levelDifficulty.updateHitbox();
			add(levelDifficulty); */
		/*levelDifficulty.alpha = 0;
			levelInfo.alpha = 0;

			levelInfo.x = FlxG.width - (levelInfo.width + 20);
			levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20); */

		bg.alpha = 0.5;
		/*FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
			FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5}); */

		grpMenuShit = new FlxTypedGroup<FlxText>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			// var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			// songText.isMenuItem = true;
			var songText:FlxText = new FlxText(gapSizeX * i + 100, (gapSizeY * i) + FlxG.height / 2, 0, menuItems[i], 80);
			songText.setFormat("assets/fonts/vcr.ttf", songText.size, FlxColor.WHITE, LEFT, SHADOW, FlxColor.BLACK);
			songText.borderSize = 12;
			songText.borderQuality = 1;
			grpMenuShit.add(songText);
		}

		changeSelection();

		FlxTween.globalManager.active = false;

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		// if (pauseMusic.volume < 0.5)
		// 	pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (accepted)
		{
			var daSelected:String = menuItems[curSelected];

			FlxTween.globalManager.active = true;

			switch (daSelected)
			{
				case "Resume":
					close();
				case "Restart Song":
					// FlxG.resetState();
					// clearCache();
					// CachedFrames.cachedInstance.clear();
					LoadingState.loadAndSwitchState(new AlmostPlayState());
				// daSong = null;
				case "Exit to menu":
					// PlayState.loadRep = false;
					MainMenuState.reRoll = true;
					// clearCache();
					// daSong = null;
					// CachedFrames.cachedInstance.clear();
					FlxG.switchState(new AlmostMainMenuState());
				case "Skip Song":
					close();
					// PlayState.staticVar.endSong();
			}
		}

		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}

		for (i in 0...grpMenuShit.members.length)
		{
			var targetY = (gapSizeY * i) + FlxG.height / 2 - gapSizeY * curSelected;
			var targetX = gapSizeX * i + 100 - gapSizeX * curSelected;
			if (grpMenuShit.members[i].y != targetY)
			{
				grpMenuShit.members[i].y = FlxMath.lerp(grpMenuShit.members[i].y, targetY, 0.16);
				grpMenuShit.members[i].x = FlxMath.lerp(grpMenuShit.members[i].x, targetX, 0.16);
			}
		}
	}

	// function clearCache()
	// {
	// 	CachedFrames.cachedInstance.clear();
	// 	for (i in members)
	// 	{
	// 		i = null;
	// 		remove(i);
	// 	}
	// 	for (i in FlxG.sound.list)
	// 	{
	// 		i = null;
	// 		FlxG.sound.list.remove(i);
	// 	}
	// 	for (i in grpMenuShit)
	// 	{
	// 		i = null;
	// 		grpMenuShit.remove(i);
	// 	}
	// 	menuItems = null;
	// }
	// override function destroy()
	// {
	// 	for (i in members)
	// 	{
	// 		i = null;
	// 		remove(i);
	// 	}
	// 	for (i in FlxG.sound.list)
	// 	{
	// 		i = null;
	// 		FlxG.sound.list.remove(i);
	// 	}
	// 	for (i in grpMenuShit)
	// 	{
	// 		i = null;
	// 		grpMenuShit.remove(i);
	// 	}
	// 	grpMenuShit = null;
	// 	menuItems = null;
	// 	//pauseMusic = null;
	// 	super.destroy();
	// 	//Main.clearMemoryHopefully();
	// }

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		// var bullShit:Int = 0;

		for (i in 0...grpMenuShit.members.length)
		{
			// item.targetY = bullShit - curSelected;
			// bullShit++;

			grpMenuShit.members[i].alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (i == curSelected)
			{
				grpMenuShit.members[i].alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
