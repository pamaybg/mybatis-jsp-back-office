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
       		/* status = "U"; */
    		/* qtjs.href('<ifvm:url name="tierGroupDtl"/>?rid='+rid+"&status="+status); */
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){
       		/* var cnt = obj.model.currentViewData; */
       	},
       	dataUrl : '<ifvm:action name="getTierGroupList"/>',
        columns:[
        	{
	      		  field : 'tierGrpNm', headerText : '등급그룹명', headerTextAlign : 'center', textAlign : 'left', width:'120px',
	      	  },{
	      		  field : 'pgmNm', headerText : '프로그램명', headerTextAlign : 'center', textAlign : 'left', width:'120px',
	      	  },{
	      		  field : 'statusCd', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width:'80px',
	      		  customAttributes : {
	      			  index : 'statusCdNm' }
	      	  },{
	      		  field : 'name', headerText : '수정자', headerTextAlign : 'center', textAlign : 'left', width:'80px',
	      	  },{
	      		  field : 'modifyDate', headerText : '수정일시', headerTextAlign : 'center', textAlign : 'center', width:'80px',searchable : true
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'modifyDate',
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
function tierGrpListSearch() {tierGrpListGrid
    $.fn.ifvmSubmitSearchCondition("tierGrpSearchList", function(){
    	tierGrpListGrid.searchGrid({item: requestitem});
    });
}

//삭제
function removeTier() {

	if($.fn.ifvmIsNotEmpty(tierGrpListGrid)) {
		var delList = tierGrpListGrid.opt.gridControl.getSelectedRecords();
		if($.fn.ifvmIsNotEmpty(delList)) {
			if(!confirm('<spring:message code="M00127" />')) return;

			$.ifvSyncPostJSON('<ifvm:action name="removeTierGrp"/>', {
				rid: delList[0].rid
			}, function(result) {
					alert('<spring:message code="M01266" />');
					getTierGrpList( );
			});
		} else {
			alert('<spring:message code="M00108"/>');
		}
	} else {
		alert('<spring:message code="M00108"/>');
	}
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
    	status = "I";
    	qtjs.href('<ifvm:url name="tierGroupDtl"/>?status='+status);
    });

    //삭제
    $("#tierGrpDelBtn").on('click', function(){
    	removeTier();
    });

});

</script>

<div class="page-title">
    <h1>
    등급 &gt; 조회
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
            <button class="btn btn-sm" id="tierGrpNewBtn" objCode="tierGrpNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>
            <!-- 삭제 -->
            <button class="btn btn-sm" id="tierGrpDelBtn" objCode="tierGrpDelBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="M00218" />
            </button>
        </div>
    </div>
    <div id="tierGrpListGrid" class="white_bg grid_bd0"></div>
</div>
