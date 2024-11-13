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
<div>
    <div id="oprDtlHistListGrid" class="white_bg grid_bd0"></div>
</div>

<!-- 정책속성값그리드 / 세부사항그리드 에서의 '이력'정보들을 띄워주는 화면 oprDtlHist -->

<script type="text/javascript">

var clickedRowRidOfSubGrid = null;

if(sgFlag == 'sg1') {
	clickedRowRidOfSubGrid = '<%= cleanXss(request.getParameter("subGrid1ClickedRowRid")) %>';
} else if(sgFlag == 'sg2') {
	clickedRowRidOfSubGrid = '<%= cleanXss(request.getParameter("subGrid2ClickedRowRid")) %>';
}

function getOprDtlHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			//data.oprDtlRid  = oprDtlRid;
			data.oprDtlRid = clickedRowRidOfSubGrid;
			return data;
		},
        dataUrl : '<ifvm:action name="getOprDtlHist"/>',

        columns: [
      	  { field: 'attrCdNm', headerText: '속성명', width: '70px', textAlign : 'center', customAttributes: { searchable: true, index: 'CC.MARK_NAME' } }
      	, { field: 'dataTypeNm', headerText: '데이터유형', width: '70px',textAlign : 'center', customAttributes: { searchable: true, index: 'CC2.MARK_NAME' } }
      	, { field: 'dataVal', headerText: '값', width: '180px', customAttributes: { searchable: true } }
      	, { field: 'contents', headerText: '설명', width: '200px' }
      	, { field: 'singleValYn', headerText: '단일값여부', width: '70px', textAlign : 'center', customAttributes: { searchable: true, index: 'singleValYn' } }
      	, { field: 'useYn', headerText: '사용여부', width: '70px', textAlign : 'center' } 
      	, { field: 'createBy', headerText: '등록자', width: '90px', textAlign : 'center' } 
      	, { field: 'createDate', headerText: '등록일', width: '80px',  textAlign : 'center' }
      	, { field: 'rid', headerText: 'rid', visible: false }
      ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '3',
      	  sord : 'ASC',
      	  _search : false,
          
        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    oprDtlHistListGrid = $("#oprDtlHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getOprDtlHistList();

});

</script>