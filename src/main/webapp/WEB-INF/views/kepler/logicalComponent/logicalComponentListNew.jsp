<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var logicalComponentListGrid = null;
var cDialog;
var selectChk = false;

var logicalComponent = {
	logicalComponentId: "",
	selRow: ""
};

//로지컬 컴포넌트 목록
function getLogicalComponentList(){

    var ejGridOption = {
   		serializeGridData : function( data ){
	        if ($.fn.ifvmIsNotEmpty(requestitem)) {
	             data.item = requestitem;
	         }
	         return data;
	    },
		recordDoubleClick : function(args) {
    		var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId='+args.data.lgcCompId+'&tab=join';
        	qtjs.href(url);

		},
        allowResizing : false,
        dataUrl : '<ifv:action name="getLogicalComponentList"/>',
        columns:[
        	  {
        		  field : 'lgcCompNm', headerText : '<spring:message code="M01427"/>',
        		  customAttributes : {searchable : true} //
        	  },{
          		  field : 'lgcDesc', headerText : '<spring:message code="M00324"/>', width: '20%',
          		  customAttributes : {searchable : true} //
          	  },{
          		  field : 'name', headerText : '<spring:message code="M00184"/>', textAlign : 'center',
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="M00185"/>', textAlign : 'center', width: '30%',
          	  },{
          		  field : 'lgcCompId', headerText : 'lgcCompId', visible : false ,
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lgc.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
    };
    logicalComponentListGrid = $("#logicalComponentListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    if(logicalComponent.selRow != "") {

    	$("#gridIdlogicalComponentListGrid").setSelection(logicalComponent.selRow, true);
    	logicalComponent.selRow = "";
    }

}

//공통 조회 조건 목록 설정
function logicalComponentListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("logicalComponentSearchList","ANL_LGC_001",gridId);
}

//공통 조회 호출
function logicalComponentListSearch() {
    $.fn.ifvmSubmitSearchCondition("logicalComponentSearchList", getLogicalComponentList);
}

$(document).ready(function() {

	//공통 조회 조건 목록 설정
    logicalComponentListSearchInit();


	/**
	 * Page Initiation
	 */
    getLogicalComponentList();



	/**
	 * Button Handler Start
	 */
    //조회
    $('#logicalComponentListSearchBtn').on('click', function(){
    	logicalComponentListSearch();
    });

    //초기화
    $("#logicalComponentListSearchInitBtn").on('click', function(){
    	logicalComponentListSearchInit('logicalComponentListGrid');
    });

    //신규 클릭시
    $('#logicalComponentNewBtn').on('click', function(){
    	var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=&tab=join';
    	qtjs.href(url);
    });
	/**
	 * Button Handler End
	 */
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="L02220" />
        &gt; <spring:message code="M00135" />
    </h1>
</div>

<!-- 조회 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="logicalComponentListSearchBtn" objCode="logicalComponentListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="logicalComponentListSearchInitBtn" objCode="logicalComponentListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="logicalComponentSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="logicalComponentNewBtn" objCode="logicalComponentNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00274" />
            </button>
        </div>
    </div>
    <div id="logicalComponentListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="dialog" class="popup_container"></div>
<div id="dialogTempPop"></div>