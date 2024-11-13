<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <%-- <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="등급" /></span>
        </div>
    </div> --%>
    <div class="row qt_border"></div>
    
    <div id="custAgreHistListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
function getCustAgreHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = agreRid;
			data.agreTypeCd = agreTypeCd;
			return data;
		},
        dataUrl : '<ifvm:action name="getCustAgreHistList"/>',

        columns : [
        	{
      		  field : 'agreTypeCdNm', headerText : '항목', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'agreTypeCd'}
      	  },{
    		  field : 'ver', headerText : '버전', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'agreYn', headerText : '동의여부', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'regDate', headerText : '동의일자', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'agreTypeCd', headerText : 'agreTypeCd', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'termRid', headerText : 'termRid', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'termVerRid', headerText : 'termVerRid', headerTextAlign : '' ,visible: false,
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '4',
      	  sord : 'desc',
      	  _search : false

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    custAgreHistListGrid = $("#custAgreHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//상세 팝업 화면 호출
function termsDetailInfoPop() {
	var t_rid;
	 if($(custAgreHistListGrid.opt.gridControl.getSelectedRecords()).length==0){
		   alert('<spring:message code="M01051"/>');
	 }else{
		 
		 termVerRid = mbrAgreListGrid.opt.gridControl.getSelectedRecords()[0].termVerRid;
		 if(termVerRid == null || termVerRid=='undefined') {
			 alert('약관 내용이 없습니다.');
			 return;
		 }
		 
		 t_rid = custAgreHistListGrid.opt.gridControl.getSelectedRecords()[0].termVerRid;
		 $.ifvSyncPostJSON('<ifvm:action name="getTermsInfoDetail"/>', {
			 termVerRid : t_rid
		 },function(result){
			 var popUrl= '<ifvm:url name="termsMbrInfoPop"/>?rid='+t_rid;
			 var popOption ="width=900, height=800, resizable=no, scrollbars=no, status=no;";
			window.open(popUrl,"",popOption);
		 },function(result){
			 alert(result.message);
		 });
	 }
}

$(document).ready(function(){
	getCustAgreHistList();
	
	$("#agreHistDetailInfoPopBtn").click(function() {
		termsDetailInfoPop();
	});
});

</script>