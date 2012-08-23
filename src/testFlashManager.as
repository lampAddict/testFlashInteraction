package
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.swiftsuspenders.injectionresults.InjectClassResult;

	public class testFlashManager extends Sprite{
	
		private var objects:Array;
		private var flash_ids:Array;
		
		private var data:Object;
		
		public function testFlashManager(){
			
			objects = new Array();
			flash_ids = new Array();
			data = new Object();
		}
		
		public function registerCall(obj:InteractiveObject, id:String):void{
			objects.push(obj);
			flash_ids.push(id);
			data[obj] = '';
			obj.addEventListener('swfEvent', eventListener);
		}
		
		private function eventListener(e:*):void{
			var swf:*;
			if( e.body != null && e.body is Object ){
				
				if( objects.indexOf(e.body['swf']) >= 0 ){
					swf = objects[ objects.indexOf(e.body['swf']) ];
				}
				
				var index:int;
				switch( e.body['type'] ){
					case 'greenLoaded':
						if( swf.getChildByName(e.body['data']) != null )
							(((swf.getChildByName(e.body['data']) as Sprite).getChildByName('green_mc') as Sprite).getChildByName('caption') as TextField).text += ' - black';
						break;
					case 'updateRed':
						index = flash_ids.indexOf('red');
						swf = objects[index];
						swf.caption(e.body['data']);
						//(swf.getChildByName('caption') as TextField).text = 'red - '+e.body['data'];
						//data[swf] = e.body['data'];
						break;
					case 'updateBlue':
						index = flash_ids.indexOf('blue');
						swf = objects[index];
						swf.caption(e.body['data']);
						//(swf.getChildByName('caption') as TextField).text = 'blue - '+e.body['data'];
						//data[swf] = e.body['data'];
						break;
					case 'getData':
						if( data[swf] != '' ){
							(swf.getChildByName('caption') as TextField).text = flash_ids[ objects.indexOf(swf) ]+' - '+data[swf];
							data[swf] = '';
							//trace(flash_ids[ objects.indexOf(swf) ]+' updated');
						}
						else{
							//trace(flash_ids[ objects.indexOf(swf) ]+' asked for data');
						}
						break;
					default:
						break;
				}
				
			}
		}
	}
}