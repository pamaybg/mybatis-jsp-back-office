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

}



function getClubBenfListEvent(){

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
      		data.ridClub	=  clubTypeRid;
            return data
       	},
        url : '<ifvm:action name="getClubBenfTabList"/>',

        colNames:[
                   '오퍼코드',
                   '오퍼명',
                   '오퍼유형',
                   '적용등급',
                   '등록일시',
                   'rid',
                   'ridMktOfferMst'
                 ],
        colModel:[
                  { name:'offerNo', 			index:'mom.OFFER_NO',  				width:'170px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'offerNm', 			index:'mom.OFFER_NM',  						width:'250px', 	align: 'left', 		resizable : true, sortable:false },
                  { name:'offerTypeCd', 		index:'cc1.MARK_NAME', 	     	width:'100px', 	align: 'center', 	resizable : true, sortable:false  },
                  { name:'tierCd',    			index:'lcbr.TIER_CD', 		 	width:'150px', 	align: 'center', 	    resizable : true, sortable:false },
                  { name:'createDate',    		index:'lcbr.CREATE_DATE',   				width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'rid', 				index:'lcbr.RID', 			 	hidden : true },
                  { name:'ridMktOfferMst', 		index:'mom.ID', 			 	hidden : true }
              ],
        sortname: 'lcbr.create_date',
        sortorder: "desc",
        radio: true,
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
	 $("#clubOfferPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubOfferPop"/>?rid='+rid,
	        contentType: "ajax",
	        title: "혜택 상세",
	        width: '700px',
	        close :'clubOfferPopClose'
	   });
}



function addClubBenfFn(){
	 $("#clubOfferPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubOfferPop"/>',
	        contentType: "ajax",
	        title: "혜택 등록",
	        width: '700px',
	        close :'clubOfferPopClose'
	   });
}
function clubOfferPopClose(){
	clubOfferPop._destroy();
}

function removeClubBenfFn(){
	if(clubBenfGrid.getCheckedGridData().length==0){
		alert( '<spring:message code="L00914"/>');
		return;
	}
	if (confirm('<spring:message code="L00086"/>')) {
		$.ifvSyncPostJSON( '<ifvm:action name="deleteClubBenfTab"/>',{rid : clubBenfGrid.getCheckedGridData()[0].rid}
		,function(result) {
			alert( '<spring:message code="M00003"/>');
			clubBenfGrid.requestData();
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
        	<ifvm:inputNew type="button" btnType="plus"  text="M01852"  id="addClubBenfBtn" btnFunc="addClubBenfFn"/>
            <ifvm:inputNew type="button" btnType="minus"   text="M01854"  id="removeClubBenfBtn" btnFunc="removeClubBenfFn"/>
        </div>
    </div>
    <div id="clubBenfGrid" class="white_bg grid_bd0"></div>
</div>

<div id="clubOfferPop" class="popup_container"></div>