<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M02950" /></span>
			<a><i class="helpBtn" style="vertical-align: middle;">
	             <div class="helptxt" style="display:none;">
	             	<spring:message code="D10304"/>
	             </div>
	        </i></a>
		</div>
		<div class="col-xs-5 searchbtn_r">
<%-- 			<ifvm:inputNew type="button"   btnType="upload"  text="이상정책 심사"  id="blackRuleFmly" btnFunc="blackRuleFmly" objCode="mbrBlackRuleFmly_OBJ"/>
 --%>			<button class="btn btn-sm" id="mbrFamilyClearMask" objCode="mbrFamilyClearMask_OBJ">
				<spring:message code="L00326" />
			</button>
			<button class="btn btn-sm" id="addFamilyMbr" objCode="addFamilyMbr_OBJ">
				<spring:message code="L02769" />
			</button>
			<button class="btn btn-sm" id="removeFamily" objCode="removeFamily_OBJ">
				<spring:message code="D10020" />
			</button>
		</div>
	</div>
	<div id="mbrFamilyListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="newFmlyPopupContainer" class="popup_container"></div>

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
<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNewPage"/>?rid={{:rid}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>

<script type="text/javascript">
var mbrFamilyList;
var rid;
var chiefRid = null;

function getMbrFamilyListSearch() {
	
	var ejGridOption = {
		recordDoubleClick : function(args){
			var data = args.data;
			//개인정보 조회 이력남기기
			$.fn.ifvmPersonalCondLogPageId("LOY_MBR_FMLY_LIST_TAB", true);
			qtjs.href('<ifvm:url name="mbrListNewPage"/>'+ '?rid='+data.rid);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.ridMbr = mbr_rid
			return data;
		},
		rowSelected : function (args) {
			rid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="getMbrFamilyList"/>',
		columns : [
		 	{
				field : 'mbrNo', headerText : '<spring:message code="O00095"/>',  textAlign : 'center', /* template: "#mbrLinkTemplate", */
			}, {
				field : 'custNm', headerText : '<spring:message code="L00798"/>',  textAlign : 'center'
			}, {
				field : 'hhp', headerText : '<spring:message code="I02122"/>', textAlign : 'center'
			}, {
				field : 'relCdNm', headerText : '<spring:message code="L00486"/>',  textAlign : 'center', customAttributes : {index : 'relCd'}
			},{
				field : 'statCdNm', headerText : '<spring:message code="L00627"/>',  textAlign : 'center', customAttributes : {index : 'statCd'}
			},{
				field : 'totalPntAvl', headerText : '<spring:message code="L00826"/>',  textAlign : 'center', format : '{0:n0}'
			}, {
				field : 'createDate', headerText : '<spring:message code="L02807"/>',  textAlign : 'center'
			}, {
				field : 'secsnDate', headerText : '<spring:message code="L02808"/>',  textAlign : 'center'
			},{
				field : 'rid', headerText : 'rid', visible : false,
			} ],
		 requestGridData : {
			sidx :'custNm',
			sord : 'asc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		tempId : 'ifvGridSimplePageTemplete'
	};
	
	mbrFamilyList = $("#mbrFamilyListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	
}


//마스크 해제
function mbrFamilyClearMaskAction() {
	  var v_rid;
	  if ($.fn.ifvmIsNotEmpty(mbrFamilyList.opt.gridControl.getSelectedRecords()[0])) {
	  	v_rid = mbrFamilyList.opt.gridControl.getSelectedRecords()[0].rid;
	  }
	  else {
	      alert('<spring:message code="M02219"/>');
	  }

	  if ($.fn.ifvmIsNotEmpty(v_rid)) {
	      $.ifvSyncPostJSON('<ifvm:action name="clearMaskListMbr"/>', {
	          rid: v_rid
	      },
	      function(result) {
	      	var gridObj = mbrFamilyList.opt.gridControl;
	      	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
	      });
	  }
}

//구성원 가입
function addNewFamlyMbr(){
	 $("#newFmlyPopupContainer").ifvsfPopup({
	        enableModal : true,
	        enableResize : false,
	        contentUrl : '<ifvm:url name="addNewFmlyMbrPop"/>',
	        contentType : "ajax",
	        title : "<spring:message code="L02809"/>",
	        width : '860px',
	        close : 'addNewFmlyMbrPopclose',
	 });
}

function addNewFmlyMbrPopclose(){
	newFmlyPopupContainer._destroy();
}

//구성원 탈퇴
function removeFamilyMem(){
	var ridMbr, stat, mbrNo;
	var checkedMbr = mbrFamilyList.opt.gridControl.getSelectedRecords()[0];
	if ($.fn.ifvmIsNotEmpty(checkedMbr)) {
		  ridMbr = checkedMbr.rid;
		  mbrNo = checkedMbr.mbrNo;
		  stat = checkedMbr.statCd;
	}else{
		alert('<spring:message code="D10287"/>');
	}
	if ($.fn.ifvmIsNotEmpty(mbrNo)){
		if(stat == '01'){
			if(confirm('<spring:message code="D10302"/>')){
				$.ifvSyncPostJSON('<ifvm:action name="removeFmlyMbr"/>', {
					mbrNo : mbrNo
				}, function(result){
					if(result.message) alert(result.message);
					else alert('<spring:message code="D10117"/>');
					mbrFamilyList._doAjax();
				}, function(result){
					if(result.message) alert(result.message);
					else alert('패밀리 구성원 탈퇴에 실패하였습니다.');
				});
			}
		}else{
			alert('<spring:message code="D10303"/>');
		}
	}
}

function buttonInit(){
	$.ifvSyncPostJSON('<ifvm:action name="checkFmlyChief"/>', {
			rid : mbr_rid
		}, function(result){
			chiefRid = result.chiefRid;
			if(chiefRid != mbr_rid){
				$("#addFamilyMbr").hide();
				$("#removeFamily").hide();
			}
		}, function(result){
			$("#addFamilyMbr").hide();
			$("#removeFamily").hide();
	});
}

function blackRuleFmly() {
    $.ifvSyncPostJSON('<ifvm:action name="blackRuleFmly"/>', {
        
    },
    function(result) {
    	mbrFamilyList._doAjax();
    	if(result.rstMsg) alert(result.rstMsg);
    	else alert('<spring:message code="이상정책 실행완료"/>');
    },function(result) {
    	if($.fn.ifvmIsNotEmpty(result.rstMsg)) {
    		alert(result.rstMsg);
    		return;
    	}
    });
}

$(document).ready(function() {

	getMbrFamilyListSearch();
	buttonInit();
	
	//마스킹해제
	$("#mbrFamilyClearMask").on('click', function() {
		mbrFamilyClearMaskAction();
	});
	
	//구성원가입
	$("#addFamilyMbr").on('click', function() {
		addNewFamlyMbr();
	});
	
	//탈퇴
	$("#removeFamily").on('click', function() {
		removeFamilyMem();
	});
	
	$('.helpBtn').setupHelpMessage();
	
});
</script>