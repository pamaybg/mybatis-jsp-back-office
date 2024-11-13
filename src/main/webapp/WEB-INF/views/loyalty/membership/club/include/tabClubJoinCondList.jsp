<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var clubJoinCondGrid;
var rid;


$(document).ready(function() {
   init();
});

function init(){
	getClubJoinCondListEvent();
	getClubJoinCondList();

}



function getClubJoinCondListEvent(){

    //신규 클릭시
    $('#addBtn').on('click', function(){
    	rid = null;
    	location.href = '<ifvm:url name="clubJoinCondDtl"/>';
    });

 	 //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
}

//등급그룹 목록 조회
function getClubJoinCondList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       		var data = clubJoinCondGrid.getRowData()[data-1];
       		rid = data.rid;
       		clubJoinCondPopDtlOpen();
       	},
      	serializeGridData : function( data ){
      		data.ridClub	=  clubTypeRid;
            return data
       	},
        url : '<ifvm:action name="getClubJoinCondTabList"/>',

        colNames:[
                   '상품카테고리',
                   '상품코드',
                   '상품명',
                   '변경자',
                   '변경일시',
                   'rid',
                 ],
        colModel:[
                  { name:'catNm', 				index:'lpc.CAT_NM',  				width:'100px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'prodId', 				index:'lp.PROD_ID',  						width:'100px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'prodNm', 			index:'lp.PROD_NM', 	     	width:'350px', 	align: 'left', 	resizable : true, sortable:false  },
                  { name:'name',    		index:'ce.NAME', 		 	width:'100px', 	align: 'center', 	    resizable : true, sortable:false },
                  { name:'modifyDate',    		index:'lcjc.MODIFY_DATE',   				width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'rid', 				index:'lcjc.RID', 			 	hidden : true },
              ],
        sortname: 'lcjc.MODIFY_DATE',
        sortorder: "desc",
        radio: true,
        /* tempId : 'ifvGridSimpleTemplete' */
    };
    clubJoinCondGrid = $("#clubJoinCondGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 호출
function clubJoinCondListSearch() {
    getClubJoinCondList();
}

function btnSearch(){
	getClubJoinCondList();
}

//삭제
function removeAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(clubJoinCondGrid.getCheckedGridData()[0])) {
  	v_rid = clubJoinCondGrid.getCheckedGridData()[0].rid;
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
              getClubJoinCondList();
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

function clubJoinCondPopDtlOpen(){
	 $("#clubJoinCondPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubJoinCondPop"/>?rid='+rid,
	        contentType: "ajax",
	        title: "가입조건 상세",
	        width: '700px',
	        close :'clubJoinCondPopClose'
	   });
}



function addClubJoinCondFn(){
	 $("#clubJoinCondPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubJoinCondPop"/>',
	        contentType: "ajax",
	        title: "가입조건 등록",
	        width: '700px',
	        close :'clubJoinCondPopClose'
	   });
}
function clubJoinCondPopClose(){
	clubJoinCondPop._destroy();
}

function removeClubJoinCondFn(){
	if(clubJoinCondGrid.getCheckedGridData().length==0){
		alert( '<spring:message code="L00914"/>');
		return;
	}
	if (confirm('<spring:message code="L00086"/>')) {
		$.ifvSyncPostJSON( '<ifvm:action name="deleteClubJoinCondTab"/>',{rid : clubJoinCondGrid.getCheckedGridData()[0].rid}
		,function(result) {
			alert( '<spring:message code="M00003"/>');
			clubJoinCondGrid.requestData();
		})
	}
}

</script>




<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <%-- <span><spring:message code="M00277" /></span> --%>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="plus"  text="M01852"  id="addClubJoinCondBtn" btnFunc="addClubJoinCondFn"/>
            <ifvm:inputNew type="button" btnType="minus"   text="M01854"  id="removeClubJoinCondBtn" btnFunc="removeClubJoinCondFn"/>
        </div>
    </div>
    <div id="clubJoinCondGrid" class="white_bg grid_bd0"></div>
</div>

<div id="clubJoinCondPop" class="popup_container"></div>