<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.icignal.common.util.BeansUtil" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02700"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="cleanMask"  text="L01530" objCode="clubMbrListCleanMask_OBJ"/>
        <ifvm:inputNew type="button" id="joinMbr"  text="D10027" objCode="clubMbrListJoinMbr_OBJ"/>
        <ifvm:inputNew type="button" id="apprMbr"  text="M00748" objCode="clubMbrListApprMbr_OBJ"/>
        <ifvm:inputNew type="button" id="rejectMbr"  text="M00977" objCode="clubMbrListRejectMbr_OBJ"/>
        <ifvm:inputNew type="button" id="leaveClub"  text="D10020" objCode="clubMbrListLeaveClub_OBJ"/>
	</div>
</div>
<div class="row">
	<div class = "col-xs-9 control_content">
		<label class="col-xs-1 control-label" style="text-align: left; width: 60px;"><spring:message code="L02709"/></label>
		<label class="col-xs-1 control-label"><spring:message code="L02705"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" nuc="true"/> 
		</div>
		<div class="col-xs-4 control_content">
			<ifvm:inputNew type="button" id="searchBtn"  text="M00096" objCode=""/>
		</div>
	</div>
</div>
<div id="clubMbrListGrid"></div>
<div id="clubMbrDetilPopupContainer" class="popup_container"></div>
<div id="reasonRgstPopupContainer" class="popup_container"></div>
<div id="ImgViewPop" class="popup_container"></div>

<script type="text/x-jsrender" id="fileImgTemplate">
   <button value="{{:clubMbrDir}}{{:fileLName}}" style="cursor:pointer; color: black; border: hidden; background-color: white;"  onclick="showImg(this);">{{:fileName}}</button>
</script>

<script type="text/javascript">
var clubMbrList;
var clubMbrRid;
var statType = "";
var realStatCd = null;
var check = null;

function getClubMbrList(startDt, endDt){
	var ejGridOption ={
			recordDoubleClick : function(args){
				var data = args.data;
				clubMbrRid = args.data.rid;
				realStatCd = args.data.statCd;
				getClubMbrDetailPop(clubMbrRid);
			},serializeGridData : function(data) {
				data.rid = clubRid;  
				data.startDt = startDt;
				data.endDt = endDt;
				return data;
			},rowSelected : function (args) {
				var data = args.data;
				clubMbrRid = data.rid;
        	},
			dataUrl : '<ifvm:action name="getClubMbrList"/>',
			columns : [
				 { 
					 type : "checkbox", width : 60
				}, {
					field : 'mbrNo', headerText : '<spring:message code="M02696"/>',  textAlign : 'center', customAttributes : {searchable : true}
				},{
					field : 'custNm', headerText : '<spring:message code="M02697"/>',  textAlign : 'center', customAttributes : {searchable : true}
				},	{
					field : 'hhp', headerText : '<spring:message code="V00107"/>',  textAlign : 'center', customAttributes : {searchable : true}
				},{
					field : 'statCdNm', headerText : '<spring:message code="V00260"/>',  textAlign : 'center', customAttributes : {index : 'statCd'}
				},{
					field : 'fileName', headerText : '<spring:message code="L02704"/>',  textAlign : 'center', template: "#fileImgTemplate", customAttributes : {searchable : true}
				},	{
					field : 'createDate', headerText : '<spring:message code="L02705"/>',  textAlign : 'center'
				},	 {
					field : 'validStartDate', headerText : '<spring:message code="L02326"/>',  textAlign : 'center'
				},{
					field : 'validEndDate', headerText : '<spring:message code="L02327"/>',  textAlign : 'center'
				},{
					field : 'modifyBy', headerText : '<spring:message code="D10097"/>',  textAlign : 'center'
				},{
					field : 'processDate', headerText : '<spring:message code="L02706"/>',  textAlign : 'center'
				},{
					field : 'clubMbrDir', headerText : 'clubMbrDir', visible : false,
				},{
					field : 'fileLName', headerText : 'fileLName', visible : false,
				}, {
					field : 'rid', headerText : 'rid', visible : false,
				}],
				requestGridData : {
					sidx : 'createDate',
					sord : 'asc',
				},
				rowList : [10, 25, 50, 100],
				radio : false,
				tempId : 'ifvGridSimplePageTemplete'
	};
	
	clubMbrList = $("#clubMbrListGrid").ifvsfGrid({ejGridOption : ejGridOption});
}

function getClubMbrDetailPop(clubMbrRid){
	$("#clubMbrDetilPopupContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="clubMbrDetailPop"/>'+ '?clubMbrRid=' + clubMbrRid,
		contentType: "ajax",
        title: '<spring:message code="L02710"/>',
        width: 900,
        close : 'clubMbrDetailPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }		
	});
}

function clubMbrDetailPopupClose() {
	clubMbrDetilPopupContainer._destroy();
} 


//마스크해제
function clubMbrClearMask() {
	var v_rid;
	var checkedList = clubMbrList.opt.gridControl.getSelectedRecords();
	if(checkedList.length == 0){
		alert('<spring:message code="I02051"/>');
	}else if(checkedList.length > 1){
		alert('<spring:message code="I02120"/>');
	}else {
		if ($.fn.ifvmIsNotEmpty(checkedList)) {
			v_rid = checkedList[0].rid;
		}
		if ($.fn.ifvmIsNotEmpty(v_rid)) {
	      $.ifvSyncPostJSON('<ifvm:action name="clearMaskClubMbr"/>', {
	    	  clubMbrRid : v_rid
	      },
	      function(result) {
	      	var gridObj = clubMbrList.opt.gridControl;
	      	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unCustNm);
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unHhp);
	      });
		}
	}
}


//승인
function apprClubMbr() {
	check = true;
	var appr_rid = [];
	var checkedList = clubMbrList.opt.gridControl.getSelectedRecords();
	if (checkedList.length == 0) {
		alert('<spring:message code="D10287"/>');
	}else{
		for(var i = 0; i < checkedList.length; i++){
			if(checkedList[i].statCd == 'C' || checkedList[i].statCd == 'W'){
				check = false;
			}else{
				appr_rid.push(checkedList[i].rid);
			}
		}
	}
	if(check) {
		if(appr_rid.length > 0){
		    $.ifvSyncPostJSON('<ifvm:action name="apprClubMbr"/>', {
		        rid : clubRid,
		    	ridList : appr_rid
		    }, function(result) {
		    	alert('<spring:message code="I02121"/>');
		    	getClubMbrList();
		    });
		}else{
			alert('<spring:message code="D10287"/>');
		}
	}else{
		alert('<spring:message code="L02743"/>');
	}
} 

//반려, 탈퇴 사유 등록 팝업 reasonRgstPop
function getReasonRgstPop(statType){
	check = true;
	var statNm = "";
	var checkedList = clubMbrList.opt.gridControl.getSelectedRecords();
	
	if (checkedList.length == 0) {
		alert('<spring:message code="D10287"/>');
	}else{
		for(var i = 0; i < checkedList.length; i++){
			if(checkedList[i].statCd != "A" && checkedList[i].statCd != "R"){
				if(checkedList[i].statCd != statType){
					check = false;
					statNm = checkedList[i].statCdNm;
					alert(statNm + '<spring:message code="L02742"/>');
					return;
				}
			} 
		}
		if(check){
			$("#reasonRgstPopupContainer").ifvsfPopup({
				enableModal : true,
				enableResize: false,
				contentUrl: '<ifvm:url name="reasonRgstPop"/>'+ '?statType=' + statType,
				contentType: "ajax",
		        title: '<spring:message code="L02741"/>',
		        width: 900,
		        close : 'reasonRgstPopupClose',
		    	open : function(){
		    		new ifvm.PopupCenter({
		        		popupDivId : 'popupContainer'
		        	});
		        }		
			});
		}
	}
}

function reasonRgstPopupClose() {
	reasonRgstPopupContainer._destroy();
}

//이미지 보기 팝업 Open
function showImg(data){
	var path;
    if ($.fn.ifvmIsNotEmpty(data.innerText)) {
    	// path = "/"+파일 디렉토리 경로+"/"+ {{:fileLName}}
    	path = "/"+data.value;
    	$("#ImgViewPop").ifvsfPopup({
    	      enableModal : true,
    	      enableResize: false,
    	      contentUrl: '<ifvm:url name="showImgPop"/>?path=' + encodeURI(path),
    	      contentType: "ajax",
    	      title: '<spring:message code="L02541"/>',
    	      width: '900px',
    	      close : 'imgViewPopupClose'
    	});
    }else {
    	alert('<spring:message code="L02586"/>');
    }
}

//이미지 보기 팝업 Close
function imgViewPopupClose() {
	ImgViewPop._destroy();
}


function setCalendar() {
	 var startDate = $('#startDt');
	 var endDate = $('#endDt');
	 //오늘날짜
	 startDate.val($.ifvGetTodayDate());
	 //오늘부터 한달 뒤
	 //endDate.val($.ifvGetNewDate('m', +1).newDateS);

	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
}
function searchDate(){
	var startDt = $('#startDt').val();
	var endDt = $('#endDt').val();
	if(startDt != "" && endDt != ""){
		getClubMbrList(startDt, endDt);
	}else{
		alert('<spring:message code="L01859"/>');
	}
}

//(접수 : R), (반려 : C), (탈퇴 : W), (승인 : A)
$(document).ready(function(){
	
	getClubMbrList();
	setCalendar();
	
	$("#cleanMask").click(function(){
		clubMbrClearMask();
	});
	$("#joinMbr").click(function(){
		if(clubRid == 'undefined' || clubRid == null){
			alert('<spring:message code="C00171"/>');
		}else{
			clubMbrRid = null;
			getClubMbrDetailPop();
		}
	});
	$("#apprMbr").click(function(){
		apprClubMbr();
	});
	$("#rejectMbr").click(function(){
		statType = 'C';
		getReasonRgstPop(statType);
	});
	$("#leaveClub").click(function(){
		statType = 'W';
		getReasonRgstPop(statType);
	});
	$("#searchBtn").click(function(){
		searchDate();
	});
	
	//Syncfusion과 협의후 추후 개발 
/* 	$(".e-checkselectall").on('click',function(){
		if($(".e-checkselectall").prop("checked")) {
			console.log(1)
			$("#clubMbrListGrid input[type='checkbox']").attr("checked",true);
		} 
		else {
			console.log(2)
			$("#clubMbrListGrid input[type='checkbox']").attr("checked",false);
		}
	});
 */
});

window.onload = function(){
	$("#clubMbrListGrid .grid_con .e-gridcontent .e-table tbody tr").click(function(){
		var tr = $(this);
		var td = tr.children();
		var div = td.children();
		var input = div.children();
		input.trigger('click');
	});
}
</script>