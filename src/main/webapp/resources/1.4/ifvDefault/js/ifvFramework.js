
var frameworkUrl = "//img.yellomarket.co.kr/resources";
if( typeof frameworkReadyUrl != 'undefined' ){
	frameworkUrl = frameworkReadyUrl;
}else if( typeof frameworkUrlTest != 'undefined' ){
	frameworkUrl = "";
}
frameworkUrl += "/ifv-Framework/1.2/";

window.appServiceId;
window.country;
window.lang;

var myTag = document.body; 
var callFunction = individual_case( myTag ); 

function get_version_of_IE () { 
	 var word; 
	 var version = "N/A"; 
	 var agent = navigator.userAgent.toLowerCase(); 
	 var name = navigator.appName; 

	 // IE old version ( IE 10 or Lower ) 
	 if ( name == "Microsoft Internet Explorer" ) word = "msie "; 
	 else { 
		 // IE 11 
		 if ( agent.search("trident") > -1 ) word = "trident/.*rv:"; 

		 // IE 12  ( Microsoft Edge ) 
		 else if ( agent.search("edge/") > -1 ) word = "edge/"; 
	 } 

	 var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" ); 
	 if (  reg.exec( agent ) != null  ) version = RegExp.$1 + RegExp.$2; 
	 return version; 
} 

function individual_case ( tag ) { 
	 var verNum = parseInt ( get_version_of_IE() ); 

	 if ( isNaN(verNum) || verNum >= 9 ){
		 document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery-2.1.4.min.js' type='text/javascript'></script>");
		 //jquery 1.9부터 삭제된 기능으로 인해 jquery-migrate-1.2.1.js 추가
		 document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery-migrate-1.2.1.js' type='text/javascript'></script>");
	 } else {
		 document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery-1.8.3.js' type='text/javascript'></script>");
	 }
} 

document.write("<link href='"+ frameworkUrl + "ifvDefault/css/ifvDefault.min.css' rel='stylesheet' type='text/css'>");

document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery.tmpl.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery.json-2.3.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery-ui.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery.watermark.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvGrid/js/i18n/grid.locale-kr.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvGrid/js/jquery.jqGrid.src.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvGrid/js/jquery.jqJSONPGrid.src.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvCommon/js/jquery-ui-i18n.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvCommon/js/bootstrap-timepicker.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvFileUploader/js/jquery.iframe-transport.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvFileUploader/js/jquery.fileupload.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvFileUploader/js/jquery.fileupload-ui.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvFileUploader/js/jquery.fileupload-fp.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvFileUploader/js/jquery.multiFilestyle.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvFileUploader/js/jQueryRotate.2.2.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvExcelReader/js/xlsx.core.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvExcelReader/js/cpexcel.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvExcelReader/js/ods.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvExcelReader/js/shim.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvExcelReader/js/jszip.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "ifvExcelReader/js/xlsx.js' type='text/javascript'></script>");

document.write("<script src='"+ frameworkUrl + "ifvDefault/js/ifvDefault.min.js' type='text/javascript'></script>");

/* syncfusion 선언부 - css */
document.write("<link href='"+ frameworkUrl + "syncfusion/themes/ej.widgets.core.min.css' rel='stylesheet' type='text/css'>");
document.write("<link href='"+ frameworkUrl + "syncfusion/themes/default-theme/ej.theme.min.css' rel='stylesheet' type='text/css'>");
document.write("<link href='"+ frameworkUrl + "syncfusion/themes/default.css' rel='stylesheet' type='text/css'>");
document.write("<link href='"+ frameworkUrl + "syncfusion/themes/default-responsive.css' rel='stylesheet' type='text/css'>");

document.write("<script src='"+ frameworkUrl + "syncfusion/scripts/knockout.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "syncfusion/scripts/jquery.globalize.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "syncfusion/scripts/jsrender.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "syncfusion/scripts/jquery.easing.1.3.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "syncfusion/scripts/ej.web.all.min.js' type='text/javascript'></script>");
document.write("<script src='"+ frameworkUrl + "syncfusion/scripts/properties.js' type='text/javascript'></script>");