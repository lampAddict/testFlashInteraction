package test.view{
	
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class mainView extends Sprite{
		
		private	var loader:Loader = new Loader();
		private var loadedSWF:Sprite;
		
		public function mainView(){
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void{
			var black:Sprite = new Sprite();
			black.graphics.beginFill(0x000000);
			black.graphics.drawRect(0, 0, 300, 300);
			black.graphics.endFill();
			
			addChild(black);
			
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		public function show():void{
			
			trace('mainView show');
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadIOError, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadSecurityError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress, false, 0, true);
			
			var request:URLRequest = new URLRequest('testFlashLoaded.swf');
			
			loader.load(request);
		}
		
		private function loadSecurityError(e:SecurityErrorEvent):void{
			trace('black securityError'+e.text);
		}
		
		private function loadProgress(e:ProgressEvent):void{
			trace('black loadProgress', e.bytesLoaded/e.bytesTotal);
		}
		
		private function loadIOError(e:IOErrorEvent):void{
			trace('black loadIOError', e.text );
		}
		
		private function loadComplete(e:Event):void{
			
			trace('red loaded');
			
			loadedSWF = e.currentTarget.content as Sprite;
			
			loadedSWF.addEventListener('greenLoaded', changeGreen);
			
			(loadedSWF.getChildByName('caption') as TextField).text += ' - black';
			
			addChild(loadedSWF);
			
			loader.removeEventListener(Event.COMPLETE, loadComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loadIOError);
			
			loader = null;
		}
		
		private function changeGreen(e:*):void{
			trace('changeGreen', e.body);
			
			if( e.body != null && loadedSWF.getChildByName(e.body) != null ){
				(((loadedSWF.getChildByName(e.body) as Sprite).getChildByName('green_mc') as Sprite).getChildByName('caption') as TextField).text += ' - black';
			}
		}

	}
	
}