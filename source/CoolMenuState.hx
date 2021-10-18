package;

import flixel.FlxCamera;
import flixel.math.FlxPoint;
import openfl.display.Stage;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flixel.ui.FlxButton;

import openfl.media.Sound;
import openfl.net.FileReference;
import openfl.utils.ByteArray;


/**
	*DEBUG MODE
 */
class CoolMenuState extends MusicBeatState
{

	var bg:FlxSprite;

	var grpItems:FlxTypedGroup<FlxSprite>;
	var menuOptions:Array<String> = [
		'story mode',
		'freeplay',
		'options',
		'twitter'
	];

	var curSelected:Int = 0;

	override function create()
	{
		super.create();
		bg = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		add(bg);

		grpItems = new FlxTypedGroup<FlxSprite>();
		add(grpItems);

		for (i in 0...menuOptions.length) {
			var spr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('coolMenu/' + menuOptions[i]));
			switch (i) {
				case 0:
					spr.setPosition(252, 50);
				case 1:
					spr.setPosition(500, 210);
				case 2:
					spr.setPosition(242, 360);
				case 3:
					spr.setPosition(50, 530);
			}
			spr.antialiasing = true;
			grpItems.add(spr);
		}
		
		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.DOWN_P)
			changeSelection(1);
		
		if (controls.UP_P)
			changeSelection(-1);

		if (controls.ACCEPT)
			enterSelection();
	}

	function enterSelection() {
		switch (curSelected) {
			case 0:
				FlxG.switchState(new StoryMenuState());
			case 1:
				FlxG.switchState(new FreeplayState());
			case 2:
				FlxG.switchState(new OptionsMenu());
			case 3:
				fancyOpenURL("https://twitter.com/ivnyrose");
				
		}
	}

	function changeSelection(change:Int = 0) {
		curSelected += change;

		if (curSelected < 0)
			curSelected = 0;
		else if (curSelected > grpItems.length - 1)
			curSelected = grpItems.length - 1;

		for (i in 0...grpItems.length) {
			if (i == curSelected) {
				grpItems.members[i].scale.set(1, 1);
				grpItems.members[i].color.lightness = 1;
			} else { 
				grpItems.members[i].scale.set(0.8, 0.8);
				grpItems.members[i].color.lightness = 0.8;
			}
		}
	}
}
