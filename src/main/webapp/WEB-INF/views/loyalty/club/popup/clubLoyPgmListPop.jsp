<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="programListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="clubLoyPgmListSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="pgmPopBtnCancel" objCode="clubLoyPgmListCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var loyProgramList = null;
var loyPgmRid;
var loyPgmNm;
var loyPgmNo;

function programListSetting(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				loyPgmRid = data.rid;
				loyPgmNm = data.pgmNm;
				loyPgmNo = data.pgmNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getLoyPgmTList"/>',
        columns:[
        	{
        		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', customAttributes :{searchable : true}
        	  },{
          		  field : 'pgmNo', headerText : '<spring:message code="L00036"/>',textAlign : 'center',  customAttributes :{searchable : true}
          	  },{
          		  field : 'statCd', headerText : '<spring:message code="L00039"/>',textAlign : 'center', customAttributes :{searchable : true}
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="M00222"/>',textAlign : 'center', customAttributes :{searchable : true}
          	  },{
          		  field : 'rid', headerText : 'rid',visible : false 
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '3',
      	  sord : 'ASC',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
      };
	loyProgramList = $("#programListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	programListSetting();

	$("#btnSelect").on('click', function(){
   		$('#pgmNm').val(loyPgmNm);
   		$('#loyPgmRid').val(loyPgmRid);
   		loyPgmTPopupClose();
	});
	
	$("#pgmPopBtnCancel").on('click', function(){
		loyPgmTPopupClose();
	}); 
});

</script>
