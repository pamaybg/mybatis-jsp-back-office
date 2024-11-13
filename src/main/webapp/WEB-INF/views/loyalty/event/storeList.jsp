<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
     	GLO SHOP
        <span>&gt; SHOP 거래이력</span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span><!-- 조회조건 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnType="search"  text="M00135"  id="reportSearchBtn" btnFunc="mbrStoreListSearch"/><!-- 조회 -->
            <button class="btn btn-sm" id="searchInitBtn">
                <spring:message code="M00278" /><!-- 초기화 -->
            </button> 
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
       <div class="row qt_border">
            <label class="col-xs-1 control-label">거래일시</label>
            <div class="col-xs-4 control_content">
            	<ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" required="true" nuc="true" /> 
            </div>
      </div>
      <div class="row">
            <label class="col-xs-1 control-label">SHOP명</label>
            <div class="col-xs-3 control_content">
            	<div class="input-group">
					<ifvm:input type="text" id="storeNm" names="storeNm" disabled="true"/>
					<span class="input-group-addon" id="btnStoreListPop">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div> 
            </div>
      </div>
      <div class="row">
            <label class="col-xs-1 control-label">채널명</label>
            <div class="col-xs-3 control_content">
            	<div class="input-group">
					<ifvm:input type="text" id="chnlNm" names="chnlNm" disabled="true"/>
					<span class="input-group-addon" id="btnChnlListPop">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div> 
            </div>
      </div>
      <div class="row">
            <label class="col-xs-1 control-label">SHOP 유형</label>
            <div class="col-xs-3 control_content">
            	<ifvm:input type="select" id="shopType" names="shopType" />
            </div>
      </div>
    </div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span><!-- 조회결과 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
         	<ifvm:inputNew type="button" text="L00326" id="clearMaskBtn" btnFunc="clearMaskAction"/><!-- 마스킹해제 -->
         	<ifvm:inputNew type="button" text="M01218" id="excelExportBtn" btnFunc="ExcelExport"/><!-- 엑셀 다운로드 -->           
        </div>
    </div>
    <div id="totPoint" style="text-align:right; padding-left: 0; padding-right: 0; padding: 7px 15px;" class="white_bg">
    		<span>적립</span>
			<input type="text" id="acrl" style="width: 80px;text-align:right;" value="0" readonly/>
			<span style="padding-left: 10px;">사용</span>
			<input type="text" id="use"  style="width: 80px;text-align:right;" value="0" readonly/>
	</div>
</div>
<div id="mbrStoreListGrid" class="white_bg grid_bd0"></div>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->


<script type="text/javascript">
var storeNm = null;
var mbrStoreList;

function mbrStoreListSearch(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
      		data.startDt = $('#startDt').val().replaceAll('-','');
      		data.endDt   = $('#endDt').val().replaceAll('-','');
      		data.storeNm = $('#storeNm').val();
      		data.chnlNm  = $('#chnlNm').val();
      		data.shopType = $('#shopType').val();
      		acrlUseSetting(data.storeNm,data.chnlNm);
            return data;
       	},
       	loadComplete : function(obj){
       		if($.fn.ifvmIsNotEmpty(mbrStoreList.opt.gridControl.getRows())){
       			$("#excelExportBtn").prop('disabled',false);//엑셀 다운로드 버튼 활성화
       		}
        },
       	dataUrl : '<ifvm:action name="getMbrStoreList"/>',
        columns:[
        	  { 
	      		  field : 'txnDt', headerText : '<spring:message code="L00604"/>', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'lst.TXN_DT'}//거래일시
        	  },{
	      		  field : 'storeType', headerText : 'SHOP 유형', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'cc4.MARK_NAME'}//SHOP 유형
	      	  },{
	      		  field : 'storeNm', headerText : 'SHOP명', headerTextAlign : 'center', textAlign: 'left',
	      		  customAttributes : {
	      			  index : 'ls.STORE_EVT_NM'}//SHOP명
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L00129"/>', headerTextAlign : 'center', textAlign: 'left',
	      		  customAttributes : {
	      			  index : 'lch.CHNL_NM'}//채널명
	      	  },{
	      		  field : 'benefitNm', headerText : '혜택', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'MCM.PNT_ACCNT_CUST_DISP_TXT'}//혜택
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'custNm', searchable : false}//회원명
	      	  },{
	      		  field : 'hhpNo', headerText : '전화번호', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'lm.HHP_NO'}//
	      	  },{
	      		  field : 'gender', headerText : '성별', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'cc3.MARK_NAME'}//
	      	  },{
	      		  field : 'age', headerText : '나이', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : "(SELECT loy.fn_get_age('Y3',lc.BIRTH_DT) FROM DUAL)"}//
	      	  },{
	      		  field : 'pntAmt', headerText : '<spring:message code="L02528"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'lst.PNT_AMT'}//포인트금액
	      	  },{
	      		  field : 'txnPntType', headerText : '<spring:message code="L02529"/>', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'lst.TXN_PNT_TYPE', searchable : false}//거래포인트유형
	      	  },{ 
	      		  field : 'rid', headerText : '', headerTextAlign : 'center', textAlign: 'center', visible :false ,
	      		  customAttributes : {
	      			  index : 'lst.RID', }//rid
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
			  sidx : 'lst.TXN_DT',
			  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	    radio : true
    };
    
    mbrStoreList = $("#mbrStoreListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//엑셀 다운로드 
function ExcelExport() {
	$.ifvExcelDn('<ifvm:action name="mbrStoreListExport"/>','mbrStoreListGrid');
}

function setCalendar() {
	var startDate = $('#startDt');
	var endDate = $('#endDt');
	
	//오늘날짜
	startDate.val($.ifvGetTodayDate());
	//오늘부터 한달 뒤
	endDate.val($.ifvGetTodayDate());

	//설정
	startDate.ifvDateChecker({
		maxDate : endDate
	});
	endDate.ifvDateChecker({
		minDate : startDate
	});
}

//마스킹해제 
function clearMaskAction() {	
	 var v_rid;
	 
	 if ($.fn.ifvmIsNotEmpty(mbrStoreList.opt.gridControl.getSelectedRecords()[0])) {
	 	v_rid = mbrStoreList.opt.gridControl.getSelectedRecords()[0].rid;
	 }
	 else {
		 //마스킹을 해제할 목록을 선택하세요.
	     alert('<spring:message code="M02219"/>');
	 }

	 if ($.fn.ifvmIsNotEmpty(v_rid)) {
	     $.ifvSyncPostJSON('<ifvm:action name="clearMaskingStore"/>', {
	     	rid: v_rid
	     },
	     function(result) {
	     	var gridObj = mbrStoreList.opt.gridControl;
	     	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	     	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);//이름
	     	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'), result.hhpNo);//전화번호
	     });
	 }
}

//적립 사용 셋팅
function acrlUseSetting(storeNm,chnlNm) {
	//포인트 적립
	totAcrlPoint(storeNm,chnlNm);
	//포인트 사용
	totRdmPoint(storeNm,chnlNm);
}

//포인트 사용
function totRdmPoint(storeNm,chnlNm){
	
	var data={"startDt" : $('#startDt').val().replaceAll('-','')
			 ,"endDt"   : $('#endDt').val().replaceAll('-','')
			 ,"storeNm" : storeNm
			 ,"chnlNm"  : chnlNm};
	
	$.ifvSyncPostJSON('<ifvm:action name="getStoreListRdmPoint"/>',{
		startDt : data.startDt,
		endDt : data.endDt,
		storeNm : data.storeNm,
		chnlNm : data.chnlNm,
		item : requestitem
	},function(result){
		if(result.rdmAmt == null){
			$('#use').val(0);
		}else{
			$('#use').val((numberWithCommas(result.rdmAmt)));
		}
	});
}

//포인트 적립
function totAcrlPoint(storeNm,chnlNm){
	var data={"startDt" :$('#startDt').val().replaceAll('-','')
			 ,"endDt" : $('#endDt').val().replaceAll('-','')
			 ,"storeNm" : storeNm
			 ,"chnlNm"  : chnlNm};
	
	$.ifvSyncPostJSON('<ifvm:action name="getStoreListAcrlPoint"/>',{
		startDt : data.startDt,
		endDt : data.endDt,
		storeNm : data.storeNm,
		chnlNm : data.chnlNm,
		item : requestitem
	},function(result){
		if(result.acrlAmt == null){
			$('#acrl').val(0);
		}else{
			$('#acrl').val((numberWithCommas(result.acrlAmt)));			
		}
	});
}

//스토어명 검색 팝업
function storePopUp() {
	$("#popupContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl : '<ifvm:url name="storeListPop"/>',
		contentType : "ajax",
		title : 'SHOP 목록',
		width : '900px',
		close : 'storePopupClose' 
	});
}

//채널명 검색 팝업
function chnlPopUp() {
	$("#popupContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl : '<ifvm:url name="chnlListPop"/>',
		contentType : "ajax",
		title : '채널 목록',
		width : '900px',
		close : 'chnlPopupClose' 
	});
}

function storePopupClose() {
	popupContainer._destroy();
}

function chnlPopupClose() {
	popupContainer._destroy();
}

function numberWithCommas(str) {
	   return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(document).ready(function() {
	
	//엑셀 다운로드 버튼 비활성화
	$("#excelExportBtn").prop('disabled',true);
	
	//기간 날짜 설정
	setCalendar();
	
	$.fn.ifvmSetSelectOptionCommCode("shopType", "EVT_STORE_TYPE", null, null, false);
	
	mbrStoreListSearch();	
    
    //초기화
    $("#searchInitBtn").on('click', function(){
    	$('#storeNm').val("");
    	$('#chnlNm').val("");
    	setCalendar();
    });
    
    $("#btnStoreListPop").on("click",function(){
		storePopUp();
	});
    
    $("#btnChnlListPop").on("click",function(){
		chnlPopUp();
	});
    
});
</script>