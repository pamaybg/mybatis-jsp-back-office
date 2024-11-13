<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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

<!-- <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css"> -->

<script type="text/javascript">
var callId = '<%=cleanXss(request.getParameter("callId")) %>';
var callDate = '<%=cleanXss(request.getParameter("callDate")) %>';
var ctiRecordUrl = null;

var recordFileListModal = null;
var groupId;
var pic = [];
var pic2 = [];
var callType = null;
var callIdFlag = null;

//callType == "NEX"일 때, NEXUS DB에 있는 녹취파일 리스트 조회
function recordFileListModalInitForNexus(){
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		onSelectRow : function(data) {
			pic = [];
			pic = data;
		},
		serializeGridData : function(data){
			data.callId = callId;
			data.callDate = callDate;
			data.callType = callType;
		},

        url : '<ifvm:action name="getRecordFileListForNexus"/>',
        colNames:[
					'<spring:message code="V00152" />', /* 구분 */
					'<spring:message code="V00153" />', /* 유형 */
					'<spring:message code="V00154" />', /* 발신/수신 */
					'<spring:message code="V00155" />', /* 녹취일시 */
					'<spring:message code="V00156" />', /* 총시간 */
					'<spring:message code="V00157" />', /* 듣기 */
					'callId',
					'idx',
					'filePath',
					'fileName',
					'onwer',
					'callerExt',
                   ],
        colModel:[
					{ name:'nexDiv', 		index:'', 					resizable : false,		width:'60px', 		align:'center',	 	formatter:nexusDivFormatter },
					{ name:'nexType', 		index:'', 					resizable : false, 		width:'60px', 		align:'center',	 	formatter:nexusTypeFormatter  },
					{ name:'nexInout', 		index:'', 					resizable : false, 		width:'60px', 		align:'center',	 	formatter:nexusInOutFormatter  },
					{ name:'insertTime', 	index:'insert_time', 		resizable : false, 		width:'130px', 		align:'cennter' ,		formatter:dateFormatter },
					{ name:'callTime', 		index:"timediff(str_to_date(endtime,'%Y%m%d %H%i%s'),str_to_date(starttime,'%Y%m%d %H%i%s'))", 			resizable : false, 		width:'100px', 		align:'center'  },
					{ name:'', 				index:"", 					resizable : false, 		width:'60px', 		align:'center',		formatter:nexusPlayFormatter  },
					{ name:'callId', 		index:'callcenterseq', 		hidden : true, 			searchable : false},
					{ name:'idx', 			index:'idx', 				hidden : true, 			searchable : false},
					{ name:'filePath', 		index:'path', 				hidden : true, 			searchable : false},
					{ name:'fileName', 		index:'filename', 			hidden : true, 			searchable : false},
					{ name:'onwer', 		index:'owner', 				hidden : true, 			searchable : false},
					{ name:'callerExt', 	index:'caller_ext', 		hidden : true, 			searchable : false},
        ],
        sortname: 'insert_time',
        sortorder: "desc",
        radio: true,
    };
	recordFileListModal = $("#recordFileListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};

//callType == "CCA"일 때, voc.qualitycontrol에 있는 녹취파일 리스트 조회
function recordFileListModalInitForCCA(){
	$.ifvSyncPostJSON('<ifvm:action name="getRecordFileListForCCA"/>',{
		callId : rowData.callId
	},function(result) {
		var strLink = "http://"+result.hostName;
		var fileName = result.fileName;
		var src = null;

		if(fileName.indexOf("IVR") > -1){
			strLink = strLink + "/ivr/";
		}else{
			strLink = strLink + "/data/";
		}

		src = strLink + fileName;

		playRecord(result.interactionId, fileName, src);
	});
};

//녹취파일 듣기 팝업 닫기
function playRecordFilePopClose() {
	$('#popAudioPlayer').empty();
	playRecordFilePop._destroy();
}

//unixtime to datetime formatter
function dateFormatter(cellvalue, options, rowObjec){
    var date = rowObjec.insertTime;
    var dateFormat = "";

    if(date != null){
    	var temp = new Date(date * 1000);
    	dateFormat = temp.format("yyyy-mm-dd HH:MM:ss");
    }

    return dateFormat;
}

//NEXUS 구분 formatter
function nexusDivFormatter(cellvalue, options, rowObjec){
    var data = rowObjec.owner;
    var rtnValue = null;

    switch(data){
    	case '1':
    		rtnValue = '<spring:message code="V00206"/>'; //전수
    		break;
    	case '2':
    		rtnValue = '<spring:message code="V00206"/>'; //전수
    		break;
    	case '3':
    		rtnValue = '<spring:message code="V00207"/>'; //부분
    		break;
    	case '4':
    		rtnValue = '<spring:message code="V00207"/>'; //부분
    		break;
    	case '9':
    		rtnValue = '<spring:message code="V00208"/>'; //이름
    		break;
    	default:
    		rtnValue = "";
    }

    return rtnValue;
}

//NEXUS 유형 formatter
function nexusTypeFormatter(cellvalue, options, rowObjec){
    var data = rowObjec.callerExt;
    var rtnValue = null;

    switch(data){
    	case '01':
    		rtnValue = '<spring:message code="V00209"/>'; //현대카드
    		break;
    	case '02':
    		rtnValue = '<spring:message code="V00210"/>'; //에듀카
    		break;
    	default:
    		rtnValue = '<spring:message code="V00211"/>'; //일반
    }

    return rtnValue;
}

//NEXUS 발신수신 formatter
function nexusInOutFormatter(cellvalue, options, rowObjec){
    var data = rowObjec.owner;
    var rtnValue = null;

    switch(data){
    	case '1':
    		rtnValue = '<spring:message code="V00212"/>'; //발신
    		break;
    	case '2':
    		rtnValue = '<spring:message code="V00213"/>'; //수신
    		break;
    	case '3':
    		rtnValue = '<spring:message code="V00212"/>'; //발신
    		break;
    	case '4':
    		rtnValue = '<spring:message code="V00213"/>'; //수신
    		break;
    	case '9':
    		rtnValue = '<spring:message code="V00213"/>'; //수신
    		break;
    	default:
    		rtnValue = "";
    }

    return rtnValue;
}

//NEXUS 녹취파일 듣기 formatter
function nexusPlayFormatter(cellvalue, options, rowObjec){
	var unixtime = null;
	var fullDate = null;
	var src = null;
	
	unixtime = rowObjec.insertTime;
	
	if(unixtime != ""){
    	var temp = new Date(unixtime * 1000)
    	fullDate = temp.format("yyyymmdd");
    }
	
    src = ctiRecordUrl+fullDate+"/"+rowObjec.fileName;
    var tag = '<a href ="javascript:void(0);" onclick="playRecord(\''+rowObjec.callId+'\', \''+rowObjec.fileName+'\', \''+src+'\')"><i class="icon-append fa fa-play-circle magnify"></i></a>';
    
    return tag;
} 

//녹취파일 듣기
function playRecord(callId, fileName, filePath){
	$("#modal_callId").val(callId);
	$("#modal_fileName").val(fileName);

	var fileFormat = fileName.indexOf(".mp3");

	if(fileFormat > -1){
		var element = $('#modal_recordFile');
		element.attr("type", "audio/mp3");
		element.find('[name="src"]').attr('value', filePath);
		element.attr("data", filePath);
		var newHtml = $('#popAudioPlayer').html();
		$('#popAudioPlayer').empty().html(newHtml);
	}else{
		var element = $('#modal_recordFile');
// 		element.find('[name="src"]').attr('value', "http://10.254.149.5:8000/REC/20171229/165_1005_1005_01088336434_1.wav");
		element.attr("type", "audio/x-wav");
		element.find('[name="src"]').attr('value', filePath);
// 		element.attr("data", "http://10.254.149.5:8000/REC/20171229/165_1005_1005_01088336434_1.wav");
		element.attr("data", filePath);
		var newHtml = $('#popAudioPlayer').html();
		$('#popAudioPlayer').empty().html(newHtml);
	}
}

function playRecordPopInit(){
	var anchorDate = new Date("01/23/2014");
	var comparisonDate = new Date(callDate.split(' ')[0]);

	if( comparisonDate >= anchorDate ){
		callType = "NEX";
		checkCallId();
	}else{
		callType = "CCA";
		recordFileListModalInitForCCA();
	}

}

//CTI NEXUS 녹취청취 URL 정보 가져오기
function getCtiRecordUrl(){
	$.ifvSyncPostJSON('<ifvm:action name="getCtiRecordUrl"/>',{
		callIdFlag : callIdFlag
	},function(result) {
		if(result.message != ""){
			ctiRecordUrl = result.message;
		}else{
			alert('<spring:message code="V00215" />');//CTI NEXUS URL 정보 호출에 실패하였습니다.
		}
	});
}

//callType 이 NEXUS 인 경우, callId 에 PBX callId(영문자가 들어간 callId)인지 체크
function checkCallId(){
	var regexp = /[a-zA-Z]/;
	
	if(regexp.test(callId)){
		//PBX callId 인 경우,
		callIdFlag = "0";
		getCtiRecordUrl();
		pbxRecordFileListForNexus();
	}else{
		//일반 callId 인 경우
		callIdFlag = "1";
		getCtiRecordUrl();
		recordFileListModalInitForNexus();
	}
}

//PBX callId 인 경우,
function pbxRecordFileListForNexus(){
	var jqGridOption = {
			onSelectCell : function (data) {
			},
			onSelectRow : function(data) {
				pic2 = [];
				pic2 = data;
			},
			serializeGridData : function(data){
				data.callId = callId;
			},

	        url : '<ifvm:action name="getPbxRecordFileListForNexus"/>',
	        colNames:[
						'<spring:message code="V00152" />', /* 구분 */
						'<spring:message code="V00153" />', /* 유형 */
						'<spring:message code="V00154" />', /* 발신/수신 */
						'<spring:message code="V00155" />', /* 녹취일시 */
						'<spring:message code="V00156" />', /* 총시간 */
						'<spring:message code="V00157" />', /* 듣기 */
						'callId',
						'idx',
						'fileName',
						'owner',
	                   ],
	        colModel:[
						{ name:'nexDiv', 		index:'', 					resizable : false,		width:'60px', 		align:'center',	 	formatter:nexusDivFormatter },
						{ name:'nexType', 		index:'', 					resizable : false, 		width:'60px', 		align:'center',	 	formatter:nexusTypeFormatter  },
						{ name:'nexInout', 		index:'', 					resizable : false, 		width:'60px', 		align:'center',	 	formatter:nexusInOutFormatter  },
						{ name:'insertTime', 	index:'update_time', 		resizable : false, 		width:'130px', 		align:'cennter' ,	formatter:dateFormatter },
						{ name:'callTime', 		index:"", 					resizable : false, 		width:'100px', 		align:'center'  },
						{ name:'', 				index:"", 					resizable : false, 		width:'60px', 		align:'center',		formatter:pbxNexusPlayFormatter  },
						{ name:'callId', 		index:'call_id', 			hidden : true, 			searchable : false},
						{ name:'idx', 			index:'idx', 				hidden : true, 			searchable : false},
						{ name:'fileName', 		index:'record_file', 		hidden : true, 			searchable : false},
						{ name:'owner', 		index:'', 					hidden : true, 			searchable : false},
	        ],
	        sortname: 'update_time',
	        sortorder: "desc",
	        radio: true,
	    };
		recordFileListModal = $("#recordFileListGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

//NEXUS 녹취파일 듣기 formatter
function pbxNexusPlayFormatter(cellvalue, options, rowObjec){
	var src = null;
	
    src = ctiRecordUrl+rowObjec.fileName;
    
    var tag = '<a href ="javascript:void(0);" onclick="pbxPlayRecord(\''+rowObjec.callId+'\', \''+rowObjec.fileName+'\', \''+src+'\')"><i class="icon-append fa fa-play-circle magnify"></i></a>';
    
    return tag;
} 

//녹취파일 듣기
function pbxPlayRecord(callId, fileName, filePath){
	$("#modal_callId").val(callId);
	$("#modal_fileName").val(fileName);

	var fileFormat = fileName.indexOf(".mp3");

	if(fileFormat > -1){
		var element = $('#modal_recordFile');
		element.attr("type", "audio/mp3");
		element.find('[name="src"]').attr('value', filePath);
		element.attr("data", filePath);
		var newHtml = $('#popAudioPlayer').html();
		$('#popAudioPlayer').empty().html(newHtml);
	}else{
		var element = $('#modal_recordFile');
		element.attr("type", "audio/x-wav");
		element.find('[name="src"]').attr('value', filePath);
		element.attr("data", filePath);
		var newHtml = $('#popAudioPlayer').html();
		$('#popAudioPlayer').empty().html(newHtml);
	}
}

$(document).ready(function(){
	playRecordPopInit();
});

</script>

<style>
	.magnify{
		font-size : 19px
	}
</style>

<div class="row qt_border">
	<ifvm:inputNew type="text" id="modal_callId" label="V00029" labelClass="1" conClass="9" disabled="true" />
</div>
<div class="row qt_border">
	<ifvm:inputNew type="text" id="modal_fileName" label="L01626" labelClass="1" conClass="9" disabled="true" />
</div>
<!-- audio player for wav format -->
<div class="row qt_border" id="popAudioPlayer">
	<object id="modal_recordFile" type="" data="" width="560" height="100">
		<param name="src" value="">
		<param name="autoplay" value="false">
		<param name="autostart" value="false">
	</object>
</div>

<div class="row">
	<div id="recordFileListGridCon" class="con_size"></div>
</div>
<center>
	<div class="row qt_border">
		<ifvm:inputNew type="button" id="closeBtn" text="L00913" btnFunc="playRecordFilePopClose"/>
	</div>
</center>