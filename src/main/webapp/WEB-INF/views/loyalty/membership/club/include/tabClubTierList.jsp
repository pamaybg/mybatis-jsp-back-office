<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var clubTierGrid;
var rid;


$(document).ready(function() {
   init();
   clubTierTabContent();
});

function init(){
	getClubTierListEvent();
	getClubTierList();

}



function getClubTierListEvent(){

    //신규 클릭시
    $('#addBtn').on('click', function(){
    	rid = null;
    	location.href = '<ifvm:url name="clubTierDtl"/>';
    });

 	 //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
}

//등급그룹 목록 조회
function getClubTierList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       		var data = clubTierGrid.getRowData()[data-1];
       		rid = data.rid;
       		clubTierPopDtlOpen();
       	},
      	serializeGridData : function( data ){
      		data.ridClub	=  clubTypeRid;
      		rid = data.rid;
            return data
       	},
        onSelectRow : function (data) {
         	var obj={};
        	obj.ridClubTier = data.rid;
        	clubTierDtlGrid.requestData(obj);
        },
        url : '<ifvm:action name="getClubTierTabList"/>',

        colNames:[
                   '등급코드',
                   '등급명',
                   '설정구간(이상)',
                   '설정구간(미만)',
                   '변경자',
                   '변경일시',
                   'rid',
                 ],
        colModel:[
                  { name:'tierCd', 				index:'lct.TIER_CD',  				width:'170px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'tierNm', 				index:'lct.TIER_NM',  						width:'350px', 	align: 'left', 		resizable : true, sortable:false },
                  { name:'secStart', 			index:'lct.SEC_START', 	     	width:'100px', 	align: 'center', 	resizable : true, sortable:false  },
                  { name:'secEnd',    			index:'lct.SEC_END', 		 	width:'100px', 	align: 'center', 	    resizable : true, sortable:false },
                  { name:'modifyBy',    		index:'ce.NAME', 		 	width:'100px', 	align: 'center', 	    resizable : true, sortable:false },
                  { name:'modifyDate',    		index:'lct.MODIFY_DATE',   				width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'rid', 				index:'lct.RID', 			 	hidden : true },
              ],
        sortname: 'lct.MODIFY_DATE',
        sortorder: "desc",
        radio: true,
    };
    clubTierGrid = $("#clubTierGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 호출
function clubTierListSearch() {
    getClubTierList();
}

function btnSearch(){
	getClubTierList();
}

//삭제
function removeAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(clubTierGrid.getCheckedGridData()[0])) {
  	v_rid = clubTierGrid.getCheckedGridData()[0].rid;
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
              getClubTierList();
              basicTierSelectSetting();
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

function clubTierPopDtlOpen(){
	 $("#clubTierPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubTierPop"/>?rid='+rid,
	        contentType: "ajax",
	        title: "등급 상세",
	        width: '700px',
	        close :'clubTierPopClose'
	   });
}



function addClubTierFn(){
	 $("#clubTierPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubTierPop"/>',
	        contentType: "ajax",
	        title: "등급 등록",
	        width: '700px',
	        close :'clubTierPopClose'
	   });
}
function clubTierPopClose(){
	clubTierPop._destroy();
}

function removeClubTierFn(){
	if(clubTierGrid.getCheckedGridData().length==0){
		alert( '<spring:message code="L00914"/>');
		return;
	}
	if (confirm('<spring:message code="L00086"/>')) {
		$.ifvSyncPostJSON( '<ifvm:action name="deleteClubTierTab"/>',{rid : clubTierGrid.getCheckedGridData()[0].rid}
		,function(result) {
			alert( '<spring:message code="M00003"/>');
			clubTierGrid.requestData();
		})
	}
}

function clubTierTabContent(){
	testTab = $('#clubTierTabContent').DrawTab({
		item: [
			{label:'클럽등급상세' , href: '<ifvm:url name="tabClubTierDtlList"/>' +"?ridTier="+rid},
		]
	});
}

</script>




<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <%-- <span><spring:message code="M00277" /></span> --%>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="plus"  text="M01852"  id="addClubTierBtn" btnFunc="addClubTierFn"/>
            <ifvm:inputNew type="button" btnType="minus"   text="M01854"  id="removeClubTierBtn" btnFunc="removeClubTierFn"/>
        </div>
    </div>
    <div id="clubTierGrid" class="white_bg grid_bd0"></div>
</div>

 <div id="clubTierTabArea">
	<div id="clubTierTabContent" ></div>
 </div>


<div id="clubTierPop" class="popup_container"></div>