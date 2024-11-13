<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="제휴 관리" /> &gt; <spring:message code="조회" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>제휴 목록</span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="partnerListAdd_OBJ"/>
	    </div>
	</div>
	<div id="partnerGrid"></div>
</div>

<script>
var partnerGrid;

function makePartnerGrid() {
	var jqGridOption = {
			serializeGridData : function( data ){
			},
			ondblClickRow : function (rowNo) {
	        	var data = partnerGrid.getRowData()[rowNo-1];
	        	
	        	partnerDetail(data.rid);
	        },
			loadComplete : function(obj){
				for(var i=0; i<obj.rows.length; i++){
					if(obj.rows[i].notice_status == "숨김"){
						$('tr#'+(i+1)).css('background-color', '#E6E6E6');
					}	
				}
			},
		    url: '<ifvm:action name="getPartnerList"/>', 
		    colNames:[
		              '제휴명',
		              '순번',
		              '분류',
		              '노출',
		              '<spring:message code="M01810" />',
		              '등록일자',
		              'rid'
		              ],
		              
		    colModel:[
		        {name:'ptnrNm',index:'ptnrNm', width:'120px', resizable : false, align: 'left'},
		        {name:'dispSeq',index:'dispSeq', width:'60px', resizable : false, align: 'center'},
		        {name:'category',index:'category', width:'60px', resizable : false, align: 'center'},
		        {name:'dispYn',index:'dispYn', width:'60px', resizable : false, align: 'center'},
		        {name:'createBy',index:'createBy', resizable : false, width:'60px', align: 'center'},
		        {name:'createDate',index:'createDate', width:'60px', resizable : false, formatter:'date', align: 'center', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'rid',index:'rid', resizable : false, searchable : false, hidden : true}
		    ],
		    autowidth:true,
		    rowList:[10,20,30,50,100],
		    sortname: 'lp.DISP_YN desc ,lp.DISP_SEQ',
			sortorder: "asc ",
			tempId : 'ifvGridOriginTemplete'
	};
	
	partnerGrid = $('#partnerGrid').ifvGrid({jqGridOption : jqGridOption});
}

$(document).ready(function() {
	makePartnerGrid();
});


 function partnerDetail(id) {
	location.href = '<ifvm:url name="partnerDetailUrl"/>' + '?rid=' + id;
} 

function btnNewClick() {
	location.href = '<ifvm:url name="partnerDetailUrl"/>';
}

</script>