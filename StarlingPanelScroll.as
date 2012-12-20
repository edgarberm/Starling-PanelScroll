package  
{
  import starling.core.Starling;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class StarlingPanelScroll extends Sprite 
	{
		private var mStarling:Starling;
		
		public function StarlingPanelScroll() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			  
			mStarling = new Starling(PanelScroll, stage);
			mStarling.antiAliasing = 2;
			mStarling.start();
		}
	}
}
