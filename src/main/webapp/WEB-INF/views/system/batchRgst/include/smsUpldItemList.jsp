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
var upldItemList;
//var ridPar;
var batchResultCd="";
var testViewList_rid = '<%=cleanXss(request.getParameter("rid")) %>';

function upldItemSearch(){
    var ejGridOption = {
       serializeGridData : function( data ){
			data.ridPar = rid;
			return data;
        },
        loadComplete : function(obj){
        },
        dataUrl : '<ifvm:action name="smsUpldItemList"/>',
        columns:[
        	{
	      		  field : 'approvalNum', headerText : '수신거부 등록번호', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'approvalNum' }/*수신거부 등록번호 */
	      	  },{
	      		  field : 'txnNum', headerText : '발신전화번호', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'txnNum' }/*발신전화번호 */
	      	  },{
	      		  field : 'requestDt', headerText : '수신거부등록일시', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'requestDt' }/*수신거부등록일시 */
	      	  },{
	      		  field : 'uploadRslt', headerText : 'SMS 수신거부결과', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'uploadRslt' }/*SMS 수신거부결과 */
	      	  } ,{
	      		  field : 'errMsg', headerText : '미처리 사유', headerTextAlign : 'center', textAlign: 'left',
	      		  customAttributes : {
	      			  index : 'errMsg' }/*미처리 사유*/
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 't1.requestDt',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        gridDataInit : false,
	        radio: false
    };
    upldItemList = $("#upldItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function upldItemSearchInit(){
    var ejGridOption = {
       serializeGridData : function( data ){
			data.ridPar = rid;
			return data;
        },
        loadComplete : function(obj){
        },
        dataUrl : '<ifvm:action name="smsUpldItemList"/>',
        columns:[
        	{
	      		  field : 'approvalNum', headerText : '수신거부 등록번호', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'approvalNum' }/*수신거부 등록번호 */
	      	  },{
	      		  field : 'txnNum', headerText : '발신전화번호', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'txnNum' }/*발신전화번호 */
	      	  },{
	      		  field : 'requestDt', headerText : '수신거부등록일시', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'requestDt' }/*수신거부등록일시 */
	      	  },{
	      		  field : 'uploadRslt', headerText : 'SMS 수신거부결과', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'uploadRslt' }/*SMS 수신거부결과 */
	      	  } ,{
	      		  field : 'errMsg', headerText : '미처리 사유', headerTextAlign : 'center', textAlign: 'left',
	      		  customAttributes : {
	      			  index : 'errMsg' }/*미처리 사유*/
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'requestDt',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: false
    };
    upldItemList = $("#upldItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	upldItemSearch();
});
</script>

<div>
    <div id="upldItemListGrid" class="white_bg grid_bd0"></div>
</div>
