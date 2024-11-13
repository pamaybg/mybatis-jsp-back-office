<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
    </div>
    <div id="mbrGroupPointStandardGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
//mbrGroupPointStandard


gMbrGroupPointStandard = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrGroupAddInfo.data.ridAcrlRule;
		    	 data.listType="SAVE";
		    	 //data.rid = '1-1NTT6';
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     },
		     loadComplete : function(result){

		     },
		     url : '<ifvm:action name="getPointItemBaseList"/>',
		     colNames:[
		               '<spring:message code="L01564"/>',
		               '<spring:message code="L01565"/>',
		               '<spring:message code="L01566"/>',
		               '<spring:message code="L01567"/>',
		               '<spring:message code="L01568"/>',
		               '<spring:message code="L01569"/>',
		               '<spring:message code="L01570"/>',
		               '<spring:message code="L01571"/>',
		               'rid'
		             ],
		    colModel:[
		         { name:'mbrDivCd',   	index:'cc1.mark_name',  	resizable : true, align:'center',   width:'100px' },
	             { name:'tierCd',   	index:'cc2.mark_name',  	resizable : true, align:'center',   width:'100px' },
	             { name:'acrlUnit',   	index:'cc3.mark_name',  	resizable : true, align:'center',   width:'100px' },
	             { name:'acrlPnt',  	index:'lpbi.acrl_pnt',  	resizable : true, align:'right',    width:'120px', formatter:'integer'  },
	             { name:'acrlPntLmt',   index:'lpbi.acrl_pnt_lmt',  resizable : true, align:'right',    width:'120px', formatter:numberCommaForamtter },
	             { name:'activeYn',   	index:'lpbi.active_yn',  	resizable : true, align:'center',   width:'80px',   },
	             { name:'aplyStartDd',  index:'lpbi.aply_start_dd', resizable : true, align:'center',   width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
	             { name:'aplyEndDd',   	index:'lpbi.aply_end_dd',  	resizable : true, align:'center',   width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
		         { name:'rid', 	   		hidden:true },
		    ],
		     sortname: 'lpbi.create_date',
		     autowidth : true ,
		     
		     sortorder: "desc"
		},
		init : function (){
			mbrGroupPointStandard = $("#mbrGroupPointStandardGrid").ifvGrid({ jqGridOption : gMbrGroupPointStandard.jqGridOption });
		},

}
gMbrGroupPointStandard.init();
function numberCommaForamtter(cellvalue, options, rowObjec){
    var pnt = rowObjec.acrlPntLmt;
	if(pnt!=null){
	    pnt = Math.round(pnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}else{
		pnt = '';
	}
	return pnt;
}

</script>






