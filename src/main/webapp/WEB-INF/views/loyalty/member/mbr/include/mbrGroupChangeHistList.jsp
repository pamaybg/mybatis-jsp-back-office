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
    <div id="mbrGroupChangeHistListGrid" class="white_bg grid_bd0"></div>
</div>
<script type="text/javascript">
//mbrGroupChangeHistList

gMbrGroupChangeHistList = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = $.ifvGetParam('rid');
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrBlackList.getRowData()[rowNo-1];
		     	console.log(data);
		     },
		     loadComplete : function(result){

		     },
		     url : '<ifvm:action name="getMbrGroupChnList"/>',
		     colNames:[
		               '<spring:message code="L01573"/>',
		               '<spring:message code="L01157"/>',
		               '<spring:message code="L01574"/>',
		               '<spring:message code="L01575"/>',
		               '<spring:message code="L01576"/>',
		               '<spring:message code="L01577"/>',
		               '<spring:message code="L01578"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'createDate', 	index:'lch.create_date', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'createBy',   	index:'e.name',  			width:'80px',	align: 'center',	resizable : true },
		        { name:'chgItem', 	    index:'lch.chg_item', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'bchngVal', 		index:'lch.bchng_val', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'achngVal', 	    index:'lch.achng_val', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'cdNm', 			index:'lch.cd_nm', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'desc1', 	    index:'lch.desc1', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'rid', 	   		index:'lbh.rid', 			hidden:true },
		    ],
		     sortname: 'lch.create_date',
		     autowidth : true ,
		     
		     sortorder: "desc",

		},
		init : function (){
			mbrGroupChangeHistList = $("#mbrGroupChangeHistListGrid").ifvGrid({ jqGridOption : gMbrGroupChangeHistList.jqGridOption });
		},

}
gMbrGroupChangeHistList.init();


</script>






