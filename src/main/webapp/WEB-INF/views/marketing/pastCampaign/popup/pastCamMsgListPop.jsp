<%@ page trimDirectiveWhitespaces="true" %>
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
<script type="text/javascript">
var id = '<%= cleanXss(request.getParameter("id")) %>';
pastCamMsgListPop = {
		init : function(){
			this.loadData();
		},
		loadData : function(){
			pastCamMsgList = $("#pastCamMsgListGrid").ifvGrid({ jqGridOption : pastCamMsgListPop.jqGridOption });
		},
		jqGridOption : {
	    		serializeGridData : function( data ){
	    			data.id = id;
	    			return data;
		        },
		        loadComplete : function(obj){
		        	console.log(obj);
		        },
		        url : '<ifvm:action name="getPastCamMsgList"/>',
		        colNames:[
		                   '<spring:message code="M02737" />',  /*단계 번호 */
		                   '<spring:message code="M02738" />',  /*유형 */
		                   '<spring:message code="M02739" />',  /*제목*/
		                   '<spring:message code="M02740" />',  /*본문 */
		                 ],
		        colModel:[
		            { name:'type',   		index:'hcm.TYPE',  			resizable : true, align:'center',    width:'100px' },
		            { name:'msgTypeNm',   	index:'hcm.MSG_TYPE_NM',  	resizable : true, align:'center',    width:'100px' },
		            { name:'xSubject', 		index:'hcm.X_SUBJECT',  	resizable : true, align:'center',    width:'100px' },
		            { name:'msgVal',		index:'hcm.MSG_VAL',  		resizable : true, align:'right',    width:'120px'  },
		        ],
		    }
}
$(document).ready(function() {
	pastCamMsgListPop.init();
})
</script>
<div class="page_btn_area" >
     <div class="col-xs-7">
        <span><spring:message code="M02517" /></span>
    </div>
    <%-- <div class="col-xs-5 searchbtn_r">
    	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('affiliateTransListGrid')" />
    	<ifvm:inputNew type="button" btnType="search" text="M02695" id="targetEmailBtn"  btnFunc="targetEmailFn" />
    </div> --%>
</div>

<div>
    <div id="pastCamMsgListGrid" class="white_bg grid_bd0"></div>
</div>
<!-- <div id="targetEmailPopDiv" class="popup_container"></div> -->

