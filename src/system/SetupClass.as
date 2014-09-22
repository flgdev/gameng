package system
{
	
	public class SetupClass 
	{
		
		public var gameWidth:Number=640;
		public var gameHeight:Number = 480;
		public var framePerSecond:Number = 30;
		// levels
		public var currentLevel:Number=0;
		public var totalLevels:Number=40;
		public var levelsPerRow:Number = 8;
		public var levelsHorizontalSpacing:Number=5;
		public var levelsVerticalSpacing:Number=5;
		public var levelsOffsetX:Number=60;
		public var levelsOffsetY:Number = 100;
		public var levelsSize:Array = new Array(
		new Array(1200,0,0,0,0),
		new Array(600,0,0,0,0));
	}
	
}