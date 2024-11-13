<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00333" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addCustAddInfoBtn">
			<i class="fa fa-plus"></i>
			<spring:message code="L00078" />
		</button>
		<button class="btn btn-sm" id="removeCustAddInfoBtn">
			<i class="fa fa-minus"></i>
			<spring:message code="L00080" />
		</button>
	</div>
</div>
<div id="custAddInfoGrid"></div>

<script>
var custAddInfoGrid;

//var currentRowData;	 // 선택된 Row의 데이터
var objCustAddInfoPop;

//삭제
function removeAction() {

	var v_rid;
	if ($.fn.ifvmIsNotEmpty(custAddInfoGrid.getCheckedGridData()[0])) {
		v_rid = custAddInfoGrid.getCheckedGridData()[0].rid;
	}

	if ($.fn.ifvmIsNotEmpty(v_rid)) {
		if (confirm('<spring:message code="L00086"/>')) {

			// 삭제
			$.ifvPostJSON('<ifvm:action name="removeCustAddInfo"/>', {
				rid : v_rid
			}, function(result) {
				alert('<spring:message code="L00085"/>');

				var getPage = getGridPage();
				//고객 목록
				getCustAddInfoList(getPage);

			}, function(result) {
				$.errorChecker(result);
			});
		}
	}
}

var page;

//페이지 구하기
function getGridPage() {
	var rtnVal = 1;
	var page = custAddInfoGrid.opt.data.page;
	var total = custAddInfoGrid.opt.data.records;
	if (total % page > 0) {
		rtnVal = page;
	}

	return rtnVal;
}

//프로그램 목록
function getCustAddInfoList(page){
    page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    var jqGridOption = {
    	ondblClickRow : function(data){
                var rowData = custAddInfoGrid.getRowData()[data-1];
               	custAddInfoPopOpen(rowData);
         },
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(cust_rid)) {
                data.rid = cust_rid;
            }
        	//페이지 설정
        	data.page = page;
            return data;
        },
       
        url : '<ifvm:action name="getCustAddInfoList"/>',
    
        colNames:[ //'유형', '값유형', '값','변경자','변경일자', 'cust_rid', 'rid'
                   
                   '<spring:message code="L00389"/>',
                   '<spring:message code="L00314"/>',
                   '<spring:message code="L00313"/>',
                   '<spring:message code="L00138"/>',
                   '<spring:message code="L00137"/>',        
                   'cust_rid',
                   'rid'                   
                 ],
        colModel:[
            { name:'addInfoTypeNm', index:'a.addInfoTypeNm', 	width:'200px', 	align: 'left', 		resizable : true  },
            { name:'attrTypeNm', 	index:'a.attrTypeNm', 		width:'200px', 	align: 'left', 		resizable : true  },
            { name:'attrVal', 	    index:'a.attrVal', 		    width:'200px', 	align: 'left', 	    resizable : false },
            { name:'modifyBy', 		index:'em1.name', 		    width:'110px', 	align: 'center', 	resizable : false },
            { name:'modifyDate', 	index:'a.modify_date', 		width:'90px', 	align: 'center', 	resizable : false },
            { name:'ridCust', 		index:'a.rid_cust', 		hidden : true },
            { name:'rid', 			index:'a.rid', 				hidden : true } 
        ],
        sortname: 'a.add_info_type_cd',
        autowidth : true , 
        sortorder: "asc",
        radio: true,
        tempId : 'ifvGridOriginTemplete',
        rowList: [5,10,15]
    };
    custAddInfoGrid = $("#custAddInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function custAddInfoPopOpen(rowData) {

	objCustAddInfoPop = $("#custAddInfoDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="custAddInfoPop"/>?'  + 'addInfo_rid=' + rowData.rid + '&cust_rid=' + rowData.ridCust ,
        contentType: "ajax",
        title: '<spring:message code="L00334"/>',
        width: '600px',
        close : 'custAddInfoPopClose'
    });
}

function custAddInfoPopClose(closeFlag) {
	if(closeFlag) {
		getCustAddInfoList(page);
	}
	objCustAddInfoPop._destroy();
}

$(document).ready(function() {
	getCustAddInfoList();
	 
	$("#addCustAddInfoBtn").click(function() {
		objCustAddInfoPop = $("#custAddInfoDialog").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : '<ifvm:url name="custAddInfoPop"/>?'
					+ 'cust_rid='
					+ cust_rid,
			contentType : "ajax",
			title : '<spring:message code="L00334"/>',
			width : '600px',
			close : 'custAddInfoPopClose'
		});
	});

	$("#removeCustAddInfoBtn").click(function() {
		removeAction();
	});
});

</script>
