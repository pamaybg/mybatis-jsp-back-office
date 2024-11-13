<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="반응고객 목록"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="excelDownPromCalcBtn" text="다운로드" objCode="promMbrCalcExcel_OBJ"/>
        </div>
    </div>
    <div id="promMbrCalcListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var rid;
var promMbrCalcListGrid=null;
function getPromMbrCalcList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.promRid = promRid;
			return data;
		},
		rowSelected : function(args){
        	rid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getPromMbrCalcList"/>',

        columns : [
        	{
      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center' ,textAlign : 'center',customAttributes :{searchable : true}
    	  },{
    		  field : 'custNm', headerText : '고객명', headerTextAlign : 'center', textAlign : 'left'
    	  },{
    		  field : 'calcDate', headerText : '산출일자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'ofrNm', headerText : '오퍼', headerTextAlign : 'center', textAlign : 'left',customAttributes :{searchable : true}
    	  },{
    		  field : 'ofrAmtTypeNm', headerText : '제공수량유형', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'ofrAmtType'}
    	  },{
    		  field : 'ofrAmt', headerText : '제공수량', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',

        },
    };

    promMbrCalcListGrid = $("#promMbrCalcListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}




function excelDownPromCalc() {
	$.ifvExcelDn('/loyalty/promreaction/promMbrCalcExcelListGrid.do','promMbrCalcListGrid');
}

$(document).ready(function(){
	
	getPromMbrCalcList();
	
	$("#excelDownPromCalcBtn").click(function() {
		excelDownPromCalc();
	});


});

</script>