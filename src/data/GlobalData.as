package data
{

	public class GlobalData
	{
		//---------------- 显示变量 ----------------
		//宽高显示区域像素
		public static var WIDTH_SCREEN_PIXEL:int;
		public static var HEIGHT_SCREEN_PIXEL:int;
		//宽高单网格像素
		public static var WIDTH_TILE_PIXEL:int;
		public static var HEIGHT_TILE_PIXEL:int;
		//总网格数
		public static var WIDTH_TILE_NUMBER:int;
		public static var HEIGHT_TILE_NUMBER:int;
		
		//层名称
		public static var LAYER_NAME:Vector.<String>;
		
		//---------------- 数据变量 ----------------
		
		public static var DATA_READY:Boolean = false;
		
		//---------------- 层级常量 ----------------
		//远背景
		public static const LAYER_BACKGROUND:String="LAYER_BACKGROUND";
		//背景卷轴1
		public static const LAYER_BACKGROUND_SCROLL_01:String="LAYER_BACKGROUND_SCROLL_01";
		//背景卷轴2
		public static const LAYER_BACKGROUND_SCROLL_02:String="LAYER_BACKGROUND_SCROLL_02";
		//地面背景1
		public static const LAYER_FLOOR_BACKGROUND:String="LAYER_FLOOR_BACKGROUND";
		//地面背景修饰
		public static const LAYER_FLOOR_GARDEN:String="LAYER_FLOOR_GARDEN";
		//地面
		public static const LAYER_FLOOR:String="LAYER_FLOOR";
		//地面热区
		public static const LAYER_HOT_FLOOR:String="LAYER_HOT_FLOOR";
		//楼梯
		public static const LAYER_LADDER:String="LAYER_LADDER";
		//楼梯热区
		public static const LAYER_HOT_LADDER:String="LAYER_HOT_LADDER";
		//事件热区
		public static const LAYER_HOT_EVENT:String="LAYER_HOT_EVENT";
		
		
		public function GlobalData()
		{
		}

		public static function DEFAULT_LAYER_NAME():void
		{
			LAYER_NAME=new Vector.<String>();
			LAYER_NAME.push(LAYER_BACKGROUND);
			LAYER_NAME.push(LAYER_BACKGROUND_SCROLL_01);
			LAYER_NAME.push(LAYER_BACKGROUND_SCROLL_02);
			LAYER_NAME.push(LAYER_FLOOR_BACKGROUND);
			LAYER_NAME.push(LAYER_FLOOR_GARDEN);
			LAYER_NAME.push(LAYER_FLOOR);
			LAYER_NAME.push(LAYER_HOT_FLOOR);
			LAYER_NAME.push(LAYER_LADDER);
			LAYER_NAME.push(LAYER_HOT_LADDER);
			LAYER_NAME.push(LAYER_HOT_EVENT);
		}
	}
}
