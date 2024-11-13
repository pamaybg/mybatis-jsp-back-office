<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var accessInfoGrid;


getAccessInfoList = {
	init : function (){
		accessInfoGrid = $("#accessInfoGrid").ifvsfGrid({ ejGridOption : getAccessInfoList.ejGridOption });
	},
	ejGridOption : {
		serializeGridData : function( data ){
	      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      		data.item = requestitem;
	        }
        },
        recordDoubleClick : function (args) {
        	var tRid = args.data.rid
        	getAccessInfoList.moveDetail(tRid);
        },
        dataUrl : '<ifvm:action name="getAccessInfoList"/>',
        columns:[
        	{
	      		  field : 'rscType', headerText : '<spring:message code="L01841"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.RSC_TYPE' } /* 유형 */
	      	  },{
	      		  field : 'rscNm', headerText : '<spring:message code="Q02846"/>', headerTextAlign : 'center',
	      		  customAttributes : { 
	      			  index : 'qr.RSC_NM' } /* 리소스명 */
	      	  },{
	      		  field : 'dbType', headerText : '<spring:message code="Q02859"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.DB_TYPE' } /* DB Type */
	      	  },{
	      		  field : 'hostAddr', headerText : '<spring:message code="Q02860"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.HOST_ADDR' } /* 호스트 주소 */
	      	  },{
	      		  field : 'port', headerText : '<spring:message code="Q02861"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.PORT' } /* Port */
	      	  },{
	      		  field : 'dbSchema', headerText : '<spring:message code="Q02862"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable: false,
	      			  index : 'qr.DBSCHEMA' } /* 스키마 */
	      	  },{
	      		  field : 'useYn', headerText : '<spring:message code="Q02830"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.USE_YN' } /* 활성여부 */
	      	  },{
	      		  field : 'userName', headerText : '<spring:message code="Q02863"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.LOGIN_ID' } /* User Name */
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="Q02847"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.create_date' } /* 생성일시 */
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="Q02834"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.modify_date' } /* 수정일시 */
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="Q02848"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'qr.modify_by' } /* 생성자 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'qr.rid' }
	      	  },
       ],
       requestGridData : {
     	  nd   : new Date().getTime(),
     	  rows : 10,
     	  sidx : 'qr.create_date',
     	  sord : 'desc',
     	  _search : false
       },
       rowList : [10,25,50,100],
       radio: true,
	   tempId : 'ifvGridOriginTemplete'

	},
	moveDetail : function(rid){
		qtjs.href('<ifvm:url name="accessInfoDetail"/>' + '?rid=' + rid);
	},
	newAccessInfo : function(){
		qtjs.href('<ifvm:url name="accessInfoDetail"/>');
	},
	deleteAccessInfo : function(){
		
		if (accessInfoGrid.opt.gridControl.getSelectedRecords()[0] == undefined){
			alert('<spring:message code="Q00015" />'); //삭제 대상을 선택하여 주세요.
			return;
		} else {
			if (confirm('<spring:message code="Q00016" />')) { //삭제하시겠습니까?
				var tRid = accessInfoGrid.opt.gridControl.getSelectedRecords()[0].rid;
				
		 		$.ifvSyncPostJSON('<ifvm:action name="removeAccessInfo"/>', {
					rid : tRid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert('<spring:message code="V00219" />'); // 완료되었습니다.
						getAccessInfoList.init();
					}
				}, function(result) {
					alert(result.message);
				});						
			}
		}
	},
}

/* function checkActYn(cellvalue, options, rowObjec){
	var isYn="";
	var regCnt = null;
	regCnt = rowObjec.useYn;

	if(regCnt == 1 || regCnt == "Y"){
		isYn="Y"
	}else{
		isYn="N";
	}
	
	return isYn;
} */

function searchCondInit() {
	$.fn.ifvmSetCommonCondList("resourceSearchList","PQIM_003");
}

//공통 조회 호출
function resourceListSearch() {
	$.fn.ifvmSubmitSearchCondition("resourceSearchList", getAccessInfoList.init);
}

$(document).ready(function(){
	
	getAccessInfoList.init();
	
	searchCondInit();
	
	  //조회
    $('#searchCondBtn').on('click', function(){
    	resourceListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });
    
});
</script>

<div class="page-title">
    <h1>
        <spring:message code="Q02858"/> <!-- 리소스 관리 -->
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span> <!-- 조회 조건 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" id="searchCondBtn" btnType="search" text="L00081" /> <!-- 조회 -->
            <ifvm:inputNew type="button" id="searchCondInitBtn" text="L00082" /> <!-- 초기화 -->
        </div>
    </div>
	<div class="well form-horizontal well_bt5" id="resourceSearchList" ></div>
</div>
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00930"/></span> <!-- 조회결과 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
           	<ifvm:inputNew type="button" id="" text="I00247" btnFunc="getAccessInfoList.newAccessInfo" /> <!-- 신규 -->
           	<!-- 로그보기 -->
           	<%-- <ifvm:inputNew type="button" id="" text="Q02873" btnFunc="" /> --%>
           	<!-- 로그위치지정 -->
           	<%-- <ifvm:inputNew type="button" id="" text="Q02874" btnFunc="" /> --%>
           	<ifvm:inputNew type="button" id="" text="I00248" btnFunc="getAccessInfoList.deleteAccessInfo" /> <!-- 삭제 -->
        </div>
    </div>
    <div id="accessInfoGrid" class="white_bg grid_bd0"></div>
</div>