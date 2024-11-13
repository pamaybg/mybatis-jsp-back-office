<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="/loyalty/member/mbr/mbrDetailNewPage?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>	
</script>

<script>
var cardNoPoolList;
var mbrCardRid;

// 등급목록 조회
function getcardNoPoolListInit(){
	var ejGridOption = {
		serializeGridData : function(data){
			data.ridCardKind = ifvGlobal.cardTypeRid;
		},
 		loadComplete : function(obj){
 			$.ifvProgressControl(false);
 		},
		dataUrl: '<ifvm:action name="getCardNoPoolList"/>',
		columns:[
	    	    {
	      		  field : 'cardNo', headerText : '<spring:message code="L00414"/>', headerTextAlign : 'center', textAlign : 'center',
	      			customAttributes: { searchable: true  }
	      	  },{
                  field : 'title', headerText : '<spring:message code="L01431"/>', headerTextAlign : 'center', textAlign : 'center',
                    customAttributes: { searchable: true  }
              },{
	      		  field : 'regDt', headerText : '<spring:message code="M00840"/>', headerTextAlign : 'center', textAlign : 'center'
	      	  },{
	      		  field : 'statNm', headerText : '<spring:message code="C00125"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'statCd'}
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="E00093"/>', headerTextAlign : 'center', textAlign : 'center',
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="E00094"/>', headerTextAlign : 'center', textAlign : 'center',
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr', visible : false ,
	      	  },{
	      		  field : 'ridCardBin', headerText : 'ridCardBin', visible : false ,
	      	  },{
	      		  field : 'ridCardKind', headerText : 'ridCardKind', visible : false ,
	      	  },    
        ],
        requestGridData : {
      	  sidx : 'createDate',
        },
	    tempId : 'ifvGridOriginTemplete'
	};
	cardNoPoolList = $("#cardNoPoolList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function genCardNoBtn() {
	genCardNoPopupOpen();
}

function downCardNoBtn() {
	$.ifvExcelDn('<ifvm:action name="exportExcelCardNoPool"/>','cardNoPoolList');
}

function uploadCardNoBtn() {
	fnExcelUpload(
			{
				url: '<ifvm:action name="uploadCardNo"/>',
				fileName: $("#fileName").val(),
				data: {ridCardKind : ifvGlobal.cardTypeRid},
			}, function (result) {
				if (result.success == true) {
	            	alert('<spring:message code="C00094" />');
	            	$.ifvProgressControl(false);
	            	
	            	getcardNoPoolListInit();
				} else {
					alert(result.message);
				}
				
			}, function (){
				// File 선택 후 동작 할 액션을 정의 한다.
				//$('#impFileNm').val(fnExcelUpload.fileName);
				
				fnExcelUpload.upload();
		});
}

//샘플 다운로드
function cardNoPoolSampleDownBtn(){
	var data = {fileName : "cardNoPoolUpload_sample_data.xlsx"};
	$.fn.ifvmExcelSampleDown(data);
}

//신규 발급
function genCardNoPopupOpen(){
	$("#genCardNoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="genCardNoPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02960" />',
        width: '500px'
    });
}

$(document).ready(function(){
	// 등급목록 조회
	getcardNoPoolListInit();
});

</script>
<div class="page_btn_area">
	<div class="col-xs-7">
		 <span><spring:message code="M02960" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" id="genCardNoBtn" btnFunc="genCardNoBtn" text="번호 생성(제작용)" nuc="true" objCode="addcardNoPoolBtn_OBJ"/>
		<ifvm:inputNew type="button" id="downCardNoBtn" btnFunc="downCardNoBtn" text="다운로드" nuc="true" objCode="downCardNoBtn_OBJ"/>
		<!-- <ifvm:inputNew type="button" id="cardNoPoolSampleDownBtn" btnFunc="cardNoPoolSampleDownBtn" text="샘플 다운로드" nuc="true" objCode="removecardNoPoolBtn_obj"/> -->
		<ifvm:inputNew type="button" id="uploadCardNoBtn" btnFunc="uploadCardNoBtn" text="제작카드 업로드" nuc="true" objCode="uploadCardNoBtn_OBJ"/>
	</div>
</div>
<div id="cardNoPoolList" class="grid_bd0"></div>
<div id="genCardNoPopup" class="popup_container"></div>
