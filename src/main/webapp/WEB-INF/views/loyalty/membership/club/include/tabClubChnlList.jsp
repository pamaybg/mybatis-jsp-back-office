<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var chnlListGrid;
var isNewTab = false;		//false : 상세 true : 신규
var tabRid;						//테이블 : loy_club_chnl --> rid

$(document).ready(function(){
	getTabChnlList();
	getTabEvent();
	if(isNew) setTabDisplay();
});


function getTabEvent(){
	//chnlLimitPop 화면을 불러온다.
	$("#addTabChnlPop").click(function(){
		isNewTab = true;
		actionAddTabChnlPop();
	})
	//삭제
	$("#removeTabChnl").click(function(){
		actionRemoveTabChnl();
	})
}

//삭제
function actionRemoveTabChnl() {

  var v_rid;
  if ($.fn.ifvmIsNotEmpty(chnlListGrid.getCheckedGridData()[0])) {
  	v_rid = chnlListGrid.getCheckedGridData()[0].rid;
  }

  if ($.fn.ifvmIsNotEmpty(v_rid)) {
      if (confirm('<spring:message code="L00086"/>')) {
          // 삭제
          $.ifvPostJSON('<ifvm:action name="deleteLoyClubChnl"/>', {
              rid: v_rid
          },
          function(result) {
              alert('<spring:message code="L00085"/>');
              //목록
              getTabChnlList();
          },
          function(result) {
              $.errorChecker(result);
          });
      }
  }
}

function actionAddTabChnlPop(){

	var url = '<ifvm:url name="chnlLimitPop"/>' + '?rid=' + clubTypeRid;

	var obj = {
			url : url,
			width : 600,
			title : '채널제한'
	}
	openPop(obj);
}

function openPop(obj){
	$("#tabChnlPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: obj.url,
        contentType: "ajax",
        width: obj.width,
        title: obj.title,
        close : 'tabChnlPopClose'
    });


}

function getTabChnlList(){

	var jqGridOption = {
			serializeGridData : function( data ){
	        	data.rid			=  clubTypeRid;
	            return data;
	       	},
	        ondblClickRow : function (rowNo) {
	        	rowData = chnlListGrid.getRowData()[rowNo-1];
	        	tabRid 	= rowData.rid;
	        	isNewTab = false;
	        	actionAddTabChnlPop();
	      	},
			url: '<ifvm:action name="getTabChnlList"/>',
		    colNames:[
		              '연관채널',
		              '연관채널명',
		              '채널',
		              '채널명',
		              '제한여부',
		              '최종변경인',
		              '변경일',
		              'rid'
	        ],
		    colModel:[
				{ name:'parNo', 		index:'parNo', 			width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
	            { name:'parNm', 		index:'parNm', 			width:'150px', 	align: 'left',   	resizable : true  ,sortable:false},
	            { name:'chnlNo', 		index:'chnlNo', 		width:'100px', 	align: 'center',	resizable : true  ,sortable:false},
	            { name:'chnlNm',	 	index:'chnlNm',	 		width:'150px', 	align: 'left', 		resizable : true  ,sortable:false},
	            { name:'limitYn', 		index:'a.limit_yn', 	width:'80px', 	align: 'center', 	resizable : true  ,sortable:false},
	            { name:'modifyBy',   	index:'a.modify_by',    width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
	            { name:'modifyDate',	index:'a.modify_date', 	width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
	            { name:'rid', 			index:'b.rid', 			hidden : true },
		    ],
		    sortname: 'lcb.modify_date',
		    sortorder: "desc",
		    radio: true,
		    tempId : 'ifvGridSimpleTemplete',	//각 페이지 별로 다른 템플릿을 쓰고 싶을 때
		};

	chnlListGrid = $("#chnlListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function tabChnlPopClose() {
	tabChnlPop._destroy();
}

function setTabDisplay(){
	$("#tabChnlBtn").hide();
}

</script>
 <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="addTabChnlPop"><i class="fa fa-plus"></i>
                <spring:message code="M00163" />
            </button>
            <button class="btn btn-sm" id="removeTabChnl"> <i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
 </div>

<div id="chnlListGrid" class="content grid_container"></div>

<div id="tabChnlPop" class="popup_container content_container"></div>