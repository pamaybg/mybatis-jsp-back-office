<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>

<script type="text/javascript">
var qnaManagementGrid;
//목록 조회
function getQnaContentList(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
    		var rid = args.data.rid;
    		qtjs.href('<ifvm:url name="qnaManagementDetail"/>' + '?rid=' + rid);
    	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	loadComplete : function(args){
       		if($.fn.ifvmIsNotEmpty(args.getCurrentViewData()[0])){
       			$("#receiptCnt").val(args.getCurrentViewData()[0].receipt);       			
       		}
       	},
       	dataUrl : '<ifvm:action name="getQnaList"/>',
        columns:[ 
        	  {
	      		  field : 'srNo', headerText : 'SR번호', headerTextAlign : 'center', textAlign : 'center', width : '100px', 
	      		  customAttributes : {
	      			  index : 'vsr.SR_NO' }/* SR번호 */
	      	  },{
	      		  field : 'srType', headerText : 'SR유형', headerTextAlign : 'center', textAlign : 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'c1.MARK_NAME' }/* SR유형 */
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr', visible: false,
	      		  customAttributes : {
	      			  index : 'lm.rid' }/* */
	      	  },{
	      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', width : '60px',template: "#mbrLinkTemplate",
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }/* 회원번호 */
	      	  },{
	      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'lc.CUST_NM' }/* 회원명 */
	      	  },{
	      		  field : 'srReqTxt', headerText : '내용', headerTextAlign : 'center', textAlign : 'left', width : '200px',
	      		  customAttributes : {
	      			  index : 'vsr.SR_REQ_TXT' }/* 내용 */
	      	  },{
	      		  field : 'srReqDt', headerText : '접수일시', headerTextAlign : 'center', textAlign : 'center',  width : '100px',
	      		  customAttributes : {
	      			  index : 'vsr.SR_REQ_DT' }/* 접수일시 */
	      	  },{
	      		  field : 'srStatus', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width : '50px',
	      		  customAttributes : {
	      			  index : 'c2.MARK_NAME' }/* 상태 */
	      	  },{
	      		  field : 'srCmpltDt', headerText : '완료일시', headerTextAlign : 'center', textAlign : 'center',  width : '100px',
	      		  customAttributes : {
	      			  index : 'vsr.SR_CMPLT_DT' }/* 완료일시 */
	      	  },{
	      		  field : 'managerNm', headerText : '담당자', headerTextAlign : 'center', textAlign : 'center',  width : '100px',
	      		  customAttributes : {
	      			  index : 'em.NAME' }/* 담당자 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'vsr.rid' }/* rid */
	      	  },{
	      		  field : 'receipt', headerText : 'receipt', visible : false,
	      		  customAttributes : {
	      			  index : 'receipt' }/* 접수건수 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 15,
	      	  sidx : 'c2.SEQ asc, vsr.CREATE_DATE',
	      	  sord : 'DESC',
	      	  _search : false
	    },
	    rowList : [15,30,60,120],
        autowidth : true ,
        radio : true , 
        tempId : 'ifvGridNotSearchTemplete'
    };
    
    qnaManagementGrid = $("#qnaManagementGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function qnaManagementAListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("qnaManagementList","QNA_MNG_01",gridId);
}

//공통 조회 호출
function qnaManagementAListSearch() {
	 $.fn.ifvmSubmitSearchCondition("qnaManagementList", getQnaContentList);
} 

//마스킹해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(qnaManagementGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = qnaManagementGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="qnaClearMaskMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = qnaManagementGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
        });
    }
}

$(document).ready(function() {
	getQnaContentList();
    //공통 조회 조건 목록 설정
    qnaManagementAListSearchInit();
	
    qnaManagementAListSearch();
    
    //조회
    $('#qnaManagementAListSearchBtn').on('click', function(){
    	qnaManagementAListSearch();
    });
    
    //초기화
    $("#qnaManagementAListSearchInitBtn").on('click', function(){
    	qnaManagementAListSearchInit('qnaManagementGrid');
    });
  	
    $("#clearMaskBtn").on('click', function(){
    	clearMaskAction();
    });
});

</script>

<div class="page-title">
    <h1>
    	<spring:message code="O00199"/> &gt; <spring:message code="M00273"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="qnaManagementAListSearchBtn" objCode="qnaManagementAListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="qnaManagementAListSearchInitBtn" objCode="qnaManagementAListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="qnaManagementList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskBtn" text="L00326" objCode="clearMaskBtn_OBJ"/>
   	 	</div>
    </div>
    <div id="qnaManagementGrid" class="white_bg grid_bd0 grid_bd0"></div> 
 </div>
     
  <!--  <div class ="row white_bg">
             <div class="col-xs-10 control_content"></div>
    	<div class="col-xs-2 control_content" style="text-align:right;">
    		<span>접수건수 :</span>
    		<input type="text" id="receiptCnt" class="receiptCnt" style="width: 80px; background-color:transparent; border:0;">
    	</div>
 
	</div> -->

        
  
