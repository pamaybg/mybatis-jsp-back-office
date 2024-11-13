<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var clubPartenariatGrid;
var rid;


$(document).ready(function() {
   init();
//    clubTierTabContent();
});

function init(){
	getClubPartenariatListEvent();
	getClubPartList();

}



function getClubPartenariatListEvent(){

    //신규 클릭시
    $('#addBtn').on('click', function(){
    	rid = null;
    	location.href = '<ifvm:url name="clubPartenariatDtl"/>';
    });

 	 //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });
}

//제휴사 목록 조회
function getClubPartList(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
       		var data = args.data;
       		rid = data.rid;
       		clubPartenariatPopDtlOpen();
       	},
      	serializeGridData : function( data ){
      		data.ridClub	=  clubTypeRid;
      		rid = data.rid;
            return data
       	},
       	dataUrl : '<ifvm:action name="getClubPartenariatTabList"/>',

        columns:[
        	  {
	    		  field : 'chnlNo', headerText : '제휴사코드', headerTextAlign : 'center',textAlign : ej.TextAlign.Center , width:'80px',
	    		  customAttributes : {
	    			  index : 'llc.CHNL_NO',
	    		  }
	    	  },{
	    		  field : 'chnlNm', headerText : '제휴사명', headerTextAlign : 'center',textAlign : ej.TextAlign.Left , width:'120px',
	    		  customAttributes : {
	    			  index : 'llc.CHNL_NM',
	    		  }
	    	  },{
	    		  field : 'stnDiv', headerText : '구분', headerTextAlign : 'center', textAlign : ej.TextAlign.Center , width:'80px',
	    		  customAttributes : {
	    			  index : 'c1.MARK_NAME',
	    		  }
	    	  },{
	    		  field : 'mbrbsStatusCd', headerText : '상태', headerTextAlign : 'center', textAlign : ej.TextAlign.Center , width:'80px',
	    		  customAttributes : {
	    			  index : 'c2.MARK_NAME',
	    		  }
	    	  },{
	    		  field : 'createDate', headerText : '등록일', headerTextAlign : 'center', textAlign : ej.TextAlign.Center , width:'100px',
	    		  customAttributes : {
	    			  index : 'lcc.CREATE_DATE',
	    		  }
	    	  },{
	    		  field : 'rid', headerText : 'rid', headerTextAlign : 'center', visible :false ,
	    		  customAttributes : {
	    			  index : 'llc.rid',
	    		  }
	    	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lcc.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false
        },
        radio: true,
        tempId :'ifvOnlyGridTemplate',
    };
    clubPartenariatGrid = $("#clubPartenariatGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 호출
function clubPartenariatListSearch() {
    getClubPartList();
}

function btnSearch(){
	getClubPartList();
}

//삭제
function removeAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(clubPartenariatGrid.getCheckedGridData()[0])) {
  	v_rid = clubPartenariatGrid.getCheckedGridData()[0].rid;
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
              getClubPartList();
              basicPartenariatSelectSetting();
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

function clubPartenariatPopDtlOpen(){
	 $("#clubPartenariatPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubPartenariatPop"/>?rid='+rid,
	        contentType: "ajax",
	        title: "제휴사 상세",
	        width: '700px',
	        close :'clubPartenariatPopClose'
	   });
}



function addClubPartenariatFn(){
	 $("#clubPartenariatPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubPartenariatPop"/>',
	        contentType: "ajax",
	        title: "제휴사 등록",
	        width: '700px',
	        close :'clubPartenariatPopClose'
	   });
}
function clubPartenariatPopClose(){
	clubPartenariatPop._destroy();
}

function removeClubPartenariatFn(){
	if(clubPartenariatGrid.opt.gridControl.getSelectedRecords().length==0){
		alert( '<spring:message code="L00914"/>');
		return;
	}
	if (confirm('<spring:message code="L00086"/>')) {
		$.ifvSyncPostJSON( '<ifvm:action name="deleteClubPartenariatTab"/>',{rid : clubPartenariatGrid.opt.gridControl.getSelectedRecords()[0].rid}
		,function(result) {
			alert( '<spring:message code="M00003"/>');
			getClubPartList();
		})
	}
}

// function clubPartenariatTabContent(){
// 	testTab = $('#clubTierTabContent').DrawTab({
// 		item: [
// 			{label:'클럽등급상세' , href: '<ifvm:url name="tabClubTierDtlList"/>' +"?ridTier="+rid},
// 		]
// 	});
// }

</script>




<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <%-- <span><spring:message code="M00277" /></span> --%>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="plus"  text="M01852"  id="addClubPartenariatBtn" btnFunc="addClubPartenariatFn"/>
            <ifvm:inputNew type="button" btnType="minus"   text="M01854"  id="removeClubPartenariatBtn" btnFunc="removeClubPartenariatFn"/>
        </div>
    </div>
    <div id="clubPartenariatGrid" class="white_bg grid_bd0"></div>
</div>

<!--  <div id="clubPartenariatTabArea"> -->
<!-- 	<div id="clubPartenariatTabContent" ></div> -->
<!--  </div> -->


<div id="clubPartenariatPop" class="popup_container"></div>