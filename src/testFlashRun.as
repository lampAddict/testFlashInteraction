package{
	
	import flash.display.Sprite;
	
	import flash.system.Security;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;
	
	public class testFlashRun extends Command{

		override public function execute():void{
			
			trace('testFlashRun', Security.sandboxType);
			Security.allowDomain('*');
			Security.allowInsecureDomain('*');
			
			dispatch(new testEvent(testEvent.INITIALIZED));
		}
	}
}