package{

	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import test.view.mainView;
	import test.view.mainViewMediator;

	public class testFlashContext extends Context{

		public function testFlashContext(contextView:DisplayObjectContainer){
			
			super(contextView);
		}
		
		override public function startup():void{
			
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, testFlashRun);
			
			mediatorMap.mapView(mainView, mainViewMediator);
			
			contextView.addChild(new mainView);
			super.startup();
		}
	}
}