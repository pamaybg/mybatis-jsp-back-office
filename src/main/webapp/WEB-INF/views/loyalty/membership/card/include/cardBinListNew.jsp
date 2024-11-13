<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>	
</script>

<script>
var cardBinList;
var mbrCardRid;

// 등급목록 조회
function getcardBinListInit(){
	var ejGridOption = {
		recordDoubleClick : function(args){
		    cardBinPopupOpen(true);
		},
		serializeGridData : function(data){
			data.ridCardKind = ifvGlobal.cardTypeRid;
		},
		dataUrl: '<ifvm:action name="getCardBinList"/>',
		columns:[
	    	{
	      		  field : 'startNo', headerText : '<spring:message code="M02968"/>', headerTextAlign : 'center', textAlign : 'right', customAttributes: { searchable: true }
	      	  },{
	      		  field : 'endNo', headerText : '<spring:message code="M02969"/>', headerTextAlign : 'center', textAlign : 'right', customAttributes: { searchable: true }
	      	  },{
	      		  field : 'validEndDt', headerText : '<spring:message code="O00011"/>', headerTextAlign : 'center', textAlign : 'center',
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="E00094"/>', headerTextAlign : 'center', textAlign : 'center',
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="L00044"/>', headerTextAlign : 'center', textAlign : 'center',
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      	  },
        ],
        requestGridData : {
      	  sidx : 'modifyDate',
        },
        radio: true
	};
	cardBinList = $("#cardBinList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addCardBinBtn() {
	cardBinPopupOpen(false);
}

function removeCardBinBtn() {
	if (cardBinList.opt.gridControl.getSelectedRecords().length > 0) {
		var data = cardBinList.opt.gridControl.getSelectedRecords()[0];
		
		$.ifvPostJSON('<ifvm:action name="removeCardBin"/>',{ rid : data.rid },
		        function(result) {
					alert('<spring:message code="L00034"/>');
					$.ifvProgressControl(false);
					getcardBinListInit();
				});
	} else {
		alert('<spring:message code="M01018"/>');
	}
}

//신규 발급
function cardBinPopupOpen(flag){
	$("#cardBinPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="cardBinPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02959" />',
        width: '500px',
        close : 'cardBinPopupClose',
        open : function() {
        	cardBinPopInitData(flag);
        }
    });
}

function cardBinPopupClose() {
	cardBinPopup.close();
}


$(document).ready(function(){
	// 등급목록 조회
	getcardBinListInit();

});

</script>
<div class="page_btn_area">
	<div class="col-xs-7">
		 <span><spring:message code="M02959" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" btnType="plus" text="M01852" btnFunc="addCardBinBtn" id="addCardBinBtn" objCode="cardBinListNewAddCardBinBtn_OBJ"/>
        <ifvm:inputNew type="button" btnType="minus" text="M01854" btnFunc="removeCardBinBtn" id="removeCardBinBtn" objCode="cardBinListNewRemoveCardBinBtn_OBJ"/>
	</div>
</div>
<div id="cardBinList" ></div>
<div id="cardBinPopup" class="popup_container"></div>
