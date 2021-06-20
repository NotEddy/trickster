package;

import flixel.addons.ui.FlxUIState;
using StringTools;

class AlmostMainMenuState extends FlxUIState
{
	override function create()
	{
		super.create();
        LoadingState.loadAndSwitchState(new MainMenuState(), false);
	}
}
