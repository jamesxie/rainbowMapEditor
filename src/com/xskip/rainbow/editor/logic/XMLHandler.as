package com.xskip.rainbow.editor.logic
{
	import com.xskip.rainbow.editor.data.GlobalData;
	import com.xskip.rainbow.editor.data.TileValues;
	import com.xskip.utils.HashMap;
	
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
			
			for (var i:int = 0;i < fLength;i++){
				var fKey:String = fHM_DATA.keys()[i];
				var fTileValues:TileValues=TileValues(fHM_DATA.getValue(fKey));

				fContents+="\t<config key='"+fKey+"' x='"+fTileValues.x+"' y='"+fTileValues.y+"' " +
					"width='"+fTileValues.width+"' " +
					"height='"+fTileValues.height+"' " +
					"path='"+fTileValues.path+"' " +
					"filename='"+fTileValues.filename+"' " +
					"/>\n";
			}
			
			//fContents+="\t<config id='1' type='A' values='东汉末年，宦官专权，群雄逐鹿中原。' time='12' next='2'/>\n";
			//fContents+="\t<config id='2' type='A' values='时巨鹿郡有兄弟三人，一名张角，一名张宝，一名张梁。' time='12' next='3'/>\n";
			
			fContents+="</root>";
			
			var file:File = new File(path);
			
			file = file.resolvePath("xml/saveFile.xml");
			
			var stream:FileStream = new FileStream();
			
			stream.open(file, FileMode.WRITE);
			
			stream.writeUTFBytes(fContents);
			
			stream.close();
			
			Alert.show("保存完毕!!!\n\n位置 : "+file.nativePath+"\n\n","提示");
			
			// msgTxt.text = "数据保存路径：" + file.nativePath;
			
		}     
	}
}