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
			<ifvm:inputNew type="button" id="clearMaskingBtn" text="L00326" btnFunc="gMbrChangeHistList.clearMasking" objCode="LOY_MAS_004"/>
        </div>
    </div>
    <div id="mbrChangeHistListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>
<script type="text/javascript">
gMbrChangeHistList = {
		jqGridOption : {
	        ondblClickRow : function(data){
	        },
	        onSelectRow : function (data) {
	        	if(data.achngData || data.bchngData){
	        		if(data.bchngData.indexOf('*')>-1 || data.achngData.indexOf('*')>-1){
		        		if(data.achngData == "****" && data.bchngData == "****"){
		        			return;
		        		}
		        		$("#clearMaskingBtn").prop('disabled',false);
		        	}else{
		        		$("#clearMaskingBtn").prop('disabled',true);
		        	}
	        	}else{
	        		$("#clearMaskingBtn").prop('disabled',true);
	        	}
	        },
	       serializeGridData : function( data ){
	       	 data.mbrRid = gMbrDetail.data.rid;
	         return data;
	        },
	        loadComplete : function(obj){
	        	$("#clearMaskingBtn").prop('disabled',true);
	        	window.top.setParentIframeHeight();
	        },
	        url : '<ifvm:action name="getMbrChangeHistList"/>',
	        colNames:[
	                   '<spring:message code="L01156" />',
	                   '<spring:message code="L01157" />',
	                   '<spring:message code="L01158" />',
	                   '<spring:message code="L01159" />',
	                   '<spring:message code="L01160" />',
	                   '<spring:message code="L01161" />',
	                   '<spring:message code="L01162" />',
	                   'rid'
	                 ],
	        colModel:[
	             { name:'createDate',   index:'a.create_date',  resizable : true, align:'center',    width:'100px', formatter : 'date',	formatoptions:{newformat:"Y-m-d H:i:s"} },
	             { name:'createBy',   	index:'e.name',  		resizable : true, align:'center',    width:'100px' },
	             { name:'chgCol',   	index:'b.mark_name ',  	resizable : true, align:'center',    width:'100px' },
	             { name:'bchngData',   	index:'a.bchng_data',  	resizable : true, align:'center',    width:'100px' },
	             { name:'achngData',   	index:'a.achng_data',  	resizable : true, align:'center',    width:'100px' },
	             { name:'chgPstn',   	index:'a.chg_pstn',  	resizable : true, align:'center',    width:'100px' },
	             { name:'rmark',   		index:'a.rmark',  		resizable : true, align:'center',    width:'100px' },
	             { name:'rid',    		index:'a.rid',    hidden : true}
	        ],
	        sortname: 'a.create_date',
	        autowidth : true ,
	        sortorder: "desc",

		    radio : true
	    },
	    clearMasking : function(){
	    	var selectedRid = mbrChangeHistList.getCheckedList()[0].rid;
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

			for (var i=0  ; i < targetField.length ; i++){
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
						targetField[i],
		        function(result) {
					var rowid = mbrChangeHistList.getRadioSelectedRowId();
					mbrChangeHistList.opt.grid.setCell(rowid , targetField[i].target , result.message );
			     })
			}
	    },
	    checkButtnAuth : function(){
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
mbrChangeHistList = $("#mbrChangeHistListGrid").ifvGrid({ jqGridOption : gMbrChangeHistList.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>







