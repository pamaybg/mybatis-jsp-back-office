<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var tierLimitGrid;

function getTierLimitList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		requestitem=null; 
	      		if (typeof pointMallRid == 'undefined') {
	      			data.ridTgtEvt = eventRid;
	      		} else {
	      			data.ridTgtEvt = pointMallRid;
	      		}
	            return data;
	       	},
	       	dataUrl : '<ifvm:action name="getTierLimitList"/>',
	        columns:[
	        	  {
		      		  field : 'rid', headerText : '', visible : false,
		      		  customAttributes : {
		      			  index : 'mt.RID' }/* rid */
		      	  },{
		      		  field : 'tiersGrpNm', headerText : '등급그룹', headerTextAlign : 'center', textAlign : 'left',
		      		  customAttributes : {
		      			  index : 'ltg.TIERS_GRP_NM'}/* 등급코드 */
		      	  },{
		      		  field : 'tierCd', headerText : '<spring:message code="L00235"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.TIER_CD'}/* 등급코드 */
		      	  },{
		      		  field : 'tierNm', headerText : '<spring:message code="L00236"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "t1.TIER_NM"
		      				, searchable : true}/* 등급명 */
		      	  },{
		      		  field : 'createDate', headerText : '<spring:message code="L00234"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "TO_CHAR(mt.CREATE_DATE,'YYYY-MM-DD HH24:MI:SS')" }/* 등록일시 */
		      	  },{
		      		  field : 'createByNm', headerText : '<spring:message code="L00237"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'ee.NAME'
		      				, searchable : true} /* 등록자 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : "2",
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	tierLimitGrid = $("#tierLimitGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	
	getTierLimitList();
	
});

//등급제한 등록 팝업Open
function insertTier(){
	if(evtStatusCd=='A'||evtStatusCd=='E'){
		alert('<spring:message code="L02621"/>');/* 중지 또는 작업 중인 이벤트만 등록하실 수 있습니다. */
		return;
	}
	
	$("#addtierContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addTierDtlPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L02616"/>',
        width: 900,
        close : 'insertTierPopClose',
    });
}

//등급제한 등록 팝업Close
function insertTierPopClose(){
	addtierContainer._destroy();	
}

//등급제한 삭제
function deleteTier(){
    var v_rid;
    
	if(evtStatusCd=='A'||evtStatusCd=='E'){
		alert('<spring:message code="L02620"/>');/* 중지 또는 작업 중인 이벤트만 삭제하실 수 있습니다. */
		return;
	}
    if ($.fn.ifvmIsNotEmpty(tierLimitGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tierLimitGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="L00117"/>');//목록을 선택해주세요.
        return;
    }

	if ($.fn.ifvmIsNotEmpty(v_rid)) {
		if(!confirm('<spring:message code="C00079" />')) return;/* 삭제 하시겠습니까? */
        $.ifvSyncPostJSON('<ifvm:action name="deleteTierLimit"/>', {
            rid: v_rid
        },
        function(result) {
        	alert('<spring:message code="L00085"/>');//삭제되었습니다.
        	getTierLimitList();
        });
    }
}

</script>

<div id="TierLimitForm">
    <div class="page_btn_area">
    	<div class="col-sm-7">
			<span style="color:#ffff">조회 결과</span>     
    	</div>
        <div class="col-sm-5 searchbtn_r">
            <ifvm:inputNew type="button" id="insertTierBtn" btnFunc="insertTier" text="L01531" objCode="tierLimitInsert_OBJ"/><!-- 신규  -->
            <ifvm:inputNew type="button" id="deleteTierBtn" btnFunc="deleteTier" text="L00080" objCode="tierLimitDelete_OBJ"/><!-- 삭제  -->
        </div>
    </div>
    <div id="tierLimitGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addtierContainer" class="popup_container"></div><!-- 팝업 -->
