<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskingBtn" text="L00326" btnFunc="gMbrChangeHistList.clearMasking" objCode="changeHistClearMask_obj"/>
        </div>
    </div>
    <div id="mbrChangeHistListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>
<script type="text/javascript">
	gMbrChangeHistList = {
		ejGridOption : {
	       	serializeGridData : function(data) {
	       	 	data.mbrRid = gMbrDetail.data.rid;
	         	return data;
	       	},
	       	// row 선택시 암호화 상태에 따른 마스킹해제버튼 활성화
	       	rowSelected : function (args) {
	       	    var data = args.data;
	        	if (data.achngData || data.bchngData) {
	        	    console.log(data.achngData.indexOf('*'))
	        		if (data.bchngData.indexOf('*') > -1 || data.achngData.indexOf('*') > -1) {
		        		if (data.achngData == "****" && data.bchngData == "****") {
		        			return;
		        		}
		        		$("#clearMaskingBtn").prop('disabled', false);
		        	}
	        		else {
		        		$("#clearMaskingBtn").prop('disabled', true);
		        	}
	        	}
	        	else {
	        		$("#clearMaskingBtn").prop('disabled',true);
	        	}
	        },
	        loadComplete : function(obj) {
	        	console.log(obj);
	        	$("#clearMaskingBtn").prop('disabled',true);
	        	window.top.setParentIframeHeight();
	        },
	        dataUrl : '<ifvm:action name="getMbrChangeHistList"/>',
	        columns:[
	        		{
	         		  field : 'createDate', headerText : '<spring:message code="L01156"/>', headerTextAlign : 'center',
	         		  customAttributes : {
	         			  index : 'a.create_date' }
	         	  },/* {
	         		  field : 'createBy', headerText : '<spring:message code="L01157"/>', headerTextAlign : 'center',
	         		  customAttributes : {
	         			  index : 'e.name' } 
	         	  }, */{
	         		  field : 'chgCol', headerText : '<spring:message code="L01158"/>', headerTextAlign : 'center',
	         		  customAttributes : {
	         			  index : 'b.mark_name' }
	         	  },{
	         		  field : 'bchngData', headerText : '<spring:message code="L01159"/>', headerTextAlign : 'center',
	         		  customAttributes : {
	         			  index : 'a.bchng_data' }
	         	  },{
	         		  field : 'achngData', headerText : '<spring:message code="L01160"/>', headerTextAlign : 'center',
	         		  customAttributes : {
	         			  index : 'a.achng_data' }
	         	  },{
	         		  field : 'chgPstn', headerText : '<spring:message code="L01161"/>', headerTextAlign : 'center' ,visible : false,
	         		  customAttributes : {
	         			  index : 'a.chg_pstn' }
	         	  },{
	         		  field : 'rmark', headerText : '<spring:message code="L01162"/>', headerTextAlign : 'center' ,visible : false,
	         		  customAttributes : {
	         			  index : 'a.rmark' }
	         	  },{
	         		  field : 'rid', headerText : 'rid',visible : false,
	         		  customAttributes : {
	         			  index : 'a.rid' }
	         	  },
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10 ,
	        	 sidx : 'a.create_date' ,
	        	 sord : 'desc' ,
	        	 _search : false
	         },
			rowList : [10, 25, 50, 100],
		    radio : true
	    },
	    // 마스킹 해제
	    clearMasking : function() {
	    	var selectedRid = mbrChangeHistList.opt.gridControl.getSelectedRecords()[0].rid;
			var targetField = [{
				type : 'chgHist',
				field : 'bData',
				rid : selectedRid,
				target : 'bchngData'
			}, {
				type : 'chgHist',
				field : 'aData',
				rid : selectedRid,
				target : 'achngData'
			}]

			for (var i = 0  ; i < targetField.length ; i++) {
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
				targetField[i],
		        function(result) {
		        	var gridObj = mbrChangeHistList.opt.gridControl;
		        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
					if (i == 0)
			        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('bchngData'), result.message);
					else
			        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('achngData'), result.message);
				});
			}
	    },
	    checkButtnAuth : function() {
	    	var isAuth = false;
	    	var authArr = $.ifvmGetAuthInfo().authList;
	    	for(var i = 0 ; i < authArr.length ; i++){
	    		var authObj = authArr[i];
	    		var authName = authObj.authName;
	    		if(authName == 'E10010') isAuth = true;
	    	}
	    	if(!isAuth){
	    		$("#clearMaskingBtn").remove();
	    	}
	    }
}
//gMbrChangeHistList.checkButtnAuth();
mbrChangeHistList = $("#mbrChangeHistListGrid").ifvsfGrid({ ejGridOption : gMbrChangeHistList.ejGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>







