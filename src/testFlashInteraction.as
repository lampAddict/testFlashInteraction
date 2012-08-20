package
{
	import flash.display.Sprite;
	
	public class testFlashInteraction extends Sprite
	{
		public var context:testFlashContext;
		
		public function testFlashInteraction()
		{
			context = new testFlashContext(this);
		}
	}
}