<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var tierGrpListGrid;
var rid;
/* var status = "I"; */

//등급그룹 목록 조회
function getTierGrpList(){
    var ejGridOption = {
       	recordDoubleClick : function(args){
       		var data = args.data;
       		rid = data.rid;
    		tierGroupDetailNew(rid);
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){
       	},
       	dataUrl : '<ifvm:action name="getTierGroupListNew"/>',
        columns:[
        	{
	      		  field : 'pgmNm', headerText : '프로그램', headerTextAlign : 'center', textAlign : 'left', width:'16%', customAttributes : {searchable : true}
	      	  },{
	      		  field : 'tiersGrpCd', headerText : '등급그룹코드', headerTextAlign : 'center', textAlign : 'center', width:'6%', customAttributes : {searchable : true}
              },{
	      		  field : 'tiersGrpNm', headerText : '등급그룹명', headerTextAlign : 'center', textAlign : 'left', width:'12%', customAttributes : {searchable : true}
	      	  },{
	      		  field : 'loyMbrTypeCdNm', headerText : '회원유형', headerTextAlign : 'center', textAlign : 'center', width:'10%', customAttributes : {index : 'loyMbrTypeCd'}
	      	  },/*{
                  field : 'brdNm', headerText : '브랜드', headerTextAlign : 'center', textAlign : 'center', width:'80px'
	      	  },*/{
	      		  field : 'vaildStartDt', headerText : '유효시작일', headerTextAlign : 'center', textAlign : 'center', width:'10%'
	      	  },{
	      		  field : 'mbrTierColNm', headerText : '등급그룹유형', headerTextAlign : 'center', textAlign : 'center', width:'8%', customAttributes : {index : 'mbrTierCol'}
	      	  },{
	      		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width:'6%', customAttributes : {index : 'statCd'}
	      	  },/*{
	      		  field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center', width:'60px'
	      	  },*/{
                  field: 'name', headerText: '수정자', textAlign: 'center', width:'10%'
              },{
                  field: 'modifyDate', headerText: '수정일자', textAlign: 'center', width: '10%'
	      	  },{
                field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', width: '10%', textAlign : 'center',
              },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '4,1',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio : true,
    };
    tierGrpListGrid = $("#tierGrpListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function tierGrpListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("tierGrpSearchList","PLOY_101",gridId);
}

//공통 조회 호출
function tierGrpListSearch() {
    $.fn.ifvmSubmitSearchCondition("tierGrpSearchList", function(){
    	tierGrpListGrid.searchGrid({item: requestitem});
    });
}

//삭제
function removeTier() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(tierGrpListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tierGrpListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTiersGrp"/>', {
            rid: v_rid
        },
        function(result) {
        	tierGrpListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function tierGroupDetailNew(rid) {
	qtjs.href('<ifvm:url name="tierGroupDetailNew"/>'+'?rid=' + rid);
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    tierGrpListSearchInit();
	getTierGrpList();

    //조회
    $('#tierGrpListSearchBtn').on('click', function(){
    	tierGrpListSearch();
    });

    //초기화
    $("#tierGrpListSearchInitBtn").on('click', function(){
    	tierGrpListSearchInit('tierGrpListGrid');
    });

    //신규 클릭시
    $('#tierGrpNewBtn').on('click', function(){
    	rid = null;
    	/* status = "I"; */
    	qtjs.href('<ifvm:url name="tierGroupDetailNew"/>');
    });

    //삭제
    $("#tierGrpDelBtn").on('click', function(){
    	removeTier();
    });

});

</script>

<div class="page-title">
    <h1>
    	<spring:message code="O00185"/> &gt; <spring:message code="M00273"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="tierGrpListSearchBtn" objCode="tierGrpListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="tierGrpListSearchInitBtn" objCode="tierGrpListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="tierGrpSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <!-- 신규 -->
            <button class="btn btn-sm" id="tierGrpNewBtn" objCode="tierGrpListNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>
            <!-- 삭제 -->
            <button class="btn btn-sm" id="tierGrpDelBtn" objCode="tierGrpListDelBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00218" />
            </button>
        </div>
    </div>
    <div id="tierGrpListGrid" class="white_bg grid_bd0"></div>
</div>
