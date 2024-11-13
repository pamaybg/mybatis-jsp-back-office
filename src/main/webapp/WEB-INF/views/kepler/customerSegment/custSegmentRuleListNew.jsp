<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
   .helpBtn {
      background-image: url("/resources/images/icons/btn_help.png");
      background-repeat:no-repeat;
       background-position:center center;
       padding-left: 30px;
       vertical-align: middle;
       width: 17px;
       height: 17px;
       line-height: 17px;
   }
</style>
<script type="text/javascript">
var segmentListGrid;
var custRuleSegmentListGrid;
var custRuleSegmentList;
var segmentID=null;
var segTypeCd=null;
//공통 조회 조건 목록 설정
function segmentListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("segmentSearchList","ANL_SEG_001",gridId);
}

//공통 조회 호출
function segmentListSearch() {
	$.fn.ifvmSubmitSearchCondition("segmentSearchList", function() {
		segmentListGrid.searchGrid({
			item : requestitem
		});
	});
}
//캠페인 목록
function getSegmentList(page){

    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var ejGridOption = {
        serializeGridData : function( data ){

        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }

        	//페이지 설정
        	data.page = page;

            return data;
        }, rowSelected : function (args) {
        	var data = args.data;
        	segmentID=data.segmentId;
        	segTypeCd=data.segTypeCd;

        	getCustRuleSegmentList(args.data);
       	},
        recordDoubleClick : function (args) {
        	var data = args.data;
        	segmentID=data.segmentId;
        	goSegmentDetail(data.segmentId);
        },
        dataUrl : '<ifvm:action name="getCustSegmentList"/>',
        columns:[
        	 {
	      		  field : 'segmentName', headerText : '<spring:message code="M00677"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 's.SEG_NM' 
	      			  ,searchable : true}/* */
	      	  }, {
	      		  field : 'logicalCompName', headerText : '<spring:message code="M02956"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'l.LGC_COMP_NM'
	      			,searchable : true}/* */
	      	  }, {
	      		  field : 'createByName', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'e.NAME' }/* */
	      	  }, {
	      		  field : 'createDate', headerText : '<spring:message code="M00185"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 's.CREATE_DATE' }/* */
	      	  }, {
	      		  field : 'segTypeCd', headerText : 'segTypeCd', visible : false ,
	      		  customAttributes : {
	      			  index : 's.seg_type_cd' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 's.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
//         tempId : 'ifvGridOriginTemplete'
    };

    segmentListGrid = $("#segmentListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//세그먼트 상세 이동
function goSegmentDetail(id) {
	var url = '<ifvm:url name="custSegmentRuleDetail"/>?segmentId=' + id
    qtjs.href(url);
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowLink(cellvalue, options, rowObjec){
    var id = rowObjec.segmentId;
    var url = '<ifvm:url name="custSegmentRuleDetail"/>?segmentId=' + id;
    var tag = '<a href="' + url + '" >' + cellvalue + '</a>';

    return tag;
}

/* 팝업 닫기 */
function segmentNewPopClose(){
	segmentNewPopup._destroy();
}


//세그먼트 생성 팝업 열기
function segmentNewPopOpen() {
    $("#segmentNewPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentCreatePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01470" />',
        width: 750,
        close : 'segmentNewPopClose'
    });
}

//세그먼트 삭제
function removeSegment() {
    var segmentId;
     if ($.fn.ifvmIsNotEmpty(segmentListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	segmentId = segmentListGrid.opt.gridControl.getSelectedRecords()[0].segmentId;
    }

    if ($.fn.ifvmIsNotEmpty(segmentId)) {
        if (confirm('<spring:message code="C00079" />')) {
            $.ifvProgressControl(true);

            //세그먼트 삭제
            $.ifvPostJSON('<ifvm:action name="removeSegment"/>', {
                segmentId: segmentId,
                segmentTypeCode : segTypeCd
            },
            function(result) {
                alert('<spring:message code="M00255" />');

                //세그먼트 목록
                getSegmentList(getGridPage());

                $.ifvProgressControl(false);
            },
            function(result) {

                $.errorChecker(result);

                $.ifvProgressControl(false);
            });
        }
    } else {
        alert('<spring:message code="M00108"/>');
    }
}

function removeCustSegRule() {
    var custRuleSegmentId;
    if ($.fn.ifvmIsNotEmpty(custRuleSegmentList.opt.gridControl.getSelectedRecords()[0])) {
    	custRuleSegmentId = custRuleSegmentList.opt.gridControl.getSelectedRecords()[0].tgtGroupId;
    }

    if ($.fn.ifvmIsNotEmpty(custRuleSegmentId)) {
        if (confirm('<spring:message code="C00079" />')) {
            $.ifvProgressControl(true);

            //세그먼트 삭제
            $.ifvPostJSON('<ifvm:action name="removeCustSegmentRule"/>', {
                rid: custRuleSegmentId
            },
            function(result) {
                alert('<spring:message code="M00255" />');
                //세그먼트 목록
                //getCustRuleSegmentList(getGridPage());
                custRuleSegmentList._doAjax();
                $.ifvProgressControl(false);
            },
            function(result) {
                $.errorChecker(result);

                $.ifvProgressControl(false);
            });
        }
    } else {
        alert('<spring:message code="M00108"/>');
    }
}

//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = segmentListGrid.opt.data.page;
    var total = segmentListGrid.opt.data.records;

    if (total % page > 0) {
        rtnVal = page;
    }

    return rtnVal;
}

function getCustRuleSegmentList(data){
	var segmentId =null;
	
	if ($.fn.ifvmIsNotEmpty(data)) {
		segmentId = data.segmentId;
	}

    var ejGridOption = {
        serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            data.segmentId=segmentId;
            return data;
        },
        recordDoubleClick : function (args) {
        	var data = args.data;
        },
        dataUrl : '<ifvm:action name="getCustRuleListBySegId"/>',
        columns:[
        	 {
	      		  field : 'tgtGroupNm', headerText : '고객 세분화 룰 명', headerTextAlign : 'center',  textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'tg.tgt_group_nm' 
	      			  ,searchable : true}
	      	  },{
	      		  field : 'custSegRuleDesc', headerText : '고객 세분화 룰 설명', headerTextAlign : 'center',  textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'tg.tgt_group_desc' 
	      			  ,searchable : true}
	      	  }, 
	      	  {
	      		  field : 'createByName', headerText : '등록자' , headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'tg.createByName' 
	      			}
	      	  },{
	      		  field : 'createDate', headerText : '등록 일시' , headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'tg.createDate' 
	      			}
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'tg.createDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
    };

    custRuleSegmentList = $("#custRuleSegmentListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    segmentListSearchInit();
	$("#custSegmentViewPopBtn").show();
	
	getSegmentList();
	getCustRuleSegmentList();

    //조회
    $('#segmentListSearchBtn').on('click', function(){
    	segmentListSearch();
    });

    //초기화
    $("#segmentListSearchInitBtn").on('click', function(){
    	segmentListSearchInit('segmentListGrid');
    });

    //신규 클릭시
    $('#segmentNewBtn').on('click', function(){
        segmentNewPopOpen();
    });

    //타겟그룹 삭제
    $('#segmentRemoveBtn').on('click', function(){
        removeSegment();
    });

    $('#custSegmentRuleRemoveBtn').on('click', function(){
        removeCustSegRule();
    });
    
    
    $("#segmentDetailBtn").on('click', function(){
    	if ($.fn.ifvmIsNotEmpty(segmentID)) {
    		var url = '<ifvm:url name="custSegmentRuleDetail"/>?segmentId=' + segmentID
    		    qtjs.href(url);
    	}else{
    		alert("목록을 선택해주세요.");
    	}
   
    });
    
	$('.helpBtn').setupHelpMessage();
	
    $('#custSegmentViewPopBtn').on('click', function() {
        openSegmentViewPopup();
    });
	
});
//세그먼트 팝업 열기
function openSegmentViewPopup() {
    var segmentId;
    var type;
    if ($.fn.ifvmIsNotEmpty(custRuleSegmentList.opt.gridControl.getSelectedRecords()[0])) {
    	tgtGroupId = custRuleSegmentList.opt.gridControl.getSelectedRecords()[0].tgtGroupId;
    	type = custRuleSegmentList.opt.gridControl.getSelectedRecords()[0].type;
   
                $("#segmentViewPopup").ifvsfPopup({
        		enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="custSegmentCondPop"/>?tgtGroupId=' + tgtGroupId,
                contentType: "ajax",
                title: '<spring:message code="M00546" />',
                width: 500,
                close : 'segmentViewPopupClose'
            });
    }else{
    	alert("선택된 고객 세분화 Rule이 없습니다.");
    }
  
}

//세그먼트 팝업 닫기
function segmentViewPopupClose() {
	segmentViewPopup._destroy();
    $('.tooltip').remove();
}

</script>

<div class="page-title">
    <h1>
      고객 세분화 Rule
        &gt; 조회 및 등록
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span>고객 세분화 Rule</span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="segmentListSearchBtn" objCode="segmentListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="segmentListSearchInitBtn" objCode="segmentListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="segmentSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span>세그먼트 <spring:message code="M00277" /></span>
            	<a><i class="helpBtn" style="vertical-align: middle;">
	             <div class="helptxt" style="display:none;">
	             	<spring:message code="D10307"/>
	             </div>
	        </i></a>
        </div>
        <div class="col-xs-5 searchbtn_r">
         <button class="btn btn-sm" id="segmentDetailBtn" objCode="segmentDetailBtn_OBJ">
                상세
            </button>
            <button class="btn btn-sm" id="segmentNewBtn" objCode="segmentNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id="segmentRemoveBtn" objCode="segmentRemoveBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>
    <div id="segmentListGrid" class="white_bg grid_bd0"></div>
  </div>
  <div>
        <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span>고객 세분화 Rule 조회 결과</span>
        </div>
          <div class="col-xs-5 searchbtn_r">
          	<%-- 조건상세 --%>
            <button class="btn btn-sm" id="custSegmentViewPopBtn" objCode="custSegmentViewPopBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00546" />
            </button>
            	<%-- 삭제 --%>
            <button class="btn btn-sm" id="custSegmentRuleRemoveBtn" objCode="custSegmentRuleRemoveBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00165" />
            </button>
        </div>
    </div>  
     <div id="custRuleSegmentListGrid" class="white_bg grid_bd0"></div>
</div>


<div id="segmentNewPopup" class="popup_container"></div>
<div id="dialogTempPop" class="popup_container"></div>
<div id="segmentViewPopup"></div>