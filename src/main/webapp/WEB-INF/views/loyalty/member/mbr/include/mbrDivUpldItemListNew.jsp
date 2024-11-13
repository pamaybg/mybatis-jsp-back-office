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
<script type="text/x-jsrender" id="embLinkTemplate">
	{{if ridMbr != null}}
		{{if memDivCd == 'P' || memDivCd == 'T'}}
			<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:rid}}" style="color:#1266FF; text-decoration:underline;" >{{:e1MbrNo}}</a>
		{{else}}
			<a href="<ifvm:url name="mbrGroupDetail"/>?rid={{:rid}}" style="color:#1266FF; text-decoration:underline;" >{{:e1MbrNo}}</a>
		{{/if}}
	{{/if}}
</script>

<script type="text/javascript">
var upldItemList;
//var ridPar;
var batchResultCd="";
var testViewList_rid = '<%=cleanXss(request.getParameter("rid"))%>';
function upldItemSearch(){
    var ejGridOption = {
//         onSelectRow : function (data) {


//         },
       serializeGridData : function( data ){
			//data.parRid = ridPar
			data.ridPntUpload = rid
        	data.batchResultCd = batchResultCd
			return data;
        },
        loadComplete : function(obj){
        	if(obj._currentJsonData.length>0){
        		//ridPar = obj._currentJsonData[0].ridPar
        	}
//         	batchResultCd="";
        },
        dataUrl : '<ifvm:action name="getMbrUpldItemList"/>',
        columns:[
        	{
	      		  field : 'seq', headerText : '순서', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.seq' }/*순서 */
	      	  },{
	      		  field : 'acrlDate', headerText : '적립일시', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.acrl_date' }/*적립일시 */
	      	  },{
	      		  field : 'batchResultCdNm', headerText : '<spring:message code="L02371"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c1.mark_name' }/*처리결과 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="L02366"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.mbr_no' }/*엑셀회원번호 */
	      	  } ,{
	      		  field : 'ci', headerText : '엑셀회원CI', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.ci' }/*엑셀회원번호 */
	      	  }
	      	  ,{
	      		  field : 'targetNm', headerText : '<spring:message code="L02367"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.target_nm' }/*엑셀대상자명 */
	      	  },{
	      		  field : 'targetHhpNo', headerText : '<spring:message code="L02368"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.target_hhp_no' }/*엑셀핸드폰번호 */
	      	  },{
	      		  field : 'acrlAmt', headerText : '적립요청포인트', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.acrl_amt' }/*적립요청포인트 */
	      	  },{
	      		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mcm.cam_nm' }
	      	  },{
	      		  field : 'validStartdtBasCdNm', headerText : '적립기준일자유형', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c13.mark_name' }
	      	  },{
	      		  field : 'validStartDtnum', headerText : '혜택시작일', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lopd.VALID_START_DTNUM' }
	      	  },{
	      		  field : 'validEndDtnum', headerText : '소멸예정월', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lopd.VALID_END_DTNUM' }
	      	  },{
	      		  field : 'dividorChnlNm', headerText : '비용부서', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lc.chnl_nm' }
	      	  },{
	      		  field : 'pntAccntCodeVal', headerText : '회계코드', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mcm.PNT_ACCNT_CODE_VAL' }
	      	  },{
	      		  field : 'pntAccntBigTypeCd', headerText : '지급계정(대)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c9.mark_name' }
	      	  },{
	      		  field : 'pntAccntMidTypeCd', headerText : '지급계정(중)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c10.mark_name' }
	      	  },{
	      		  field : 'pntAccntSmlTypeCd', headerText : '지급계정(소)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c11.mark_name' }
	      	  },{
	      		  field : 'pntAccntDetailTypeCd', headerText : '지급계정(세)', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c12.mark_name' }
	      	  },{
// 	      		  field : 'validStartDate', headerText : '<spring:message code="L02369"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'lmui.valid_start_date' }/*포인트유효시작일 */
// 	      	  },{
// 	      		  field : 'validEndDate', headerText : '<spring:message code="L02370"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'lmui.valid_end_date' }/*포인트유효종료일 */
// 	      	  },{
	      		  field : 'batchErrorDesc', headerText : '<spring:message code="L02372"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmui.batch_error_desc' }/*미처리사유 */
	      	  },{
	      		  field : 'mbrNoChk', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lm.mbr_no' }/*회원번호 */
	      	  },{
	      		  field : 'custNmChk', headerText : '<spring:message code="M00850"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lc.cust_nm' }/*회원명 */
	      	  },{
	      		  field : 'mbrStatCdNmChk', headerText : '<spring:message code="M02019"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c2.mark_name' }/*회원상태 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lmui.rid' }/*rid */
	      	  },{
	      		  field : 'batchResultCd', headerText : 'batchResultCd',visible : false,
	      		  customAttributes : {
	      			  index : 'lmui.batch_result_cd' }/*batchResultCd */
	      	  },{
	      		  field : 'mbrStatCdChk', headerText : 'mbrStatCdChk',visible : false,
	      		  customAttributes : {
	      			  index : 'lm.mbr_stat_cd' }/*mbrStatCdChk */
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr',visible : false,
	      		  customAttributes : {
	      			  index : 'lm.rid' }/*ridMbr */
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lmui.seq',
	      	  sord : 'asc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    upldItemList = $("#upldItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
/* function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;

 	if( rowObjec.memDivCd == 'P' ||rowObjec.memDivCd == 'T' ){
	    var url = '<ifvm:url name="mbrDetailNew"/>' + '?rid=' + id;

	}else{
	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;

	}

    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
} */


/* function pointStandardDtlFn(){
 	var url = "<ifvm:url name='standardPointDetail'/>";
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
} */

/* function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='standardPointDetail'/>");
} */

/* function tabContent(){
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="pointSaveListInfo"/>'},
		]
	});
} */


function allSearchFn(){
	batchResultCd =""
	upldItemSearch();
}

function searchFn(){
	upldItemSearch();
}

/**
 * 마스킹해제 (핸드폰번호)
 */
function clearMaskFn() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(upldItemList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = upldItemList.opt.gridControl.getSelectedRecords()[0].ridMbr;
//     	v_rid = upldItemList.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvPostJSON('<ifvm:action name="clearMaskMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = upldItemList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('targetHhpNo'), result.hhpNo);
        });
    } else {
    	alert('해당 회원정보가 없습니다.');
    }
}

$(document).ready(function() {
	allSearchFn()
	upldItemSearch;
    //공통 조회 조건 목록 설정
 	$("#excelListBtn").on('click', function() {
      	$.ifvExcelDn('/loyalty/batchRgst/getPntUpldItemDown.do','upldItemListGrid' );
    });
});
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="searchBtn"  nuc="true"    btnFunc="searchFn"/>

 			<ifvm:inputNew type="button"   btnType="save"    text="L00326"  id="clearMaskBtn"      btnFunc="clearMaskFn"/>
 			<ifvm:inputNew type="button"   btnType="save"    text="엑셀다운로드"  nuc="true" id="excelListBtn"  btnFunc="excelListBtn"/>
        </div>
    </div>
    <div id="upldItemListGrid" class="white_bg grid_bd0"></div>
</div>
