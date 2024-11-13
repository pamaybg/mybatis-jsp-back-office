<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var custListGrid;

//고객 목록
function getCustList(page){

    var ejGridOption = {
    	loadComplete : function(obj){
    		//로그저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("PLOY_003", custListGrid.opt.data.records);
    	},  
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정
			data.page = page;
			return data;
		},
   		recordDoubleClick : function (args) {
   			var data =args.data.rid ;
   	    	goCustDetail(data);
        },

        dataUrl : '<ifvm:action name="getCustList"/>',

        columns : [
        	{
      		  field : 'custNm', headerText : '<spring:message code="L00320"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'a.cust_nm_decoding',
      			  title : '{{:custNm}}'
      		  }
      	  },{
    		  field : 'identiTypeNm', headerText : '<spring:message code="L00343"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'cd.mark_name',
    			  title : '{{:identiTypeNm}}'
    		  }
    	  },{
    		  field : 'identiVal', headerText : '<spring:message code="L00342"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'a.identi_val',
    			  title : '{{:identiVal}}'
    		  }
    	  },{
    		  field : 'custTypeNm', headerText : '<spring:message code="L00318"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'cd1.mark_name',
    			  title : '{{:custTypeNm}}'
    		  }
    	  },{
    		  field : 'realnmCertiYn', headerText : '<spring:message code="L00344"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'a.realnm_certi_yn',
    			  title : '{{:realnmCertiYn}}'
    		  }
    	  },{
    		  field : 'realnmCertiDate', headerText : '<spring:message code="L00345"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'a.realnm_certi_date',
    			  title : '{{:realnmCertiDate}}'
    		  }
    	  },
    	  /* {
    		  field : 'createBy', headerText : '<spring:message code="L00093"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'em.name',
    			  title : '{{:createBy}}'
    		  }
    	  }, */
    	  {
    		  field : 'modifyDate', headerText : '<spring:message code="L00094"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'a.modify_date'
    		  }
    	  },{
    		  field : 'modifyBy', headerText : '<spring:message code="L00095"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'em1.name'
    		  }
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    		  customAttributes : {
    			  index : 'a.rid'
    		  }
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.rid',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    custListGrid = $("#custListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동
function goCustDetail(id) {
	$.fn.ifvmPersonalCondLogPageId("PLOY_003", true);
	qtjs.href('<ifvm:url name="custDetail"/>' + '?rid=' + id);
}

/*
//그리드 텍스트 선택시 상세로 이동
 function goGridRowLink(cellvalue, options, rowObjec){
    var id = rowObjec.rid;
    var url = '<ifvm:url name="custDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" >' + cellvalue + '</a>';

    return tag                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ;
}

 */

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","PLOY_003");
}

//공통 조회 호출
function custListSearch() {
    $.fn.ifvmSubmitSearchCondition_NoAllSearch("commSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	    	custListGrid.searchGrid({item: requestitem});
	//     		getCustList);
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
}



//삭제
function removeAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(custListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = custListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M00108"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        if (confirm('<spring:message code="L00086"/>')) {
            $.ifvProgressControl(true);

            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeCust"/>', {
                rid: v_rid
            },
            function(result) {
                alert('<spring:message code="L00085"/>');

                //고객 목록
                getCustList(getGridPage());

                $.ifvProgressControl(false);
            },
            function(result) {
                $.errorChecker(result);
                $.ifvProgressControl(false);
            });
        }
    }
}




//마스크해제
function clearMaskAction() {

    var v_rid;
    if ($.fn.ifvmIsNotEmpty(custListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = custListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
            $.ifvSyncPostJSON('<ifvm:action name="clearMaskCust"/>', {
                rid: v_rid
            },
            function(result) {
            	var gridObj = custListGrid.opt.gridControl;
            	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
            	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
            	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('identiVal'), result.identiVal);

//             	var rowid = custListGrid.getRadioSelectedRowId();
//                 custListGrid.opt.grid.setCell( rowid, 'custNm' , result.custNm );  // 고객명 세팅
//                 custListGrid.opt.grid.setCell( rowid, 'identiVal' , result.identiVal ); //식별값 세팅


            });

    }
}


//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = custListGrid.opt.data.page;
    var total = custListGrid.opt.data.records;

    if (total % page > 0) {
        rtnVal = page;
    }

    return rtnVal;
}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#clearMaskBtn").remove();
	}

}
$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();

  //마스킹해제 권한 체크
	//checkButtnAuth();
    getCustList();


    //조회
    $('#searchCondBtn').on('click', function(){
    	custListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });

    //신규 클릭시
/*     $('#addBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="custDetail"/>');
    }); */

    //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });


    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

});

</script>

<div class="page-title">
    <h1>
        <spring:message code="L00431"/><!-- 회원 -->
        &gt; <spring:message code="L00316"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="custSearchCondBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="custSearchCondInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00084"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 신규 버튼 --%>
            <!-- <button class="btn btn-sm" id="addBtn">
                <i class="fa fa-plus"></i>
                <spring:message code="L00078"/></button>-->
            <%-- 삭제 버튼 --%>
<!--             <button class="btn btn-sm" id="removeBtn"> -->
<!--                 <i class="fa fa-minus"></i> -->
<%--                 <spring:message code="L00080"/></button> --%>
            <%-- 마스킹해제 버튼 --%>
            <button class="btn btn-sm" id="clearMaskBtn" objCode="custClearMaskBtn_OBJ">
                <spring:message code="L00326"/></button>
        </div>
    </div>
    <div id="custListGrid" class="white_bg grid_bd0"></div>
</div>