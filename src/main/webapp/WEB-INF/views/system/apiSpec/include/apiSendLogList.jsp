<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="apiSendLogGrid"></div>
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

var apiSendLogGrid = function(){
	 var _rid = '<%=cleanXss(request.getParameter("rid"))%>';
	    this.init = function() {
			this.setGridAndDataLoad();
	    },
	    this.getRid = function(){
	    	return _rid;
	    },
		this.setGridAndDataLoad = function () {
	        var _serializeGridData = function(data) {
	        	data.rid = this.getRid();
	            return data;
	        };
			var ejGridOption = {
				serializeGridData : _serializeGridData.bind(this),
				dataUrl : '<ifvm:action name="getApiSendLogList"/>',
				columns : [ {
					field : 'rid',
					visible : false
				}, {
					field : '',
					headerText : '<spring:message code=""/>',
					customAttributes : {
						searchable : true
					}
             }, {
					field : '',
					headerText : '<spring:message code=""/>',
					customAttributes : {
						searchable : true
					}
				}, {
					field : '',
					headerText : '<spring:message code=""/>',
                 textAlign : 'center',
					customAttributes : {
						index : ''
					}
				}, {
					field : '',
					headerText : '<spring:message code=""/>',
                 textAlign : 'center',
					customAttributes : {
						index : ''
					}
				}, {
					field : 'createBy',
                 textAlign : 'center',
					headerText : '<spring:message code="실행자"/>',
				}, {
					field : 'createDate',
                 textAlign : 'center',
					headerText : '<spring:message code="실행일자"/>',
				} ],
				requestGridData : {
					sidx : 'createDate'
				},
				radio : false,
			};
			
			$("#apiSendLogGrid").ifvsfGrid({
				ejGridOption : ejGridOption
			});
		}
}

$(document).ready(function(){
	var apiSendLogListNew = new apiSendLogGrid();
	apiSendLogListNew.init();
})
</script>