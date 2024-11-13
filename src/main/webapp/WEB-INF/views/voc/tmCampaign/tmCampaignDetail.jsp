<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
gTmCampaignDetail = {
	dateFieldId : ['camStartDd', 'camEndDd'],
	init  : function(){
		$.ifvGetCommCodeList('select', 'campaignStatus', '<ifvm:action name="getCommCodeList2"/>', 'MKT_CAM_STAT', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'campaignType', '<ifvm:action name="getCommCodeList2"/>', 'MKT_CAM_TYPE_CD', 'loy', false, false, true);
		$.ifvmLnbSetting('tmCamTgtList');
		this.loadData();

	},
	setDateField : function(){
		for(var pi = 0 ; pi < this.dateFieldId.length ; pi++){
			var _pval = $("#"+this.dateFieldId[pi]).val();
			var _aval="";
			if(_pval){
				_aval = _pval.split(' ')[0];
			}
			$("#tmCampaignDetailWrap #"+this.dateFieldId[pi]).val(_aval);
		}
	},
	loadData : function(){
		var action = '<ifvm:action name="getTmCampaignDetail"/>';
		$.ifvSyncPostJSON(action, {
			camRid: $.ifvGetParam('camRid')
		}, function(result) {

			if ($.fn.ifvmIsNotEmpty(result)) {
				$("#tmCampaignDetailWrap").dataSetting(result);
				gTmCampaignDetail.setDateField();
			}
		})
		tmCamTgtList = $("#tmTargetMemListGrid").ifvGrid({ jqGridOption : gTmCampaignDetail.jqGridOption });
	},
	clearMasking : function(){
		var checkedList = tmCamTgtList.getCheckedGridData();
		if(checkedList.length == 0){
			alert('<spring:message code="L01393" />');
			return;
		}
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
				{
			type : 'mbr',
			field : 'phone',
			rid : checkedList[0].ridMbr,
			target : 'hhpNo'
		},
        function(result) {

			var rowid = tmCamTgtList.getRadioSelectedRowId();
			tmCamTgtList.opt.grid.setCell(rowid , 'hhpNo' , result.message );

	     })
	},
	searchUnComplTm : function(){
		gTmCampaignDetail.jqGridOption.serializeGridData = function(data){
			data.camRid = $.ifvGetParam('camRid');
			data.tmStatus = 'N'
			return data;
		}
		tmCamTgtList = $("#tmTargetMemListGrid").ifvGrid({ jqGridOption : gTmCampaignDetail.jqGridOption });
	},
	searchComplTm : function(){
		gTmCampaignDetail.jqGridOption.serializeGridData = function(data){
			data.camRid = $.ifvGetParam('camRid');
			data.tmStatus = 'Y'
			return data;
		}
		tmCamTgtList = $("#tmTargetMemListGrid").ifvGrid({ jqGridOption : gTmCampaignDetail.jqGridOption });
	},
	jqGridOption : {
		ondblClickRow : function(data){
        },
        onSelectRow : function (data) {
        },
        ondblClickRow : function(rowNo){
        	var data = tmCamTgtList.getRowData()[rowNo-1];
	     	console.log(data);
	     	tmCamTgtDetailPopup.pop(data);
        },
       serializeGridData : function( data ){
    	   data.camRid = $.ifvGetParam('camRid')
	       return data;
        },
        loadComplete : function(obj){
        	console.log(obj);
        },
        url : '<ifvm:action name="getTmTargetMemList"/>',
        colNames:[
                   '<spring:message code="V00277" />',  /*회원번호 */
                   '<spring:message code="V00278" />',  /*회원명 */
                   '<spring:message code="V00279" />',  /*회원등급 */
                   '<spring:message code="V00280" />',  /*휴대전화번호 */
                   '<spring:message code="V00281" />',  /*TM 완료 여부*/
                   '<spring:message code="V00282" />',  /*통화 결과*/
                   '<spring:message code="V00283" />',  /*통화 내역*/
                   'ridMbr',
                   'rid'
                 ],
        colModel:[
             { name:'mbrNo',   		index:'ctt.MBR_NO',  		resizable : true, align:'center',   width:'140px'},
             { name:'custNm',   	index:'lc.CUST_NM',  		resizable : true, align:'center',  	width:'80px' },
             { name:'tierNm',   	index:'lt.TIER_NM',  		resizable : true, align:'center',  	width:'120px' },
             { name:'hhpNo',   		index:'lm.HHP_NO',  		resizable : true, align:'center',   width:'60px' },
             { name:'tmStatus',   	index:'ctt.TM_STATUS',  	resizable : true, align:'center',   width:'140px' },
             { name:'callStatus',   index:'ctt.CALL_STATUS',  	resizable : true, align:'center',   width:'80px' },
             { name:'callDesc',   	index:'ctt.CALL_DESC',  	resizable : true, align:'center',   width:'140px'},
             { name:'ridMbr',   	index:'lm.ridMbr',    hidden : true},
             { name:'rid',   		index:'ctt.rid',    hidden : true},
        ],
        sortname: 'ctt.create_date',
		autowidth : true ,
		sortorder: "desc",
		shrinkToFit: false,
		radio : true
    }
}

tmCamTgtDetailPopup = {
		id  : "tmCamTgtPop",
		url : '<ifvm:url name="tmCamTgtDetailPop"/>',
		pop : function(obj){
			this.url = '<ifvm:url name="tmCamTgtDetailPop"/>';
			if(obj != null){
				this.url += '?rid='+obj.rid;
			}
			$("#"+this.id).ifvsfPopup({
   	            enableModal : true,
   	            enableResize : false,
   	            contentUrl : this.url,
   	            contentType : "ajax",
   	            title : '<spring:message code="V00274"/>', // TM 대상 회원,
   	            width : '900px'
   	        });
		},
		beforeClose : function(obj){
			if(obj != null){
				mbrCarHist.requestData();
			}
		},
		close : function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
}

$(document).ready(function() {
  	gTmCampaignDetail.init();
});
</script>
<div class="page-title">
	<h1>
		<spring:message code="V00255"/> &gt; <spring:message code="L00079"/>
	</h1>
</div>
<div class="page_btn_area" id="headForm">
	<div class="col-xs-2">
		<span><spring:message code="V00273"/></span><!-- 캠페인 상세 정보 -->
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" btnFunc="gTmCampaignDetail.moveList" text="L00824" /><!-- 목록 -->
	</div>

</div>
<div class="form-horizontal underline top_well" id="tmCampaignDetailWrap" >
	<div class="row">
		<div class="half_wrap top_well">
			<div class="half_content half_left qt_border">
				<div class="form-horizontal top_well underline"  >
					<div class="row">
						<ifvm:inputNew type="text" id="camNm"   dto="camNm"	disabled="true"
							label="V00257" labelClass="2" conClass="10" /><!-- 캠페인명-->
					</div>
					<div class="row">
						<ifvm:inputNew type="date" id="camStartDd"   dto="camStartDd"	disabled="true"
							label="V00258" labelClass="2" conClass="4" /><!-- 시작일-->
						<ifvm:inputNew type="date" id="camEndDd"   dto="camEndDd"    disabled="true"
							label="V00259" labelClass="2" conClass="4" /><!-- 종료일 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="select" id="campaignStatus"   dto="campaignStatus" 	disabled="true"
							label="V00260" labelClass="2" conClass="4" /><!-- 상태-->
						<ifvm:inputNew type="select" id="campaignType"   dto="campaignType"	disabled="true"
							label="V00261" labelClass="2" conClass="4" /><!-- 유형 -->
				   </div>
				</div>
			</div>
			<div class="half_content half_right">
				<div class="form-horizontal top_well underline" id="mktAgree" >
					<div class="row">
						<ifvm:inputNew type="textarea" id="description"   dto="description"    disabled="true"	rows="3"
							label="L00885" labelClass="2" conClass="10" /><!-- 비고-->
					</div>
				</div>
			</div>
		  </div>
	</div>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="V00274" /><spring:message code="L01258" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button"   btnType="search"	text="V00275"  btnFunc="gTmCampaignDetail.searchUnComplTm"/>
		<ifvm:inputNew type="button"   btnType="search"	text="V00276"  btnFunc="gTmCampaignDetail.searchComplTm"/>
		<ifvm:inputNew type="button"   text="L00326"  btnFunc="gTmCampaignDetail.clearMasking"/>
	</div>
</div>
<div id=tmTargetMemListGrid></div>
<div id="tmCamTgtPop" class="popup_container"></div>


