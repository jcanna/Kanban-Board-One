function findObject(objId) {
	if (document.getElementById)
		return document.getElementById(objId);

	if (document.all)
		return document.all[objId];
}

function isEclipse() {
	return (window.name == "ContentViewFrame") || (parent.name == "ContentViewFrame") || (parent.parent.name == "ContentViewFrame");;
}

function configPage() {
	if (isEclipse()) {
		findObject("titleTable").style.display = "none";
		for (i = 1; i < 11; i++) {
			cell = findObject("navigationCell" + i);
			if (cell == null)
				break;
			else
				cell.style.display = "";
			
			cell = findObject("noFramesLink" + i);
			if (cell != null) {
				if (window.name == "ContentViewFrame")
					cell.style.display = "none";
				else
					cell.style.display = "";
			}
			cell2 = findObject("framesLink" + i);
			if (cell2 != null) {
				if (window.name == "ContentViewFrame")
					cell2.style.display = "";
				else
					cell2.style.display = "none";
			}
		}
	}
	else if (window == top) { // no frames
		findObject("titleTable").style.display = "";
		for (i = 1; i < 11; i++) {
			cell = findObject("navigationCell" + i);
			if (cell == null)
				break;
			else
				cell.style.display = "";
		}
	}
	else { // frames
		findObject("titleTable").style.display = "none";
		for (i = 1; i < 11; i++) {
			cell = findObject("navigationCell" + i);
			if (cell == null)
				break;
			else
				cell.style.display = "none";
		}
	}
	showTitle(asdocTitle);
}

function loadFrames(classFrameURL, classListFrameURL) {
	var classListFrame = findObject("classListFrame");
	if(classListFrame != null && classListFrameContent!='')
		classListFrame.document.location.href=classListFrameContent;
 
	if (isEclipse()) {
		var contentViewFrame = findObject("contentViewFrame");
		if (contentViewFrame != null && classFrameURL != '')
			contentViewFrame.document.location.href=classFrameURL;
	}
	else {
		var classFrame = findObject("classFrame");
		if(classFrame != null && classFrameContent!='')
			classFrame.document.location.href=classFrameContent;
	}
}

function showTitle(title) {
	if (!isEclipse())
		top.document.title = title;
}

function loadClassListFrame(classListFrameURL) {
	if (parent.frames["classListFrame"] != null) {
		parent.frames["classListFrame"].location = classListFrameURL;
	}
	else if (parent.frames["packageFrame"] != null) {
		if (parent.frames["packageFrame"].frames["classListFrame"] != null) {
			parent.frames["packageFrame"].frames["classListFrame"].location = classListFrameURL;
		}
	}
}

function gotoLiveDocs(primaryURL, secondaryURL) {
	var urlBase = "http://livedocs.macromedia.com/labs/1/flex/langref/";
	var url = urlBase + "index.html?" + primaryURL;
	if (secondaryURL != null && secondaryURL != "")
		url += ("&" + secondaryURL);
	window.open(url, "mm_livedocs", "menubar=1,toolbar=1,status=1,scrollbars=1");
}