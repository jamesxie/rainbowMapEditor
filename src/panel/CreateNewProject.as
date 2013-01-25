package panel
{
	import spark.components.Window;

	public class CreateNewProject extends Window
	{
		public function CreateNewProject() 
		{
			init();
		}
		
		private function init():void{
			this.title="创建新地图";
			this.width = 600;
			this.height = 800;
		}
	}
}