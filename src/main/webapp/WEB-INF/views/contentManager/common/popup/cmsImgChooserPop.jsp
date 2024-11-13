<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<script>
var imgPath;
var imgName;
var localServ, ajaxSettings;
var obj;
var typeString = "*.JPG, *.PNG"; //채널 설정 값이 처리 안되어있을 경우 임시.
var sizeStore = []; 


function obj (){
    $("#fileExplorer").ejFileExplorer({
        isResponsive: true,
        gridSettings:{columns:[
          { field: "name", headerText: "Name", width: 0 },
          { field: "type", headerText: "Type", width: 95 },
          { field: "size", headerText: "Size", width: 90 }]
        }, 
        filterSettings: { 
            filterType: "startswith",
            },
        fileTypes: typeString,
        layout: "list",
        path : '<ifvm:url name="imageView"/>' + "/resources/UploadImages/CONTENT_MANAGER/",
        select: "onSelect",
        remove : "onRemove",
        //open : "oOpen",
        ajaxAction: localServ,
        ajaxSettings: ajaxSettings,
        allowMultiSelection: false,         
        toolsList : ["editing"],
        tools : {
            editing : ["Upload", "Delete", "Refresh"]
        },
        locale : "es-ES", 
        showFooter: false,
        showTreeview: false,
        showContextMenu: false
    });
    
    obj = $("#fileExplorer").data("ejFileExplorer");
}

ajaxSettings = {
    upload: { 
        url: "/contentManager/common/cmsUploadImage.do{0}"
    },
    download: {
        url: "http://mvc.syncfusion.com/OdataServices/fileExplorer/fileoperation/Download{0}"
    },
};
localServ = "/contentManager/common/getCmsImgList.do"

if (isRestrictCrossOrigin()) {                
    //IE8, IE9 browser restrict CORS, so we set ajax request as JSONP to enable CORS
    jsonpAjaxSettings = {
        read: {
            dataType: "jsonp"
        },
        createFolder: {
            dataType: "jsonp"
        },
        destroy: {
            dataType: "jsonp"
        },
        getDetais: {
            dataType: "jsonp"
        },
        paste: {
            dataType: "jsonp"
        },
        rename: {
            dataType: "jsonp"
        }
    };
    //we have called "PerformJSONPAction" method to handle JSONP AJAX requests
    localServ = "/contentManager/common/getCmsImgList.do"

    
    //appends jsonpAjaxSettings with ajaxSettings and result stored in ajaxSettings
    $.extend(true, ajaxSettings, jsonpAjaxSettings);
}

function isRestrictCrossOrigin () {
	
    browserInfo = ej.browserInfo();
    return (browserInfo.name == 'msie' && browserInfo.version <= 9) ? true : false;                
}
 
 function descSave(){
     if($('#fileid').val() != null){
         $.ifvSyncPostJSON('<ifvm:action name="editCmsImgDesc"/>', {
                id     : $('#fileid').val(),
                description : $("#description").val()
            }, function(result) {
                alert('<spring:message code="M00430"/>');
            });
         obj.refresh();
     }
 }
 
 function onRemove(args){
        $.ifvSyncPostJSON('<ifvm:action name="editImageFileDel"/>', {
            id     : args.selectedItems[0].id
        }, function(result) {
            
        });
        obj.refresh();
 }

function onSelect(args) {

    if(args.selectedItems[0] != null)
    {
        imgPath = args.model.path;
        imgName = args.name;
         
        filesize = args.selectedItems[0].size.split(" KB")
        date = args.selectedItems[0].dateModified.split(" ");
        $('#filedate').val(date[0]);
        $('#modifiers').val(args.selectedItems[0].memId);
        $('#filesize').val(filesize[0]);
        $('#fileid').val(args.selectedItems[0].id);
        $('#description').val(args.selectedItems[0].description);
    }
}

ej.FileExplorer.Locale["es-ES"] = {
    Search : '<spring:message code="M00799"/>',
    Searchbar : '<spring:message code="M00799"/>',
    ReplaceAlert : '<spring:message code="M00800"/>',
    Error : '<spring:message code="M00801"/>',  
    YesToAllButton: '<spring:message code="M00802"/>',
    NoToAllButton: '<spring:message code="M00803"/>',
    YesButton: '<spring:message code="M00804"/>',
    NoButton: '<spring:message code="M00805"/>'
};

ej.Uploadbox.Locale["es-ES"] = {
        buttonText: {
            upload: '<spring:message code="M00438"/>',
            browse: '<spring:message code="M00440"/>',
            close: '<spring:message code="M00441"/>',
            cancel: '<spring:message code="M00442"/>'
        },
        dialogText: {
            title: '<spring:message code="M00438"/>',
            name: '<spring:message code="M00443"/>',
            size: '<spring:message code="M00444"/>',
            status: '<spring:message code="M00445"/>'
        }
};

$(document).ready(function(){
    //언어별 file explorer 버튼 이미지 분기
    var head  = document.getElementsByTagName('head')[0];
    var link  = document.createElement('link');
    link.rel  = 'stylesheet';
    link.type = 'text/css';
    link.media = 'screen';
    
    if(window.lang == "ko") {
        link.href = '${pageContext.request.contextPath}/resources/css/marketing/fileEx_ko.css';
    } else {
        link.href = '${pageContext.request.contextPath}/resources/css/marketing/fileEx_en.css';
    }
    head.appendChild(link);

    
    $("#fileid").hide();
    
    $('#addImage').on('click', function(){
        
        var typeChk =typeString.replaceAll('*.',"");
        typeChk = typeChk.replaceAll(',',"");
        
        var typeChk2 = typeChk.split(" ");
        var Chkcount = 0;
        
        for(var i=0;i<typeChk2.length;i++){
            var name = imgName[0].split(".")[1].toUpperCase();
            
            if(typeChk2[i] == name){
                Chkcount++;
            }
        }
        
        if(Chkcount == 0){
            alert('<spring:message code="M00385"/>');
            return;
        }

        mergeCheck = false;
        var imgFullPath = imgPath + imgName;
        var nameStore = imgFullPath.split('.')
        
        var size = sizeStore.length
        var sizeCheck = true;
        
        //채널에 설정된 각 이미지 버전에 맞는 용량 비교.
        for(var i=0;i<size;i++){
            if(nameStore[1] == (sizeStore[i].name).toLowerCase()){
                
                if(($("#filesize").val() * 1) > sizeStore[i].maxVol ){
                    sizeCheck = false;
                }
            }
        }
        if(sizeCheck){
			var locaOrigin = location.origin;
			
			if(imageType != "THUMBNAIL_IMG") {
				imgFullPath = "<img src='"+ locaOrigin + imgFullPath + "' />";
				var rteObj = $("#htmlNewslatterArea").data("ejRTE");
				rteObj.executeCommand("inserthtml", imgFullPath);
	                
	            if((typeof(offerClick) != "undefined") && offerClick == false && $("#imgBarCnt").val() == 1){
	                $("#imgBarCnt").val(0);
	                barcodeImageSetting();
	            }
			} else {
				var thumbnailPath = locaOrigin + imgFullPath;
				$("#thumbnailView").attr("src", thumbnailPath);
				$("#thumbnailView").data("thumbnailPath", thumbnailPath);
			}
			
            imgChooserPopClose();
        }
        else{
            alert('<spring:message code="M00384"/>');
        }
    });
    
    $('.inner_btn').on('click',function(){
        descSave();
    })
    $('#fileExplorerClose').on('click', function() {
    	imgChooserPopClose();
    });
    
    obj ();
});
</script>

<style>
#fileExplorer{width:100% !important;}
#fileExplorer_splitter{width:100% !important;}
#fileExplorer_splitter .e-cont2{width:100% !important;}
</style>


<div class="">
    <div id="fileExplorer"></div>
    <div class="well form-horizontal well_sum fileexplorer_bg">
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code="M00810"/></label>
            <div class="col-xs-9">
                <ifvm:input type="text" id="description"/>
            </div>
            <div class="col-xs-1 text-right">
            <button class="inner_btn"><spring:message code="M00811"/></button>
            </div>
        </div>
        <div class="row">
            <label class="col-xs-2 control-label"><spring:message code="M00812"/></label>
            <div class="col-xs-1">
                <ifvm:input type="text" disabled="true" id="filesize"/>
                <ifvm:input type="text" disabled="true" id="fileid"/>
            </div>
            <div class="col-xs-1 fileexplorer_kbyte">
                <spring:message code="M00815"/>
            </div>
            <label class="col-xs-3 control-label"><spring:message code="M00813"/></label>   
            <div class="col-xs-2">
                <ifvm:input type="text" disabled="true" id="modifiers" />
            </div>
            <label class="col-xs-1 control-label"><spring:message code="M00814"/></label>
            <div class="col-xs-2">
                <ifvm:input type="text" disabled="true" id="filedate" />
            </div>
        </div>
        
    </div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="addImage">         
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00282"/>
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="fileExplorerClose">         
        <spring:message code="M00284"/>
    </button> 
</div>


