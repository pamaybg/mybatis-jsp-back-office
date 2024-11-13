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
var ridPar;
var uploadRslt="";
var testViewList_rid = '<%=cleanXss(request.getParameter("rid"))%>';
function upldItemSearch(){
    var ejGridOption = {
       serializeGridData : function( data ){
    	   data.parRid = ridPar
        	   data.uploadRslt = uploadRslt
           return data;
        },
        loadComplete : function(obj){
        	if(obj._currentJsonData.length>0){
        		ridPar = obj._currentJsonData[0].ridPar
        	}
        },
        dataUrl : '<ifvm:action name="getUpldItemList"/>',
        columns:[
        	{
	      		  field : 'uploadRslt', headerText : '<spring:message code="L01646"/>', headerTextAlign : 'center', /*성공/실패 */
	      	  },{
	      		  field : 'typeCdNm', headerText : '<spring:message code="L01647"/>', headerTextAlign : 'center', /*거래유형 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="L01649"/>', headerTextAlign : 'center', /*회원번호 */
	      	  },{
	      		  field : 'reqPoint', headerText : '<spring:message code="L01650"/>', headerTextAlign : 'center', /*요청포인트 */
	      	  },{
	      		  field : 'memStatusCdNm', headerText : '<spring:message code="L01653"/>', headerTextAlign : 'center', /*회원상태 */
	      	  },{
	      		  field : 'chnlNo', headerText : '<spring:message code="L01654"/>', headerTextAlign : 'center', /*가맹점코드 */
	      	  },{
	      		  field : 'statusCdNm', headerText : '<spring:message code="L01656"/>', headerTextAlign : 'center', /*처리상태 */
	      	  },{
	      		  field : 'requestDt', headerText : '<spring:message code="L01657"/>', headerTextAlign : 'center', /*요청일시 */
	      	  },{
	      		  field : 'requestId', headerText : '<spring:message code="L01658"/>', headerTextAlign : 'center', /*요청자 */
	      	  },{
	      		  field : 'terminalCdNm', headerText : '<spring:message code="L01659"/>', headerTextAlign : 'center', /*승인요청기관 */
	      	  },{
	      		  field : 'txnDt', headerText : '<spring:message code="L01660"/>', headerTextAlign : 'center', /*거래일시 */
	      	  },{
	      		  field : 'txnNum', headerText : '<spring:message code="L01661"/>', headerTextAlign : 'center', /*거래추적번호 */
	      	  },{
	      		  field : 'approvalDt', headerText : '<spring:message code="L01662"/>', headerTextAlign : 'center', /*VAN 승인일자 */
	      	  },{
	      		  field : 'approvalNum', headerText : '<spring:message code="L01663"/>', headerTextAlign : 'center', /*승인번호 */
	      	  },{
	      		  field : 'returnCdNm', headerText : '<spring:message code="L01664"/>', headerTextAlign : 'center', /*승인응답 */
	      	  },{
	      		  field : 'returnText', headerText : '<spring:message code="L01665"/>', headerTextAlign : 'center', /*처리실패 메시지 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false, /*rid */
	      	  },{
	      		  field : 'carridPardNum', headerText : 'ridPar',visible : false, /*ridPar */
	      	  },{
	      		  field : 'memDivCd', headerText : 'memDivCd',visible : false, /*memDivCd */
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'uploadRslt',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    upldItemList = $("#upldItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
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
}


function pointStandardDtlFn(){
 	var url = "<ifvm:url name='standardPointDetail'/>";
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='standardPointDetail'/>");
}

function tabContent(){
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="pointSaveListInfo"/>'},
		]
	});
}

function allSearchFn(){
	uploadRslt =""
	upldItemSearch();
}
function sucesSearchFn(){
	uploadRslt ="S"
	upldItemSearch();
}

function failSearchFn(){
	uploadRslt ="F"
	upldItemSearch();
}
$(document).ready(function() {
	allSearchFn();
	sucesSearchFn();
	upldItemSearch;
    //공통 조회 조건 목록 설정
});
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="allSearchBtn" btnFunc="allSearchFn"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01667"  id="sucesSearchBtn" btnFunc="sucesSearchFn"/>
 			<ifvm:inputNew type="button"   btnType="search" text="L01668"  id="failSearchBtn" btnFunc="failSearchFn"/>
        </div>
    </div>
    <div id="upldItemListGrid" class="white_bg grid_bd0"></div>
</div>
