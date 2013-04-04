package com.eclecticdesignstudio.piratepig;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.utils.ByteArray;


class PiratePig extends Sprite {
	
	
	private var Background:Loader;
	private var Footer:Loader;
	private var Game:PiratePigGame;
	
	
	public function new () {
		
		super ();
		
		initialize ();
		construct ();
		
		resize (stage.stageWidth, stage.stageHeight);
		stage.addEventListener (Event.RESIZE, stage_onResize);
		
		#if android
		stage.addEventListener (KeyboardEvent.KEY_UP, stage_onKeyUp);
		#end
		
	}
	
	
	private function construct ():Void {
		
		addChild (Background);
		addChild (Footer);
		addChild (Game);
		
	}
	
	
	private function initialize ():Void {
		
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		Background = new Loader ();
		Footer = new Loader ();
		Game = new PiratePigGame ();
		
		Background.contentLoaderInfo.addEventListener (Event.COMPLETE, stage_onResize);
		Background.load (new URLRequest ("images/background_tile.png"));
		
		Footer.contentLoaderInfo.addEventListener (Event.COMPLETE, stage_onResize);
		Footer.load (new URLRequest ("images/center_bottom.png"));
		
	}
	
	
	private function resize (newWidth:Int, newHeight:Int):Void {
		
		Background.width = newWidth;
		Background.height = newHeight;
		
		Game.resize (newWidth, newHeight);
		
		Footer.scaleX = Game.currentScale;
		Footer.scaleY = Game.currentScale;
		Footer.x = newWidth / 2 - Footer.width / 2;
		Footer.y = newHeight - Footer.height;
		
	}
	
	
	private function stage_onKeyUp (event:KeyboardEvent):Void {
		
		#if android
		
		if (event.keyCode == 27) {
			
			event.stopImmediatePropagation ();
			nme.Lib.exit ();
			
		}
		
		#end
		
	}
	
	
	private function stage_onResize (event:Event):Void {
		
		resize (stage.stageWidth, stage.stageHeight);
		
	}
	
	
}