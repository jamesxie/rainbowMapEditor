package com.xskip.rainbow.editor.map
{
	import com.xskip.rainbow.editor.data.GlobalData;
	import com.xskip.rainbow.editor.data.TileValues;
	import com.xskip.rainbow.editor.event.EventCenter;
	import com.xskip.rainbow.editor.event.EventType;
	import com.xskip.rainbow.editor.event.JEvent;
	import com.xskip.utils.HashMap;
	import com.xskip.utils.ImageSparkPlus;
	import com.xskip.utils.StarlingLine;
	
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
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
		
		private var _fixX:int;
		private var _fixY:int;
		private var _fixW:int;
		private var _fixH:int;
		
		private var _matrix:Matrix;
		//素材旋转方向 Matrix
		private var _direction:Number;
		//缩放比例
		private var _zoom:Number;

		//地面贴图合集
		private var _hmLAYER_FLOOR:HashMap;
		
		//笔刷目标（只绑定一次）
		private var _ImageSparkPlus:ImageSparkPlus;
		
		//鼠标是否按下
		private var _isMouseDown:Boolean;
		//笔触历史位置
		private var _pointHistory:Point;
		
		//已经保存的地图数据
		//key : 层name_x_y 
		//values : TileValues CLASS [width,height,path,filename,x,y,Image]
		private var _hmTiles:HashMap;

		public function MainStarling()
		{
			super();
			trace("MainStarling");
			init();

		}

		private function init():void
		{
			_ready = false;

			initData();
			initDisplay();
			initEventListener();

			_ready = true;
			
			_isMouseDown = false;
			
			_pointHistory=new Point();
			
			_hmTiles=new HashMap();
			
			GlobalData.SAVE_DATA = _hmTiles;
			
			resetPointHistory();
		}
		
		private function resetPointHistory():void{
			_pointHistory.x = -1;
			_pointHistory.y = -1;
		}

		private function initData():void
		{

			_hmLAYER_FLOOR=new HashMap();
			
			_mouseX = 0;
			_mouseY = 0;
			
			_fixX = GlobalData.WORLD.viewPort.x;
			_fixY = GlobalData.WORLD.viewPort.y;
			_fixW = GlobalData.WORLD.viewPort.width;
			_fixH = GlobalData.WORLD.viewPort.height;
			
			_direction = 0;
			
			_matrix = new Matrix();
			
			_zoom = (GlobalData.WIDTH_TILE_PIXEL/64);
			
			/*var mat1:Matrix = new Matrix();
			mat1.identity();
			//90度
			mat1.rotate(Math.PI/2);
			mat1.scale(2,2);
			mat1.translate(10,20);*/
			
		}

		private function initEventListener():void
		{
			//笔触广播
			GlobalData.WORLD.stage.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			
			GlobalData.STAGE.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			
			//XXX 即将取消的功能
			GlobalData.STAGE.addEventListener(KeyboardEvent.KEY_UP,onKeyboardUpHandler);
			
			//XXX 已经被取消的功能
			EventCenter.dispatcher.addEventListener(EventType.EVENT_CHANGE_IMAGE, onChangeImageHandler);
			
			//更新笔刷图片
			//EventCenter.dispatcher.addEventListener(EventType.EVENT_BRUSH_IMAGE, onBrushImageHandler);
			
		}
		
		//设置笔刷
		public function setBrushImage(pImageSparkPlus:ImageSparkPlus):void{
			_ImageSparkPlus = pImageSparkPlus;
		}
		
		//更新笔刷图片
		private function onBrushImageHandler(e:JEvent):void{
			if (_ready){
				
				var fImageSparkPlus:ImageSparkPlus = ImageSparkPlus(e.obj);
				
				if (!fImageSparkPlus.visible){
					trace("隐藏");
				}else{
					trace("显示");
				}
				
				/*
				//取得位置
				var fPoint:Point = getMousePlace();
				
				var angle_in_radians :Number = ((GlobalData.IMAGE_Direction/180)*Math.PI); 
				
				var fSourceBMD:BitmapData=BitmapData(e.obj);
				var fBitmapData:BitmapData=new BitmapData(GlobalData.WIDTH_TILE_PIXEL,GlobalData.HEIGHT_TILE_PIXEL);
				
				_matrix=new Matrix();
				_matrix.tx-=(fSourceBMD.width/2);
				_matrix.ty-=(fSourceBMD.height/2);
				
				_matrix.rotate(angle_in_radians);
				
				_matrix.tx+=(fSourceBMD.width/2);
				_matrix.ty+=(fSourceBMD.height/2);
				_matrix.scale(_zoom,_zoom);
				
				fBitmapData.draw(fSourceBMD,_matrix);
				
				var fTexture:Texture=Texture.fromBitmapData(fBitmapData);
				
				var fImage:Image=new Image(fTexture);
				fImage.x=fPoint.x * GlobalData.WIDTH_TILE_PIXEL;
				fImage.y=fPoint.y * GlobalData.HEIGHT_TILE_PIXEL;
				
				//trace("fImage.x "+fImage.x+" fImage.y "+fImage.y);
				
				_spNow.addChild(fImage);
				*/
			}
		}
		
		
		//键盘设置缩放和旋转
		private function onKeyboardUpHandler(e:KeyboardEvent):void{
			var fKey:uint = e.keyCode;
			//trace("fKey = " + fKey);
			switch(fKey){
				case 37:
					//_direction = 270;
					GlobalData.IMAGE_Direction=270;
					break;
				case 38:
					//_direction = 0;
					GlobalData.IMAGE_Direction=0;
					break;
				case 39:
					//_direction = 90;
					GlobalData.IMAGE_Direction=90;
					break;
				case 40:
					//_direction = 180;
					GlobalData.IMAGE_Direction=180;
					break;
				default:
					
			}
		}
		
		//维护鼠标位置
		private function onMouseMoveHandler(e:MouseEvent):void{
			mouseX = GlobalData.STAGE.mouseX - _fixX;
			mouseY = GlobalData.STAGE.mouseY - _fixY;
			
			if (mouseX < 0){
				mouseX = 0;
			}
			if (mouseX > _fixW){
				mouseX = _fixW;
			}
			
			if (mouseY < 0){
				mouseY = 0;
			}
			if (mouseY > _fixH){
				mouseY = _fixH;
			}
			
		}
		
		//XXX 暂时无用的方法
		private function onChangeImageHandler(e:JEvent):void
		{
			if (_ready)
			{
				var fPoint:Point=getMousePlace();
				var angle_in_radians :Number = ((GlobalData.IMAGE_Direction/180)*Math.PI); 
				
				var fSourceBMD:BitmapData=BitmapData(e.obj);
				var fBitmapData:BitmapData=new BitmapData(GlobalData.WIDTH_TILE_PIXEL,GlobalData.HEIGHT_TILE_PIXEL);
				
				_matrix=new Matrix();
				_matrix.tx-=(fSourceBMD.width/2);
				_matrix.ty-=(fSourceBMD.height/2);
				
				_matrix.rotate(angle_in_radians);
				
				_matrix.tx+=(fSourceBMD.width/2);
				_matrix.ty+=(fSourceBMD.height/2);
				_matrix.scale(_zoom,_zoom);
				
				fBitmapData.draw(fSourceBMD,_matrix);
				
				var fTexture:Texture=Texture.fromBitmapData(fBitmapData);

				var fImage:Image=new Image(fTexture);
				fImage.x=fPoint.x * GlobalData.WIDTH_TILE_PIXEL;
				fImage.y=fPoint.y * GlobalData.HEIGHT_TILE_PIXEL;
				
				//trace("fImage.x "+fImage.x+" fImage.y "+fImage.y);
				
				_spNow.addChild(fImage);
			}
		}

		//得到鼠标（所在网格）位置
		private function getMousePlace():Point
		{
			var fPoint:Point=new Point();
			
			var fX:Number=mouseX;
			var fY:Number=mouseY;

			refreshNowSprite();
			
			//trace("mouseX "+fX+" GlobalData.WIDTH_TILE_PIXEL "+GlobalData.WIDTH_TILE_PIXEL);

			fPoint.x = Math.floor(fX / GlobalData.WIDTH_TILE_PIXEL);
			fPoint.y = Math.floor(fY / GlobalData.HEIGHT_TILE_PIXEL);
			
			//trace("fPoint.x "+fPoint.x);
			//trace("fPoint.y "+fPoint.y);
			
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
			_spControl.touchable = true;
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
			var fSprite:Sprite = new Sprite();

			//禁止点击
			fSprite.touchable = false;

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
			//var touches:Vector.<Touch>=e.getTouches(this);
			
			var touch:Touch = e.getTouch(GlobalData.WORLD.stage);
			if (touch){
				
				//trace("touch.phase = " + touch.phase);
				
				if (touch.phase == TouchPhase.BEGAN){
					//trace("开始绘制");
					_isMouseDown=true;
					resetPointHistory();
				}
				
				if (touch.phase == TouchPhase.ENDED){
					//trace("结束绘制");
					_isMouseDown=false;
					resetPointHistory();
				}
				
				//移动
				if (touch.phase == TouchPhase.MOVED){
					
					//trace("_isMouseDown = " + _isMouseDown);
					//trace("_ready = " + _ready);
					
					if (_isMouseDown && _ready){
						
						if (GlobalData.IMAGE_SPARK_PLUS){
							
							//获取位置参数
							
							var fPoint:Point = getMousePlace();
							
							
							if (fPoint.x == _pointHistory.x && fPoint.y == _pointHistory.y){
								return;
							}else{
								_pointHistory.x = fPoint.x;
								_pointHistory.y = fPoint.y;
							}
							
							
							
							
							var fkey:String = GlobalData.SELECTED_LAYER+"_"+String(fPoint.x)+"_"+String(fPoint.y);
							
							//trace("------------------------------");
							//trace("处理 fkey = "+fkey);
							
							var fValues:TileValues;
							
							if (_hmTiles.containsKey(fkey)){
								fValues=TileValues(_hmTiles.getValue(fkey));
							}else{
								fValues = new TileValues();
							}
							
							
							if (GlobalData.IMAGE_SPARK_PLUS.visible){
								///////显示中
								
								//trace("绘制");
								
								
								var fSourceBMD:BitmapData = BitmapData(GlobalData.IMAGE_SPARK_PLUS.bitmapData);
								var fBitmapData:BitmapData = new BitmapData(GlobalData.WIDTH_TILE_PIXEL,GlobalData.HEIGHT_TILE_PIXEL);
								
								fBitmapData.draw(fSourceBMD,_matrix);
								
								var fTexture:Texture = Texture.fromBitmapData(fBitmapData);
								
								if (fValues.image){
									fValues.image.texture.dispose();
									fValues.image.texture = fTexture;
								}else{
									fValues.image = new Image(fTexture);
								}
								
								if (!_spNow.contains(fValues.image)){
									_spNow.addChild(fValues.image);
								}
								
								//var fImage:Image = new Image(fTexture);
								
								fValues.image.x = fPoint.x * GlobalData.WIDTH_TILE_PIXEL;
								fValues.image.y = fPoint.y * GlobalData.HEIGHT_TILE_PIXEL;
								
								//fValues.image=fImage;
								
								_hmTiles.put(fkey,fValues);
								
								
							}else{
								///////删除中
								
								//trace("删除 fkey = "+fkey);
								
								if (_hmTiles.containsKey(fkey)){
									
									//trace("得到删除项目");
									fValues=TileValues(_hmTiles.getValue(fkey));
									
									var fImage2:Image=fValues.image;
									
									//trace("fImage2 = "+fImage2);
									
									//trace("_spNow.contains(fImage2) = "+_spNow.contains(fImage2));
									
									_spNow.removeChild(fImage2);
									
									_hmTiles.remove(fkey);
									
								}
								
								
								
							}
						}

						
					}
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
