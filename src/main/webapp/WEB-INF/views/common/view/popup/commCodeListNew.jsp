<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<br>
<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
        	<!-- 조회조건  -->
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="commCodeSearchCondBtn" objCode="commCodeListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="commCodeSearchCondInitBtn" objCode="commCodeListSearchInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<!-- 그룹 코드 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="그룹 코드"/></span> <!-- M00277 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
   <div id="commCodeListGrid"></div>
</div>
<!-- 코드 상세 -->
<div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="코드 상세"/></span> <!-- M00277 -->
        </div>
        <div class="col-xs-5 searchbtn_r"></div>
</div>
<div id="commCodeItemListGrid"></div>

<br>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="commCodeItemSelect" objCode="commCodeListSelect_OBJ">
        <i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="commCodeItemCancle" objCode="commCodeListCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>


<script type="text/javascript">
var commCodeItemListGrid = null;
var commCodeListGrid = null;
var groupCode = null;
var codeName = null;
var markName = null;
/* var tierFieldTypeCdNm; */

function getCommCodeList(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				groupCode = data.groupCode;
				getCommCodeItemList();
        },
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
	        }
	          return data;
		},
        dataUrl : '<ifvm:action name="getCommCodeListNew"/>',
        columns : [
        	/* {
      		  field : 'typeMarkNm', headerText : '분류', headerTextAlign : 'center', textAlign : 'center',width:'100px' , customAttributes :{index : 'type'}
      	  }, */
      	  {
    		  field : 'groupCode', headerText : '그룹코드', headerTextAlign : 'center', textAlign : 'left',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'groupName', headerText : '그룹명', headerTextAlign : 'center', textAlign : 'left', width:'200px' , customAttributes : {searchable : true}
    	  },{
    		  field : 'codeId', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '2',
      	  sord : 'desc',
      	  
        },
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
	commCodeListGrid = $("#commCodeListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function getCommCodeItemList(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				codeName = args.data.codeName;
				markName = args.data.markName;
        },
		serializeGridData : function( data ){
			data.groupCode = groupCode;
			return data;
		},
        dataUrl : '<ifvm:action name="getCommCodeItemList"/>',
        columns : [
        	 { field : 'seq', headerText : 'SEQ', headerTextAlign : 'center', textAlign : 'center',  width:'40px' ,customAttributes :{searchable : true} }
        	,{ field : 'markName', headerText : '코드명', headerTextAlign : 'center', textAlign : 'left',  width:'125px' ,customAttributes :{searchable : true } }
        	,{ field : 'codeName', headerText : '값', headerTextAlign : 'center', textAlign : 'center',  width:'125px' ,customAttributes :{searchable : true } }
        	/* ,{ field : 'markCode', headerText : '표시코드값', headerTextAlign : 'center', textAlign : 'left',  width:'140px' ,customAttributes :{searchable : true} } */
    	  	,{ field : 'codeId', headerText : 'codeId',visible : false }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',
      	  
        },
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
	commCodeItemListGrid = $("#commCodeItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function commCodeListSearch() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", function(){
    	commCodeListGrid.searchGrid({item: requestitem});
    });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","COMM_CODE_LIST_NEW",gridId);
}

	
$(document).ready(function() {
	searchCondInit();
	getCommCodeList();
	//조회
    $('#commCodeSearchCondBtn').on('click', function(){
    	commCodeListSearch();
    });

    //초기화
    $("#commCodeSearchCondInitBtn").on('click', function(){
    	searchCondInit('commCodeListGrid');
    });

	$("#commCodeItemSelect").on('click', function(){
		if(commCodeItemListGrid.opt.gridControl.getSelectedRecords().length == 0){ // 선택한 레코드가 없었을 경우
    		alert('<spring:message code="M00285"/>'); // 레코드 선택해주세요
    	}else {
    		$("#dataVal").val(codeName); 
    		$("#markNm").val(markName); 
    		$("#groupCd").val(groupCode); // 그룹코드값 groupCd필드에 넣기
    		    		
     		$.fn.ifvmPopupClose();
    	}
	});
	
	$("#commCodeItemCancle").on('click', function(){
		$.fn.ifvmPopupClose();
	}); 
});

</script>
