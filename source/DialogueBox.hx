package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRightgf:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitRightbf:FlxSprite;
	var portraitLeftt:FlxSprite;
	var portraitLefttt:FlxSprite;
	var portraitLeftttt:FlxSprite;
	var GFBFport:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'trunk':
				FlxG.sound.playMusic(Paths.music('treeambiance'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'warning':
				FlxG.sound.playMusic(Paths.music('treeambiance'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'revolution':
				FlxG.sound.playMusic(Paths.music('treeambiance'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'trunk':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.y = 400;
			case 'warning':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.y = 400;
			case 'revolution':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.y = 400;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('Portrait');
		portraitLeft.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.flipX = true;
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftt = new FlxSprite(-20, 40);
		portraitLeftt.frames = Paths.getSparrowAtlas('TreePortrait');
		portraitLeftt.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitLeftt.updateHitbox();
		portraitLeftt.flipX = true;
		portraitLeftt.scrollFactor.set();
		add(portraitLeftt);
		portraitLeftt.visible = false;

		portraitLefttt = new FlxSprite(-20, 40);
		portraitLefttt.frames = Paths.getSparrowAtlas('TreeMadP');
		portraitLefttt.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitLefttt.updateHitbox();
		portraitLefttt.flipX = true;
		portraitLefttt.scrollFactor.set();
		add(portraitLefttt);
		portraitLefttt.visible = false;

		portraitLeftttt = new FlxSprite(-20, 40);
		portraitLeftttt.frames = Paths.getSparrowAtlas('BlackTree');
		portraitLeftttt.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitLeftttt.updateHitbox();
		portraitLeftttt.flipX = true;
		portraitLeftttt.scrollFactor.set();
		add(portraitLeftttt);
		portraitLeftttt.visible = false;


		portraitRightgf = new FlxSprite(0, 40);
		portraitRightgf.frames = Paths.getSparrowAtlas('gfPortrait');
		portraitRightgf.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRightgf.updateHitbox();
		portraitRightgf.scrollFactor.set();
		add(portraitRightgf);
		portraitRightgf.visible = false;

		
		portraitRightbf = new FlxSprite(0, 40);
		portraitRightbf.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRightbf.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRightbf.updateHitbox();
		portraitRightbf.scrollFactor.set();
		add(portraitRightbf);
		portraitRightbf.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		GFBFport = new FlxSprite(0, 40);
		GFBFport.frames = Paths.getSparrowAtlas('bfgfPortrait');
		GFBFport.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		GFBFport.updateHitbox();
		GFBFport.scrollFactor.set();
		add(GFBFport);
		GFBFport.visible = false;	

		box.animation.play('normalOpen');
//		if(PlayState.curStage != 'park1')box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
//		if(PlayState.curStage != 'park2')box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
//		if(PlayState.curStage != 'park3')box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = false;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0x000000;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
		portraitLeft.visible = true;
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightgf.visible = false;
				portraitLeftt.visible = false;
				GFBFport.visible = false;
				if (!portraitRight.visible)
				{
					portraitRightbf.visible = true;
					portraitRightbf.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('BFVoice'), 0.6)];
				}
			case 'tree':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightgf.visible = false;
				portraitRightbf.visible = false;
				if (!portraitLeftt.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
				{
					portraitLeftt.visible = true;
					portraitLeftt.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
				}
			case 'tree2':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightgf.visible = false;
				portraitRightbf.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
				if (!portraitLefttt.visible)
				{
					portraitLefttt.visible = true;
					portraitLefttt.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
				}
			case 'tree3':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightgf.visible = false;
				portraitRightbf.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
				if (!portraitLeftttt.visible)
				{
					portraitLeftttt.visible = true;
					portraitLeftttt.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('TextDialog'), 0.6)];
				}
			case 'gf':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightbf.visible = false;
				portraitLeftt.visible = false;
				GFBFport.visible = false;
				if (!portraitRightgf.visible)
				{
					portraitRightgf.visible = true;
					portraitRightgf.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('GFVoice'), 0.6)];
				}
			case 'bfgf':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightbf.visible = false;
				portraitLeftt.visible = false;
				if (!GFBFport.visible)
				{
					GFBFport.visible = true;
					GFBFport.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('GFBFVoice'), 0.6)];
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
