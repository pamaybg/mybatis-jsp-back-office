<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="pop_inner_wrap" id="tmCamAssignWrap">
	<div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="V00268"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" id="searchCondBtn" text="V00269" btnFunc="gAssignConsultant.setUnAsnTm" />
            <ifvm:inputNew type="button" id="searchCondBtn" text="V00270" btnFunc="gAssignConsultant.setUnComplTm" />
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="searchFormPopArea" >
		<div class="row">
			<ifvm:inputNew type="text" id="totTmCnt"   	dto="totTmCnt"    label="V00264" labelClass="2" conClass="2" disabled="true"/>
			<ifvm:inputNew type="text" id="unAsnTmCnt" 	dto="unAsnTmCnt"    label="V00265" labelClass="2" conClass="2" disabled="true"/>
			<ifvm:inputNew type="text" id="unComplCnt"  dto="unComplCnt"    label="V00267" labelClass="2" conClass="2"	disabled="true" />
		</div>

	</div>
    <div id="consultantListGrid" class="white_bg grid_bd0"></div>
    <script>

    </script>
</div>

<div id="addUnreceivePopDiv" class="popup_container"></div>

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
var camRid = '<%= cleanXss(request.getParameter("camRid")) %>';
gAssignConsultant = {
		init : function(){
			this.loadData();

		},
		data :{},
		loadData : function(){
			var action = '<ifvm:action name="getTmAssignCount"/>';
			$.ifvSyncPostJSON(action, {
				camRid: camRid
			}, function(result) {


				gAssignConsultant.data=result;
				$("#tmCamAssignWrap").dataSetting(result);

				gConsultantListGrid = $("#consultantListGrid").ifvGrid({ jqGridOption : gAssignConsultant.jqGridOption });
			});

		},
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.camRid = camRid
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = gConsultantListGrid.getRowData()[rowNo-1];

		     },
		     loadComplete : function(result){
		     },
		     url : '<ifvm:action name="getTmConsultantList"/>',
		     colNames:[
		               '<spring:message code="V00271"/>',//상담원
		               '<spring:message code="V00272"/>',//미할당 TM수
		               '<spring:message code="V00266"/>',//완료건수
		               '<spring:message code="V00267"/>',//미완료건수
		             ],
		    colModel:[
		        { name:'empName', 	    index:'e.name', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'asgnCount', 	index:'', 			width:'100px', 	align: 'center', 	resizable : true, sortable : false },
		        { name:'complCnt', 	    index:'', 			width:'100px', 	align: 'center', 	resizable : true, sortable : false },
		        { name:'unCompleCnt', 	index:'', 			width:'80px', 	align: 'center', 	resizable : true, sortable : false },

		    ],
		     sortname: 'ctt.AGENT_ID',
		     autowidth : true ,
		     sortorder: "desc"




		},
		setUnAsnTm : function(){
			if(gAssignConsultant.data.unAsnTmCnt == 0){
				alert('<spring:message code="L02186"/>');//미할당 TM이 없습니다.
				return;
			}
			var action = '<ifvm:action name="setUnAsnTm"/>';
			$.ifvSyncPostJSON(action, {
				camRid: camRid
			}, function(result) {


				gAssignConsultant.loadData();
				gTmCampaignList.loadDate();
			});

		},
		setUnComplTm : function(){
			if(gAssignConsultant.data.unAsnTmCnt == 0){
				alert('<spring:message code="L02187"/>');//미완료 TM이 없습니다.
				return;
			}
		}

}
//일시 구분자 추가
function insertDash(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');;
	}
	else{
		return "";
	}
}



$(document).ready(function() {
	gAssignConsultant.init();
	//gConsultantListGrid = $("#consultantListGrid").ifvGrid({ jqGridOption : gAssignConsultant.jqGridOption });
})
</script>