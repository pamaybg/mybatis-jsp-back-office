<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}&tabid=mbrEventHistoryList" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>


<div id="evtLimitMbrForm">
    <div class="page_btn_area">
    	<div class="col-sm-7">
			<span>조회 결과</span>    
    	</div>
        <div class="col-sm-5 searchbtn_r">
            <button class="btn btn-sm" id="removeMaskBtn" objCode="limitMbrMask_OBJ">
            	<spring:message code="L01538"/><!-- 마스킹해제-->
            </button>
        	<button class="btn btn-sm" id="terminationBtn" objCode="limitMbrTerminate_OBJ">
            	<spring:message code="L02552"/><!-- 해지 -->
            </button>
        </div>
    </div>
    <div id="evtLimitMbrGrid" class="white_bg grid_bd0"></div>
</div>
<div id="terminationContainer" class="popup_container"></div><!-- 팝업 -->

<script type="text/javascript">
var evtLimitMbrGrid;

function getLimitMbrList(){
	var ejGridOption = {
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
	       	dataUrl : '<ifvm:action name="getLimitMbrList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : '', visible : false,
		      		  customAttributes : {
		      			  index : 'limMbr.RID' }/* rid */
		      	  },{
		      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
		      		  customAttributes : {
		      			  index : 'limMbr.RID_MBR'} /* RID_MBR */
		      	  },{
		      		  field : 'mbrNo', headerText : '<spring:message code="L02427"/>', headerTextAlign : 'center', textAlign : 'center',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 't3.MBR_NO'
		      				, searchable : true} /* 회원번호 */
		      	  },{
		      		  field : 'custNm', headerText : '<spring:message code="L01927"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't4.CUST_NM'
		      				, searchable : false} /* 회원명 */
		      	  },{
		      		  field : 'limDesc', headerText : '<spring:message code="L02629"/>', headerTextAlign : 'center', textAlign : 'left',
		      		  customAttributes : {
		      			  index : 'limMbr.LIMIT_DESC'
		      				, searchable : true} /* 제한 사유 */
		      	  },{
		      		  field : 'relDesc', headerText : '<spring:message code="L02630"/>', headerTextAlign : 'center', textAlign : 'left',
		      		  customAttributes : {
		      			  index : 'limMbr.RELEA_DESC'
		      				, searchable : true} /* 해지 사유 */
		      	  },{
		      		  field : 'startDt', headerText : '<spring:message code="L02553"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "to_char(limMbr.START_DT ,'YYYY-MM-DD')" 
		      				, searchable : true }/* 제한시작일 */
		      	  },{
		      		  field : 'endDt', headerText : '<spring:message code="L02554"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "to_char(limMbr.END_DT ,'YYYY-MM-DD')" 
		      				, searchable : true}/* 제한종료일 */
		      	  },{
		      		  field : 'status', headerText : '<spring:message code="L02204"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'cc1.MARK_NAME'
		      				, searchable : true} /* 상태 */
		      	  },{
		      		  field : 'statusCd', headerText : '', visible : false,
		      		  customAttributes : {
		      			  index : 'limMbr.STATUS' 
		      			  }/* 상태코드 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'limMbr.STATUS, limMbr.CREATE_DATE',
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	evtLimitMbrGrid = $("#evtLimitMbrGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

//부정 등록 해지
function termination(){
	if ($.fn.ifvmIsNotEmpty(evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0])) {
		var rid= evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0].rid;
    	var custNm= evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0].custNm;
    	var status= evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0].statusCd;
    	var mbrRid= evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    	if(status == 'I'){//비활성인 경우
    		alert('<spring:message code="L02581"/>');//이미 해지된 회원입니다.
    	}else{//활성인 경우
    		$("#terminationContainer").ifvsfPopup({
  		      enableModal : true,
  		      enableResize: false,
  		      contentUrl: '<ifvm:url name="terminationPop"/>?rid=' + rid + '&mbrRid=' + mbrRid,
  		      contentType: "ajax",
  		      title: '<spring:message code="L02569"/>',/* 부정등록회원 해지 */
  		      width: '400px',
  		      close : 'terminationPopupClose'
  			}); 
    	}
    }else {
        alert('<spring:message code="M00854"/>');//대상자를 선택하세요.
    }
     
}

function terminationPopupClose() {
	terminationContainer._destroy();
}

//마스킹해제
function removeMasking(){
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = evtLimitMbrGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');/* 마스킹을 해제할 목록을 선택하세요. */
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="LimitMbrClearMask"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = evtLimitMbrGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        });
    }
}

$(document).ready(function() {
 	// 해지
	$('#terminationBtn').on('click', function() {
		termination();
    });
 	
	// 마스킹해제
	$('#removeMaskBtn').on('click', function() {
		removeMasking();
    });
	
	getLimitMbrList();
});

</script>