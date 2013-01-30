package com.xskip.rainbow.editor.map
{
	import com.xskip.rainbow.editor.data.GlobalData;
	import com.xskip.utils.HashMap;
	import com.xskip.utils.StarlingLine;
	
	import starling.display.Sprite;
	
	public class MainStarling extends Sprite
	{
		private var _spControl:Sprite;
		
		public function MainStarling()
		{
			super();
			trace("MainStarling");
			
			/*
			createViewLayer(_commViewLayer01,10,"远背景",GlobalData.LAYER_BACKGROUND);
			createViewLayer(_commViewLayer02,9,"背景卷轴1",GlobalData.LAYER_BACKGROUND_SCROLL_01);
			createViewLayer(_commViewLayer03,8,"背景卷轴2",GlobalData.LAYER_BACKGROUND_SCROLL_02);
			createViewLayer(_commViewLayer04,7,"地面背景",GlobalData.LAYER_FLOOR_BACKGROUND);
			createViewLayer(_commViewLayer05,6,"地面背景修饰",GlobalData.LAYER_FLOOR_GARDEN);
			createViewLayer(_commViewLayer06,5,"地面",GlobalData.LAYER_FLOOR);
			createViewLayer(_commViewLayer07,4,"地面热区",GlobalData.LAYER_HOT_FLOOR);
			createViewLayer(_commViewLayer08,3,"楼梯",GlobalData.LAYER_LADDER);
			createViewLayer(_commViewLayer09,2,"楼梯热区",GlobalData.LAYER_HOT_LADDER);
			createViewLayer(_commViewLayer10,1,"事件热区",GlobalData.LAYER_HOT_EVENT);
			createViewLayer(_commViewLayer11,0,"网格层",GlobalData.LAYER_TILE_CELL);
			*/
			
			init();
			
		}
		
		private function init():void{
			
			initDisplay();
		}
		
		private function initDisplay():void{
			GlobalData.DISPLAY_ALL_SPRITE = new HashMap();
			
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
			_spControl = new Sprite();
			GlobalData.WORLD.stage.addChild(_spControl);
			
			//初始化各个图层
			init_LAYER_TILE_CELL();
			
			trace("initDisplay Done");
			
			/*trace("w = "+GlobalData.WIDTH_SCREEN_PIXEL);
			trace("h = "+GlobalData.HEIGHT_SCREEN_PIXEL);
			
			trace("cell w = "+GlobalData.WIDTH_TILE_PIXEL);
			trace("cell h = "+GlobalData.HEIGHT_TILE_PIXEL);*/
			
		}
		
		private function addSprite(pKey:String=""):void{
			var fSprite:Sprite = new Sprite();
			
			//禁止点击
			fSprite.touchable = false;
			
			GlobalData.DISPLAY_ALL_SPRITE.put(pKey,fSprite);
			GlobalData.WORLD.stage.addChild(fSprite);
		}
		
		private function init_LAYER_TILE_CELL():void{
			var fSprite:Sprite=Sprite(GlobalData.DISPLAY_ALL_SPRITE.getValue(GlobalData.LAYER_TILE_CELL));
			
			//TODO 以后变更为真正场景宽高
			var fWNum:int = int(GlobalData.WIDTH_SCREEN_PIXEL/GlobalData.WIDTH_TILE_PIXEL)+1;
			var fHNum:int = int(GlobalData.HEIGHT_SCREEN_PIXEL/GlobalData.HEIGHT_TILE_PIXEL)+1;
			
			//trace("fWNum = "+fWNum);
			//trace("fHNum = "+fHNum);
			
			for (var i:int=0;i<fWNum;i++){
				var fWX:int=GlobalData.WIDTH_TILE_PIXEL*i;
				var fWLine:StarlingLine=new StarlingLine();
				fWLine.x=fWX;
				fWLine.y=0;
				fWLine.lineTo(fWX,GlobalData.HEIGHT_SCREEN_PIXEL);
				fSprite.addChild(fWLine);
			}
			
			for (var j:int=0;j<fHNum;j++){
				var fHY:int=GlobalData.HEIGHT_TILE_PIXEL*j;
				var fHLine:StarlingLine=new StarlingLine();
				fHLine.x=0;
				fHLine.y=fHY;
				fHLine.lineTo(GlobalData.WIDTH_SCREEN_PIXEL,fHY);
				fSprite.addChild(fHLine);
			}
		}
	}
}