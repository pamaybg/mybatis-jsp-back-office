<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var clubBenfGrid;
var rid;


$(document).ready(function() {
   init();
});

function init(){
	getClubBenfListEvent();
	getClubBenfList();
	clubSearchCondInit();

}

function clubSearchCondInit(){
	 $.fn.ifvmSetCommonCondList("commSearchList","CLUB_BENF");
}

//공통 조회 호출
function clubSearch() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", getClubBenfList);
}

function getClubBenfListEvent(){
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
    	location.href = '<ifvm:url name="clubBenfDtl"/>';
    });

 	 //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
}

//등급그룹 목록 조회
function getClubBenfList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       		var data = clubBenfGrid.getRowData()[data-1];
       		rid = data.rid;
       		clubBenfPopDtlOpen();
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {

                data.item = requestitem;
            }
            return data
       	},
       	loadComplete : function(data){
       	},
        url : '<ifvm:action name="getClubBenfList"/>',

        colNames:[
                   '혜택유형',
                   '혜택명',
                   '시작일',
                   '종료일',
                   '등록자',
                   '등록일시',
                   'rid',
                   'ridCamMst'
                 ],
        colModel:[
                  { name:'typeNm', 			index:'cc1.MARK_NAME',  				width:'170px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'name', 			index:'lcb.name',  						width:'350px', 	align: 'left', 		resizable : true, sortable:false },
                  { name:'validStartDate', 	index:'lcb.VALID_START_DATE', 	     	width:'100px', 	align: 'center', 	resizable : true, sortable:false  ,formatter:'date', formatoptions:{newformat:"Y-m-d"}},
                  { name:'validEndDate',    index:'lcb.VALID_END_DATE', 		 	width:'100px', 	align: 'center', 	    resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d"} },
                  { name:'createBy',  		index:'ce.name', 						width:'100px',	align: 'center', 	resizable : true, sortable:false   },
                  { name:'createDate',    	index:'lcb.CREATE_DATE',   				width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'rid', 			index:'lcb.RID', 			 	hidden : true },
                  { name:'ridCamMst', 		index:'lcb.RID_CAM_MST', 			 	hidden : true },
              ],
        sortname: 'lcb.create_date',
        sortorder: "desc",
        radio: true,
        /* tempId : 'ifvGridOriginTemplete' */
    };
    clubBenfGrid = $("#clubBenfGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 호출
function clubBenfListSearch() {
    getClubBenfList();
}

function btnSearch(){
	getClubBenfList();
}

//삭제
function removeAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(clubBenfGrid.getCheckedGridData()[0])) {
  	v_rid = clubBenfGrid.getCheckedGridData()[0].rid;
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
              getClubBenfList();
              $.ifvProgressControl(false);
          },
          function(result) {
        	  alert(result.message);
        	  $.ifvProgressControl(false);
              //$.errorChecker(result);
          });
      }
  }
}

function clubBenfPopDtlOpen(){
	 $("#clubBenfPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubBenfPop"/>?rid='+rid,
	        contentType: "ajax",
	        title: "혜택 상세",
	        width: '700px',
	        close :'clubBenfPopClose'
	   });
}

function addClubBenfFn(){
	 $("#clubBenfPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubBenfPop"/>',
	        contentType: "ajax",
	        title: "혜택 상세",
	        width: '700px',
	        close :'clubBenfPopClose'
	   });
}
function clubBenfPopClose(){
	clubBenfPop._destroy();
}

function removeClubBenfFn(){
	if(clubBenfGrid.getCheckedGridData().length==0){
		alert( '<spring:message code="L00914"/>');
		return;
	}
	if (confirm('<spring:message code="L00086"/>')) {
		$.ifvSyncPostJSON( '<ifvm:action name="deleteClubBenf"/>',{rid : clubBenfGrid.getCheckedGridData()[0].rid}
		,function(result) {
			alert( '<spring:message code="M00003"/>');
			clubBenfGrid.requestData();
		})
	}
}

</script>






<div class="page-title">
    <h1>
       	혜택관리 &gt; <spring:message code="L00081"/>
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
        	<ifvm:inputNew type="button" btnType="plus"  text="M01852"  id="addClubBenfBtn" btnFunc="addClubBenfFn"/>
            <ifvm:inputNew type="button" btnType="minus"   text="M01854"  id="removeClubBenfBtn" btnFunc="removeClubBenfFn"/>
        </div>
    </div>
    <div id="clubBenfGrid" class="white_bg grid_bd0"></div>
</div>

<div id="clubBenfPop" class="popup_container"></div>