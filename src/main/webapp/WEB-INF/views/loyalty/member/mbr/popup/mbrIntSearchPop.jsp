<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id='tierPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="통합회원"/></label>
	        <div class="col-xs-2 control_content">
	            <ifvm:inputNew type="text" dto="reqCustNm" id="reqCustNm" disabled="true"/>
	        </div>
	        <div class="col-xs-2 control_content">
	            <ifvm:inputNew type="text" dto="repHhp" id="repHhp" disabled="true" />
	        </div>
	        <div class="col-xs-1 control_content">
	            <ifvm:inputNew type="text" dto="reqCustTypeCd" id="reqCustTypeCd" disabled="true" />
	        </div>
	        <div class="col-xs-2 control_content">
	            <ifvm:inputNew type="text" dto="repMbrTypeCd" id="repMbrTypeCd" disabled="true" />
	        </div>
	        <div class="col-xs-1 control_content">
	            <ifvm:inputNew type="text" dto="reqSbscTypeCd" id="reqSbscTypeCd" disabled="true"  />
	        </div>
	    </div>
	</div>

</div>

<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <%-- <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="clearMaskBtn" >
                <spring:message code="L00326"/></button>
        </div> --%>
    </div>
    <div id="mbrIntListSearchGrid" class="white_bg grid_bd0"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="mbrIntSaveBtn" objCode="mbrIntSearchPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="등록"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="mbrIntPopCancel" objCode="mbrIntSearchPopCancel_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<script type="text/javascript">
var mbrIntListSearchGrid;
//고객 목록
function getMbrIntListSearchGrid(){

    var ejGridOption = {
    		loadComplete : function(obj){
        		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
        		//$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListPopGrid.opt.data.records);
            },
          	serializeGridData : function(data) {
			  var hhpNo = $("#hhp").val();
			  hhpNo = hhpNo.replace(/\-/g,'');
          	  data.encrytedCustNm = $("#cust_nm").val();
			  data.encrytedHhp = hhpNo;
              return data;
          	},
        dataUrl : '<ifvm:action name="getMbrIntListSearch"/>',
        columns: [
      	  {
      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center',textAlign : 'center'
      	  },
      	  {
      		  field : 'custTypeCdNm', headerText : '회원유형',headerTextAlign : 'center', textAlign : 'center',customAttributes : {index : 'custTypeCd'}
      	  },
      		{
      		  field : 'mbrTypeCdNm', headerText : '회원유형', headerTextAlign : 'center', textAlign : 'center' ,customAttributes : {index : 'mbrTypeCd'}
      	  },
      	  {
      		  field : 'unMaskCustNm', headerText : '회원명',headerTextAlign : 'center' ,customAttributes : {index : 'lc.cust_nm'}
      	  },
      	  {
      		  field : 'unMaskHhp', headerText : '휴대전화번호', headerTextAlign : 'center' ,customAttributes : {index : 'lc.hhp'}
      	  },
      	  {
      		  field : 'ridMbr', headerText : 'ridMbr', headerTextAlign : '',visible: false
      	  },
      	  {
      		  field : 'ridCust', headerText : 'ridCust', headerTextAlign : '',visible: false
      	  }

        ],
        requestGridData : {
      	  sidx : '3',
      	  sord : 'desc',
      	 _search : false,
        },
        rowList : [10,25,50,100],
      	radio: false,
      	tempId : 'ifvGridSimplePageTemplete2'
    };

    mbrIntListSearchGrid = $("#mbrIntListSearchGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function getMbrIntInitData() {
	$("#reqCustNm").val($("#cust_nm").val());
	$("#repHhp").val($("#hhp").val());
	$("#reqCustTypeCd").val($("#custTypeCdNm").val());
	$("#repMbrTypeCd").val($("#mbrTypeCdNm").val());
	$("#reqCustNm").val($("#cust_nm").val());
	$("#reqSbscTypeCd").val($("#sbscTypeCdNm").val());
}

function mbrIntSave() {
	if(mbrIntListSearchGrid.opt.gridControl._gridRecordsCount==0) {
		alert("통합할 대상이 없습니다.");
		return;
	}
	
	if(confirm('<spring:message code="조회된 회원은 통합회원으로 통합되며, 탈회처리 됩니다. \n 통합하시겠습니까?"/>')){
 	$.ifvSyncPostJSON('<ifvm:action name="saveTgtMbrInt"/>',{
 		tgtMbrNo : $("#mbrNo").val(),
 		ridMbr   : mbr_rid
 	}, function(result) {
		alert('<spring:message code="M00624"/>');
		mbrIntListGrid._doAjax();
		$.fn.ifvmPopupClose();
		mbrDetail();
	});
	}
}


$(document).ready(function() {
	getMbrIntInitData();
	
	getMbrIntListSearchGrid();
 


	$("#mbrIntPopCancel").click(function() {
	    mbrIntSearchPopupClose();
	}); 
	
	$("#mbrIntSaveBtn").click(function() {
		mbrIntSave();
	});

	    
});




</script>