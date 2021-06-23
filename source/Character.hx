package;

import flixel.util.FlxDestroyUtil;
import flixel.animation.FlxAnimationController;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var exSpikes:FlxSprite;

	var tex:FlxAtlasFrames;
	

	// public function new(x:Float, y:Float)
	// {
	// 	super(x, y);

	// 	trace('creating ');

	// 	//doCrap(x, y, character, isPlayer, isDebug);
	// }

	public function doCrap(posx:Float, posy:Float, ?character:String = "bf", ?isPlayer:Bool = false, ?isDebug:Bool = false)
	{
		x = posx;
		y = posy;
		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		antialiasing = true;

		switch (curCharacter)
		{
			case 'nothing':
				loadGraphic(Paths.image('nothing', 'clown'));
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets');
				frames = tex;
				setGraphicSize(Std.int(width*2));
				updateHitbox();
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gf-hell':
				tex = Paths.getSparrowAtlas('hellclwn/GF/gf_phase_3','clown');
				frames = tex;
				setGraphicSize(Std.int(width*4));
				updateHitbox();
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-tied':
				tex = Paths.getSparrowAtlas('fourth/EX Tricky GF','clown');
				frames = tex;

				setGraphicSize(Std.int(width*2));
				updateHitbox();

				trace(frames.frames.length);

				animation.addByIndices('danceLeft','GF Ex Tricky',[0,1,2,3,4,5,6,7,8], "", 24, false);
				animation.addByIndices('danceRight','GF Ex Tricky',[9,10,11,12,13,14,15,16,17,18,19], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				trace(animation.curAnim);

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
				
				playAnim('idle');
				
			case 'tricky':
				tex = Paths.getSparrowAtlas('tricky','clown');
				frames = tex;
				setGraphicSize(Std.int(width * 2));
				updateHitbox();
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -75);
				addOffset("singUP", 93, -76);
				addOffset("singRIGHT", 16, -176);
				addOffset("singLEFT", 103, -72);
				addOffset("singDOWN", 6, -84);

				playAnim('idle');
				
			case 'trickyH':
				if (FlxG.save.data.perfUltraLow)
				{
					tex = Paths.getSparrowAtlas('hellclwn/Tricky/evensmoller','clown');
					frames = tex;
					scale.x = scale.y = 2.0;
					updateHitbox();
					x = posx;
					y = posy;
				}
				else
				{
					tex = Paths.getSparrowAtlas('hellclwn/Tricky/smol','clown');
					frames = tex;
				}
				setGraphicSize(Std.int(width * 4));
				updateHitbox();
				animation.addByPrefix('idle', 'Phase 3 Tricky Idle', 24);
				animation.addByPrefix('singUP', 'Proper Up', 24);
				animation.addByPrefix('singRIGHT', 'Proper Right', 24);
				animation.addByPrefix('singLEFT', 'Proper Left', 24); 
				animation.addByPrefix('singDOWN', 'Proper Down', 24);
				
				addOffset("idle", 325, 0);
				addOffset("singUP", 575, -450);
				addOffset("singRIGHT",485, -300);
				addOffset("singLEFT", 516, 25);
				addOffset("singDOWN", 475, -450);

				updateHitbox();
				playAnim('idle');
				
			// case 'trickyHDown':
			// 	tex = CachedFrames.cachedInstance.fromSparrow('down','hellclwn/Tricky/Down');

			// 	frames = tex;

			// 	//graphic.persist = true;
			// 	//graphic.destroyOnNoUse = false;

			// 	setGraphicSize(Std.int(width * 2));

			// 	animation.addByPrefix('idle','Proper Down', 24);

			// 	addOffset("idle",475, -450);

			// 	// y -= 2000;
			// 	// x -= 1400;

			// 	playAnim('idle');
			// case 'trickyHUp':
			// 	tex = CachedFrames.cachedInstance.fromSparrow('up','hellclwn/Tricky/Up');


			// 	frames = tex;

			// 	//graphic.persist = true;
			// 	//graphic.destroyOnNoUse = false;

			// 	setGraphicSize(Std.int(width * 2));

			// 	animation.addByPrefix('idle','Proper Up', 24);

			// 	addOffset("idle", 575, -450);

			// 	// y -= 2000;
			// 	// x -= 1400;

			// 	playAnim('idle');
			// case 'trickyHRight':
			// 	tex = CachedFrames.cachedInstance.fromSparrow('right','hellclwn/Tricky/right');

			// 	frames = tex;

			// 	//graphic.persist = true;
			// 	//graphic.destroyOnNoUse = false;

			// 	setGraphicSize(Std.int(width * 2));

			// 	animation.addByPrefix('idle','Proper Right', 24);

			// 	addOffset("idle",485, -300);

			// 	// y -= 2000;
			// 	// x -= 1400;

			// 	playAnim('idle');
			// case 'trickyHLeft':
			// 	tex = CachedFrames.cachedInstance.fromSparrow('left','hellclwn/Tricky/Left');

			// 	frames = tex;

			// 	//graphic.persist = true;
			// 	//graphic.destroyOnNoUse = false;

			// 	setGraphicSize(Std.int(width * 2));

			// 	animation.addByPrefix('idle','Proper Left', 24);

			// 	addOffset("idle", 516, 25);

			// 	// y -= 2000;
			// 	// x -= 1400;
				
			// 	playAnim('idle');

			case 'trickyMask':
				tex = Paths.getSparrowAtlas('TrickyMask','clown');
				frames = tex;
				setGraphicSize(Std.int(width * 2));
				updateHitbox();
				
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -117);
				addOffset("singUP", 93, -100);
				addOffset("singRIGHT", 16, -164);
				addOffset("singLEFT", 194, -95);
				addOffset("singDOWN", 32, -168);

				playAnim('idle');
				
			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND');
				frames = tex;

				setGraphicSize(Std.int(width*2));
				updateHitbox();

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('stunned', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('stunned', 31, 22);

				playAnim('idle');

				flipX = true;
			case 'bf-hell':
				var tex = Paths.getSparrowAtlas('hellclwn/BF/BF_3rd_phase','clown');
				frames = tex;

				setGraphicSize(Std.int(width*4));
				updateHitbox();

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('stunned', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-car':
				var tex = Paths.getSparrowAtlas('bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'signDeath':
				frames = Paths.getSparrowAtlas('signDeath','clown');
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				
				playAnim('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop');
				addOffset('deathConfirm', 0, 40);

				animation.pause();

				updateHitbox();
				antialiasing = false;
				flipX = true;
			case 'exTricky':
				frames = Paths.getSparrowAtlas('fourth/EXTRICKY','clown');
				setGraphicSize(Std.int(width * 2));
				updateHitbox();
				if (!Main.ultraLow)
				{
					exSpikes = new FlxSprite(x - 350,y - 170);
					exSpikes.frames = Paths.getSparrowAtlas('fourth/FloorSpikes','clown');
					exSpikes.visible = false;
					exSpikes.setGraphicSize(Std.int(exSpikes.width * 2));
					exSpikes.updateHitbox();

					exSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);
				}
				else
					exSpikes = new FlxSprite().loadGraphic(Paths.image('nothing', 'clown'));

				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('Hank', 'Hank', 24, true);

				addOffset('idle');
				addOffset('Hank');
				addOffset("singUP", 0, 100);
				addOffset("singRIGHT", -209,-29);
				addOffset("singLEFT",127,20);
				addOffset("singDOWN",-100,-340);

				playAnim('idle');
		}

		antialiasing = true;

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf') && !curCharacter.toLowerCase().contains('death'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	// public function addOtherFrames():Array<Character>
	// {
		
	// 	// for (i in otherFrames)
	// 	// 	{
	// 	// 		PlayState.staticVar.add(i);
	// 	// 		i.visible = false;
	// 	// 	}
	// 	return otherFrames;
	// }

	override function update(elapsed:Float)
		{
			if (!curCharacter.startsWith('bf') && animation.curAnim != null)
			{
				if (animation.curAnim.name.startsWith('sing'))
				{
					holdTimer += elapsed;
				}
	
				var dadVar:Float = 4;
	
				if (curCharacter == 'dad')
					dadVar = 6.1;
				if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
				{
					if (curCharacter != 'trickyHLeft' && curCharacter != 'trickyHRight' && curCharacter != 'trickyHDown' && curCharacter != 'trickyHUp')
					{
						dance();
						holdTimer = 0;
					}
				}
			}
	
			switch (curCharacter)
			{
				case 'gf':
					if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
						playAnim('danceRight');
				case 'exTricky':
					if (exSpikes.animation.frameIndex >= 3 && animation.curAnim.name == 'singUP')
					{
						trace('paused');
						exSpikes.animation.pause();
					}
			}
	
			super.update(elapsed);
		}
	
		private var danced:Bool = false;
	
		/**
		 * FOR GF DANCING SHIT
		 */
		public function dance()
		{
			if (!debugMode)
			{
				switch (curCharacter)
				{
					case 'gf':
						if (!animation.curAnim.name.startsWith('hair'))
						{
							danced = !danced;

							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}
					case 'gf-hell':
						if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
					case 'gf-tied':
						if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
					default:
						playAnim('idle');
				}
			}
		}
	
		// other frames implementation is messy but who cares lol!

		public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
		{
			
			animation.play(AnimName, Force, Reversed, Frame);

			if (curCharacter == 'exTricky')
			{
				if (AnimName == 'singUP')
				{
					trace('spikes');
					exSpikes.visible = true;
					if (exSpikes.animation.finished)
						exSpikes.animation.play('spike');
				}
				else if (!exSpikes.animation.finished)
				{
					exSpikes.animation.resume();
					trace('go back spikes');
					exSpikes.animation.finishCallback = function(pog:String) {
						trace('finished');
						exSpikes.visible = false;
						exSpikes.animation.finishCallback = null;
					}
				}
			}

			var daOffset = animOffsets.get(AnimName);
			if (animOffsets.exists(AnimName))
			{
				offset.set(daOffset[0], daOffset[1]);
			}
			else
				offset.set(0, 0);
			if (curCharacter == 'gf')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}
	
				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
		}
	
		public function addOffset(name:String, x:Float = 0, y:Float = 0)
		{
			animOffsets[name] = [x, y];
		}

		public function clear()
		{
			animOffsets.clear();
			FlxDestroyUtil.put(frames.border);
		}
		

		override public function destroy()
		{
			clear();
			animOffsets = null;
			FlxDestroyUtil.destroy(tex);
			if (exSpikes != null)
				exSpikes.active = false;
			FlxDestroyUtil.destroy(exSpikes);
			super.destroy();
		}
}
