<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        	<span><spring:message code="이상거래대상자"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskBtn" text="마스킹해제" objCode="blackMbrListClearMask_OBJ"/>
			<ifvm:inputNew type="button" id="addBlackMbrBtn" text="신규" objCode="blackMbrListAdd_OBJ"/>
			<ifvm:inputNew type="button" id="mofiyBlackMbrBtn" text="수정" objCode="blackMbrListModify_OBJ"/>
			<ifvm:inputNew type="button" id="removeBlackMbrBtn" text="삭제" objCode="blackMbrListRemove_OBJ"/>
			
        </div>
    </div>
    <div id="blackMbrList" class="white_bg grid_bd0"></div>
</div>

<div id="addBlackMbrPopup" class="popup_container"></div>
<div id="modifyStatCdPop" class="popup_container"></div>


<script type="text/javascript">
var blackMbrRid;

function getBlackMbrListTab(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.blackTxnRid = blackRuleDetail_rid;
			return data;
		},
		recordDoubleClick : function (args) {
			blackMbrRid = args.data.rid;
			mofiyBlackMbrBtn();
        },rowSelected : function(args){
        	blackMbrRid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getBlackMbrListTab"/>',

        columns : [
        	{
      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', width:'80px',customAttributes : {searchable : true}
      	  },{
    		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', width:'60px', textAlign : 'center' 
    	  },{
    		  field : 'hhp', headerText : '전화번호', headerTextAlign : 'center', width:'100px', textAlign : 'center'
    	  },{
    		  field : 'totCnt', headerText : '발생횟수', headerTextAlign : 'center', width:'50px', textAlign : 'right' ,customAttributes : {searchable : true}
    	  },{
    		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', width:'130px', textAlign : 'center'
    	  },{
    		  field : 'contents', headerText : '설명',headerTextAlign : 'center', width:'100px', textAlign : 'left',customAttributes : {searchable : true}
    	  },{
    		  field : 'validStartDate', headerText : '유지시작일',headerTextAlign : 'center', width:'110px', textAlign : 'center'
    	  },{
    		  field : 'validEndDate', headerText : '유지종료일',headerTextAlign : 'center', width:'110px', textAlign : 'center'
    	  },{
    		  field : 'confirmDate', headerText : '확정일자',headerTextAlign : 'center', width:'110px', textAlign : 'center'
    	  },{
    		  field : 'cancelDate', headerText : '해제일자',headerTextAlign : 'center', width:'110px', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '13',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    blackMbrList = $("#blackMbrList").ifvsfGrid({ ejGridOption : ejGridOption });
}


function addBlackMbrPop() {
	$("#addBlackMbrPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addBlackMbrPopup"/>',
        contentType: "ajax",
        title: '이상거래대상자 등록',
        width: 600,
        close : 'addBlackMbrClosePopup'
	});
}
function addBlackMbrClosePopup() {
	addBlackMbrPopup._destroy();
}

function modifyStatCdPopup() {
	$("#modifyStatCdPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="modifyStatCdPop"/>',
        contentType: "ajax",
        title: '처리등록',
        width: 600,
        close : 'modifyStatCdClosePop'
	});
}
function modifyStatCdClosePop() {
	modifyStatCdPop._destroy();
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(blackMbrList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = blackMbrList.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskBlackMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = blackMbrList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
        });
    }
}

function removeBlackMbr() {
	 var v_rid;
	    if ($.fn.ifvmIsNotEmpty(blackMbrList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = blackMbrList.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="M02219"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	    	if( confirm('<spring:message code="I01500"/>') == true ){
	        $.ifvSyncPostJSON('<ifvm:action name="removeBlackMbr"/>', {
	            rid: v_rid
	        },
	        function(result) {
	        	blackMbrList._doAjax();
				alert('<spring:message code="I00726"/>');
	        });
	    }
	}
}

$(document).ready(function(){
	getBlackMbrListTab();
	
	$("#addBlackMbrBtn").click(function() {
		blackMbrRid=null;
		addBlackMbrPop();
	});
	
	
	$("#removeBlackMbrBtn").click(function() {
		removeBlackMbr();
	});
	
	$("#clearMaskBtn").click(function() {
		clearMaskAction();
	});
	
	$("#mofiyBlackMbrBtn").click(function() {
		modifyStatCdPopup();
	});

});

</script>