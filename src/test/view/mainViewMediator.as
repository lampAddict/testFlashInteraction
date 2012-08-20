package test.view{
	
	import org.robotlegs.mvcs.Mediator;
	
	public class mainViewMediator extends Mediator{
		
		[Inject]
		public var view:mainView;
		
		override public function onRegister():void{

			addContextListener(testEvent.INITIALIZED,	onInitialized);
		}
		
		private function onInitialized(e:testEvent):void{
			view.show();
		}
	}
}