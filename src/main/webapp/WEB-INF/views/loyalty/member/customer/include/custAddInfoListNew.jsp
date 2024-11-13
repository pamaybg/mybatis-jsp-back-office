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
		<button class="btn btn-sm" id="addCustAddInfoBtn" objCode="addCustAddInfoBtn_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="L00078" />
		</button>
		<button class="btn btn-sm" id="removeCustAddInfoBtn" objCode="removeCustAddInfoBtn_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="L00080" />
		</button>
	</div>
</div>
<div id="custAddInfoGrid"></div>

<script>
var custAddInfoGrid;

// 선택된 Row의 데이터
var objCustAddInfoPop;

//삭제
function removeAction() {

	var v_rid;
	if ($.fn.ifvmIsNotEmpty(custAddInfoGrid.opt.gridControl.getSelectedRecords()[0])) {
		v_rid = custAddInfoGrid.opt.gridControl.getSelectedRecords()[0].rid;
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
	if (custAddInfoGrid.opt.data != null) {
		var page = custAddInfoGrid.opt.data.page;
		var total = custAddInfoGrid.opt.data.records;
		if (total % page > 0) {
			rtnVal = page;
		}
	}
	return rtnVal;
}

// 프로그램 목록
function getCustAddInfoList(page){
	page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var ejGridOption = {
   		serializeGridData : function(args){
           	if ($.fn.ifvmIsNotEmpty(cust_rid)) {
                args.rid= cust_rid;
			}
        	args.page = page;
           	return args;
   		},
    	recordDoubleClick : function(args){
    			var data =args.data ;
               	custAddInfoPopOpen(data);
         },
        dataUrl : '<ifvm:action name="getCustAddInfoList"/>',

        columns : [
      	  {
      		  field : 'addInfoTypeNm', headerText : '<spring:message code="L00389"/>', headerTextAlign : 'left',
      		  customAttributes : {
      			  index : 'a.attr_type_cd',
      			  title : '{{:custNm}}'
      		  }
      	  },{
      		  field : 'attrTypeNm', headerText : '<spring:message code="L00314"/>', headerTextAlign : 'center',
      		  customAttributes : {
       			  sortable: false,
      			  index : 'a.attrTypeNm',
      			  title : '{{:hhpNo}}'
      		  }
      	  },{
      		  field : 'attrVal', headerText : '<spring:message code="L00313"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'a.ATTR_VAL',
      			  title : '{{:birthDt}}'
      		  }
      	  },{
      		  field : 'modifyBy', headerText : '<spring:message code="L00138"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'em1.name',
      			  title : '{{:memDiv}}'
      		  }
      	  },{
      		  field : 'modifyDate', headerText : '<spring:message code="L00137"/>',headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'a.modify_date',
      			  title : '{{:tierNm}}'
      		  }
      	  },{
      		  field : 'ridCust', headerText : 'cust_rid',headerTextAlign : '',visible: false,
      		  customAttributes : {
      			  index : 'a.rid_cust'
      		  }
      	  },{
      		  field : 'rid', headerText : 'rid',headerTextAlign : '',visible: false,
      		  customAttributes : {
      			  index : 'a.rid'
      		  }
      	  }

        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.add_info_type_cd',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
    };

    custAddInfoGrid = $("#custAddInfoGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
	if(closeFlag == true) {
		getCustAddInfoList(1);
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
