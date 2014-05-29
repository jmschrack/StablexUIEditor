package expandableTree;

import flash.display.Sprite;
import flash.events.MouseEvent;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.HBox;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.VBox;
import Xml;
/**
 * This is an expanding tree widget that builds itself based on an XML tree.
 * ...
 * @author Jonathan Schrack
 */
class ExpandableTree extends VBox
{

	
	var xmlNode:Xml;
	var children:List;
	var isCollapsed:Bool = true;
	//---------------
	//Widgets
	//---------------
	var titleContainer:HBox;
	var childrenContainer:VBox;
	var expandButton:Button;
	var nameLabel:Text;
	
	public function new() 
	{
		this.addEventListener(onClick);
		
		this.addChild(titleContainer);
		titleContainer.addChild(expandButton);
		titleContainer.addChild(nameLabel);
		this.addChild(childrenContainer);
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