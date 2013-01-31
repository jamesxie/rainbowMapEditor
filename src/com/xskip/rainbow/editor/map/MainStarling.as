package com.xskip.rainbow.editor.map
{
	import com.xskip.rainbow.editor.data.GlobalData;
	import com.xskip.rainbow.editor.event.EventCenter;
	import com.xskip.rainbow.editor.event.EventType;
	import com.xskip.rainbow.editor.event.JEvent;
	import com.xskip.utils.HashMap;
	import com.xskip.utils.StarlingLine;

	import flash.display.BitmapData;
	import flash.geom.Point;

	import mx.controls.Text;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class MainStarling extends Sprite
	{
		private var _spControl:Sprite;

		//贴图模式 (贴图 or 擦除)
		private var _changeModel:String;

		private var _ready:Boolean;

		private var _spNow:Sprite;

		private var _mouseX:Number;
		private var _mouseY:Number;


		//地面贴图合集
		private var _hmLAYER_FLOOR:HashMap;

		public function MainStarling()
		{
			super();
			trace("MainStarling");
			init();

		}

		private function init():void
		{
			_ready=false;

			initData();
			initDisplay();
			initEventListener();

			_ready=true;
		}

		private function initData():void
		{

			_hmLAYER_FLOOR=new HashMap();
		}

		private function initEventListener():void
		{
			//更新坐标位置
			GlobalData.WORLD.stage.addEventListener(TouchEvent.TOUCH, onTouchHandler);


			EventCenter.dispatcher.addEventListener(EventType.EVENT_CHANGE_IMAGE, onChangeImageHandler);
		}



		private function onChangeImageHandler(e:JEvent):void
		{
			if (_ready)
			{
				var fPoint:Point=getMousePlace();

				var fTexture:Texture=Texture.fromBitmapData(BitmapData(e.obj));

				var fImage:Image=new Image(fTexture);
				fImage.x=fPoint.x * GlobalData.WIDTH_TILE_PIXEL;
				fImage.y=fPoint.y * GlobalData.HEIGHT_TILE_PIXEL;


				_spNow.addChild(fImage);
			}
		}

		private function getMousePlace():Point
		{
			var fPoint:Point=new Point();

			refreshNowSprite();

			fPoint.x=int(_mouseX / GlobalData.WIDTH_TILE_PIXEL);
			fPoint.y=int(_mouseY / GlobalData.HEIGHT_TILE_PIXEL);

			return fPoint;
		}


		//刷新当前显示层
		private function refreshNowSprite():void
		{
			if (GlobalData.SELECTED_LAYER)
			{
				if (GlobalData.SELECTED_LAYER.length > 0)
				{
					_spNow=Sprite(GlobalData.DISPLAY_ALL_SPRITE.getValue(GlobalData.SELECTED_LAYER));
				}
			}

		}

		private function initDisplay():void
		{
			GlobalData.DISPLAY_ALL_SPRITE=new HashMap();

			addSprite(GlobalData.LAYER_BACKGROUND);
			addSprite(GlobalData.LAYER_BACKGROUND_SCROLL_01);
			addSprite(GlobalData.LAYER_BACKGROUND_SCROLL_02);
			addSprite(GlobalData.LAYER_FLOOR_BACKGROUND);
			addSprite(GlobalData.LAYER_FLOOR_GARDEN);
			addSprite(GlobalData.LAYER_FLOOR);
			addSprite(GlobalData.LAYER_HOT_FLOOR);
			addSprite(GlobalData.LAYER_LADDER);
			addSprite(GlobalData.LAYER_HOT_LADDER);
			addSprite(GlobalData.LAYER_HOT_EVENT);
			addSprite(GlobalData.LAYER_TILE_CELL);

			//选定层
			GlobalData.SELECTED_LAYER=GlobalData.LAYER_FLOOR;

			//添加控制层
			_spControl=new Sprite();
			GlobalData.WORLD.stage.addChild(_spControl);

			//初始化各个图层
			init_LAYER_TILE_CELL();

			trace("initDisplay Done");

		/*trace("w = "+GlobalData.WIDTH_SCREEN_PIXEL);
		trace("h = "+GlobalData.HEIGHT_SCREEN_PIXEL);

		trace("cell w = "+GlobalData.WIDTH_TILE_PIXEL);
		trace("cell h = "+GlobalData.HEIGHT_TILE_PIXEL);*/

		}

		private function addSprite(pKey:String=""):void
		{
			var fSprite:Sprite=new Sprite();

			//禁止点击
			fSprite.touchable=false;

			GlobalData.DISPLAY_ALL_SPRITE.put(pKey, fSprite);
			GlobalData.WORLD.stage.addChild(fSprite);
		}

		private function init_LAYER_TILE_CELL():void
		{
			var fSprite:Sprite=Sprite(GlobalData.DISPLAY_ALL_SPRITE.getValue(GlobalData.LAYER_TILE_CELL));

			//透明度
			fSprite.alpha=0.5;

			//TODO 以后变更为真正场景宽高
			var fWNum:int=int(GlobalData.WIDTH_SCREEN_PIXEL / GlobalData.WIDTH_TILE_PIXEL) + 1;
			var fHNum:int=int(GlobalData.HEIGHT_SCREEN_PIXEL / GlobalData.HEIGHT_TILE_PIXEL) + 1;

			//trace("fWNum = "+fWNum);
			//trace("fHNum = "+fHNum);

			for (var i:int=0; i < fWNum; i++)
			{
				var fWX:int=GlobalData.WIDTH_TILE_PIXEL * i;
				var fWLine:StarlingLine=new StarlingLine();
				fWLine.x=fWX;
				fWLine.y=0;
				fWLine.lineTo(fWX, GlobalData.HEIGHT_SCREEN_PIXEL);
				fSprite.addChild(fWLine);
			}

			for (var j:int=0; j < fHNum; j++)
			{
				var fHY:int=GlobalData.HEIGHT_TILE_PIXEL * j;
				var fHLine:StarlingLine=new StarlingLine();
				fHLine.x=0;
				fHLine.y=fHY;
				fHLine.lineTo(GlobalData.WIDTH_SCREEN_PIXEL, fHY);
				fSprite.addChild(fHLine);
			}
		}


		//更新坐标位置 begin
		private function onTouchHandler(e:TouchEvent):void
		{
			var touches:Vector.<Touch>=e.getTouches(this);

			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.HOVER)
				{
					var location:Point=touch.getLocation(this);
					mouseX=location.x;
					mouseY=location.y;
				}
			}
		}

		public function get mouseX():Number
		{
			return _mouseX;
		}

		public function set mouseX(value:Number):void
		{
			_mouseX=value;
		}

		public function get mouseY():Number
		{
			return _mouseY;
		}

		public function set mouseY(value:Number):void
		{
			_mouseY=value;
		}
		//更新坐标位置 end
	}
}
