package com.xskip.rainbow.editor.data
{
	import com.xskip.utils.HashMap;
	import com.xskip.utils.ImageSparkPlus;
	
	import flash.display.Stage;
	
	import starling.core.Starling;

	public class GlobalData
	{
		//---------------- 全局变量 ----------------
		//Stage
		public static var STAGE:Stage;
		public static var WORLD:Starling;
		
		
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
		
		
		//---------------- starling变量 ----------------
		
		//所有的图层
		public static var DISPLAY_ALL_SPRITE:HashMap;
		
		//图片旋转角度
		public static var IMAGE_Direction:Number = 0;
		
		//笔刷（内容有或无）
		public static var IMAGE_SPARK_PLUS:ImageSparkPlus;
		
		//编辑模式 可以移动素材
		public static var MODE_EDIT:Boolean = false;
		
		//---------------- 数据变量 ----------------
		
		public static var DATA_READY:Boolean = false;
		
		//当前选中层
		public static var SELECTED_LAYER:String="";
		
		//需要保存的数据
		//key : 层name_x_y 
		//values : TileValues CLASS [width,height,path,filename,x,y,Image]
		public static var SAVE_DATA:HashMap;
		
		//---------------- 层级常量 ----------------
		//1 远背景
		public static const LAYER_BACKGROUND:String="LAYER_BACKGROUND";
		//2 背景卷轴1
		public static const LAYER_BACKGROUND_SCROLL_01:String="LAYER_BACKGROUND_SCROLL_01";
		//3 背景卷轴2
		public static const LAYER_BACKGROUND_SCROLL_02:String="LAYER_BACKGROUND_SCROLL_02";
		//4 地面背景
		public static const LAYER_FLOOR_BACKGROUND:String="LAYER_FLOOR_BACKGROUND";
		//5 地面背景修饰
		public static const LAYER_FLOOR_GARDEN:String="LAYER_FLOOR_GARDEN";
		//6 地面
		public static const LAYER_FLOOR:String="LAYER_FLOOR";
		//7 地面热区
		public static const LAYER_HOT_FLOOR:String="LAYER_HOT_FLOOR";
		//8 楼梯
		public static const LAYER_LADDER:String="LAYER_LADDER";
		//9 楼梯热区
		public static const LAYER_HOT_LADDER:String="LAYER_HOT_LADDER";
		//10 事件热区
		public static const LAYER_HOT_EVENT:String="LAYER_HOT_EVENT";
		//11 网格层
		public static const LAYER_TILE_CELL:String="LAYER_TILE_CELL";
		
		
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
			LAYER_NAME.push(LAYER_TILE_CELL);
		}
	}
}
