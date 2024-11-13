<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
	<h1>
		<spring:message code="L02771" />
		&gt; <spring:message code="D10049" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="familyListSearchBtn" objCode="familyListSearch_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="familyListInitBtn" objCode="familyListSearchInit_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="familySearchList">
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
			<a><i class="helpBtn" style="vertical-align: middle;">
	             <div class="helptxt" style="display:none;">
	             	<spring:message code="해지후 유예개월수가 지난 패밀리는 자동으로 삭제됩니다."/>
	             </div>
	        </i></a>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="familyClearMask" objCode="familyListClearMask_OBJ">
				<spring:message code="L01530" />
			</button>
			<button class="btn btn-sm" id="addFmly" objCode="familyListAddFmly_OBJ">
				<spring:message code="신규" />
			</button>
			<button class="btn btn-sm" id="apprProcs" objCode="familyListApprProcs_ObJ">
				<spring:message code="L01444" />
			</button>
			<button class="btn btn-sm" id="canlProcs" objCode="familyListCanlProcs_OBJ">
				<spring:message code="L02552" />
			</button>
		</div>
	</div>
	<div id="familyListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="familyPrcsPopupContainer" class="popup_container"></div>
<div id="addFmlyPopupContainer" class="popup_container"></div>

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
var familyList;
var rid;
var mbrRid;
var statType ="", statNm = "";

// 패밀리목록 조회 리스트
function getFamilyListSearch() {
	
	var ejGridOption = {
		recordDoubleClick : function(args) {
			var data = args.data;
			mbrRid = data.mbrRid;
			//개인정보 조회 이력남기기
			qtjs.href('<ifvm:url name="mbrListNewPage"/>' + '?rid=' + mbrRid);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		rowSelected : function (args) {
			rid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="getFamilyList"/>',
		columns : [
		 	{
		 		 type : "checkbox", width : 60
		 	},{
				field : 'pgmNm', headerText : '<spring:message code="M00774"/>',  textAlign : 'left', customAttributes :{searchable : true}
			}, {
				field : 'fmlyNm', headerText : '<spring:message code="L02786"/>',  textAlign : 'center'
			}, {
				field : 'statCdNm', headerText : '<spring:message code="M00147"/>', textAlign : 'center', customAttributes :{index : 'statCd'}
			}, {
				field : 'custNm', headerText : '<spring:message code="L00876"/>',  textAlign : 'center', customAttributes : {searchable : true}
			}, {
				field : 'email', headerText : '<spring:message code="L02787"/>',  textAlign : 'center', customAttributes : {searchable : true}
			}, {
				field : 'hhp', headerText : '<spring:message code="L02788"/>', textAlign : 'center', customAttributes :{searchable : true}
			}, {
				field : 'fmlyCnt', headerText : '<spring:message code="L02789"/>',  textAlign : 'center', customAttributes :{searchable : true}
			},{
				field : 'applDate', headerText : '<spring:message code="L02790"/>',  textAlign : 'center'
			},{
				field : 'apprDate', headerText : '<spring:message code="L02791"/>',  textAlign : 'center'
			}, {
				field : 'canlDate', headerText : '<spring:message code="L02792"/>',  textAlign : 'center'
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			}, {
				field : 'mbrRid', headerText : 'mbrRid', visible : false,
			} ],
		 requestGridData : {
			sidx : 'applDate',
			sord : 'desc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : false
	};

	familyList = $("#familyListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

//공통 조회 조건 목록 설정
function familyListInit(gridId) {
	$.fn.ifvmSetCommonCondList("familySearchList", "LOY_FAMILY_LIST", gridId);
}

//공통 조회 호출
function familyListSearch() {
	$.fn.ifvmSubmitSearchCondition("familySearchList", getFamilyListSearch);
}

//마스크 해제
function familyClearMaskAction() {
	  var v_rid;
	  if ($.fn.ifvmIsNotEmpty(familyList.opt.gridControl.getSelectedRecords()[0])) {
	  	v_rid = familyList.opt.gridControl.getSelectedRecords()[0].rid;
	  }
	  else {
	      alert('<spring:message code="M02219"/>');
	  }
	  
	  if ($.fn.ifvmIsNotEmpty(v_rid)) {
		  if(familyList.opt.gridControl.getSelectedRecords().length > 1){
			  alert("마스킹해제는 1개씩만 가능합니다.");
		  }
		  else{
		      $.ifvSyncPostJSON('<ifvm:action name="clearMaskFamilyList"/>', {
		          rid: v_rid
		      },
		      function(result) {
		      	var gridObj = familyList.opt.gridControl;
		      	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
		      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
		      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.unMaskEmail);
		      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
		      });
		  }
	  }
}

function getCanlPrcsPop(){
	var check = true;
	var checkedList = familyList.opt.gridControl.getSelectedRecords();
	if (checkedList.length == 0) {
		alert('<spring:message code="D10300"/>');
	}else{
		for(var i = 0; i < checkedList.length; i++){
			if(checkedList[i].statCd != "02"){
				check = false;
				statNm = checkedList[i].statCdNm;
				alert(statNm + '상태에선 해지를 할수 없습니다.');
				return;
			}
		}
		if(check){
		    $("#familyPrcsPopupContainer").ifvsfPopup({
		        enableModal : true,
		        enableResize : false,
		        contentUrl : '<ifvm:url name="familyProcessPop"/>',
		        contentType : "ajax",
		        title : "<spring:message code="L02793"/>",
		        width : '860px',
		        close : 'familyPrcsPopupClose',
		     });
		}
	}
}

function familyPrcsPopupClose(){
	familyPrcsPopupContainer._destroy();
}

function saveApprProcs(){
	var check = true;
	var a_rid =[];
	var checkedList = familyList.opt.gridControl.getSelectedRecords();
	
	if (checkedList.length == 0) {
		alert('<spring:message code="D10300"/>');
	}else{
		for(var i = 0; i < checkedList.length; i++){
			if(checkedList[i].statCd != "01"){
				check = false;
				statNm = checkedList[i].statCdNm;
				alert(statNm + '상태에선 활성를 할수 없습니다.');
				return;
			}
		}
		if(check){
			for(var i = 0; i < checkedList.length; i++){
				a_rid.push(checkedList[i].rid);
			}
			if(confirm('<spring:message code="D10301"/>') ){
				$.ifvSyncPostJSON('<ifvm:action name="saveApprProcess"/>', {
					ridList : a_rid,
			    	statCd : '02'
				}, function(result){
			    	alert('<spring:message code="D10117"/>');
			    	familyList._doAjax();
				});
			}
		}
	}
}

function addNewFmly(){
	$("#addFmlyPopupContainer").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="addNewFmlyPop"/>',
        contentType : "ajax",
        title : "<spring:message code="패밀리 신규 가입"/>",
        width : '860px',
        close : 'addNewFmlyPopupClose',
     });
}

function addNewFmlyPopupClose(){
	addFmlyPopupContainer._destroy();
}

$(document).ready(function() {

	familyListInit();
	familyListSearch();
	
	//조회
	$('#familyListSearchBtn').on('click', function() {
		familyListSearch();
	});

	//초기화
	$("#familyListInitBtn").on('click', function() {
		familyListInit('familyList');
	});

	//마스킹해제
	$("#familyClearMask").on('click', function() {
		familyClearMaskAction();
	});
	
	//패밀리신규
	$("#addFmly").click(function(){
		addNewFmly();
	});
	
	//승인
	$("#apprProcs").click(function(){
		saveApprProcs();
	});
	
	//해지
	$("#canlProcs").on('click', function() {
		getCanlPrcsPop();
	});

	
	$('.helpBtn').setupHelpMessage();
	
});
</script>
