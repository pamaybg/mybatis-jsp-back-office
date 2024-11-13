<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
        </div>
        <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="stmpInfoPopBtn" text="스탬프정보 " nuc="true" btnFunc="mbrStmpObj.openStmpInfoPop"/>
			<ifvm:inputNew type="button" id="stmpHistPopBtn" text="스탬프이력" nuc="true" btnFunc="mbrStmpObj.openStmpHistPop"/>
			<ifvm:inputNew type="button" id="stmpTxnHistPopBtn" text="거래내역" nuc="true" btnFunc="mbrStmpObj.openStmpTxnHistPop"/>
			<ifvm:inputNew type="button" id="stmpBnftHistPopBtn" text="혜택이력" nuc="true" btnFunc="mbrStmpObj.openStmpBnftHistPop"/>
        </div>
    </div>
    <div id="mbrStmpHistListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stmpInfoPop" class="popup_container"></div>
<div id="stmpHistPop" class="popup_container"></div>
<div id="stmpTxnHistPop" class="popup_container"></div>
<div id="stmpBnftHistPop" class="popup_container"></div>

<script type="text/javascript">

var mbrStmpHistList;

var mbrStmpObj = {
	//스탬프 이력 그리드
	initMbrStmpHistList : function(data) {
		var ejGridOption = {
	       	serializeGridData : function(data) {
	       	 	data.ridMbr = gMbrDetail.data.rid;
	         	return data;
	       	},
	        dataUrl : '<ifvm:action name="getMbrStmpHistList"/>',
	        columns:[
	        		{
	         		  field : 'stmpNo', headerText : '스탬프번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	         		  customAttributes : {
	         			  index : 'stmpNo' }
	         	  },{
	         		  field : 'stmpNm', headerText : '스탬프명', headerTextAlign : 'center', textAlign : 'left', width : '300px',
	         		  customAttributes : {
	         			  index : 'stmpNm' }
	         	  },{
	         		  field : 'regDt', headerText : '참여일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'regDt' }
	         	  },{
	         		  field : 'stmpLastAcrlDt', headerText : '최근이용일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'stmpLastAcrlDt' }
	         	  },{
	         		  field : 'stmpItemNo', headerText : '스탬프수', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
	         		  customAttributes : {
	         			  index : 'stmpItemNo' }
	         	  },{
	         		  field : 'stmpBnftAmt', headerText : '혜택금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
	         		  customAttributes : {
	         			  index : 'stmpBnftAmt' }
	         	  },{
	         		  field : 'stmpMbrStatus', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width : '70px',
	         		  customAttributes : {
	         			  index : 'stmpMbrStatus' }
	         	  },{
	         		  field : 'purAmt', headerText : '누적금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
	         		  customAttributes : {
	         			  index : 'purAmt' }
	         	  },{
	         		  field : 'purCnt', headerText : '구매횟수', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
	         		  customAttributes : {
	         			  index : 'purCnt' }
	         	  },{
	         		  field : 'ridStmp', headerText : 'ridStmp', headerTextAlign : 'center', textAlign : 'center', visible: false,
	         		  customAttributes : {
	         			  index : 'ridStmp' }
	         	  },{
	         		  field : 'ridStmpMbr', headerText : 'ridStmpMbr', headerTextAlign : 'center', textAlign : 'center', visible: false,
	         		  customAttributes : {
	         			  index : 'ridStmpMbr' }
	         	  },{
	         		  field : 'ridStmpBnft', headerText : 'ridStmpBnft', headerTextAlign : 'center', textAlign : 'center', visible: false,
	         		  customAttributes : {
	         			  index : 'ridStmpBnft' }
	         	  },
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,
	        	 sidx : 't2.modifyDate',
	        	 sord : 'desc',
	        	 _search : false
			},
			radio : true
	    }

		mbrStmpHistList = $("#mbrStmpHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	},
	//스탬프정보 팝업
	openStmpInfoPop : function(data) {
		var _selectedRow = mbrStmpHistList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(_selectedRow)) {
			$("#stmpInfoPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="mbrStmpInfoPop"/>?ridStmp=' + _selectedRow.ridStmp,
		        contentType: "ajax",
		        title: '스탬프 정보',
		        width: 1200,
		    });
		} else {
			alert('<spring:message code="L00066"/>');
		}
	},
	//스탬프이력 팝업
	openStmpHistPop : function(data) {
		var _selectedRow = mbrStmpHistList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(_selectedRow)) {
			$("#stmpHistPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="mbrStmpHistPop"/>?ridStmpMbr=' + _selectedRow.ridStmpMbr,
		        contentType: "ajax",
		        title: '스탬프 이력',
		        width: 1200,
		    });
		} else {
			alert('<spring:message code="L00066"/>');
		}
	},
	//거래내역 팝업
	openStmpTxnHistPop : function(data) {
		var _selectedRow = mbrStmpHistList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(_selectedRow)) {
			$("#stmpTxnHistPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="mbrStmpTxnHistPop"/>?ridStmp=' + _selectedRow.ridStmp,
		        contentType: "ajax",
		        title: '스탬프 거래내역',
		        width: 1200,
		    });
		} else {
			alert('<spring:message code="L00066"/>');
		}
	},
	//혜택이력 팝업
	openStmpBnftHistPop : function(data) {
		var _selectedRow = mbrStmpHistList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(_selectedRow)) {
			$("#stmpBnftHistPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="mbrStmpBnftHistPop"/>?ridStmpMbr=' + _selectedRow.ridStmpMbr,
		        contentType: "ajax",
		        title: '스탬프 혜택',
		        width: 1200,
		    });
		} else {
			alert('<spring:message code="L00066"/>');
		}
	},
}

$(document).ready(function(){
	mbrStmpObj.initMbrStmpHistList();
	window.top.setParentIframeHeight();
});

</script>