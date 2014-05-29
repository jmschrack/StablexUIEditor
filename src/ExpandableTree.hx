package expandableTree;

import flash.display.Sprite;
import flash.events.MouseEvent;
import Xml;
/**
 * ...
 * @author Jonathan Schrack
 */
class ExpandableTree extends Widget
{

	var xmlNode:Xml;
	var children:List;
	var isCollapsed:Bool = true;
	
	public function new() 
	{
		this.addEventListener(onClick);
	}
	public static function createTree(XML xml):ExpandableTree {
		var tree:ExpandableTree = new();
		tree.xmlNode = xml;
		for ( n in xml.elements()) {
			tree.children.add(createTree(n));
		}
		return tree;
	}
	
	public function expand() {
		
	}
	
	public function collapse() {
		
	}
	
	public function onClick(event:MouseEvent):Void {
		if (isCollapsed) { collapse(); } else { expand(); }
		isCollapsed = isCollapsed != true;
	}
}