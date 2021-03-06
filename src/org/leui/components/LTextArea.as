package org.leui.components
{
	
	import flash.events.Event;
	
	import org.leui.core.IViewport;

	/**
	 *  文本域，用于大段文字及需要配合滚动面板的文本。
	 * </br>注意，setAlign方法在此组件中不可用，需要文字布局的，需使用其父类LText
	 * @see LText.setAlign()
	 *@author swellee
	 */
	public class LTextArea extends LText implements IViewport
	{

		/**
		 * 作为IViewport时，尺寸变化的侦听函数
		 */		
		protected var viewSizeListenFun:Function;
		private var oldNumLines:int;
		
		public function LTextArea(text:String="", editable:Boolean=true)
		{
			super(text, editable);
			textField.mouseWheelEnabled=false;
			textField.wordWrap=true;
			textField.multiline=true;
		}
		override protected function addEvents():void
		{
			super.addEvents();
			textField.addEventListener(Event.CHANGE,textChangeHandler);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			textField.removeEventListener(Event.CHANGE,textChangeHandler);
		}
		protected function textChangeHandler(event:Event):void
		{
			if(textField.height<=height)
			{
				textField.y=0;
			}
			if(textField.numLines!=oldNumLines)
			{
				textField.height=textField.textHeight+textFrameSpace;
				oldNumLines=textField.numLines;
				if(viewSizeListenFun!=null)viewSizeListenFun.call(null);
			}
		}
		override public function set text(value:String):void
		{
			oldNumLines=textField.numLines;
			super.text=value;
			textChangeHandler(null);
		}
		/**
		 *  将 newTxt 参数指定的字符串追加到文本字段的文本的末尾。此方法要比对 text 属性的加法赋值 (+=)（如 someTextField.text += moreText）更有效，对于包含大量内容的文本字段尤其有效。 
		 * @param newTxt
		 * 
		 */
		public function appendText(newTxt:String):void
		{
			textField.appendText(newTxt);
			textChangeHandler(null);
		}
		public function setViewPosition(posX:Number, posY:Number):void
		{
			textField.x=posX;
			textField.y=posY;
		}
		public function addViewSizeListener(fun:Function):void
		{
			this.viewSizeListenFun=fun;
		}
		public function removeViewSizeListener():void
		{
			this.viewSizeListenFun=null;
		}
		override public function set width(value:Number):void
		{
			if(value==width)return;
			
			super.width=value;
			textField.width=width;
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		override public function set height(value:Number):void
		{
			if(value==height)return;
			
			super.height=value;
			textField.height=height;
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		override protected function updateAlign():void
		{
		}
		public function get viewWidth():int
		{
			return textField.width;
		}
		public function get viewHeight():int
		{
			return textField.height;
		}
	}
}