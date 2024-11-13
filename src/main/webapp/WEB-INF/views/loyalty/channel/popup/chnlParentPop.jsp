<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="chnlParentGridList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="chnlParentPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="ChnlPopCancel" objCode="chnlParentPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script>
var chnlParentGridList = null;
var parChnlRid;
var parChnlNm;

function parentChnlListSetting(){
	var ejGridOption = {
			rowSelected : function (args) {
				parChnlRid = args.data.rid;
				parChnlNm = args.data.chnlNm;
        },
		serializeGridData : function( data ){
			chnlTypeCd = $('#chnlTypeCd').val();
			data.chnlTypeCd = chnlTypeCd;
			return data;
		},
        dataUrl : '<ifvm:action name="getParentChnlTList"/>',
        columns:[
        	  {
        		  field : 'chnlNo', headerText : '<spring:message code="채널 번호"/>', headerTextAlign : 'center' , textAlign : 'center', customAttributes : {searchable : true}
        	  },{
        		  field : 'chnlNm', headerText : '<spring:message code="M02706"/>', headerTextAlign : 'center' ,customAttributes : {searchable : true}
        	  },{
          		  field : 'statCdNm', headerText : '<spring:message code="L00271"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'statCd'}
          	  },{
          		  field : 'rid', headerText : 'rid',visible : false 
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
        radio: true,
      };
	chnlParentGridList = $("#chnlParentGridList").ifvsfGrid({ ejGridOption : ejGridOption });
};


function chnlListSetup() {
	if($.fn.ifvmIsEmpty(chnlParentGridList.opt.gridControl.getSelectedRecords()[0])){
		alert('<spring:message code="M00285"/>');
	}else {
		$('#parChnlNm').val(parChnlNm);
		chnlPopclose();
	}
}

$(document).ready(function() {
	parentChnlListSetting();
	
	//마스킹해제 클릭시
    $('#btnSelect').on('click', function(){
    	chnlListSetup();
    });
	
  //마스킹해제 클릭시
    $('#ChnlPopCancel').on('click', function(){
    	chnlPopclose();
    });
})
</script>