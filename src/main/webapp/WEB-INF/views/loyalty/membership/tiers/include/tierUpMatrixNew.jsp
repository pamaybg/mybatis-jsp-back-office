<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var tierupMatrixList;
var tierupMatrixRid;
var tierMatrixType='<%= cleanXss(request.getParameter("type")) %>';

//팝업 닫기
function tiersDtlPopClose() {
	popdialog._destroy();
}


//타겟 레벨 삭제
function removeTierup(){
	var selectData = tierupMatrixList.opt.gridControl.getSelectedRecords();
	ridTierupMatrix = [];
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			
			var data = {
					ridTierupMatrix	: selectData[0].rid
					, type : tierMatrixType
			};
			
			$.ifvSyncPostJSON('<ifvm:action name="removeTierRuleDetail"/>', data	
			,function(result) {
				alert('<spring:message code="M00622"/>');
				tierupMatrixListInit();
			});
		}
	}
}


function tierupMatrixListInit(){
	var ejGridOption = {
		recordDoubleClick : function(data){
   			var data = tierupMatrixList.getRowData()[data-1];
   			tierupMatrixRid = data.rid;
   			tierupMatrixPopInit();
		},
		serializeGridData : function(data){
			data.ridTierGroup = ridTierGroup;
			data.type = tierMatrixType;
		},		
		dataUrl: '<ifvm:action name="getTierUpMatrixList"/>',
		columns:[
			  {
	      		  field : 'memTypeCd', headerText : '<spring:message code="L01686"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'tierCd', headerText : '<spring:message code="L01691"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'valueTierCd', headerText : '<spring:message code="L01687"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'startValue', headerText : '<spring:message code="L01688"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'limitValue', headerText : '<spring:message code="L01689"/>', headerTextAlign : 'center', width:'80px',
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'memTypeCd',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
		radio:true,
	    
	};
	tierupMatrixList = $("#tierupMatrixList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//팝업.
function tierupMatrixPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierRulePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01985" />',
        width: '800px',
        close : 'tiersDtlPopClose',
    });
}
 

$(document).ready(function(){
	tierupMatrixListInit();
	
	//추가
	$("#addTierupBtn").on("click", function(){
		tierupMatrixRid = null;
		tierupMatrixPopInit();
	});
	
	//채널삭제
	$("#delTierupBtn").on("click", function(){
		removeTierup();
	});
	
	if(ridTierGroup != null){ 
		$("#addTierupBtn").attr("disabled",false);
		$("#delTierupBtn").attr("disabled",false);
	}else{ 
		$("#addTierupBtn").attr("disabled",true);
		$("#delTierupBtn").attr("disabled",true);
	}
	
});

</script>
	
<div class="page_btn_area">
	<div class="col-xs-7">
		 <spring:message code="M01986" />
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTierupBtn">
			<i class="fa fa-plus"></i>
			<spring:message code="M01852"/>
		</button> 
		<button class="btn btn-sm" id="delTierupBtn">
			<i class="fa fa-minus"></i>
			<spring:message code="M01854"/>
		</button> 
	</div>
</div>
<div id="tierupMatrixList" class="grid_bd0"></div>

