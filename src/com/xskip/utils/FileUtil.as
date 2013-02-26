package com.xskip.utils
{
	public class FileUtil
	{
		public function FileUtil()
		{
		}
		
		//根据完整路径返回目录名
		public static function getDirectory(strFullPath:String):String{
			var fStr:String = strFullPath;
			var fReturn:String="Error";
			var fArr:Array=fStr.split("\\");
			if(fArr.length>1){
				fReturn="";
			}
			for (var i:int=0;i<fArr.length-1;i++){
				fReturn+=(String(fArr[i])+"\\");
			}
			return fReturn;
		}
		
		//根据完整路径返回文件名
		public static function getFileName(strFullPath:String):String{
			var fStr:String = strFullPath;
			var fReturn:String="Error";
			var fArr:Array=fStr.split("\\");
			if(fArr.length>1){
				fReturn=String(fArr[(fArr.length-1)]);
			}
			return fReturn;
		}
	}
}