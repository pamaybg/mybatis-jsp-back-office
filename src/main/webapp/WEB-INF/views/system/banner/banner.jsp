<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
    	<spring:message code="O00212" /> &gt; <spring:message code="L00030" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>베너사항 목록</span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="bannerAdd_OBJ" />
	    </div>
	</div>
	<div id="bannerGrid"></div>
</div>

<script>
var bannerGrid;

function makeBannerGrid() {
	var jqGridOption = {
			serializeGridData : function( data ){
			},
			ondblClickRow : function (rowNo) {
	        	var data = bannerGrid.getRowData()[rowNo-1];

	        	bannerDetail(data.rid);
	        },
			loadComplete : function(obj){
				for(var i=0; i<obj.rows.length; i++){
					if(obj.rows[i].banner_status == "숨김"){
						$('tr#'+(i+1)).css('background-color', '#E6E6E6');
					}
				}
			},
		    url: '<ifvm:action name="getBannerList"/>',
		    colNames:[
		              '<spring:message code="M00377" />',
		              '<spring:message code="M01732" />',
		              '<spring:message code="M01810" />',
		              '<spring:message code="M01860" />',
		              '순번',
		              '게시일',
		              '<spring:message code="C00125" />',
		              'rid'
		              ],

		    colModel:[
		        {name:'bannerNm',index:'bannerNm', width:'120px', resizable : false, align: 'left'},
		        {name:'hitCnt',index:'hitCnt', resizable : false, width:'60px', align: 'right'},
		        {name:'createBy',index:'createBy', resizable : false, width:'60px', align: 'center'},
		        {name:'createDate',index:'createDate', width:'60px', resizable : false, formatter:'date', align: 'center', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'bannerSeq',index:'bannerSeq', width:'60px', resizable : false, align: 'right'},
		        {name:'openDate',index:'openDate', width:'60px', resizable : false, formatter:'date', align: 'center', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'banner_status',index:'exposureYn', width:'60px', resizable : false, align: 'center'},
		        {name:'rid',index:'rid', resizable : false, searchable : false, hidden : true}
		    ],
		    autowidth:true,
		    rowList:[10,20,30,50,100],
		    sortname: 't1.createDate',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
	};

	bannerGrid = $('#bannerGrid').ifvGrid({jqGridOption : jqGridOption});
}

$(document).ready(function() {
	makeBannerGrid();
});


 function bannerDetail(id) {
	location.href = '<ifvm:url name="bannerDetailUrl"/>' + '?rid=' + id;
}

function btnNewClick() {
	location.href = '<ifvm:url name="bannerDetailUrl"/>';
}

</script>