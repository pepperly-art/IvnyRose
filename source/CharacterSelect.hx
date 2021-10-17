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
class CharacterSelect extends MusicBeatState
{

	var bg:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var characterText:FlxText;

	var characterOffsets:Array<FlxPoint> = [

	];
	var characterArray:Array<String> = [
		'bf',
		'bf-justice',
		'bf-pigeon'
	];

	var character:Character;
	var curSelected:Int = 0;

	override function create()
	{
		super.create();
		for(i in 0...characterArray.length){
			switch (i){
				case 0:
					characterOffsets.push(new FlxPoint(0, 0));
				case 1:
					characterOffsets.push(new FlxPoint(-40, -80));
				case 2:
					characterOffsets.push(new FlxPoint(0, 0));
				default:
					characterOffsets.push(new FlxPoint(0, 0));
			}
		}
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);
		leftArrow = new FlxSprite(222, 76).loadGraphic(Paths.image('characterMenu/leftArrow'));
		add(leftArrow);
		rightArrow = new FlxSprite(899, 68).loadGraphic(Paths.image('characterMenu/rightArrow'));
		add(rightArrow);
		
		character = new Character(0, 0, 'bf');
		add(character);
		
		characterText = new FlxText(333, 109, 574, '', 60);
		characterText.font = Paths.font('friday night.ttf');
		characterText.color = FlxColor.WHITE;
		characterText.alignment = CENTER;
		add(characterText);


		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.LEFT_P)
			changeSelection(-1);
		
		if (controls.RIGHT_P)
			changeSelection(1);

		if (controls.ACCEPT)
			saveSelection();

		if (controls.BACK)
			FlxG.switchState(new CoolMenuState());

	}

	function saveSelection() {
		FlxG.save.data.characterSelected = characterArray[curSelected];
	}
	function changeSelection(change:Int = 0) {	
		curSelected += change;

		if (curSelected < 0)
			curSelected = characterArray.length - 1;
		else if (curSelected > characterArray.length - 1)
			curSelected = 0;

		characterText.text = characterArray[curSelected].toUpperCase();

		remove(character);
		character = new Character(420, 200, characterArray[curSelected]);
		character.x += characterOffsets[curSelected].x;
		character.y += characterOffsets[curSelected].y;
		add(character);
	}
}
