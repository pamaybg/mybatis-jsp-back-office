<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="addBenefitsForm">
    <div class="page_btn_area">
    	<div class="col-sm-7">
			<span>조회 결과</span>     
    	</div>
        <div class="col-sm-5 searchbtn_r">
            <ifvm:inputNew type="button" id="insertBtn" btnFunc="validLimitProm" text="L01531"/><!-- 신규  -->
            <ifvm:inputNew type="button" id="deleteBtn" btnFunc="deleteProm" text="L00080" /><!-- 삭제  -->
        </div>
    </div>
    <div id="addPromGrid" class="white_bg grid_bd0"></div>
</div>
<div id="addPromContainer" class="popup_container"></div><!-- 팝업 -->

<script type="text/javascript">
var addPromGrid;

$(document).ready(function() {
	
 	if (typeof evtStatusCd == "undefined" || evtStatusCd == null) {
		$("#insertBtn").prop('disabled',true);
		$("#deleteBtn").prop('disabled',true);
	} else if (evtStatusCd == 'E') {
		$("#insertBtn").prop('disabled',true);
		$("#deleteBtn").prop('disabled',true);
	}
 	
	getAddPromList();    
});

function getAddPromList(){
	var ejGridOption = {
			recordDoubleClick : function(args){
	    		rid = args.data.rid;
	    		insertPopUp(rid);
	    	},
	      	serializeGridData : function( data ){
	      		requestitem=null;
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = eventRid;
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getAddPromList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : '', visible : false,
		      		  customAttributes : {
		      			  index : 'le.rid' }/* rid */
		      	  },{
		      		  field : 'camNm', headerText : '<spring:message code="L00152"/>', headerTextAlign : 'center', textAlign : 'center', width:'100px',
		      		  customAttributes : {
		      			  index : 'mc.CAM_NM'}/* 캠페인명 */
		      	  },{
		      		  field : 'dispNo', headerText : '<spring:message code="L00268"/>', headerTextAlign : 'center', textAlign : 'center', width:'50px',
		      		  customAttributes : {
		      			  index : 'mc.DISP_NO'} /* 캠페인번호 */
		      	  },{
		      		  field : 'selfTotAmt', headerText : '<spring:message code="L00617"/>', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width:'40px',
		      		  customAttributes : {
		      			  index : 'om.self_tot_amt' }/* 포인트 */
		      	  },{
		      		  field : 'condType', headerText : '<spring:message code="L02548"/>', headerTextAlign : 'center', textAlign : 'center', width:'50px',
		      		  customAttributes : {
		      			  index : 'cc1.MARK_NAME' }/* 조건유형 */
		      	  },{
		      		  field : 'conCd', headerText : '', visible : false,
		      		  customAttributes : {
		      			  index : 'le.COND_TYPE_CD' }/* 조건타입코드 */
		      	  },{
		      		  field : 'condVal', headerText : '<spring:message code="L02549"/>', headerTextAlign : 'center', textAlign : 'center', width:'30px',
		      		  customAttributes : {
		      			  index : 'le.COND_VAL' }/* 조건값 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'le.CREATE_DATE',
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	addPromGrid = $("#addPromGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

//추가혜택 신규 Validation
function validLimitProm(){
	//스탬프 개수가 1인 경우, 추가혜택 등록 불가
	if(maxStmpCnt==1){
		alert('<spring:message code="L02640"/>');//스탬프 개수가 1인 경우는 추가혜택을 등록할 수 없습니다.
		return;
	}
	//추가혜택 중복체크
	$.ifvSyncPostJSON('<ifvm:action name="validLimitProm"/>',{
		evtRid : eventRid
	},function(result){
		insertPopUp();
	},function(result){
		alert('<spring:message code="L02609"/>');//이미 추가혜택이 등록되어 있습니다.
	});
}

//추가혜택등록 팝업Open
function insertPopUp(rid) {
    $("#addPromContainer").ifvsfPopup({
    	enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addPromPop"/>'+'?rid='+rid,
        contentType: "ajax",
        title: '<spring:message code="L02579"/>',/* 추가혜택등록 */
        width: '400px',
        close : 'addPromPopUpClose'
        });
}

//추가혜택등록 팝업Close
function addPromPopUpClose() {
	addPromContainer._destroy();
}

//삭제
function deleteProm(){
	var list = addPromGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		var rid = list[0].rid;
		
		if(!confirm('<spring:message code="C00079" />')) return;/* 삭제 하시겠습니까? */
		
		$.ifvSyncPostJSON('<ifvm:action name="deleteProm"/>', {
			rid: rid
		}, function(result) {
			alert('<spring:message code="M01266" />');/* 삭제되었습니다. */
			getAddPromList();
		});
	}else {
        alert('<spring:message code="L00117"/>');//목록을 선택해주세요.
    }
}
</script>