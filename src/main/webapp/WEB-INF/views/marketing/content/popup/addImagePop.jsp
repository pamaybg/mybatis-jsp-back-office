<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script>
var imgPath;
var imgName;
var obj;
var typeString = "*.JPG, *.PNG"; //채널 설정 값이 처리 안되어있을 경우 임시.
var conChanneltype = '<%= cleanXss(request.getParameter("type")) %>';
var sizeStore = []; 
var imgData = {};
var multiImagePage = false;

//채널에 설정된 이미지 설정 값 가져오기
function getImageUpType() {
    var j = 0;

    if (conid != "null") { //기존페이지 이미지 수정
        $.ifvSyncPostJSON('<ifvm:action name="getImageUpType"/>', {
            id : conid
        }, function(result) {
            var size = result.length;

            if (size == 0) {
                alert('<spring:message code="M00437"/>');
                return;
            }
            for (j = 0; j < size; j++) {
                if (typeString == null) {
                    typeString = "*." + result[j].name;
                }
                else {
                    typeString = typeString + ", *." + result[j].name;
                }

                sizeStore.push(result[j]);
            }
        });
    }
    else { //신규 페이지에서 이미지 생성
        $.ifvSyncPostJSON('<ifvm:action name="getNewImgUpType"/>', {
            
        }, function(result) {
            var size = result.length;

            if (size == 0) {
                check = false;
                alert('<spring:message code="M00437"/>');
                return;
            }
            for (j = 0; j < size; j++) {
                if (typeString == null) {
                    typeString = "*." + result[j].name;
                }
                else {
                    typeString = typeString + ", *." + result[j].name;
                }
            }
        });
    }
}

function obj(){
	//파일아이디 항목 숨김
	$("#fileid").hide();
	
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
	
	var ajaxSettings = {
	    upload: { 
	    	url: "/common/uploadImage.do"
	    },
	    download: {
	        url: "http://mvc.syncfusion.com/OdataServices/fileExplorer/fileoperation/Download{0}"
	    },
	};

	var localServ = "/common/getFile.do";

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
	    
	    //appends jsonpAjaxSettings with ajaxSettings and result stored in ajaxSettings
	    $.extend(true, ajaxSettings, jsonpAjaxSettings);
	}
	
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
        path : '<ifvm:url name="imageView"/>'+"/resources/UploadImages/CAMPAIGN/content/",
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

function isRestrictCrossOrigin () {
    browserInfo = ej.browserInfo();
    return (browserInfo.name == 'msie' && browserInfo.version <= 9) ? true : false;                
}
 
 function descSave(){
     if($('#fileid').val() != null){
         $.ifvSyncPostJSON('<ifvm:action name="eidtDescFile"/>', {
                id     : $('#fileid').val(),
                description : $("#description").val()
            }, function(result) {
                alert('<spring:message code="M00430"/>');
            });
         obj.refresh();
     }
 }
 
 function onRemove(args){
        $.ifvSyncPostJSON('<ifvm:action name="removeImage"/>', {
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
        imgId = args.selectedItems[0].id

        imgData.imgPath = imgPath;
        imgData.imgName = imgName;
        imgData.imgId = imgId;

        filesize = args.selectedItems[0].imgSize.split(" KB");
        date = args.selectedItems[0].dateModified.split(" ");
        $('#filedate').val(date[0]);
        $('#modifiers').val(args.selectedItems[0].memId);
        $('#filesize').val(filesize[0]);
        $('#fileid').val(args.selectedItems[0].id);
        $('#description').val(args.selectedItems[0].description);
    }
    
    $("#imgCnt").val(1);
}

//이미지 선택
function selectImage() {
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
    var _imgName = imgName + "";
    var nameStore = _imgName.split('.')
    
    //원본 가로세로 사이즈 구하기
    var imgOrigin = new Image();
    imgOrigin.src = $('li[role="tileitem"][aria-selected="true"]').find('img').attr('src');
    var widthOrigin = imgOrigin.width;
    var heightOrigin = imgOrigin.height;
    
    var size = sizeStore.length;
    var sizeCheck = true;
    var imgResolCheck = true;
    
    //채널에 설정된 각 이미지 버전에 맞는 용량 비교.
    for(var i=0;i<size;i++){
        if(nameStore[1] == (sizeStore[i].name).toLowerCase()){
            
            if(($("#filesize").val() * 1) > sizeStore[i].maxVol ){
                sizeCheck = false;
            }
            
            if(sizeStore[i].imgResolW < widthOrigin || sizeStore[i].imgResolH < heightOrigin) {
            	imgResolCheck = false;
            }
            
           	if(sizeStore[i].chnlTypeCd == 'KAKAO') {
           		//친구톡 가로사이즈 최소제한 (필수)
           		if(widthOrigin < 500) {
            		alert('<spring:message code="M02745"/>'); //친구톡 이미지의 가로사이즈는 최소 500px 이상이어야합니다.
            		return false;
           		} 
           		
           		//친구톡 비율 제한 (필수)
           		var _rate = heightOrigin/widthOrigin;
           		if(_rate < 0.5 || _rate > 1.5) {
            		alert('<spring:message code="M02746"/>'); //친구톡 이미지의 비울은 1:0.5 ~ 1:1.5 이내여야만 합니다.
            		return false;
           		}
           	}
        }
    }
    if(sizeCheck){
    	if(!imgResolCheck) { //권장 가로세로길이 초과시
    		var _imgResolW = sizeStore[0].imgResolW;
    		var _imgResolH = sizeStore[0].imgResolH;
    		
    		if(!confirm('<spring:message code="M02744" argumentSeparator=";" arguments="'+ _imgResolW + ';' + _imgResolH +'"/>')) { 
    			return false;
    		}
    	}
    	
        if(conChanneltype == "null"){
            if(multiImagePage == false){
                $("#mmsImage").attr('src', imgFullPath);
                $('.image_close').show();
            }
            imgData.imgFullPath = imgFullPath;
        }
        else{
        	var locaOrigin = location.origin;
            imgFullPath = "<img src='"+ locaOrigin + imgFullPath + "' />";
            var rteObj = $("#htmlContentsArea").data("ejRTE");
            rteObj.executeCommand("inserthtml", imgFullPath);
        }
        if((typeof(offerClick) != "undefined") && offerClick == false && $("#imgBarCnt").val() == 1){
            $("#imgBarCnt").val(0);
            barcodeImageSetting();
        }
        // 여러개의 이미지를 업로드 하는 경우 
        // 부모 팝업의 해당 메서드를 실행한다
        if (multiImagePage == true) {
            setMultiImageInfo();
        }
        mmsFormNewPopClose();
    }
    else{
        alert('<spring:message code="M00384"/>');
    }
}


$(document).ready(function(){
	//채널에 설정된 이미지 설정 값 가져오기
    getImageUpType();
    
    //이미지 등록 및 검색 팝업 설정
    obj();
    
    $('#addImage').on('click', function(){
    	//이미지 선택
		selectImage();        
    });
    
    $('.inner_btn').on('click',function(){
        descSave();
    })
    $('#fileExplorerClose').on('click', function() {
        mmsFormNewPopClose();
    });
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


