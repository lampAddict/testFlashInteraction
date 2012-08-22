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
	import flash.text.TextFormat;
	
	public class mainView extends Sprite{
		
		private	var loader:Loader = new Loader();
		private var loadedSWF:Sprite;
		
		private	var caption:TextField = new TextField();
		
		private var manager:testFlashManager;
		
		private var requests:Array = new Array();
		private var loaded_swf:Array = new Array();
		private var xC:int = 150;
		
		public function mainView(){
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void{
			var black:Sprite = new Sprite();
			black.graphics.beginFill(0x000000);
			black.graphics.drawRect(0, 0, 300, 300);
			black.graphics.endFill();
			
			caption.x = 0;
			caption.y = 280;
			caption.height = 20;
			caption.width = 300;
			
			var tf:TextFormat = new TextFormat();
			tf.color= 0xFFFFFF;
			
			caption.defaultTextFormat = tf;
			caption.text = 'black';
			
			black.addChild(caption);
			
			addChild(black);
			
			requests.push('testFlashLoaded.swf');
			requests.push('testFlash.swf');
			
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		public function show():void{
			
			//trace('mainView show');
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadIOError, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadSecurityError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress, false, 0, true);
			
			var request:URLRequest = new URLRequest(requests.splice(0,1));
			
			loader.load(request);
		}
		
		private function loadSecurityError(e:SecurityErrorEvent):void{
			//trace('black securityError'+e.text);
		}
		
		private function loadProgress(e:ProgressEvent):void{
			//trace('black loadProgress', e.bytesLoaded/e.bytesTotal);
		}
		
		private function loadIOError(e:IOErrorEvent):void{
			//trace('black loadIOError', e.text );
		}
		
		private function loadComplete(e:Event):void{
			
			trace('red loaded');
			
			loadedSWF = e.currentTarget.content as Sprite;
			
			manager = new testFlashManager();
			
			manager.registerCall(loadedSWF);
			
			//loaded_swf.push(loadedSWF);
			//loadedSWF.addEventListener('swfEvent', changeRed);
			
			(loadedSWF.getChildByName('caption') as TextField).text += ' - black';
			
			xC -= 50;
			loadedSWF.x = xC;
			
			addChild(loadedSWF);

			if( requests.length > 0 ){
				var request:URLRequest = new URLRequest(requests.splice(0,1));
				loader.load(request);
			}
			else{
				loader.removeEventListener(Event.COMPLETE, loadComplete);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, loadIOError);
				
				loader = null;
			}
		}
		
		private function changeRed(e:*):void{

			if( e.body != null && e.body is Object ){
				
				if( loaded_swf.indexOf(e.body['swf']) >= 0 ){
					
					var loadedSWF:Sprite = loaded_swf[ loaded_swf.indexOf(e.body['swf']) ];
					
					switch( e.body['type'] ){
						case 'greenLoaded':
							if( loadedSWF.getChildByName(e.body['data']) != null )
								(((loadedSWF.getChildByName(e.body['data']) as Sprite).getChildByName('green_mc') as Sprite).getChildByName('caption') as TextField).text += ' - black';
							break;
						default:
							break;
					}
				}
			}
		}

	}
}