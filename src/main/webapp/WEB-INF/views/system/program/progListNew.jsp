<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script>
var progList = null;
var authId = $.ifvmGetAuthInfo().authList[0].id;
var pgmId = null;
var pgmChildId = null;

//프로그램 리스트 조회
function progListSetting(){
	
	var ejGridOption = {
		rowSelected : function(args) {
			pgmId = args.data.id;
			programRelTab.drawTab();
		},
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.authId = authId;
			return data;
		},
        dataUrl : '<ifvm:action name="getProgAllList"/>',
        columns:[
        	{
        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', customAttributes :{searchable : true}
        	  },{
          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'pgmTypeNm', headerText : '<spring:message code="I02046"/>', textAlign : 'center', customAttributes :{searchable : false, index : 'cc.MARK_NAME'}
          	  },{
          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes :{searchable : true, index : 'pgmPath'}
          	  },{
          		  field : 'prog_crea', headerText : '<spring:message code="I02055"/>', textAlign : 'center'
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center'
          	  },{
          		  field : 'id', headerText : 'id', visible : false 
          	  },{
          		  field : 'menuChkYn', headerText : 'menuChkYn', visible : false 
          	  },
        ],	
    		loadComplete: function () {
            $("#programRelTabArea").empty();
        },
        requestGridData : {
      	  sidx : 'createDate',
      	  sord : 'desc'
        },
        radio: true,
        multiselect: true,
        tempId : 'ifvGridOriginTemplete',
        rowList: $.ifvmGetSelectBoxNum(),
    };
	progList = $("#progListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
};

//셀클릭시 프로그램 리스트 아이디 넘기고 디테일 화면으로 이동
function progDetail(progId){
	qtjs.href('<ifvm:url name="progDetailNew"/>' + '?progId=' + progId);
};

function progNew(){
	pgmId = null;
	qtjs.href('<ifvm:url name="progDetail"/>');
};

function progModify() {
	if(progList.opt.gridControl.getSelectedRecords().length==0) {
		alert('<spring:message code="I00728"/>');
		return;
	}
	progDetail(pgmId);
}

//프로그램 리스트 삭제
function deleteProg() {
		var checkedList = progList.opt.gridControl.getSelectedRecords();
		var progIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			progIdList.push( checkedList[i].id );	
		}
		
		if(progIdList.length > 0){
			
			if( confirm('<spring:message code="I01500"/>') == true ){
			
				$.ifvSyncPostJSON('<ifvm:action name="deleteProgList"/>',{
					progId : progIdList,
					prgId : pgmId,
				},
				function(result) {
					alert('<spring:message code="I00726"/>');
					progList._doAjax();
					//location.reload();
				});
			}
			
		}else{
			alert('<spring:message code="I00728"/>');
		}
	
};

function programAuthList() {
	if(progList.opt.gridControl.getSelectedRecords().length==0) {
		alert('<spring:message code="I00728"/>');
		return;
	}
	if(progList.opt.gridControl.getSelectedRecords()[0].menuChkYn!="Y") {
		alert('<spring:message code="M02930"/>');
		return;
	}
	$("#authAddDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="getAuthAddDialog"/>',
        contentType: "ajax",
        title: '<spring:message code="I02075"/>',
        width: 1000,
        close : 'AuthPopupClose'
    });
}

function AuthPopupClose(){
	authAddDialog._destroy();
}

var programRelTab = {
    drawTab : function () {
        $("#programRelTabArea").empty();

        $("#programRelTabArea").DrawTab(
            {
                item: items
                	/* [
					{
                        label: '<spring:message code="L02669"/>',
                        href: '<ifvm:url name="lowProgramRel"/>'
					},
					{
                        label: '<spring:message code="하위 탭 목록"/>',
                        href: '<ifvm:url name="programChildTab"/>'
					},
                    {
                        label: '<spring:message code="L02674"/>',
                        href: '<ifvm:url name="authProgramConnection"/>'
                    },
                    {
                    	label: '<spring:message code="L02690"/>',
                        href: '<ifvm:url name="excelDownloadList"/>'
                    }
                	] */
            }
        )
    }
}


function pgmListSearchInit(gridId){
	$.fn.ifvmSetCommonCondList("programSearchList","AUT_PROG_01",gridId);
}

//공통 조회 호출
function pgmListSearch() {
    $.fn.ifvmSubmitSearchCondition("programSearchList", progListSetting);
} 

	
$(document).ready(function() {	
	progListSetting();
	
	pageSetUp();
	
	$.ifvmAdminCheck(false, true, true);
	
    //공통 조회 조건 목록 설정
    pgmListSearchInit();
    
    //조회
    $('#pgmListSearchBtn').on('click', function(){
    	pgmListSearch();
    });
    
    //초기화
    $("#pgmListSearchInitBtn").on('click', function(){
    	pgmListSearchInit('progList');
    });
    

	
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="I02054"/>
		&gt; <spring:message code="M00273"/>
	</h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="pgmListSearchBtn" objCode="progListNewSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="pgmListSearchInitBtn" objCode="progListNewSearchInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="programSearchList" >
    </div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02035"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" className="authAddBtn" btnFunc="programAuthList()" id="programAuthBtn"  text="I02075" btnType="plus" objCode="authAddAuthBtn_OBJ"/>
			<ifvm:inputNew type="button" className="authCretBtn" btnFunc="progNew()" text="I00887" btnType="plus" objCode="authCretBtn_OBJ" />
			<ifvm:inputNew type="button" className="authModifyBtn" btnFunc="progModify()" text="M01853" btnType="save" objCode="authModifyBtn_OBJ" />
			<ifvm:inputNew type="button" className="authDelBtn" btnFunc="deleteProg()" text="I00888" btnType="minus" objCode="authDelBtn_OBJ" />
		</div>
	</div>
		<div id="progListGrid" class="grid_bd0"></div>
</div>
<div id="programRelTabArea"></div>
<div id="authAddDialog" class="popup_container"></div>
