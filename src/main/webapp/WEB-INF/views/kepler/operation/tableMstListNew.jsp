<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var tableMstListGrid;

var tableId;
var tblNm;
var dbId;
var tblType;
var subjectAreaNm;

//테이블 컬럼 목록
function getTableMstList() {
    var ejGridOption = {
   		recordDoubleClick : function(args) {
       		var data = args.data;
       		tableId = data.tableId;
       		tblNm = data.tblNm;
       		dbId = data.dbId;
       		tblType = data.tblType;
       		subjectAreaNm = data.subjectAreaNm;
    		qtjs.href('<ifvm:url name="tableProperDetail"/>?tableId='+tableId+'&tblNm='+tblNm+'&dbId='+dbId+'&tblType='+tblType+'&subjectAreaNm='+encodeURIComponent(subjectAreaNm));
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	dataUrl : '<ifvm:action name="getTableMstList_KPR"/>',
        columns:[
        	{
        		  field : 'serviceNm', headerText : '<spring:message code="M01577"/>', textAlign : 'center', customAttributes : {searchable : true}, width: '180px',

        	  },{
          		  field : 'subjectAreaNm', headerText : '<spring:message code="M01155"/>', headerTextAlign : 'center', width: '180px',

          	  },{
          		  field : 'dbmsTypeCd', headerText : '<spring:message code="M00508"/>', textAlign : 'center',

          	  },{
          		  field : 'schmaNm', headerText : '<spring:message code="M00236"/>', textAlign : 'center', customAttributes : {searchable : true}

          	  },{
          		  field : 'tblNm', headerText : '<spring:message code="M00519"/>', customAttributes : {searchable : true}

          	  },{
          		  field : 'dpNm', headerText : '<spring:message code="M01573"/>', textAlign : 'center',customAttributes : {searchable : true}

          	  },{
          		  field : 'tblTypeCd', headerText : '<spring:message code="M01605"/>', textAlign : 'center',
          		  customAttributes : {
          			  index : 'c.mark_name' }
          	  },{
          		  field : 'tblSpaceNm', headerText : '<spring:message code="M01593"/>', textAlign : 'center',

          	  },{
          		  field : 'importYn', headerText : '<spring:message code="M01576"/>', textAlign : 'center', customAttributes : {searchable : true}

          	  },{
          		  field : 'tableId', headerText : 'id', visible : false ,
          		  customAttributes : {
          			  index : 't.ID' }
          	  },{
          		  field : 'dbId', headerText : 'dbId', visible : false , 
          		  customAttributes : {
          			  index : 'sd.db_id' }
          	  },{
          		  field : 'tblType', headerText : 'tblType', visible : false ,
          		  customAttributes : {
          			  index : 'c.code_name' }
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 't.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
    };

    tableMstListGrid = $("#tableMstListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/* 팝업 닫기 */
function tableMstPopClose(){
	dialog._destroy();
}

//공통 조회 조건 목록 설정
function tableMstListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("tableMstSearchList","ANL_TBL_001",gridId);
}

//공통 조회 호출
function tableMstListSearch() {
    $.fn.ifvmSubmitSearchCondition("tableMstSearchList", getTableMstList);
}

//테이블 불러오기 팝업 열기
function tableCallPopOpen() {
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tableImportPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01606" />',
        width: "700",
        close : 'tableMstPopClose'
    });
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    tableMstListSearchInit();


	getTableMstList();


    //조회
    $('#tableMstListSearchBtn').on('click', function(){
    	tableMstListSearch();
    });

    //초기화
    $("#tableMstListSearchInitBtn").on('click', function(){
    	tableMstListSearchInit('tableMstListGrid');
    });

    //신규 클릭시
    $('#tableNewBtn').on('click', function(){
    	tableId = null;
    	qtjs.href('<ifvm:url name="tableProperDetail"/>');
    });

    //불러오기 클릭시
    $('#tableCallBtn').on('click', function(){
    	tableCallPopOpen();
    });
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M01175" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 조회 버튼 --%>
            <button class="btn btn-sm" id="tableMstListSearchBtn" objCode="tableMstListSearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <%-- 초기화 버튼 --%>
            <button class="btn btn-sm" id="tableMstListSearchInitBtn" objCode="tableMstListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="tableMstSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 신규 버튼 --%>
            <button class="btn btn-sm" id="tableNewBtn" objCode="tableNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>
            <%-- 불러오기 버튼 --%>
            <button class="btn btn-sm" id="tableCallBtn" objCode="tableCallBtn_OBJ">
               <spring:message code="M00613" />
            </button>
        </div>
    </div>
    <div id="tableMstListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="dialog" class="popup_container"></div>
