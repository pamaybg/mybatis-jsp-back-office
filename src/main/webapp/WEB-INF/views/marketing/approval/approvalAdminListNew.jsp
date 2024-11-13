<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var approvalAdminList;
var gridIdapprovalAdminList;
var rid ;
var elecApproval_id=null;

//전자결재 관리
function getapprovalAdminListSearch(){
    var ejGridOption = {
      recordDoubleClick : function(args){
      var data = args.data;
      rid = data.id;
      
      approvalAdminDetailDtlPop();   // 상세 보기 이벤트
        },
        rowSelected : function (data) {
        	elecApproval_id = data.id;
        	fnButtonStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }     
            return data;
        },  
        loadComplete : function(obj){
        	$('#approvalAdminRemoveBtn').attr('disabled',true);
        }, 
        dataUrl : '<ifvm:action name="getApprovalAdminList"/>',
        columns:[ 
        	 {
	      		  field : 'elecAprvType', headerText : '<spring:message code="L01593"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'b.mark_name' }
	      	  },{
	      		  field : 'elecAprvTblNm', headerText : '<spring:message code="L01594"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_aprv_tbl_nm' }
	      	  },{
	      		  field : 'ridElecReqTmpl', headerText : '<spring:message code="L01595"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.rid_elec_req_tmpl' }
	      	  },{
	      		  field : 'elecReqFuncNm', headerText : '<spring:message code="L01596"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_req_func_nm' }
	      	  },{
	      		  field : 'elecReqAutomailId', headerText : '승인요청(썬더메일id)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_req_automail_id' }
	      	  },{
	      		  field : 'ridElecAprvTmpl', headerText : '<spring:message code="L01597"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.rid_elec_aprv_tmpl' }
	      	  },{
	      		  field : 'elecAprvFuncNm', headerText : '<spring:message code="L01598"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_aprv_func_nm' }
	      	  },{
	      		  field : 'elecAprvAutomailId', headerText : '승인처리(썬더메일id)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_aprv_automail_id' }
	      	  },{
	      		  field : 'ridElecRjtTmpl', headerText : '<spring:message code="L01599"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.rid_elec_rjt_tmpl' }
	      	  },{
	      		  field : 'elecRjtFuncNm', headerText : '<spring:message code="L01600"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_rjt_func_nm' }
	      	  },{
	      		  field : 'elecRjtAutomailId', headerText : '승인거절(썬더메일id)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.elec_rjt_automail_id' }
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="L01601"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.create_date' }
	      	  },{
	      		  field : 'createBy', headerText : '<spring:message code="L01602"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'e.name' }
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="L01603"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.modify_date' }
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="L01604"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'g.name' }
	      	  },{
	      		  field : 'id', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'a.rid' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'a.rid',
	      	  sord : 'desc',
	      	  _search : false
	        },
	 	rowList : [10,25,50,100],
        radio : true
    };
    
    approvalAdminList = $("#approvalAdminListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdapprovalAdminList = $("#gridIdapprovalAdminList");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플 
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}


//공통 조회 조건 목록 설정
function approvalAdminListSearchInit() {
    $.fn.ifvmSetCommonCondList("approvalAdminListSearchList","PGM_L_200");
}

//공통 조회 호출
function approvalAdminListSearch() {
    $.fn.ifvmSubmitSearchCondition("approvalAdminListSearchList", getapprovalAdminListSearch);
} 

// 상세 팝업 화면 호출 
function approvalAdminDetailDtlPop(){
 
 $("#approvalAdminDetailDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="approvalAdminDetail"/>' + '?rid=' + rid ,
        contentType: "ajax",
        title: '유형 관리',
        width: '1000px',
        close : 'approvalAdminDetailPopClose'
    });
}

function fnApprovalAdminNew(){
	 
	 $("#approvalAdminDetailDialog").ifvsfPopup({
	  enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="approvalAdminDetail"/>' ,
	        contentType: "ajax",
	        title: '유형 관리',
	        width: '1000px',
	        close : 'approvalAdminDetailPopClose'
	    });
}

// 삭제 

function fnApprovalAdminRemove() {
	if (elecApproval_id != null) {
		if (confirm('<spring:message code="M00127"/>')) {
			var submitData = {
				id : elecApproval_id
			};
			$.ifvSyncPostJSON('<ifvm:action name="deleteApprovalAdminDetail"/>', submitData, function(result) {
				alert('<spring:message code="L00034"/>');
				getapprovalAdminListSearch();
			}, function(result) {
				alert(result.message);
			});
		}
	}

}

//팝업 닫기
function approvalAdminDetailPopClose() {
	approvalAdminDetailDialog._destroy();

}

//고객 상세 이동
function approvalAdminDetailDtl() {
	qtjs.href('<ifvm:url name="approvalAdminDetail"/>' + '?rid=' + rid);
}

function fnButtonStatus() {

	elecApproval_id != null ? $('#approvalAdminRemoveBtn').attr('disabled', false) : $('#approvalAdminRemoveBtn').attr('disabled', true);

}

$(document).ready(function() {
	fnButtonStatus();
	//공통 조회 조건 목록 설정
	approvalAdminListSearchInit();
	$.ifvmLnbSetting('approvalAdminListNew');
	approvalAdminListSearch();
	//조회
	$('#approvalAdminListSearchBtn').on('click', function() {
		approvalAdminListSearch();
	});

	//초기화
	$("#approvalAdminListSearchInitBtn").on('click', function() {
		approvalAdminListSearchInit();
	});

});
</script>


<div class="page-title">
    <h1>
    	<spring:message code="L02194" />
 		&gt; <spring:message code="M00135" />
    </h1>
</div>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" btnType="plus" text="I00080" id="approvalAdminNewBtn"  btnFunc="fnApprovalAdminNew" /> 
        <ifvm:inputNew type="button" btnType="delete" text="L00029" id="approvalAdminRemoveBtn"  btnFunc="fnApprovalAdminRemove" /> 
        
        
        </div>
    </div>
    <div id="approvalAdminListGrid" class="white_bg grid_bd0"></div>     
</div>

<div id="approvalAdminDetailDialog" class="popup_container"></div>



