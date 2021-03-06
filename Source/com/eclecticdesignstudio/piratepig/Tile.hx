package com.eclecticdesignstudio.piratepig;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import motion.Actuate;
import motion.actuators.GenericActuator;
import motion.easing.Linear;
import motion.easing.Quad;


class Tile extends Sprite {
	
	
	public var column:Int;
	public var moving:Bool;
	public var removed:Bool;
	public var row:Int;
	public var type:Int;
	
	
	public function new (bitmapData:BitmapData) {
		
		super ();
		
		var image:Dynamic = null;
		var image = new Bitmap (bitmapData);
		image.smoothing = true;
		addChild (image);
		
		mouseChildren = false;
		buttonMode = true;
		
		// Currently, MouseEvent listeners are added to each Tile.
		// To make them easier to tap, add an empty fill to increase 
		// the size of the hit area
		
		graphics.beginFill (0x000000, 0);
		graphics.drawRect (-5, -5, 66, 66);
		
	}
	
	
	public function moveTo (duration:Float, targetX:Float, targetY:Float):Void {
		
		moving = true;
		
		Actuate.tween (this, duration, { x: targetX, y: targetY } ).ease (Quad.easeOut).onComplete (this_onMoveToComplete);
		
	}
	
	
	public function remove (animate:Bool = true):Void {
		
		#if js
		animate = false;
		#end
		
		if (!removed) {
			
			if (animate) {
				
				mouseEnabled = false;
				buttonMode = false;
				
				parent.addChildAt (this, 0);
				Actuate.tween (this, 0.6, { alpha: 0, scaleX: 2, scaleY: 2, x: x - width / 2, y: y - height / 2 } ).onComplete (this_onRemoveComplete);
				
			} else {
				
				this_onRemoveComplete ();
				
			}
			
		}
		
		removed = true;
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function this_onMoveToComplete ():Void {
		
		moving = false;
		
	}
	
	
	private function this_onRemoveComplete ():Void {
		
		parent.removeChild (this);
		
	}
	
	
}