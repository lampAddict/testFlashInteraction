package
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.text.TextField;

	public class testFlashManager{
	
		private var objects:Array;
		
		public function testFlashManager(){
			
			objects = new Array();
		}
		
		public function registerCall(obj:InteractiveObject):void{
			objects.push(obj);
			obj.addEventListener('swfEvent', eventListener);
		}
		
		private function eventListener(e:*):void{
			if( e.body != null && e.body is Object ){
				
				if( objects.indexOf(e.body['swf']) >= 0 ){
					var swf:Sprite = objects[ objects.indexOf(e.body['swf']) ];
				}
				
				switch( e.body['type'] ){
					case 'greenLoaded':
						if( swf.getChildByName(e.body['data']) != null )
							(((swf.getChildByName(e.body['data']) as Sprite).getChildByName('green_mc') as Sprite).getChildByName('caption') as TextField).text += ' - black';
						break;
					default:
						break;
				}
			}
		}
	}
}