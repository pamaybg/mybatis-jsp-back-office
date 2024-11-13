<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var clubTierDtlGrid;
var clubTierRId;
var rid;

$(document).ready(function() {
   init();
});

function init(){
	getClubTierDtlListEvent();
	getClubTierDtlList();

}



function getClubTierDtlListEvent(){

    //신규 클릭시
    $('#addBtn').on('click', function(){
    	rid = null;
    	location.href = '<ifvm:url name="clubTierDtlDtl"/>';
    });

 	 //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
}

//등급그룹 목록 조회
function getClubTierDtlList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       		var data = clubTierDtlGrid.getRowData()[data-1];
       		rid = data.rid;
       		clubTierTabDtlFn();
       	},
      	serializeGridData : function( data ){
      		data.ridClub	=  clubTypeRid;
            return data
       	},
        url : '<ifvm:action name="getClubTierDtlTabList"/>',

        colNames:[
                   '상품카테고리',
                   '상품코드',
                   '상품명',
                   '변경자',
                   '등록일시',
                   'rid',
                   'ridProd',
                   'ridProdCat',
                 ],
        colModel:[
                  { name:'catNm', 			index:'lpc.CAT_NM',  				width:'100px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'prodId', 			index:'lp.PROD_ID',  				width:'100px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'prodNm', 			index:'lp.PROD_NM', 	     	width:'200px', 	align: 'left', 	resizable : true, sortable:false  },
                  { name:'modifyBy',    		index:'ce.name', 		 	width:'100px', 	align: 'center', 	    resizable : true, sortable:false },
                  { name:'modifyDate',    		index:'lctd.MODIFY_DATE',   				width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'rid', 				index:'lctd.rid', 			 	hidden : true },
                  { name:'ridProd', 		index:'lctd.RID_PROD', 			 	hidden : true },
                  { name:'ridProdCat', 		index:'lctd.RID_PROD_CAT', 			 	hidden : true }
              ],
        sortname: 'lctd.modify_date',
        sortorder: "desc",
        radio: true,
    };
    clubTierDtlGrid = $("#clubTierDtlGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 호출
function clubTierDtlListSearch() {
    getClubTierDtlList();
}

function btnSearch(){
	getClubTierDtlList();
}

//삭제
function removeAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(clubTierDtlGrid.getCheckedGridData()[0])) {
  	v_rid = clubTierDtlGrid.getCheckedGridData()[0].rid;
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
              getClubTierDtlList();
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




function addClubTierDtlFn(){
	  if ($.fn.ifvmIsEmpty(clubTierGrid.getCheckedGridData()[0])) {
		  alert("클럽등급을 선택해주세요");
		  return;
	}
	 $("#clubTierTabDtlPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="clubTierTabDtlPop"/>',
		        contentType: "ajax",
		        title: "클럽등급 상세 등록",
		        width: '700px',
		        close :'clubTierTabDtlPopClose'
	   });
}



function clubTierTabDtlFn(){
	 $("#clubTierTabDtlPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubTierTabDtlPop"/>?rid='+rid,
	        contentType: "ajax",
	        title: "클럽등급 상세 정보",
	        width: '700px',
	        close :'clubTierTabDtlPopClose'
	   });
}
function clubTierTabDtlPopClose(){
	clubTierTabDtlPop._destroy();
}
function removeClubTierDtlFn(){
	if(clubTierDtlGrid.getCheckedGridData().length==0){
		alert( '<spring:message code="L00914"/>');
		return;
	}
	if (confirm('<spring:message code="L00086"/>')) {
		$.ifvSyncPostJSON( '<ifvm:action name="deleteClubTierDtlTab"/>',{rid : clubTierDtlGrid.getCheckedGridData()[0].rid}
		,function(result) {
			alert( '<spring:message code="M00003"/>');
			clubTierDtlGrid.requestData();
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
        	<ifvm:inputNew type="button" btnType="plus"  text="M01852"  id="addClubTierDtlBtn" btnFunc="addClubTierDtlFn"/>
            <ifvm:inputNew type="button" btnType="minus"   text="M01854"  id="removeClubTierDtlBtn" btnFunc="removeClubTierDtlFn"/>
        </div>
    </div>
    <div id="clubTierDtlGrid" class="white_bg grid_bd0"></div>
</div>

<div id="clubTierDtlPopDiv">
	<div id="clubTierTabDtlPop" class="popup_container"></div>
</div>