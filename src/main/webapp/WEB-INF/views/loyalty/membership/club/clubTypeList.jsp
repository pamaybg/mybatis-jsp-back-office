<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var clubTypeGrid;
var rid;
var load = false;		//최초 로딩이면 false

$(document).ready(function() {
   init();
});

function init(){
	getClubTypeListEvent();
	getClubTypeList();
	clubSearchCondInit();
 	load = true;
}

function clubSearchCondInit(){
	 $.fn.ifvmSetCommonCondList("commSearchList","DEMO_CLUB");
}

//공통 조회 호출
function clubSearch() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", getClubTypeList);
}

function getClubTypeListEvent(){
	 //조회
    $('#searchCondBtn').on('click', function(){
    	clubSearch();
    });

  //초기화
    $("#searchCondInitBtn").on('click', function(){
    	clubSearchCondInit();
    });

    //신규 클릭시
    $('#addBtn').on('click', function(){
    	rid = null;
    	location.href = '<ifvm:url name="clubTypeDtl"/>';
    });

 	 //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
}

//등급그룹 목록 조회
function getClubTypeList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       		var data = clubTypeGrid.getRowData()[data-1];
       		rid = data.rid;
    		location.href = '<ifvm:url name="clubTypeDtl"/>?rid='+rid;
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {

                data.item = requestitem;
            }
            return data
       	},
        url : load ? '<ifvm:action name="getClubTypeList"/>' : '<ifvm:action name="getLoadClubTypeList"/>',

        colNames:[
                   '클럽명',
                   '클럽설명',
                   '사용여부',
                   '효력시작일',
                   '효력종료일',
                   'rid'
                 ],
        colModel:[
                  { name:'clubNm', 			index:'b.club_nm',  		width:'170px', 	align: 'left', 		resizable : true, sortable:false },
                  { name:'clubDescTxt', 	index:'b.club_desc_txt',  	width:'350px', 	align: 'left', 		resizable : true, sortable:false },
                  { name:'useYn',	    	index:'b.use_yn',        	width:'70px', 	align: 'center', 	resizable : true, sortable:false },
                  { name:'validStartDate',  index:'b.valid_start_date', width:'100px',	align: 'center', 	resizable : true, sortable:false  ,formatter:'date', formatoptions:{newformat:"Y-m-d"} },
                  { name:'validEndDate',    index:'b.valid_end_date',   width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d"}},
                  { name:'rid', 			index:'b.rid', 			 	hidden : true },
              ],
        sortname: 'lcb.create_date',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };

    clubTypeGrid = $("#clubTypeGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 호출
function clubTypeListSearch() {
    getClubTypeList();
}

function btnSearch(){
	getClubTypeList();
}

//삭제
function removeAction() {

  var v_rid;
  if ($.fn.ifvmIsNotEmpty(clubTypeGrid.getCheckedGridData()[0])) {
  	v_rid = clubTypeGrid.getCheckedGridData()[0].rid;
  }

  if ($.fn.ifvmIsNotEmpty(v_rid)) {
      if (confirm('<spring:message code="L00086"/>')) {
          // 삭제
          $.ifvProgressControl(true);
          $.ifvPostJSON('<ifvm:action name="deleteClub"/>', {
              rid: v_rid
          },
          function(result) {
              alert('<spring:message code="L00085"/>');
              getClubTypeList();
              $.ifvProgressControl(false);
          },
          function(result) {
        	  alert(result.message);
        	  $.ifvProgressControl(false);
              //$.errorChecker(result);
          });
      }
  }else{
		alert( '<spring:message code="L00914"/>');
  }
}

</script>





<div class="page-title">
    <h1>
        클럽관리 &gt; <spring:message code="L00081"/>
    </h1>
</div>
<div>
 <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00310" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn"> <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>

 </div>
 	<div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>

</div>
<div class="well form-horizontal" id="offerRequiredList" >

</div>
<%--  <div class="well mg_bt0 underline form-horizontal" id="searchArea">
 	<div class="row qt_border">
        <label class="col-xs-2 span control-label">클럽명</label>
            <div class="col-xs-3 control_content">
                    <ifvm:input type="text"  id="type"/>
            </div>
     </div>
</div> --%>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
                 <button class="btn btn-sm" id="addBtn"> <i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='removeBtn'> <i class="fa fa-minus"></i>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="clubTypeGrid" class="white_bg grid_bd0"></div>
</div>

