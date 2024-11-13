<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<script type="text/javascript">
var programList = null;
var childprgId = null;

function programListSetting(){
	var ejGridOption = {
			recordDoubleClick : function (args) {
			
		},rowSelected : function (args) {
			childprgId=args.data.id;
        },
		serializeGridData : function( data ){
			data.prgId=pgmId;
			return data;
		},
        dataUrl : '<ifvm:action name="getProgramListPop"/>',
        columns:[
        	{
        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>',  textAlign : 'center',customAttributes : {searchable : true, index : 'p.pgm_no'}
        	  },{
          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', textAlign : 'center',customAttributes : {searchable : true, index : 'p.pgm_nm'}
          	  },{
          		  field : 'pgmType', headerText : '<spring:message code="I02046"/>',  textAlign : 'center',
          	  },{
          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes : {searchable : true, index : 'p.pgm_path'}
          	  },{
          		  field : 'prog_crea', headerText : '<spring:message code="I02055"/>',  textAlign : 'center',
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="I02056"/>',  textAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id',visible : false 
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'createDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
      };
	programList = $("#programListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function selectprogram() {
	if(programList.opt.gridControl.getSelectedRecords().length==0) {
		alert('<spring:message code="M00285"/>');
	} else {
		$.ifvSyncPostJSON('<ifvm:action name="editProgramDown"/>', {
			prgId : pgmId,
			childprgId : childprgId
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00624"/>');
	                programPopupClose();
	                programListCon._doAjax();
	            }
	        }
		});
	}
}


$(document).ready(function() {
	programListSetting();

});

</script>


<div id="programListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectprogramBtn" onClick="selectprogram()" objCode="getprogramPopSelectBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="I02113" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="programPopupClose()" objCode="getprogramPopCloseBtn_OBJ"><spring:message code="M00441" /></button>
</div>
