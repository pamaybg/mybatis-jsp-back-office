<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="clubListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommClubPopSelect" objCode="btnCommClubPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommClubPopCancel" objCode="btnCommClubPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var clubListGrid = null;
var clubNm;
var clubNo;
var clubId;

function clubListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			clubId = data.rid;
			clubNm = data.clubNm;
			clubNo = data.clubNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getClubList"/>',
        columns : [
		 	 {
				field : 'clubNo', headerText : '<spring:message code="L02692"/>',  textAlign : 'center', customAttributes :{searchable : true}, width : '130px'
			}, {
				field : 'clubNm', headerText : '<spring:message code="L02693"/>', textAlign : 'left', customAttributes :{searchable : true}
			}, {
				field : 'ctgCdNm', headerText : '<spring:message code="M00180"/>',  textAlign : 'center', customAttributes : { index : 'ctgCd'}, width : '140px'
			}, {
				field : 'clubStatCdNm', headerText : '<spring:message code="M00245"/>',  textAlign : 'center', customAttributes : { index : 'clubStatCd'}, width : '140px'
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			} ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'clubNo',
      	  sord : 'ASC',
        },
        radio: true
      };
	clubListGrid = $("#clubListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	clubListSetting();
	
	$("#btnCommClubPopSelect").click(function(){
		if(clubListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#clubNo').val(clubNo);
    		$('#clubNm').val(clubNm);
    		clubRid = clubId;
    		$('#ridClub').val(clubId);
    		$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommClubPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>