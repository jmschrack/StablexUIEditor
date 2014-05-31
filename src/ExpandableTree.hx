package ;

import flash.display.Sprite;
import flash.events.MouseEvent;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.HBox;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.VBox;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Widget;
import Xml;

/**
 * This is an expanding tree widget that builds itself based on an XML tree.
 * ...
 * @author Jonathan Schrack
 */
class ExpandableTree extends VBox
{

	
	public var xmlNode:Xml;
	//var children:List;
	var isCollapsed:Bool = true;
	//---------------
	//Widgets
	//---------------
	var titleContainer:HBox = new HBox();
	var childrenContainer:VBox = new VBox();
	var paddingContainer:VBox = new VBox();
	var expandButton:Button = new Button();
	var nameLabel:Text = new Text();
	
	public function new() 
	{
		super();
		this.left = 10;
		//this.addChild(paddingContainer);
		this.addChild(titleContainer);
		this.addChild(childrenContainer);
		this.childPadding = 10;
		
		
		//this.addEventListener(onClick);
		//this.addChild(paddingContainer);
		paddingContainer.autoHeight = true;
		paddingContainer.childPadding = 10;
		titleContainer.autoHeight = true;
		childrenContainer.autoHeight = true;
		childrenContainer.childPadding = 10;
		
		
		//this.addChild(titleContainer);
		//titleContainer.addChild(expandButton);
		titleContainer.addChild(nameLabel);
		//titleContainer.autoHeight = true;
		//titleContainer.childPadding = 10;
		//childrenContainer.refresh()
		//this.addChild(childrenContainer);
		
		
	}
	public static function createTree(xml:Xml,depth:String):ExpandableTree {
		//trace("adding nodetype:");
		//trace(xml.nodeType);
		//if (xml.nodeType == "element") {
			//trace(xml.nodeName);
		//}
		
		var tree = UIBuilder.create(ExpandableTree, { xmlNode:xml } );
		
		tree.setXml(xml, depth);
		depth = "\t" + depth;
		for ( n in xml.elements()) {
			var temp:ExpandableTree = createTree(n,depth);
			//temp.leftPt = 20;
			tree.childrenContainer.addChild(temp);
			
		}
		tree.refresh();
		tree.childrenContainer.refresh();
		tree.paddingContainer.refresh();
		//tree.paddingContainer.childPadding = 20;
		
		
		
		return tree;
	}
	public function setXml(xml:Xml,depth:String) {
		xmlNode = xml;
		nameLabel.text = depth+xml.nodeName;
		
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