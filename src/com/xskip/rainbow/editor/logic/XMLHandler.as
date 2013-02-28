package com.xskip.rainbow.editor.logic
{
	import com.xskip.rainbow.editor.data.GlobalData;
	import com.xskip.rainbow.editor.data.TileValues;
	import com.xskip.utils.HashMap;
	import com.xskip.utils.StringUtil;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;

	public class XMLHandler
	{
		public function XMLHandler()
		{
		}
		
		public function save():void{
			if (!GlobalData.SAVE_DATA){
				Alert.show("暂无数据");
				return;
			}
			
			
			saveFile(File.applicationDirectory.nativePath);
		}
		
		private function saveFile(path:String):void {
			
			var fContents:String = "";
			
			fContents="<?xml version='1.0' encoding='utf-8' ?>\n<root>\n";
			
			/*
			private var _x:Number;
			private var _y:Number;
			
			private var _width:Number;
			private var _height:Number;
			
			private var _path:String;
			private var _filename:String;
			*/
			
			var fHM_DATA:HashMap = GlobalData.SAVE_DATA;
			var fLength:int = fHM_DATA.size();
			
			//排序
			fHM_DATA.sortByKey();
			
			for (var i:int = 0;i < fLength;i++){
				var fKey:String = fHM_DATA.keys()[i];
				var fTileValues:TileValues=TileValues(fHM_DATA.getValue(fKey));

				fContents+="\t<config layer='"+fTileValues.layer+"' type='"+fTileValues.type+"' direction='"+fTileValues.direction+"' x='"+fTileValues.x+"' y='"+fTileValues.y+"' " +
					"width='"+fTileValues.width+"' " +
					"height='"+fTileValues.height+"' " +
					"path='"+fTileValues.path+"' " +
					"filename='"+fTileValues.filename+"' " +
					"/>\n";
			}
			
			
			/*
			fContents+="\t<config layer='onSort'/>\n";
			
			//TODO 2013-02-25 暂时不用 排序算法
			//fHM_DATA.sortByKey();
			
			for (var j:int = 0;j < fLength;j++){
				var fKey2:String = fHM_DATA.keys()[j];
				var fTileValues2:TileValues=TileValues(fHM_DATA.getValue(fKey2));
				
				fContents+="\t<config layer='"+fTileValues2.layer+"' x='"+fTileValues2.x+"' y='"+fTileValues2.y+"' " +
					"width='"+fTileValues2.width+"' " +
					"height='"+fTileValues2.height+"' " +
					"path='"+fTileValues2.path+"' " +
					"filename='"+fTileValues2.filename+"' " +
					"/>\n";
			}*/
			
			
			
			//fContents+="\t<config id='1' type='A' values='东汉末年，宦官专权，群雄逐鹿中原。' time='12' next='2'/>\n";
			//fContents+="\t<config id='2' type='A' values='时巨鹿郡有兄弟三人，一名张角，一名张宝，一名张梁。' time='12' next='3'/>\n";
			
			fContents+="</root>";
			
			var file:File = new File(path);
			
			file = file.resolvePath("xml/saveFile"+StringUtil.GetFullTime("_","-","")+".xml");
			
			var stream:FileStream = new FileStream();
			
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(fContents);
			
			stream.openAsync(file, FileMode.READ); 
			stream.addEventListener(Event.COMPLETE, saveCompleteHandler);
			
			//Alert.show("保存完毕!!!\n\n位置 : "+file.nativePath+"\n\n","提示");
			
			//stream.close();

			// msgTxt.text = "数据保存路径：" + file.nativePath;
			
		}
		
		private function saveCompleteHandler(e:Event):void{
			var fStream:FileStream=FileStream(e.target);
			if (fStream.hasEventListener(Event.COMPLETE)){
				fStream.removeEventListener(Event.COMPLETE, saveCompleteHandler);
			}
			
			fStream.close();
			
			Alert.show("保存完毕!!!\n\n","提示");
		}
	}
}