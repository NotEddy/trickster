package;

import flixel.util.FlxDestroyUtil;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var burning:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	// public var prevNote:Note;
	public var prevNoteisSustain:Bool = false;
	public var prevNoteData:Int = 0;
	public var isLastSustain:Bool = false;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var rating:String = "shit";

	// public function new(_strumTime:Float, _noteData:Int, ?_prevNote:Note, ?sustainNote:Bool = false)
	public function new(_strumTime:Float, _noteData:Int, sustainNote:Bool = false, prevSus:Bool = false, prevData:Int = -1, susEnd:Bool = false)
	{
		super();

		// if (_prevNote == null)
		// 	_prevNote = this;

		// prevNote = _prevNote;
		prevNoteisSustain = prevSus;
		prevNoteData = prevData;
		isSustainNote = sustainNote;
		isLastSustain = susEnd;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		strumTime = _strumTime + FlxG.save.data.offset;
		strumTime = strumTime < 0 ? 0 : strumTime;

		burning = _noteData > 7;
		// if(!isSustainNote) { burning = Std.random(3) == 1; } //Set random notes to burning

		// No held fire notes :[ (Part 1)
		if (isSustainNote && prevData > 7)
		{
			burning = true;
			noteData = -99;
		}

		if (isSustainNote && FlxG.save.data.downscroll)
			flipY = true;

		noteData = _noteData % 4;

		switch (PlayState.pixelOnly)
		{
			case true:
				loadGraphic(Paths.image('pixel/arrows-pixels'), true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('pixel/arrowEnds'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				if (burning)
				{
					loadGraphic(Paths.image('NOTE_fire-pixel', "clown"), true, 21, 31);
					animation.add('redScroll', [9, 10, 9, 11], 8);
					animation.add('purpleScroll', [0, 1, 0, 2], 8);
					if (!FlxG.save.data.downscroll)
					{
						animation.add('greenScroll', [6, 7, 6, 8], 8);
						animation.add('blueScroll', [3, 4, 3, 5], 8);
					}
					else
					{
						animation.add('blueScroll', [6, 7, 6, 8], 8);
						animation.add('greenScroll', [3, 4, 3, 5], 8);
					}
					
					if (FlxG.save.data.downscroll)
						flipY = true;
					x -= 15;
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

			default:
				frames = Paths.getSparrowAtlas('NOTE_assets');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				if (burning)
				{
					if (PlayState.curStage == 'auditorHell')
					{
						if (!FlxG.save.data.perfSkull)
						{
							frames = Paths.getSparrowAtlas('fourth/mech/ALL_deathnotes', "clown");
							animation.addByPrefix('greenScroll', 'Green Arrow');
							animation.addByPrefix('redScroll', 'Red Arrow');
							animation.addByPrefix('blueScroll', 'Blue Arrow');
							animation.addByPrefix('purpleScroll', 'Purple Arrow');
							x -= 165;
						}
						else
							loadGraphic(Paths.image('NOTE_fire_alt2', 'clown'));
					}
					else
					{
						if (!FlxG.save.data.perfSkull)
						{
							frames = Paths.getSparrowAtlas('NOTE_fire', "clown");
							if (!FlxG.save.data.downscroll)
							{
								animation.addByPrefix('blueScroll', 'blue fire');
								animation.addByPrefix('greenScroll', 'green fire');
							}
							else
							{
								animation.addByPrefix('greenScroll', 'blue fire');
								animation.addByPrefix('blueScroll', 'green fire');
							}
							animation.addByPrefix('redScroll', 'red fire');
							animation.addByPrefix('purpleScroll', 'purple fire');

							if (FlxG.save.data.downscroll)
								flipY = true;

							x -= 50;
						}
						else
							loadGraphic(Paths.image('NOTE_fire_alt', 'clown'));
					}
				}

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
		}

		if ((!FlxG.save.data.perfSkull || PlayState.pixelOnly) && burning)
			setGraphicSize(Std.int(width * 0.86));

		switch (noteData)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}

		// trace(prevNote);

		// if (isSustainNote && prevNote != null)
		if (isSustainNote && prevNoteData != -1)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			if (isLastSustain)
			{
				switch (noteData)
				{
					case 2:
						animation.play('greenholdend');
					case 3:
						animation.play('redholdend');
					case 1:
						animation.play('blueholdend');
					case 0:
						animation.play('purpleholdend');
				}
			}
			else
			{
				switch (noteData)
				{
					case 0:
						animation.play('purplehold');
					case 1:
						animation.play('bluehold');
					case 2:
						animation.play('greenhold');
					case 3:
						animation.play('redhold');
				}

				scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				updateHitbox();
				// prevNote.setGraphicSize();
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.pixelOnly)
				x += 30;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// No held fire notes :[ (Part 2)
		if (isSustainNote && noteData == -99)
		{
			this.kill();
		}

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (!burning)
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (PlayState.curStage == 'auditorHell') // these though, REALLY hard to hit.
				{
					if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.3)
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.2)) // also they're almost impossible to hit late!
						canBeHit = true;
					else
						canBeHit = false;
				}
				else
				{
					// make burning notes a lot harder to accidently hit because they're weirdchamp!
					if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.6)
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.4)) // also they're almost impossible to hit late!
						canBeHit = true;
					else
						canBeHit = false;
				}
			}
			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}

	override public function destroy()
	{
		// prevNote = null;
		super.destroy();
	}
}
