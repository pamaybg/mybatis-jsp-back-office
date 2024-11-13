<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<script type="text/javascript">
var dormancyUserList;
// var dormancyData= new Array();

//포인트 소멸자  조회
function getDromancyList() {
	var ejGridOption = {
		loadComplete : function(obj){
			//고정된 조회조건 세팅
			var conds = new Array();
			var cond = {};
			cond.rid = $('#dorTerm').parent().prev().text().trim();
			conds.push(cond);
			
        	//로그 저장
    		$.fn.ifvmFixedCondLogging("DORMAN_02", dormancyUserList.opt.data.records, conds);
		},
		recordDoubleClick : function(args) {
			var data = args.data;
			rid = data.rid;
		},
		serializeGridData : function(data) {
			data.dorTerm=$('#dorTerm').val();
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
// 		dataSource : dormancyData,
// 		datatype : 'clientSide',
		dataUrl : '<ifvm:action name="getDormancyPredUser"/>',
		columns : [
		{
			field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'lm.MBR_NO'
			}
		}, {
			field : 'custNm', headerText : '회원명', headerTextAlign : 'center',
			customAttributes : {
				sortable : false,
				searchable: false,
				index : 'lc.cust_Nm'
			}
		}, {
			field : 'mbrStCd', headerText : '회원상태', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				sortable : false,
				searchable: false,
				index : 'lm.mbrStCd'
			}
		}, {
			field : 'dormancyDt', headerText : '휴면 예정일자', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				sortable : false,
				searchable: false,
				index : ''
			}
		}, {
			field : 'svrLastDt', headerText : '최종 접속일자',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				sortable : false,
				index : 'lmai.svrLastDt',
				searchable: false,
			}
		}, {
			field : 'chnlNm', headerText : '최종 접속 채널',headerTextAlign : 'center',
			customAttributes : {
				sortable : false,
				searchable: false,
				index : 'lch.chnlNm'
			}
		}, {
			field : 'rid', headerText : 'rid', visible : false,
			customAttributes : {
				index : 'lm.rid'
			}
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : 're.mbrno',
			sord : 'asc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		tempId : 'ifvGridSimplePageTemplete2'
		
// 		gridDataInit: false
	};

   dormancyUserList = $("#dormancyListGrid").ifvsfGrid({
      ejGridOption : ejGridOption
   });
}

function dormancyListSearch() {
	var dorData = $('#dorTerm').val();
// 	dormancyUserList.searchGrid(test);
	getDromancyList(dorData);
}

//공통 조회 호출
// function dormancyListSearch() {
// 	var tData = null;
// 	tData = $("#term").getSubmitData();

// 	$.ifvSyncPostJSON('<ifvm:action name="getDormancyPredUser"/>', tData
// 	, function(result) {
// 		dormancyData =result.rows;
// 		getDromancyList();
// 	});
// }
//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(dormancyUserList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = dormancyUserList.opt.gridControl.getSelectedRecords()[0].rid;
//     	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskMbr"/>', {
            rid: v_rid
        },
        function(result) {
           var gridObj = dormancyUserList.opt.gridControl;
           var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
           gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.mbrNm);
        });
    }
}

$(document).ready(function() {
   $.ifvmLnbSetting('dormancyScdUser');
   $.fn.ifvmSetSelectOptionCommCode( "dorTerm", "SELECT_DOR_TERM", null, null, true);
//     $.ifvProgressControl(true);
   //조회
   $('#ListSearchBtn').on('click', function() {
      dormancyListSearch();
   });
     //마스킹해제 클릭시
   $('#clearMaskBtn').on('click', function(){
      clearMaskAction();
   });
   getDromancyList();
   requestitem=null;

});
</script>

<style>
#hideFile {
   display: none
}
</style>

<div class="page-title">
   <h1>
      휴면 예정자 조회
   </h1>
</div>

<div>
   <div class="page_btn_area">
      <div class="col-xs-7">
         <span><spring:message code="L01838" /></span>
      </div>
      <div class="col-xs-5 searchbtn_r">
         <button class="btn btn-sm" id="ListSearchBtn" objCode="domancyScdListSearchBtn_OBJ">
            <i class="fa fa-search"></i>
            <spring:message code="M00135" />
         </button>
         <button class="btn btn-sm" id="channelListSearchInitBtn" objCode="doscdchannelListSearchInitBtn_OBJ">
            <spring:message code="M00278" />
         </button>
      </div>
   </div>
<!--    <div class="well form-horizontal well_bt5" id="ListSearchList"></div> -->
   <div class="row well form-horizontal" id ="term">
      <ifvm:inputNew type="select" id="dorTerm" names="dorTerm" dto="dorTerm" label="L00291" labelClass="1" conClass="3" /> <!-- 결과 유형 -->
   </div>
</div>

<div>
   <div class="page_btn_area">
      <div class="col-xs-7">
         <span><spring:message code="L00930" /></span>
      </div>
      <div class="col-xs-5 searchbtn_r">
         <ifvm:inputNew type="button" id="clearMaskBtn"  text="D10091" objCode="domancyScdclearMaskBtn_OBJ"/>
      </div>
   </div>
   <div id="dormancyListGrid" class="white_bg grid_bd0"></div>
</div>