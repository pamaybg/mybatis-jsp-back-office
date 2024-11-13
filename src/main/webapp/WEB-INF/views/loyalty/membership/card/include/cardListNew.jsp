<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="/loyalty/member/mbr/mbrDetailNewPage?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>	
</script>

<script>
var cardList;
var mbrCardRid;

// 등급목록 조회
function getCardListInit(){
	var ejGridOption = {
		recordDoubleClick : function(args){
   			var data = args.data;
   			mbrCardRid = data.rid;
			issuCardPopInit();
		},
		serializeGridData : function(data){
			data.ridCardKind = ifvGlobal.cardTypeRid;
		},
		dataUrl: '<ifvm:action name="getIssuedCardList"/>',
		columns:[
	    	{
	      		  field : 'cardNo', headerText : '<spring:message code="L00414"/>', textAlign : 'center', customAttributes : {searchable : true}
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', textAlign : 'center', template : "#mbrLinkTemplate" ,
	      	  },{
	      		  field : 'statNm', headerText : '<spring:message code="M00856"/>', textAlign : 'center', customAttributes : {index : 'stat'}
	      	  },{
	      		  field : 'issueDate', headerText : '<spring:message code="L00368"/>', textAlign : 'center', 
	      	  },{
	      		  field : 'leavDate', headerText : '<spring:message code="M01933"/>', textAlign : 'center',
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="M01922"/>', textAlign : 'center', 
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="M00185"/>', textAlign : 'center', 
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="M00335"/>', textAlign : 'center', 
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="M00334"/>', textAlign : 'center', 
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false , 
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr', visible : false , 
	      	  },           
        ],
        requestGridData : {
      	  sidx : 'createDate',
        },
	    tempId : 'ifvGridOriginTemplete'
	};
	cardList = $("#cardList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    } else {
    	tag="";
    }
    return tag;
}
//신규 발급
function issuCardPopInit(){
    // $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="issuCardPop"/>', '<spring:message code="M01934"/>');
}

$(document).ready(function(){
	// 등급목록 조회
	getCardListInit();

	//타겟 레벨 추가
	$("#addCardListBtn").on("click", function(){
		mbrCardRid = null;
		issuCardPopInit();
	});

	// 신규/수정 경우 버튼 disabled
	if(ifvGlobal.cardTypeRid == "null" || ifvGlobal.cardTypeRid == null){
		$("#addCardListBtn").attr("disabled",true);
	} else {
		$("#addCardListBtn").attr("disabled",false);
	}
});
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		 <span><spring:message code="M01935" /></span>
	</div>
</div>
<div id="cardList"></div>
