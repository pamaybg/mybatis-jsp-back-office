<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--
-----------------------
@program Id : POP_904
@author   : knlee
@date : 2017.1.09
@description : 고객 조회/등록 공통 팝업

----------------------
-->
<script>
var custListPopGrid;

function getCustList(){
	var ejGridOption = {
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
			recordDoubleClick : function (args) {

	    },
	    dataUrl : '<ifvm:action name="getCustList"/>',
	    columns : [
	    	{
	  		  field : 'custNo', headerText : '고객번호', textAlign : 'center', customAttributes : { searchable : true }
	  	  },{
			  field : 'custNm', headerText : '고객명', customAttributes : { searchable : true }
		  },{
			  field : 'hhp', headerText : '전화번호', customAttributes : { searchable : true }
		  },{
			  field : 'custTypeCdNm', headerText : '유형',  textAlign : 'center',
			  customAttributes : {index : 'lcm.cust_type_cd'}
		  },{
			  field : 'custStatCdNm', headerText : '상태',  textAlign : 'center',
			  customAttributes : {index : 'lcm.cust_stat_cd'}
		  },{
			  field : 'sbscDate', headerText : '가입일',  textAlign : 'center', customAttributes : { searchable : true }
		  },{
			  field : 'chnlNm', headerText : '가입채널', customAttributes : { searchable : true }
		  }, {
			  field : 'createDate', headerText : '등록일시',  textAlign : 'center'
		  },{
			  field : 'rid', visible: false
		  }
	    ],
	    requestGridData : {
	  	  nd   : new Date().getTime(),
	  	  rows : 10,
	  	  sidx : '1',
	  	  sord : 'desc',
	  	  _search : false,
	    },
	    rowList : [10,25,50,100],
	    gridDataInit: false,
	    radio: true,
	    tempId : 'ifvGridSimplePageTemplete2'
	};
	custListPopGrid = $("#custListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//마스크해제
function clearMaskAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(custListPopGrid.opt.gridControl.getSelectedRecords()[0])) {
  	v_rid = custListPopGrid.opt.gridControl.getSelectedRecords()[0].rid;
  }
  else {
      alert('<spring:message code="M02219"/>');
  }

  if ($.fn.ifvmIsNotEmpty(v_rid)) {
      $.ifvSyncPostJSON('<ifvm:action name="clearMaskCustList"/>', {
          rid: v_rid
      },
      function(result) {
      	var gridObj = custListPopGrid.opt.gridControl;
      	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.hhp);
      });
  }
}

$(document).ready(function(){
	getCustList();

	//선택 클릭시
    $('#selectBtn').on('click', function(){

    	if(custListPopGrid.opt.gridControl.getSelectedRecords() == ''){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		//추후 개발
    		var dataArr = custListPopGrid.opt.gridControl.getSelectedRecords();
    		alert('<spring:message code="L00440"/>');
    		custPopupClose();
    		/* if(dataArr[0].clearMask != "Y"){
    			alert('<spring:message code="L00440"/>');
    		}else {
	  			$("#ridCust").text(dataArr[0].rid).val(dataArr[0].custNm);
	  			$("#custTypeCd").val(dataArr[0].custTypeCd); // 고객유형
	  			custPopupClose();
    		} */
    	}
    });

  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	custPopupClose();
    });

    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

	/* 고객 신규 팝업  */
	$('#addBtn').on('click', function(){
		     $.fn.ifvmPopupOpen('popupContainer1', '', '<ifvm:url name="custDetailPop"/>',  '<spring:message code="L00078"/>',860);
    });

});
</script>

<div id="pop_main_div">
	<div class="page_btn_area" id=''>
	    <div class="col-xs-7"></div>
	    <div class="col-xs-5 searchbtn_r">
	        <button class="btn btn-sm" id="clearMaskBtn">
	            <spring:message code="L00326"/></button>
	        <button class="btn btn-sm" id="addBtn">
	            <i class="fa fa-plus"></i>
	            <spring:message code="L00078"/></button>
	    </div>
	</div>
	<div class="pop_inner_wrap">
		<div id="custListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn">
	        <i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00123"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn">
	    <spring:message code="L00124"/>
	    </button>
	</div>
</div>