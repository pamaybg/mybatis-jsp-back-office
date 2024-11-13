<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="통합회원"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
	    <ifvm:inputNew type="button" text="통합대상자조회"  id="mbrIntSearchBtn" names="packageAcrlPointBtn" objCode="mbrIntListIntSearch_OBJ"/>
		<%-- <ifvm:inputNew type="button" text="신규"  id="packageAcrlPointBtn" names="packageAcrlPointBtn" btnFunc="addMbrIntPopup"/> --%>
		<%-- <ifvm:inputNew type="button" text="삭제" id="mbrTxnHistExcelList"  btnFunc="removeMbrInt" objCode="mbrTxnHistExcelList_OBJ"/> --%>
     </div>
</div>
    <div id="mbrIntListGrid" class="white_bg grid_bd0"></div>
	 

<div id="addMbrIntPop" class="popup_container"></div>
<div id="mbrIntSearchPop" class="popup_container"></div>

<script type="text/javascript">
var mbrIntCode=null;
function getMbrIntList(){

    var ejGridOption = {
    	loadComplete : function(data){
        		if(data.getCurrentViewData().length>0) {
        			mbrIntCode = data.getCurrentViewData()[0].mbrIntCode;
        		}
        },
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
		dataUrl : '<ifvm:action name="getMbrIntList"/>',
        columns : [
        	{
        	  field : 'mbrTypeCdNm', headerText : '회원유형', headerTextAlign : 'center', textAlign : 'center',customAttributes : {searchable : true}
          },{
      		  field : 'repYn', headerText : '대표여부', headerTextAlign : 'center', textAlign : 'center',customAttributes : {searchable : true}
      	  },{
    		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',customAttributes : {searchable : true}

    	  },{
    		  field : 'sbscDate', headerText : '가입일자', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'sescnDate', headerText : '탈회일자', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'mbrStatCdNm', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true,index :'em2.name'}

    	  },{
    		  field : 'modifyDate', headerText : '수정일자', headerTextAlign : 'center', textAlign : 'center',

    	  }
    	  ,{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true,index :'em.name'}

    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
    	  },{
    		  field : 'mbrIntCode', headerText : 'mbrIntCode', headerTextAlign : '',visible: false,
    	  },{
    		  field : 'ridMbr', headerText : 'ridMbr', headerTextAlign : '',visible: false,
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'DESC',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
    };

    mbrIntListGrid = $("#mbrIntListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addMbrIntPopup() {
	$("#addMbrIntPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addMbrIntPop"/>',
        contentType: "ajax",
        title: '회원통합 신규',
        width: 500,
        close : 'addMbrIntClosePop'
    });
};
function addMbrIntClosePop() {
	addMbrIntPop._destroy();
}

function mbrIntSearchPopup() {
	if($("#custTypeCd").val()=='I' && $("#mbrTypeCd").val()=='M3') {
	
		$("#mbrIntSearchPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="mbrIntSearchPop"/>',
	        contentType: "ajax",
	        title: '통합대상자 조회',
	        width: 1000,
	        close : 'mbrIntSearchPopupClose'
		});
	} else {
		alert("개인 통합회원만 가능합니다.");
		return;
	}
}

function mbrIntSearchPopupClose() {
	mbrIntSearchPop._destroy();
}


function removeMbrInt() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(mbrIntListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = mbrIntListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    	v_repYn = mbrIntListGrid.opt.gridControl.getSelectedRecords()[0].repYn;
    	v_mbrIntCode = mbrIntListGrid.opt.gridControl.getSelectedRecords()[0].mbrIntCode;
    	v_ridMbr = mbrIntListGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    }
    else {
        alert('<spring:message code="M00104"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeMbrInt"/>', {
            rid: v_rid,
            repYn : v_repYn,
            mbrIntCode : v_mbrIntCode,
            ridMbr     : v_ridMbr
        },
        function(result) {
        	mbrIntListGrid._doAjax();
        	mbrDetail();
			alert('<spring:message code="I00726"/>');
        },function(result) {
        	if($.fn.ifvmIsNotEmpty(result.message)) {
        		alert(result.message);
        		return;
        	}
        });
    }
  }
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(mbrIntListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = mbrIntListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskMbrInt"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = mbrIntListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        });
    }
}


$(document).ready(function(){
	getMbrIntList();

	//조회
    $('#clearMask').on('click', function(){
    	clearMaskAction();
    });
	
  //조회
    $('#mbrIntSearchBtn').on('click', function(){
    	mbrIntSearchPopup();
    });
  
  	
});

</script>