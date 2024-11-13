<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
        <spring:message code="O00190"/>
        &gt; <spring:message code="M03005"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" >
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
      		  <button class="btn btn-sm" id="tgtGroupBtn" >
              	<spring:message code="타겟그룹"/>
              </button>
              <button class="btn btn-sm" id="clearMaskBtn"> <!-- 마스킹해제 -->
                <spring:message code="L00326"/>
              </button>
              <button class="btn btn-sm" id="excelDownBtn" > <!-- 다운로드 -->
                <spring:message code="O00084"/>
              </button>
        </div>
    </div>
    <div id="cafe24MemListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="genTargetGroupPopDialog" class="popup_container"></div>
<script type="text/javascript">

var cafe24MemListGrid;

//공통 조회 조건 목록 설정
 function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","CUST_CF24_LIST",gridId);
}

//공통 조회 호출
function cafe24MemListSearch() {

	$.fn.ifvmSubmitSearchCondition("commSearchList", function(bool) {
		bool ? alert('최소 1개의 조회조건을 입력해주세요.') :	cafe24MemListGrid.searchGrid({item: requestitem});
     });
}

//타겟그룹
function genTargetGroupPop(){
	$("#genTargetGroupPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="genTargetGroupPop"/>',
        contentType: "ajax",
        title: '타겟그룹생성',
        width: 600,
        close : 'genTargetGroupPopupClose'
    });
}

function genTargetGroupPopupClose(){
	
	genTargetGroupPopDialog._destroy();
	
}

//마스킹 해제
function clearMaskAction() {
    var id;
    if ($.fn.ifvmIsNotEmpty(cafe24MemListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	id = cafe24MemListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(id)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskCf24MbrList"/>', {
        	rid : id
        },
        function(result) {
        	var gridObj = cafe24MemListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('name'), result.unmaskName);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('cellPh'), result.unmaskCellPh);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.unmaskEmail);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('userId'), result.unMaskUserId);

        });
    }
}

//고객 목록
function getCafe24MemList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
   		recordDoubleClick : function (args) {
   			var rid = args.data.rid ;
   			qtjs.href('<ifvm:url name="cafe24MbrDetail"/>?rid='+rid);
        },

        dataUrl : '<ifvm:action name="getCafe24MemList"/>',

        columns : [
        	{
      		  field : 'mallNm', headerText : '가입몰', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
					index : 'mall'
				}
      	  },{
    		  field : 'name', headerText : '이름', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'cellPh', headerText : '휴대전화번호', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'email', headerText : 'EMAIL', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'userId', headerText : '사용자ID', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'smsYn', headerText : 'SMS수신', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'emailYn', headerText : 'EMAIL수신', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'regDate', headerText : '가입일자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    cafe24MemListGrid = $("#cafe24MemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();
    getCafe24MemList();
    
   /*  if(cafe24MemListGrid.opt.data.rows.length<1){
    	$("#tgtGroupBtn").attr('disabled',true);
    }else{
    	$("#tgtGroupBtn").attr('disabled',false);
    }    */
       //조회
    $('#searchCondBtn').on('click', function(){
    	cafe24MemListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("cafe24MemListGrid");
    }); 
    
    //타겟그룹
    $("#tgtGroupBtn").on('click', function(){
    	genTargetGroupPop();
    }); 

	//엑셀다운로드
    $("#excelDownBtn").on('click', function() {
      	$.ifvExcelDn('/loyalty/member/customer/cafe24ExcelDown.do','cafe24MemListGrid' );
    });
	
    //마스킹해제
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

    
});

</script>