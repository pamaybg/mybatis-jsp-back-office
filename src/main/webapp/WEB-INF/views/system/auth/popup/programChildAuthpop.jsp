<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var programChildListGrid = null;
var progRid = null;

function programChildListSetting(){
	var ejGridOption = {
			recordDoubleClick : function (args) {
			
		},rowSelected : function (args) {
			progRid=args.data.id;
        },
		serializeGridData : function( data ){
			data.prgId  = pgmId;
			data.authId = authId;
			return data;
		},
        dataUrl : '<ifvm:action name="getAuthProgramLChildistPop"/>',
        columns:[
        	{
        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', customAttributes :{searchable : true}
        	  },{
          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'pgmTypeCd', headerText : '<spring:message code="I02046"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="I02056"/>',
          	  },{
          		  field : 'id', headerText : 'id',visible : false ,
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
	programChildListGrid = $("#programChildListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function addProgramChildAuth() {
	if(programChildListGrid.opt.gridControl.getSelectedRecords().length==0) {
		alert('<spring:message code="M00285"/>');
	} else {
		$.ifvSyncPostJSON('<ifvm:action name="addProgramChildAuth"/>', {
			prgId  : progRid,
			authId : authId
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00624"/>');
	                programChildPopupClose();
	                programChildList._doAjax();
	            }
	        }
		});
	}
} 


$(document).ready(function() {
	programChildListSetting();

});

</script>


<div id="programChildListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectChildprogramBtn" onClick="addProgramChildAuth()" objCode="getprogramPopSelectBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="I02075" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnChildClosePop" onClick="programChildPopupClose()" objCode="getprogramPopCloseBtn_OBJ"><spring:message code="M00441" /></button>
</div>
