<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="채널 목록"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addChnlItemBtn" text="신규" objCode="chnlGrpItemAdd_OBJ"/>
			<ifvm:inputNew type="button" id="removeChnlItemBtn" text="삭제" objCode="chnlGrpItemRemove_OBJ"/>
			<ifvm:inputNew type="button" id="removeAllTChnlItemBtn" text="전체 삭제" objCode="chnlGrpItemRemoveAll_OBJ"/>
			<ifvm:inputNew type="button" id="excelUploadChnlItemBtn" text="업로드" objCode="chnlGrpItemUpload_OBJ"/>
			<ifvm:inputNew type="button" id="excelDownChnlItemBtn" text="다운로드" objCode="chnlGrpItemDown_OBJ"/>
			<ifvm:inputNew type="button" id="excelSampleChnlItemBtn" text="업로드 양식" objCode="chnlGrpItemSample_OBJ"/>
        </div>
    </div>
    <div id="chnlItemListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="chnlExcelUploadPop" class="popup_container"></div>
<div id="addChnlItemPop" class="popup_container"></div>

<script type="text/javascript">
var rid;
var chnlItemListGrid=null;
function getChnlItemList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.chnlGrpRid = chnlGrp_Rid;
			return data;
		},
		rowSelected : function(args){
        	rid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getChnlItemList"/>',

        columns : [
        	{
      		  field : 'lvlCd', headerText : '레벨', headerTextAlign : 'center' ,textAlign : 'center',width:'80px',customAttributes :{searchable : true}
      	  },{
      		  field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center' ,textAlign : 'left',customAttributes :{searchable : true}
    	  },{
    		  field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',customAttributes :{searchable : true}
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',

        },
    };

    chnlItemListGrid = $("#chnlItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/**
 * 회원샘플다운로드
 */
function excelSampleChnlItem(){
	var data = {};
	data.offerType = "CHNL_GRP"; // <====[my필기] 이 부분도 ROAD_ADDRESS 식으로, 내 엑셀내려받기 경우 전용의 타입 키를 하나 만들어서 설정해놓는다.
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

function excelUploadChnlItem() {
	$("#chnlExcelUploadPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlExcelUploadPop"/>',
        contentType: "ajax",
        title: '채널 업로드',
        width: 600,
        close : 'chnlExcelUploadClosePop'
	});
}

function chnlExcelUploadClosePop() {
	chnlExcelUploadPop._destroy();
}

function addChnlItem() {
	$("#addChnlItemPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addChnlMultiItem"/>',
        contentType: "ajax",
        title: '채널 조회',
        width: 800,
        close : 'addChnlItemClosePop'
	});
}

function addChnlItemClosePop() {
	addChnlItemPop._destroy();
}


function removeChnlItem() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(chnlItemListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = chnlItemListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="삭제할 목록을 클릭해주세요."/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeChnlItem"/>', {
            rid: v_rid
        },
        function(result) {
        	chnlItemListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function removeAllTChnlItem() {

    	if( confirm('전체 삭제 하시겠습니까?') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeAllTChnlItem"/>', {
            chnlGrpRid : chnlGrp_Rid
        },
        function(result) {
        	chnlItemListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }

}

function excelDownChnlItem() {
	$.ifvExcelDn('/loyalty/chnlgrp/chnlGrpXmExcelList.do','chnlItemListGrid');
}

$(document).ready(function(){
	
	getChnlItemList();
	
	$("#addChnlItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 등록할 수 있습니다.");
			return;
		}
		
		addChnlItem();
	});
	
	$("#removeChnlItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeChnlItem();
	});
	
	$("#removeAllTChnlItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeAllTChnlItem();
	});
	
	$("#excelUploadChnlItemBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 업로드할 수 있습니다.");
			return;
		}
		
		excelUploadChnlItem();
	});
	
	$("#excelDownChnlItemBtn").click(function() {
		excelDownChnlItem();
	});
	
	$("#excelSampleChnlItemBtn").click(function() {
		excelSampleChnlItem();
	});

});

</script>