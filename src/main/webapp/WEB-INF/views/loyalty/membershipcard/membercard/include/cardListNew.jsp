<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>	
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
//         onSelectRow : function (data) {
// 		},
		serializeGridData : function(data){
			data.ridCardKind = cardTypeRid;
		},
// 		loadComplete : function(obj){
// 		},
		dataUrl: '<ifvm:action name="getCardListTab"/>',
		columns:[
	    	{
	      		  field : 'cardNo', headerText : '<spring:message code="L00414"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'mc.card_no' }
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center', template : "#mbrLinkTemplate" ,
	      		  customAttributes : {
	      			  index : 'm.mbr_no' }
	      	  },{
	      		  field : 'statNm', headerText : '<spring:message code="M00856"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'cc1.mark_name' }
	      	  },{
	      		  field : 'issueDate', headerText : '<spring:message code="L00368"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'mc.issue_date' }
	      	  },{
	      		  field : 'cardLeavDate', headerText : '<spring:message code="M01933"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'mc.card_leav_date' }
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="M01922"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'c.chnl_nm' }
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="M00185"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'c.create_date' }
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="M00335"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'c.modify_date' }
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="M00334"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'e.name' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false , 
	      		  customAttributes : {
	      			  index : 'mc.rid' }
	      	  },      
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'mc.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        
        rowList : [10,25,50,100],
	    tempId : 'ifvGridOriginTemplete'
	};
	cardList = $("#cardList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}
//신규 발급
function issuCardPopInit(){
	$("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="issuCardPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01934" />',
        width: '750px',
        close : 'mainPopupClose',
    });
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
	if(cardTypeRid == "null" || cardTypeRid == null){
		$("#addCardListBtn").attr("disabled",true);
	}else{
		$("#addCardListBtn").attr("disabled",false);
	}
});

</script>
<div class="page_btn_area">
	<div class="col-xs-7">
		 <spring:message code="M01935" />
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addCardListBtn">
			<i class="fa fa-plus"></i>
			<spring:message code="M01936" />
		</button>
	</div>
</div>
<div id="cardList" class="grid_bd0"></div>
