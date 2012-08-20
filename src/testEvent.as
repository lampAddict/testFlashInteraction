package {
	
	import flash.events.Event;
	
	import org.robotlegs.base.ContextEvent;
	
	public class testEvent extends ContextEvent{
		
		public static const INITIALIZED		:String = 'INITIALIZED';
		
		public function testEvent(type:String, body:* = null){
			super(type, body);
		}
	}
}