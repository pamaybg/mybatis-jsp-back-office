<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/marketing/common/common/common.jsp" />
<script>

var imageFileLimitGrid;

//이미지, 파일 제한 그리드
function imageFileLimitGrid(){
	$.ifvSyncPostJSON('<ifvm:action name="getChnlId"/>',{
		chnltype : chnlCode
	},function(result) {
		chnltypeId = result.chnlId
	});
	
	var jqGridOption = {	
		   onSelectCell : function (data) {
				selectChilRow = data.id;    
		   },
		   url:'<ifvm:action name="getImgOption"/>',
		    serializeGridData : function( data ){
				data.mktChlId = chnltypeId
			},
			
		    colNames:[
		              '<spring:message code="M00490"/>', 
		              '<spring:message code="M00491"/>', 
		              '<spring:message code="M00492"/>', 
		              '<spring:message code="M00493"/>', 
		              '<spring:message code="M00494"/>',
		              'id'
		              ],
		    colModel:[
		        {name:'upldType',index:'mcc.upld_type', resizable : false},
		        {name:'upldEtsionCd',index:'c1.mark_name', resizable : false},
		        {name:'maxVol',index:'mcc.max_vol', resizable : false,formatter: $.fn.comma,align:"right"},
		        {name:'imgResolW',index:'mcc.img_resol_w', resizable : false,align:"right"}, 
		        {name:'imgResolH',index:'mcc.img_resol_h', resizable : false,align:"right"},
		        {name:'id', index:'id', resizable : false,  hidden : true,  searchable : false}

		    ],
	    width : 756,
	    sortname: 'mcc.upld_type',
		sortorder: "asc",
	    tempId : 'LimitPopTemplete'
	    ,emptyRows : true
	};
	imageFileLimitGrid = $("#imageFileLimitGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	imageFileLimitGrid();
	
	//var chnlCode = "EMAIL"
	
	$.ifvSyncPostJSON('<ifvm:action name="getChnlId"/>',{
		chnltype : chnlCode
	},function(result) {
		chnltypeId = result.chnlId
	});
});	
	
</script>
<script id="LimitPopTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<div id="barcodeListArea">
	<div class="pop_inner_wrap">	
		<div id="imageFileLimitGrid" class="pop_grid2"></div>
	</div>

</div>	
