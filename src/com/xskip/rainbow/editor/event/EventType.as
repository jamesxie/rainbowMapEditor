package com.xskip.rainbow.editor.event
{
	public class EventType
	{
		
		//改变贴图(参数 bitmap)
		public static const EVENT_CHANGE_IMAGE:String="EVENT_CHANGE_IMAGE";
		
		//改变贴图(参数 image 中的 ImageSparkPlus)
		public static const EVENT_BRUSH_IMAGE:String="EVENT_BRUSH_IMAGE";
		
		//变成橡皮擦
		public static const EVENT_CHANGE_RUBBER:String="EVENT_CHANGE_RUBBER";
		
		//笔刷 模式
		public static const EVENT_MODEL_BRUSH:String="EVENT_BRUSH";
		//单拽 模式
		public static const EVENT_MODEL_DRAG:String="EVENT_DRAG";
		
		/*
		public static const :String="";
		public static const :String="";
		public static const :String="";
		public static const :String="";
		public static const :String="";
		public static const :String="";
		public static const :String="";
		public static const :String="";
		*/
		
		public function EventType()
		{
			
		}
	}
}