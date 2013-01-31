package com.xskip.rainbow.editor.event {
	import flash.events.Event;	

	/**
	 * Example:
	 * ----ClassA code:----
	 * dispatchEvent(new JEvent("click", "Hello"));
	 * 
	 * ----ClassB code:----
	 * classA.addEventListener("click", moveJob);
	 * public function moveJob(e:JEvent):void{
	 *     alert(e.obj);
	 * }
	 * 
	 * ----Output:----
	 * Hello
	 */
	/**
	 * 扩展Event类使其可以传递一个对象
	 * @author James
	 * @version 1.0
	 */
	public class JEvent extends Event {
		private var _obj : Object;

		public function JEvent(type : String, obj : Object = null,bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			this._obj = obj;
		}

		public function get obj() : Object {
			return this._obj;
		}

		override public function clone() : Event {
			return new JEvent(this.type, this._obj, this.bubbles, this.cancelable);
		}
	}
}
