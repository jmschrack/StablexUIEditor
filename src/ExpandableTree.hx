package ;

import flash.display.Sprite;
import flash.events.MouseEvent;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.HBox;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.InputText;
import ru.stablex.ui.widgets.VBox;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Widget;
import flash.display.DisplayObject;
import Xml;

/**
 * This is an expanding tree widget that builds itself based on an XML tree.
 * ...
 * @author Jonathan Schrack
 */
class ExpandableTree extends VBox
{

	public static var xmlInfoBox:VBox;
	
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
	var indentLabel:Text = new Text();
	var parentT:Dynamic;
	
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
		titleContainer.addChild(indentLabel);
		titleContainer.addChild(expandButton);
		titleContainer.addChild(nameLabel);
		expandButton.text = "";
		if (expandButton.skin == null) expandButton.skin = new Paint();
		cast(expandButton.skin, Paint).color = 0xaaaaaa;
		expandButton.onInitialize();
		expandButton.onCreate();
		//expandButton.w = 0;
		//expandButton.h = 0;
		expandButton.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		nameLabel.addEventListener(MouseEvent.MOUSE_DOWN, onXmlClick);
		//titleContainer.autoHeight = true;
		//titleContainer.childPadding = 10;
		//childrenContainer.refresh()
		//this.addChild(childrenContainer);
		
		
	}
	public static function createTree(xml:Xml,depth:String, ?parentNode:Dynamic):ExpandableTree {
		//trace("adding nodetype:");
		//trace(xml.nodeType);
		//if (xml.nodeType == "element") {
			//trace(xml.nodeName);
		//}
		
		var tree = UIBuilder.create(ExpandableTree, { xmlNode:xml } );
		if(parentNode!=null) tree.parentT=parentNode;
		tree.setXml(xml);
		tree.indentLabel.text = depth;
		depth = "\t" + depth;
		for ( n in xml.elements()) {
			var temp:ExpandableTree = createTree(n,depth,tree.refreshAllChildren);
			//temp.leftPt = 20;
			tree.childrenContainer.addChild(temp);
			
		}
		tree.checkVis();
		tree.refresh();
		tree.titleContainer.refresh();
		tree.childrenContainer.refresh();
		tree.paddingContainer.refresh();
		//tree.paddingContainer.childPadding = 20;
		
		
		
		return tree;
	}
	public function setXml(xml:Xml) {
		xmlNode = xml;
		nameLabel.text = xml.nodeName;
		
	}
	
	public function checkVis() {
		if (this.childrenContainer.numChildren > 0) {
			this.expandButton.text="+";
			this.expandButton.visible=true;
		}else {
			this.expandButton.visible=false;
		}
	}
	public function expand() {
	trace("Expand");
		this.expandButton.text="-";
		this.childrenContainer.autoSize=true;
		this.childrenContainer.visible=true;
		refreshAllChildren();
		refreshParent();
	}
	
	public function collapse() {
	trace("Collapse");
		this.expandButton.text="+";
		this.childrenContainer.autoSize=false;
		this.childrenContainer.h=0;
		this.childrenContainer.visible=false;
		this.childrenContainer.refresh();
		refreshAllChildren();
		refreshParent();
	}
	
	public function onClick(event:MouseEvent):Void {
		if (isCollapsed) { collapse(); } else { expand(); }
		isCollapsed = isCollapsed != true;
	}
	
	public function refreshParent(){
		if(parentT!=null){
			parentT();
		}
	}
	
	public function refreshAllChildren(){
		this.childrenContainer.refresh();
		this.titleContainer.refresh();
		this.refresh();
		
	}
	
	public function onXmlClick(event:MouseEvent):Void{
		if(xmlInfoBox!=null){
			xmlInfoBox.removeChildren();
			var atts:Iterator<String> = xmlNode.attributes();
			var temp:String;
			var tempLabel:Text;
			var tempValue:InputText;
			while(atts.hasNext()){
				temp=atts.next();
				var hbx = new HBox();
				tempLabel= new Text();
				tempLabel.text=temp;
				tempValue= new InputText();
				tempValue.text=xmlNode.get(temp);
				tempValue.refresh();
				hbx.addChild(tempLabel);
				hbx.addChild(tempValue);
				hbx.refresh();
				xmlInfoBox.addChild(hbx);
			}
			xmlInfoBox.refresh();
			var leftPane:VBox = cast UIBuilder.get('leftPanel');
			leftPane.refresh();
		}
	}
}
