<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="chnlLoyPgmListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="chnlLoyPgmListPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="pgmChnlPopBtnCancel" objCode="chnlLoyPgmListPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var chnlLoyPgmListGrid = null;
var PgmNm;
var PgmNo;

function programListSetting(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				pgmChnlRid = data.rid;
				pgmRid = data.pgmRid;
				pgmNm  = data.pgmNm;
				pgmNo  = data.pgmNo;
        },
		serializeGridData : function( data ){
			data.chnlRid = channelDetail_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getChnlLoyPgmListNew"/>',
        columns : [
        	{
      		  field : 'pgmNo', headerText : '프로그램ID', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'pgmNm', headerText : '프로그램명', headerTextAlign : 'center', width:'300px', customAttributes :{searchable : true}
    	  },{
    		  field : 'useYn', headerText : '사용여부', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'pntAcrlYn', headerText : '포인트적립', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'pntRdmYn', headerText : '포인트사용', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'evtYn', headerText : '이벤트참여', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'pgmRid', headerText : 'pgmRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
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
	chnlLoyPgmListGrid = $("#chnlLoyPgmListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	programListSetting();

	$("#btnSelect").on('click', function(){
		if(chnlLoyPgmListGrid.opt.gridControl.getSelectedRecords().length==0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$('#pgmNo').val(pgmNo);
    		$('#pgmNm').val(pgmNm);
    		chnlLoyPgmListClosePop();
    	}
	});
	
	$("#pgmChnlPopBtnCancel").on('click', function(){
		chnlLoyPgmListClosePop();
	}); 
});

</script>
