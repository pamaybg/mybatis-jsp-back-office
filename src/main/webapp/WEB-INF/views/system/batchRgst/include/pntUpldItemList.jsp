<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/x-jsrender" id="embLinkTemplate">
	{{if ridMbr != null}}
		{{if memDivCd == 'P' || memDivCd == 'T'}}
			<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:rid}}" style="color:#1266FF; text-decoration:underline;" >{{:e1MbrNo}}</a>
		{{else}}
			<a href="<ifvm:url name="mbrGroupDetail"/>?rid={{:rid}}" style="color:#1266FF; text-decoration:underline;" >{{:e1MbrNo}}</a>
		{{/if}}
	{{/if}}
</script>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/javascript">
var upldItemList;
var batchResultCd="";
var testViewList_rid = '<%=cleanXss(request.getParameter("rid")) %>';
function upldItemSearch(){
    var ejGridOption = {
       serializeGridData : function( data ){
			data.ridPntUpload = rid
        	data.batchResultCd = batchResultCd
			return data;
        },
        loadComplete : function(obj){
        	if(obj._currentJsonData.length>0){
        	}
        },
        dataUrl : '<ifvm:action name="getPntUpldItemList"/>',
        columns:[
        	{
	      		  field : 'seq', headerText : '순서', headerTextAlign : 'center', textAlign : 'center', width: '60px'
	      	  },{
	      		  field : 'acrlDate', headerText : '적립일시', headerTextAlign : 'center', width : '140px', textAlign : 'center',
	      	  },{
	      		  field : 'batchResultCdNm', headerText : '<spring:message code="L02371"/>', headerTextAlign : 'center', textAlign: 'center', width : '70px' /*처리결과 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="L02366"/>', headerTextAlign : 'center', textAlign: 'center', width: '90px'  /*엑셀회원번호 */
	      	  },{
	      		  field : 'targetHhpNo', headerText : '<spring:message code="휴대전화번호"/>', headerTextAlign : 'center', width : '100px' /*엑셀핸드폰번호 -> 휴대전화번호*/
	      	  },{
	      		  field : 'targetNm', headerText : '<spring:message code="L02367"/>', width:'100px', headerTextAlign : 'center', textAlign: 'center' /*엑셀대상자명 */
	      	  },{
	      		  field : 'acrlAmt', headerText : '적립요청포인트', width:'100px', headerTextAlign : 'center', textAlign: 'right' /*적립요청포인트 */
	      	  },{
	      		  field : 'ofrNo', headerText : '오퍼번호', headerTextAlign : 'center', textAlign: 'center', width: '90px' 
	      	  },{
	      		  field : 'ofrNm', headerText : '오퍼명', headerTextAlign : 'center', width: '150px'
	      	  },{
	      		  field : 'batchErrorDesc', headerText : '<spring:message code="L02372"/>', headerTextAlign : 'center', width: '150px'
	      	  },{
	      		  field : 'mbrNoChk', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center', textAlign: 'center', width: '90px'
	      	  },{
	      		  field : 'mbrStatCdNmChk', headerText : '<spring:message code="M02019"/>', headerTextAlign : 'center', textAlign: 'center', width: '70px' 
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      	  },{
	      		  field : 'batchResultCd', headerText : 'batchResultCd',visible : false /*batchResultCd */
	      	  },{
	      		  field : 'mbrStatCdChk', headerText : 'mbrStatCdChk',visible : false, /*mbrStatCdChk */
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr',visible : false, /*ridMbr */
	      	  },{
	      		  field : 'promRid', headerText : 'promRid',visible : false, /*ridMbr */
	      	  },{
	      		  field : 'ofrNo', headerText : 'ofrNo',visible : false, /*ridMbr */
	      	  },{
	      		  field : 'ofrRid', headerText : 'ofrRid',visible : false, /*ridMbr */
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'seq',
	      	  sord : 'asc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true,
	        isHorizontalScroll: true,
	        tempId : 'ifvGridSimplePageTemplete'
    };
    upldItemList = $("#upldItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
function allSearchFn(){
	batchResultCd =""
	upldItemSearch();
}
function sucesSearchFn(){
	batchResultCd ="S"
	upldItemSearch();
}

function failSearchFn(){
	batchResultCd ="F"
	upldItemSearch();
}

function workingSearchFn(){
	batchResultCd ="W"
	upldItemSearch();
}

/**
 * 마스킹해제 (핸드폰번호)
 */
function clearMaskFn() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(upldItemList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = upldItemList.opt.gridControl.getSelectedRecords()[0].rid;
    	v_targetHhpNo = upldItemList.opt.gridControl.getSelectedRecords()[0].targetHhpNo;
    	v_targetNm = upldItemList.opt.gridControl.getSelectedRecords()[0].targetNm;
    }
    else {
        alert('<spring:message code="M02219"/>');
        return;
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvPostJSON('<ifvm:action name="clearMaskPntItemMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = upldItemList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetHhpNo'), result.unMaskHhp);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('webId'), result.unMaskEmail);
        	/* if ($.fn.ifvmIsNotEmpty(v_targetHhpNo) && $.fn.ifvmIsNotEmpty(v_targetNm)){
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetNm'), result.unMaskCustNm);
            	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetHhpNo'), result.unMaskHhp);
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNmChk'), result.unMaskCustNm);
        	} else if($.fn.ifvmIsEmpty(v_targetHhpNo) && $.fn.ifvmIsEmpty(v_targetNm)) {
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNmChk'), result.unMaskCustNm);
        	} else if($.fn.ifvmIsEmpty(v_targetHhpNo) && $.fn.ifvmIsNotEmpty(v_targetNm)) {
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetNm'), result.unMaskCustNm);
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNmChk'), result.unMaskCustNm);
        	} else if($.fn.ifvmIsNotEmpty(v_targetHhpNo) && $.fn.ifvmIsEmpty(v_targetNm)) {
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetHhpNo'), result.unMaskHhp);
        		gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNmChk'), result.unMaskCustNm);
        	} */
        });
    } else {
    	alert('해당 회원정보가 없습니다.');
    }
}

$(document).ready(function() {
	allSearchFn();
	upldItemSearch;
    //공통 조회 조건 목록 설정
	$("#excelListBtn").on('click', function() {
      	$.ifvExcelDn('/system/batchRgst/getPntUpldItemDown.do','upldItemListGrid' );
    });
});
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="allSearchBtn"      btnFunc="allSearchFn" objCode="pntAllSearchBtn_obj"/>
 			<ifvm:inputNew type="button"   btnType="search"  text="L01667"  id="sucesSearchBtn"    btnFunc="sucesSearchFn" objCode="succesSearchBtn_obj"/>
 			<ifvm:inputNew type="button"   btnType="search"  text="L01668"  id="failSearchBtn"     btnFunc="failSearchFn" objCode="failSearchBtn2_obj"/>
 			<%--<ifvm:inputNew type="button"   btnType="search"  text="처리대기중조회" nuc="true" id="workingSearchBtn"  btnFunc="workingSearchFn" objCode="pntUpldItemListWork_OBJ"/>--%>
 			<ifvm:inputNew type="button"   btnType="save"    text="L00326"  id="clearMaskBtn"      btnFunc="clearMaskFn" objCode="pntClearMaskBtn_obj"/>
 			<ifvm:inputNew type="button"   btnType="save"    text="엑셀다운로드"  nuc="true" id="excelListBtn"  btnFunc="excelListBtn" objCode="excelListBtn2_obj"/>
        </div>
    </div>
    <div id="upldItemListGrid" class="white_bg grid_bd0"></div>
</div>
