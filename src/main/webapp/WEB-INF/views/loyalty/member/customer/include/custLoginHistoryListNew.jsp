<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="custLoginListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="custLoginListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="custLoginListSearchList"></div>
</div>
<div id="custLoginHistoryGrid" class="grid_bd0"></div>


<script type="text/javascript">
var custLoginHistoryGrid=null;

function getCustLoginList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
    		if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.rid = cust_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getCustLoginList"/>',

        columns : [
        	{
      		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center', textAlign : 'center', visible: false,
      		  customAttributes : {
      			  index : '1'
      		  }
      	  },{
    		  field : 'webUseCdNm', headerText : '웹접근유형', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  searchable : false,
    			  index : '2'
    		  }
    	  },{
    		  field : 'webInputCdNm', headerText : '유입유형', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  searchable : false,
    			  index : '3'
    		  }
    	  },{
    		  field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '4'
    		  }
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    		  customAttributes : {
    			  index : '5'
    		  }
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lcwh.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    custLoginHistoryGrid = $("#custLoginHistoryGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function custLoginSearchInit(gridId){
	$.fn.ifvmSetCommonCondList("custLoginListSearchList","LOY_CUST_LOGIN_HIST",gridId);
}

//공통 조회 호출
function custLoginListSearch() {
	$.fn.ifvmSubmitSearchCondition("custLoginListSearchList", getCustLoginList);
} 

$(document).ready(function(){
	$.ifvmLnbSetting('custLoginHistoryGrid');
	
	custLoginSearchInit();
	
	getCustLoginList();
	
	//초기화
    $("#custLoginListSearchInitBtn").on('click', function(){
    	custLoginSearchInit("custLoginHistoryGrid");
    });
	
  	//조회
    $("#custLoginListSearchBtn").on('click', function(){
    	custLoginListSearch();
    });
  	
});

</script>




