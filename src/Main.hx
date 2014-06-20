package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import openfl.Assets;
import ru.stablex.ui.widgets.VBox;
/**
 * ...
 * @author Jonathan Schrack
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		//var bitmap = new Bitmap (Assets.getBitmapData ("assets/openfl.png"));
		//addChild (bitmap);
		
		//bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		//bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		
		
		
		
		UIBuilder.regClass('ExpandableTree');
		UIBuilder.init();
		addChild( UIBuilder.buildFn('window.xml')() );
		var treeContainer:VBox = cast UIBuilder.get('treeContainer');
		var xmlContainer:VBox = cast UIBuilder.get('xmlContainer');
		var xmlInfoContainer:VBox = cast UIBuilder.get('infoContainer');
		ExpandableTree.xmlInfoBox=xmlInfoContainer;
		// (your code here)
		trace("Building tree");
		var doc:Xml = Xml.parse(Assets.getText("assets/position.xml"));
		var xmlTree:ExpandableTree = ExpandableTree.createTree(doc.firstElement(),"");
		trace("Adding tree");
		treeContainer.addChild(xmlTree);
		
		xmlContainer.addChild(UIBuilder.buildFn("assets/position.xml")());
		//trace(xmlTree.numChildren);
		//trace(xmlTree.xmlNode.nodeName);
		//addChild(xmlTree);
		// Stage:
		//\\ stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public function testPrint(){
		trace("Called from main");
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
