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
<script type="text/javascript">
var offerSearchHelpGrid;
var gridIdofferSearchHelp;
var rid ;
var offerObj=null;
<%-- var prodNm = decodeURIComponent('<%= request.getParameter("prodNm") %>') --%>

//
function getofferSearchHelpSearch(){
    var ejGridOption = {
            serializeGridData : function( data ) {
                data.type = 'MKT';
                if (requestitem != null && requestitem.length > 0) {
                    data.item = requestitem;
                }
                return data;
            },
            rowSelected : function (selectedData)
            {
            	offerObj=selectedData.data;
                //location.href = '<ifvm:url name="MKTOfferDetail"/>?id='+data.id;
                /* qtjs.href('<ifvm:url name="MKTOfferDetail"/>?id='+selectedData.data.id); */
            },

//             loadComplete : function(obj) {
//             },
            dataUrl: '<ifvm:action name="getListOffer"/>',
            columns:[
            	  {
    	      		  field : 'offerNo', headerText : '<spring:message code="M00313"/>', headerTextAlign : 'center', width:'80px', textAlign : ej.TextAlign.Center,
    	      		  customAttributes : {
    	      			  index : 'mof.offer_no' }/* */
    	      	  }, {
    	      		  field : 'offerName', headerText : '<spring:message code="M00314"/>', headerTextAlign : 'center', width:'140px',
    	      		  customAttributes : {
    	      			  index : 'mof.offer_nm' }/* */
    	      	  }, {
    	      		  field : 'offerTypeCd', headerText : '<spring:message code="M00319"/>', headerTextAlign : 'center', width:'60px',textAlign : ej.TextAlign.Center,
    	      		  customAttributes : {
    	      			  index : 'c2.mark_name' }/* */
    	      	  }, {
    	      		  field : 'offerSubTypeNm', headerText : '<spring:message code="M01896"/>', headerTextAlign : 'center',width:'60px',textAlign : ej.TextAlign.Center,
    	      		  customAttributes : {
    	      			  index : 'c8.mark_name' }/* */
    	      	  }, {
    	      		  field : 'offerEcnrsDivNm', headerText : '<spring:message code="M02276"/>', headerTextAlign : 'center', width:'40px', textAlign :ej.TextAlign.Center,
    	      		  customAttributes : {
    	      			  index : 'c9.mark_name' }/* */
    	      	  }, {
    	      		  field : 'offerUseDeskDivNm', headerText : '<spring:message code="M02275"/>', headerTextAlign : 'center', width:'40px',textAlign : ej.TextAlign.Center,
    	      		  customAttributes : {
    	      			  index : 'c9.mark_name' }/* */
    	      	  }, {
    	      		  field : 'id', headerText : 'id', visible : false ,
    	      		  customAttributes : {
    	      			searchable : false,
    	      			  index : 'lmsr.CARD_NUM' }/* */
    	      	  },
            ],
            requestGridData : {
    	      	  nd   : new Date().getTime(),
    	      	  rows : 10,
    	      	  sidx : 'mof.offer_no',
    	      	  sord : 'desc',
    	      	  _search : false
    	        },
    	    rowList : [10,25,50,100],
    		radio: true,
            tempId : 'ifvGridOriginTemplete'
        };
    offerSearchHelpGrid = $("#offerSearchHelpGrid").ifvsfGrid({ ejGridOption : ejGridOption });
//    gridIdofferSearchHelp = $("#gridIdofferSearchHelp");
}


function gridDataSetFlag(cellValue) {
    if (cellValue == '1') return 'Y';
    else return 'N';
}


//공통 조회 조건 목록 설정
function offerSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("offerSearchHelpSearchList","MKTOFR001");
}

//공통 조회 호출
function offerSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("offerSearchHelpSearchList", getofferSearchHelpSearch);
}



function defaultSearch(){

	 if(typeof offerNm != "undefined" && offerNm != "undefined"
		 && $.fn.ifvmIsNotEmpty(offerNm) && offerNm != "null") {
		 first ='';

		$("#pop_main_div_offer .SearchCondition .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm') == "offer_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(offerNm)}
			})
		}
}


//선택
function choiceofferFn(){

	if(offerObj==null){
		alert('<spring:message code="L01393" />');
		return;
	}
	offerSearchHelpPopSave(offerObj);
}
//닫기
function cancelofferSearchHelpFn(){
	offerSearchHelpPop.close();
}




$(document).ready(function() {

    //공통 조회 조건 목록 설정
    offerSearchHelpSearchInit();
    defaultSearch();
    offerSearchHelpSearch();
    //조회
    $('#offerSearchHelpSearchBtn').on('click', function(){
    	offerSearchHelpSearch();
    });

    //초기화
    $("#offerSearchHelpSearchInitBtn").on('click', function(){
    	offerSearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#offerSearchHelpSearchList input"], function(){
    	offerSearchHelpSearch();
	});

});

</script>

<div id="pop_main_div_offer">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="offerSearchHelpSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="offerSearchHelpSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="offerSearchHelpSearchList" >
	    </div>
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="offerSearchHelpGrid" class="grid_bd0"></div>
	</div>


	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceofferBtn" btnFunc="choiceofferFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelofferSearchHelpBtn" btnFunc="cancelofferSearchHelpFn"/>
	</div>
</div>
