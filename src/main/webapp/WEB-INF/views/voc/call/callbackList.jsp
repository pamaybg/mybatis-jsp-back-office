<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var callbackGrid;
var listUrl;
var rowData = null;
var mbrNo = '<%=cleanXss(request.getParameter("mbrNo")) %>';


function getCallbackList(ridMbr){
	var jqGridOption = {
		ondblClickRow : function(data){
		},
	    onSelectRow : function (data) {
	    	rowData = null;
	    	rowData = data;
		},
		serializeGridData : function( data ){
			//회원 조회
			if(ridMbr != null && ridMbr != ""){
				data.ridMbr = ridMbr;
			}

			if ($.fn.ifvmIsNotEmpty(requestitem) && (ridMbr == null || ridMbr == "")) {
                data.item = requestitem;
            }
            return data;
		},
		url: '<ifvm:action name="getCallbackList"/>',
	    colNames:[
	              '<spring:message code="V00084"/>', /* 유입일시 */
	              '<spring:message code="V00085"/>', /* 유입전화번호 */
	              '<spring:message code="V00079"/>', /* 상담원명 */
	              '<spring:message code="V00086"/>', /* 연락가능 연락처 */
	              '<spring:message code="V00087"/>', /* 회원번호 */
	              '<spring:message code="L02512"/>', /* ecom회원번호 */
	              '<spring:message code="V00005"/>', /* 회원명 */
	              '<spring:message code="V00088"/>', /* 콜백일시 */
	              '<spring:message code="V00089"/>', /* 콜백상태 */
	              '<spring:message code="V00090"/>', /* 콜백비고 */
	              '<spring:message code="V00091"/>', /* 상담원ID */
	              'rid'
	              ],
	    colModel:[
	              {name:'createDate',  				index:'a.CREATE_DATE', 			resizable : false, 		align:'center',    	width:'110px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'aniNum', 					index:'a.ani_number', 			resizable : false, 		align:'center',    	width:'100px'},
	              {name:'csName', 					index:'c.name', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'contactNum',     			index:'a.CALLBACK_AVL_NUM', 		resizable : false, 		align:'center',    	width:'100px'},
	              {name:'mbrNo', 					index:'d.mbr_no', 				resizable : false, 		align:'center',    	width:'100px', 			formatter:goGridRowMbrLink},
	              {name:'ecommMbrNo', 				index:'d.ECOMM_MBR_NO', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'custNm', 					index:'e.CUST_NM', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'callbackDate', 			index:'a.callback_date', 		resizable : false, 		align:'center',    	width:'110px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'calHndrStatus', 			index:'f.mark_name', 			resizable : false, 		align:'center',    	width:'100px'},
	              {name:'callbackDesc', 			index:'a.callback_desc', 		resizable : false, 		align:'center',    	width:'100px'},
	              {name:'csId', 					index:'b.user_id', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'rid', 						index:'a.RID', 					resizable : false, hidden : true},
			      ],
		radio:true,
		sortname: 'a.CREATE_DATE',
		sortorder: "desc",
// 		tempId : 'ifvGridExcelTemplete'
	};
	callbackGrid = $("#callBackListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function init(){
	clickInitializeCallBackListBtn();

	$("#callBackSearchList .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm')== 'MBR_NO'){
			$(this).parents('.SearchCondition').find('.searchCondition option').not('[value="EQUAL(=)"]').remove()
		}
	});
	if(mbrNo != "" && mbrNo != "null"){
		$("#callBackSearchList .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm')== 'MBR_NO'){
				$(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(mbrNo);
			}
		});
	 	clickSearchCallBackListBtn();
	}else{
		getCallbackList(null);
	}
	
	searchInitialize();
}

//전화걸기(연락가능 연락처)
function clickContactableCallBtn(){
	if(callbackGrid.getCheckedGridData()[0] != undefined){
		//연락가능 연락처 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	        rid: rowData.rid ,
	        type: 'voc5' ,
	        field: 'callbackAvlNum'
	    },
	    function(result) {
	    	parent.localSoftMakeCall(result.message,null);
	    });
	}else{
		alert('<spring:message code="V00204"/>'); //한 개의 목록을 선택해주세요.
	}
}

//전화걸기(유입전화번호)
function clickInflowCallBtn(){
	if(callbackGrid.getCheckedGridData()[0] != undefined){
		//유입전화번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	        rid: rowData.rid ,
	        type: 'voc5' ,
	        field: 'aniNumber'
	    },
	    function(result) {
	    	parent.localSoftMakeCall(result.message,null);
	    });
	}else{
		alert('<spring:message code="V00204"/>'); //한 개의 목록을 선택해주세요.
	}
}

//회원조회 팝업 - 이성원 과장님
function clickSearchMemberListBtn(){
	mbrSearchHelpPop ={
	        id : "mbrSearchPopDiv"
	    };
	mbrSearchHelpPop.popup = function (){
	mbrSearchHelpPop.pop = $('#'+mbrSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="mbrSearchHelp"/>'    ,
	            contentType: "ajax",
	            title: '회원명 찾기',
	            width: 700
	        });
	};
	mbrSearchHelpPop.beforeClose = function (obj) {
	};
	mbrSearchHelpPop.close = function (obj) {
		 if(obj!=null){
			 	mbrSearchHelpSearchInit();
			 	if(mbrNo != "" && mbrNo != "null"){
				 	clickSearchCallBackListBtn();
				}else{
					getCallbackList(null);
				}
	        }
	        this.beforeClose(obj);
	        mbrSearchHelpPop.pop._destroy();
	 };
	 mbrSearchHelpPop.popup();
}

//공통 조회 호출
function clickSearchCallBackListBtn() {
    $.fn.ifvmSubmitSearchCondition("callBackSearchList", getCallbackList);
}

//공통 조회 조건 목록 설정
function clickInitializeCallBackListBtn() {
	$.fn.ifvmSetCommonCondList("callBackSearchList","PGM_V_003");
}

//콜백상태수정 팝업
function showChangeCBStatusPop(){
	if(callbackGrid.getCheckedGridData()[0] != undefined){
		$("#changeCBStatusPop").ifvsfPopup({
		       enableModal : true,
			   enableResize: false,
			   contentUrl: '<ifvm:url name="changeCBStatusPop"/>?ridCallBack='+callbackGrid.getCheckedGridData()[0].rid,
			   contentType: "ajax",
			   title: "<spring:message code='V00216'/>",
			   width: 600,
			   close : 'changeCBStatusPopClose'
			});
	}else{
		alert('<spring:message code="V00204"/>'); //한 개의 목록을 선택해주세요.
	}
}

//콜백상태수정 팝업닫기
function changeCBStatusPopClose() {
	changeCBStatusPop._destroy();
}

//회원명 초기 조건 equal 로 설정
function searchInitialize(){
	$("#callBackSearchList .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == 'MBR_NO'){
			$(this).parents('.SearchCondition').find('#searchCon').val("EQUAL(=)");
		}
	});
}

function goGridRowMbrLink(cellvalue, options, rowObjec){
    var mbrNo = rowObjec.mbrNo;
    var url = '<ifvm:url name="mbrDetail"/>' + '?mbrNo=' + mbrNo;
   	var tag = null;
   	
   	if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
   	
   	return tag;
}

$(document).ready(function(){
	init();

	$.ifvEnterSetting(["#callBackSearchList"], function(){
		clickSearchCallBackListBtn();
	});

	if( !window.parent.document.getElementById("TSPhone")){
		$("#contactableCallBtn, #inflowCallBtn").attr("disabled",true);
	}
});
</script>

<div class="page-title">
    <h1>
    	<spring:message code="V00095" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-2">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-10 searchbtn_r">
            <ifvm:inputNew type="button" id="searchCallBackListBtn"  text="L00030" btnType="search" btnFunc="clickSearchCallBackListBtn"/>
            <ifvm:inputNew type="button" id="initializeCallBackListBtn"  text="L00031" btnType="" btnFunc="clickInitializeCallBackListBtn"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="callBackSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-2">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-10 searchbtn_r">
        	<ifvm:inputNew type="button" id="inflowCallBtn"  text="V00093" btnType="" btnFunc="clickInflowCallBtn"/>
        	<ifvm:inputNew type="button" id="contactableCallBtn"  text="V00092" btnType="" btnFunc="clickContactableCallBtn"/>
<%--         	<ifvm:inputNew type="button" id="searchMemberListBtn"  text="V00094" btnType="" btnFunc="clickSearchMemberListBtn"/> --%>
        	<ifvm:inputNew type="button" id="changeCBStatusBtn"  text="V00216" btnType="" btnFunc="showChangeCBStatusPop" objCode="VOC_MOD_001"/>
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('callBackListGrid')" objCode="COM_EXC_001"/>
        </div>
    </div>
    <div id="callBackListGrid" class="white_bg grid_bd0"></div>
</div>

<!-- 회원번호 및 회원명 선택 팝업 - 이성원 과장님 -->
<div id="mbrSearchPopDiv" class="empty_popup_container"></div>

<!-- 콜백상태수정 -->
<div id="changeCBStatusPop"></div>