<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
	<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
        </div>
        <div class="col-xs-7 searchbtn_r">
        	<button class="btn btn-sm" id="clearMaskBtn" objCode="recommclearMaskBtn_obj">
             	<spring:message code="L00326" />
    		</button>
        </div>
    </div>
    <div id="mbrEventHistoryListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="pointCouponPop" class="popup_container"></div>

<script type="text/javascript">

var mbrEventHistoryList;
var recomm_Rid;
var rid= null;

var mbrEventHistoryObj = { 
	initMbrEventHistoryList : function(data) {
		var ejGridOption = {
		    serializeGridData : function(data) {
	       		data.rid = mbr_rid;
	       	},
	       	rowSelected : function(args){ //수정중
	       		recomm_Rid = args.data.rid;
			},
			loadComplete : function(obj){
	       		window.top.setParentIframeHeight();
			}, 
	        dataUrl : '<ifvm:action name="getMbrRecomHistoryList"/>',
	        columns:[
	        	  {
                      field : 'rid', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
	         		  customAttributes : {
	         			  index : 'fr.rid' }
	         	  },
	        	  {
	         		  field : 'rcmmHist', headerText : '구분', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'fr.rcmmHist' }
	         	  },{
	         		  field : 'rcmType', headerText : '등록프로그램', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'fr.rcmType' }
	         	  },{
	         		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'fr.custNm' }
	         	  },{
	         		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', template: "#mbrLinkTemplate",
	         		  customAttributes : {
	         			  index : 'fr.mbrNo' }
	         	  },{
	         		  field : 'mbrStatCd', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'fr.mbrStatCd' }
	         	  },{
	         		  field : 'joinDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'fr.joinDate' }
	         	  },
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,
	        	 sidx : 'fr.joinDate',
	        	 sord : 'desc',
	        	 _search : false
			},
			radio: true,
			tempId : 'ifvGridSimplePageTemplete2'
	    };

		mbrEventHistoryList = $("#mbrEventHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}
}

//마스크해제 
function clearMaskAction() {
	 var v_rid;
	     if ($.fn.ifvmIsNotEmpty(mbrEventHistoryList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = mbrEventHistoryList.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="M02219"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) { 
	        $.ifvSyncPostJSON('<ifvm:action name="clearMaskRecomm"/>', {
	        	recomRid: v_rid
	          , rid : mbr_rid
	        },
	        function(result) {
	        	var gridObj = mbrEventHistoryList.opt.gridControl;
	        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
	        });
	    }
	}

$(document).ready(function(){
	mbrEventHistoryObj.initMbrEventHistoryList(); 
	
	//마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
});

</script>