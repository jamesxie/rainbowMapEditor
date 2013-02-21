package com.xskip.utils
{
	import com.xskip.rainbow.editor.data.GlobalData;
	
	import spark.components.Image;
	
	public class ImageSparkPlus extends Image
	{
		//路径
		private var _path:String;
		//文件名
		private var _fileName:String;
		//方向
		private var _direction:Number;
		
		//原始尺寸 宽度
		private var _baseWidth:Number;
		//原始尺寸 高度
		private var _baseHeight:Number;
		
		public function ImageSparkPlus()
		{
			super();
		}
		
		private function init():void {
			_path = "";
			_fileName = "";
			_direction = 0;
			_baseWidth = GlobalData.WIDTH_TILE_PIXEL;
			_baseHeight = GlobalData.HEIGHT_TILE_PIXEL;
		}
		
		public function set path(str:String):void{
			_path = str;
		}
		
		public function get path():String{
			return _path;
		}
		
		public function set fileName(str:String):void{
			_fileName = str;
		}
		
		public function get fileName():String{
			return _fileName;
		}
		
		public function set direction(num:Number):void{
			_direction = num;
		}
		
		public function get direction():Number{
			return _direction;
		}
		
		public function set baseWidth(num:Number):void{
			_baseWidth = num;
		}
		
		public function get baseWidth():Number{
			return _baseWidth;
		}
		
		public function set baseHeight(num:Number):void{
			_baseHeight = num;
		}
		
		public function get baseHeight():Number{
			return _baseHeight;
		}
	}
}