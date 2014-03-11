package components
{
	import core.ICombine;
	
	import vos.ChildStyleHashVO;
	
	/**
	 *组合UI,由多个子组件拼合而成，典型子类如LScrollBar、LScrollPane
	 *@author swellee
	 *2013-4-29
	 */
	public class LCombine extends LContainer implements ICombine
	{
		protected var _elementStyleHash:Vector.<ChildStyleHashVO>;
		public function LCombine()
		{
			super();
		}
		override protected function init():void
		{
			super.init();
			initElementStyleHash();
			initElements();
		}
		/**初始化子组件名－子组件样式映射列表*/
		protected function initElementStyleHash():void
		{
			_elementStyleHash=new Vector.<ChildStyleHashVO>();
		}
		/**初始化子组件实例及在此容器中的位置*/
		protected function initElements():void
		{
		}
		
		public function get elementStyleHash():Vector.<ChildStyleHashVO>
		{
			return _elementStyleHash;
		}
		
		public function setElementStyle(elementName:String, styleName:String):void
		{
			if(hasOwnProperty(elementName))
			{
				try
				{
					this[elementName].style=styleName;
				} 
				catch(error:Error) 
				{
					
				}
			}
		}
		
		public function applyElementStyles():void
		{
			for each (var childVo:ChildStyleHashVO in elementStyleHash) 
			{
				setElementStyle(childVo.childName,childVo.childStyle);
			}
		}
		
		override public function dispose():void
		{
			_elementStyleHash=null;
			super.dispose();
		}
	}
}