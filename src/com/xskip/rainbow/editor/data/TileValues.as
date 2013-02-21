package com.xskip.rainbow.editor.data
{
	import starling.display.Image;

	public class TileValues
	{
		
		private var _x:Number;
		private var _y:Number;
		
		private var _width:Number;
		private var _height:Number;
		
		private var _path:String;
		private var _filename:String;
		
		private var _image:Image;
		
		
		public function TileValues()
		{
			init();
		}
		
		private function init():void{
			_x=0;
			_y=0;
			_width=0;
			_height=0;
			_path="";
			_filename="";
		}
		
		
		public function set x(num:Number):void{
			_x = num;
		}
		
		public function get x():Number{
			return _x;
		}
		
		public function set y(num:Number):void{
			_y = num;
		}
		
		public function get y():Number{
			return _y;
		}
		
		public function set width(num:Number):void{
			_width = num;
		}
		
		public function get width():Number{
			return _width;
		}
		
		public function set height(num:Number):void{
			_height = num;
		}
		
		public function get height():Number{
			return _height;
		}
		
		public function set path(str:String):void{
			_path = str;
		}
		
		public function get path():String{
			return _path;
		}
		
		public function set filename(str:String):void{
			_filename = str;
		}
		
		public function get filename():String{
			return _filename;
		}
		
		public function set image(img:Image):void{
			_image = img;
		}
		
		public function get image():Image{
			return _image;
		}
	}
}