<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="고객목록"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="excelUploadTgtGrpXmBtn" text="업로드" objCode="tgtGrpXmListUpload_OBJ"/>
			<ifvm:inputNew type="button" id="removeTgtGrpXmBtn" text="삭제" objCode="tgtGrpXmListRemove_OBJ"/>
			<ifvm:inputNew type="button" id="removeAllTgtGrpXmBtn" text="전체 삭제" objCode="tgtGrpXmListRemoveAll_OBJ"/>
			<ifvm:inputNew type="button" id="excelSampleDownTgtGrpXmBtn" text="업로드 양식" objCode="tgtGrpXmListDown_OBJ"/>
        </div>
    </div>
    <div id="tgtGrpXmListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="tgtGrpXmExcelUploadPop" class="popup_container"></div>

<script type="text/javascript">
var rid;
function getTgtGrpXmList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.tgtGrpRid = tgtGrp_Rid;
			return data;
		},
		rowSelected : function(args){
        	rid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getTgtGrpXmList"/>',

        columns : [
        	{
      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center' ,textAlign : 'center',customAttributes :{searchable : true}
    	  },{
    		  field : 'custNm', headerText : '고객명', headerTextAlign : 'center', textAlign : 'left'
    	  },{
    		  field : 'custStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : "custStatCd"}
    	  },{
    		  field : 'regDt', headerText : '가입일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',

        },
    };

    tgtGrpXmListGrid = $("#tgtGrpXmListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function chnlLoyPgmDetail(pgmRid) {
	addChnlLoyPgmPopup();
}

/**
 * 회원샘플다운로드
 */
function excelSampleDownTgtGrpXm(){
	var data = {};
	data.offerType = "TARGET_TGTGRP";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

//샘플데이터 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/system/batchRgst/excelSampleDown2.do";
	var method = "post"
		//data를 입력받음
		if( data ){
			if ($.fn.ifvmIsNotEmpty(data.offerType)) {
				inputs += '<input type="hidden" name="offerType" value="'+ data.offerType +'" />';

				// request를 보낸다.
				jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
				.appendTo('body').submit().remove();
			}
		};
};

function excelUploadTgtGrpXmPopup() {
	$("#tgtGrpXmExcelUploadPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tgtGrpXmExcelUploadPop"/>',
        contentType: "ajax",
        title: '고객 업로드',
        width: 600,
        close : 'tgtGrpXmExcelUploadClosePop'
	});
}

function tgtGrpXmExcelUploadClosePop() {
	tgtGrpXmExcelUploadPop._destroy();
}


function removeTgtGrpXm() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(tgtGrpXmListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tgtGrpXmListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('삭제할 목록을 클릭해주세요.');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTgtGrpXm"/>', {
            rid: v_rid
        },
        function(result) {
        	tgtGrpXmListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function removeAllTgtGrpXmBtn() {

    	if( confirm('전체 삭제 하시겠습니까?') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeAllTgtGrpXm"/>', {
            tgtGrpRid : tgtGrp_Rid
        },
        function(result) {
        	tgtGrpXmListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }

}

$(document).ready(function(){
	
	getTgtGrpXmList();
	
	$("#removeTgtGrpXmBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		removeTgtGrpXm();
	});
	
	$("#removeAllTgtGrpXmBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		removeAllTgtGrpXmBtn();
	});
	
	$("#excelUploadTgtGrpXmBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 업로드할 수 있습니다.");
			return;
		}
		excelUploadTgtGrpXmPopup();
	});
	
	$("#excelSampleDownTgtGrpXmBtn").click(function() {
		excelSampleDownTgtGrpXm();
	});

});

</script>