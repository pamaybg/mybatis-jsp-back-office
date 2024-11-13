<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="chnlTgtGrpIncList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnChnlTgtGrpPopSelect" objCode="chnlTgtGrpSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btntChnlTgtGtpPopCancel" objCode="chnlTgtGrpCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var chnlTgtGrpIncList = null;
var chnlTgtGrpId;
var chnlTgtGrpNm;
var chnlTgtGrpNo;


function getChnlTgtGrpList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			chnlTgtGrpId = data.rid;
			chnlTgtGrpNm = data.chnlTgtGrpNm;
			chnlTgtGrpNo = data.chnlTgtGrpNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getChnlTgtGrpList"/>',
        columns:[
        	{
        		field : 'chnlTgtGrpNo', headerText : '채널군번호',textAlign : 'center', customAttributes :{searchable : true, index : 'lcg.TGT_GRP_NO'}
        	  },{
        		  field : 'chnlTgtGrpNm', headerText : '채널군명',textAlign : 'left',  customAttributes :{searchable : true, index : 'lcg.TGT_GRP_NM'}
        	  },{
        		  field : 'id', headerText : 'id', visible : false 
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
        },
        radio: true
      };
	chnlTgtGrpIncList = $("#chnlTgtGrpIncList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getChnlTgtGrpList();
	
	$("#btnChnlTgtGrpPopSelect").click(function(){
		if(chnlTgtGrpIncList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#chnlTgtGrpNo').val(chnlTgtGrpNo);
    		$('#chnlTgtGrpNm').val(chnlTgtGrpNm);
    		$('#ac1JoinChnlNo').val(chnlTgtGrpNo);
    		$('#ac1JoinChnlNm').val(chnlTgtGrpNm);
    		$('#chnlGrpNo').val(chnlTgtGrpNo);
    		$('#chnlGrpNm').val(chnlTgtGrpNm);
    		$('#chnlGrpRid').val(chnlTgtGrpId);
    		chnlTgtGrpRid = chnlTgtGrpId;
    		ac1JoinChnlTgtGrpRid = chnlTgtGrpId;
    		promAc1CardChnlTgtRid = chnlTgtGrpId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btntChnlTgtGtpPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>