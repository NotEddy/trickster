package;

import flixel.addons.ui.FlxUIState;
using StringTools;

class AlmostPlayState extends FlxUIState
{
	override function create()
	{
		super.create();
        LoadingState.loadAndSwitchState(new PlayState(), false);
	}
}
