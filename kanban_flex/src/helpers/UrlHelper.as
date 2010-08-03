package helpers
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.System;
	
	import model.ModelLocator;
	
	import models.User;
	
	import mx.core.Application;
	
	public class UrlHelper
	{

		public static function getBoardUrl():String
		{
			var serverName:String;
            try {
            	serverName = Application.application.parameters.kanbanServer;
            } catch (ReferenceError){
            	trace("RESTfulActiveRecord couldn't find server assumeing http://localhost:3000/");
            }
            finally { 
            	if (serverName == null)
            		serverName = "http://localhost:3000/";
            }
			return serverName + "home?board_id=" + ModelLocator.getInstance().currentBoard.id;
		}
		
		public static function boardUrlToClipboard():void
		{
			System.setClipboard( getBoardUrl() );
		}

		public static function cardUrlToClipboard(cardId:int):void
		{
			var url:String = getBoardUrl();
			System.setClipboard( url + "&card_id=" + cardId );
		}
		
		public static function userEmailToClipboard(user:User):void
		{
			System.setClipboard( user.mud_id + "@gsk.com" );
		}
		
	    //Open URL passed to this method in a new web page
	    public static function goToURL(urlStr:String):void {
	         var webPageURL:URLRequest = new URLRequest( urlStr );
	         navigateToURL(webPageURL, '_blank')
	    }
		public static function emailUser(u:User):void {
			goToURL( "mailto:" + u.mud_id + "@gsk.com" );
		}


	}
}