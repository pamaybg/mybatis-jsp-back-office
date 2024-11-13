<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div>
    <div id="certListGrid" class="white_bg grid_bd0"></div>
</div>


<script type="text/javascript">

//고객 목록
function getCertList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getCertList"/>',

        columns : [
        	{
      		  field : 'certTypeCdNm', headerText : '인증유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'certTypeCd'}
      	  },{
    		  field : 'certVal', headerText : '인증값', headerTextAlign : 'center' , customAttributes :{searchable : true}
    	  },{
    		  field : 'certDate', headerText : '인증일시', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lcct.create_date',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    certListGrid = $("#certListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/* //공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","CUST_PAGE_001");
}

//공통 조회 호출
function custListSearch() {
    $.fn.ifvmSubmitSearchCondition_NoAllSearch("commSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
    		certListGrid.searchGrid({item: requestitem});
	//     		getCustList);
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
} */

$(document).ready(function() {

  //마스킹해제 권한 체크
    getCertList();

    //조회
    $('#searchCondBtn').on('click', function(){
    	custListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });

    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

});

</script>