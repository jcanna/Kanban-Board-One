package helpers.modelServices
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.xml.XMLDocument;
	import flash.utils.describeType;
	
	import helpers.FlexIntrospectionHelper;
	import helpers.ResourceName;
	import helpers.StringHelper;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Bindable]
	public class RESTfulActiveRecord extends EventDispatcher
	{
		public var serverName;// = "http://kanbanflexdemo.heroku.com/";
		public var RESTService = new HTTPService();
		public var modelPackageName = "models";
		private var baseTypeName;
		private var resourceName;

		public function RESTfulActiveRecord()
		{	
			initialize();	
		}
		
		public function initialize() {
			resourceName = initializeResourceName();
			
			RESTService.resultFormat = "e4x";
			RESTService.addEventListener(ResultEvent.RESULT, successfulRESTResult);
			RESTService.addEventListener(FaultEvent.FAULT, failureRESTResult);

			// the kanbanServer is a flashvar that comes in part of the html which kicks off
            // the kanban application.
/*
            try {
            	serverName = Application.application.parameters.kanbanServer;
            } catch (ReferenceError){
            	serverName = "http://localhost:3000/";
            }
            finally { 
            	if (serverName == null)
            		serverName = "http://localhost:3000/";
            }
*/
			//serverName = "http://kanbanflexdemo.heroku.com/";
			serverName = "http://localhost:3000/"
		}

		public function find(id="all", params=null) {
			RESTService.method = "GET";
			RESTService.contentType = HTTPService.CONTENT_TYPE_FORM;
			RESTService.request = null;
			RESTService.url = serverName + resourceName;
			RESTService.url += id == "all" ? ".xml" : "/" + id ;
			RESTService.send(params);			
		}
		
		public function remove() {
			// HTTPService does not support DELETE, this is a rails specific workaround
			// where we utilize the POST method, adding delete as a method parameter and pass in XML
			RESTService.method = "POST";
			RESTService.url = serverName + resourceName + "/" + this.id  + "?_method=DELETE";
			updateDatabase();
		}
		
		public function create() {			
			// HTTPService will automagically call the CREATE method by default in rails on a POST
			RESTService.method = "POST";
			RESTService.url = serverName + resourceName ;
			updateDatabase();
		}

		public function save() {
			// HTTPService does not support PUT, this is a rails specific workaround			
			// where we utilize the POST method, adding delete as a method parameter and pass in XML
			RESTService.method = "POST";
			RESTService.url = serverName + resourceName + "/" + this.id  + "?_method=put";
			updateDatabase();
		}

		private function updateDatabase() {
			RESTService.contentType = HTTPService.CONTENT_TYPE_XML;
			RESTService.request = populateXML();
			RESTService.send(null); // Update details are passed in XML Doc
		}		

		public function populateXML():XMLDocument {
			var className = StringHelper.removePlural(resourceName);
			var genXML:XML = <{className}></{className}>
			for (item in this) { //items are retrieved from dynamic model
				genXML.appendChild( <{item}>{this[item]}</{item}> );
			}

			return new XMLDocument(genXML);
		}

		private function successfulRESTResult(event:ResultEvent) {	
			var xmlResult = event.result;	

			var RESTCallResult;
			if (xmlResult is XML) {
				if ("array" == xmlResult.@type.toString()) 
					RESTCallResult = createObjects(xmlResult);
				else
					RESTCallResult = createObject(xmlResult);
			}
			
			dispatchEvent(ResultEvent.createEvent(RESTCallResult));

		}
		
		private function failureRESTResult(event:FaultEvent) {
			Alert.show("REST call failed:\n" + event.toString());
		}

		private function createObjects(xml) {
			var listToReturn = new ArrayCollection();
		    var railsName = xml[0].name().toString();
		    if ("nil-classes" == railsName)
		    	return listToReturn;
		    	
			var classBaseName = StringHelper.removePlural(railsName);
			classBaseName = FlexIntrospectionHelper.generateValidClassName(classBaseName);
			var ClassReference = getDefinitionByName(modelPackageName + "::" + classBaseName) as Class;
			
			for each (var item in xml.children()) {						
				listToReturn.addItem(createObject(item));
			}
			
			return listToReturn;
		}
		
		private function createObject(xml) {
			var basicClassName = FlexIntrospectionHelper.generateValidClassName(xml.name().toString());
			var ClassReference = getDefinitionByName(modelPackageName + "::" + basicClassName) as Class;
			var objectToReturn = new ClassReference();
			for each (var property in xml.elements()) {
				if ("array" == property.@type.toString())
					propertyValue = createObjects(property);
				else
					propertyValue = property.valueOf().toString();
					
				var propertyName = FlexIntrospectionHelper.generateValidPropertyName(property.name().toString());
				objectToReturn[propertyName] = propertyValue;
			}
			
			return objectToReturn;
		}
		
		private function removeAllParamFromArgs(args:Array) {
			return args.slice(1,args.length);
		}
		
		private function initializeResourceName() {
			var classInfo = describeType(this);
			var regularExpression:RegExp = new RegExp("^.*?::(.*)$")
			var baseTypeName = classInfo.@name.toString().match(regularExpression)[1]
			return StringHelper.addPlural(baseTypeName).toLowerCase();
		}
	}
}