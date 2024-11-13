<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var programList = null;
var progRid = null;

function programListSetting(){
	var ejGridOption = {
			recordDoubleClick : function (args) {
			
		},rowSelected : function (args) {
			progRid=args.data.pgmRid;
        },
		serializeGridData : function( data ){
			data.prgId = pgmId;
			data.authId = authId;
			return data;
		},
        dataUrl : '<ifvm:action name="getAuthProgramListPop"/>',
        columns:[
        	{
        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', textAlign : 'center', customAttributes :{searchable : true}
        	  },{
          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', textAlign : 'center', customAttributes :{searchable : true}
          	  },{
          		  field : 'pgmType', headerText : '<spring:message code="I02046"/>', textAlign : 'center', customAttributes :{index : 'pgmTypeCd'}
          	  },{
          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="I02056"/>', textAlign : 'center', customAttributes :{searchable : true}
          	  },{
          		  field : 'pgmRid', headerText : 'id',visible : false ,
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'pgmRid',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
      };
	programList = $("#programListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function addProgramAuth() {
	if(programList.opt.gridControl.getSelectedRecords().length==0) {
		alert('<spring:message code="M00285"/>');
	} else {
		$.ifvSyncPostJSON('<ifvm:action name="addProgramAuth"/>', {
			prgId  : progRid,
			authId : authId
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00624"/>');
	                programPopupClose();
	                programAuthList._doAjax();
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
	<button class="btn btn-sm btn_gray"  id="selectprogramBtn" onClick="addProgramAuth()" objCode="getprogramPopSelectBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="I02075" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="programPopupClose()" objCode="getprogramPopCloseBtn_OBJ"><spring:message code="M00441" /></button>
</div>
