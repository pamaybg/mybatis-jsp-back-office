<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="카테고리 목록"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addCategoryBtn" text="신규" objCode="prodGrpCategoryListAdd_OBJ"/>
			<ifvm:inputNew type="button" id="removeCategoryBtn" text="삭제" objCode="prodGrpCategoryListRemove_OBJ"/>
			<ifvm:inputNew type="button" id="removeAllTCategoryBtn" text="전체 삭제" objCode="prodGrpCategoryListRemoveAll_OBJ"/>
			<ifvm:inputNew type="button" id="excelUploadCategoryBtn" text="업로드" objCode="prodGrpCategoryListUpld_OBJ"/>
			<ifvm:inputNew type="button" id="excelDownCategoryBtn" text="다운로드" objCode="prodGrpCategoryListDown_OBJ"/>
			<ifvm:inputNew type="button" id="excelSampleCategoryBtn" text="업로드 양식" objCode="prodGrpCategoryListUpldSample_OBJ"/>
        </div>
    </div>
    <div id="categoryListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="categoryExcelUploadPop" class="popup_container"></div>
<div id="addCategoryPop" class="popup_container"></div>

<script type="text/javascript">
var rid;
var categoryListGrid=null;
function getCategoryList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.prodGrpRid = prodGrp_Rid;
			return data;
		},
		rowSelected : function(args){
        	rid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getProdCategoryList"/>',

        columns : [
        	{
      		  field : 'catId', headerText : '카테고리 번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'catNm', headerText : '카테고리 명', headerTextAlign : 'center' ,textAlign : 'left',customAttributes :{searchable : true}
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

    categoryListGrid = $("#categoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/**
 * 회원샘플다운로드
 */
function excelSampleCategory(){
	var data = {};
	data.offerType = "PROD_CATEGORY_GRP";
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

function excelUploadCategory() {
	$("#categoryExcelUploadPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="categoryExcelUploadPop"/>',
        contentType: "ajax",
        title: '카테고리 업로드',
        width: 600,
        close : 'categoryExcelUploadClosePop'
	});
}

function categoryExcelUploadClosePop() {
	categoryExcelUploadPop._destroy();
}

function addCategory() {
	$("#addCategoryPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addCategory"/>',
        contentType: "ajax",
        title: '카테고리 조회',
        width: 800,
        close : 'addCategoryClosePop'
	});
}

function addCategoryClosePop() {
	addCategoryPop._destroy();
}


function removeCategory() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(categoryListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = categoryListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="삭제할 목록을 클릭해주세요."/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeProdCategory"/>', {
            rid: v_rid
        },
        function(result) {
        	categoryListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function removeAllTCategory() {

    	if( confirm('전체 삭제 하시겠습니까?') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeAllTCategory"/>', {
            prodGrpRid : prodGrp_Rid
        },
        function(result) {
        	categoryListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }

}

function excelDownCategory() {
	$.ifvExcelDn('/loyalty/prodgrp/cateogoryGrpXmExcelList.do','categoryListGrid');
}

$(document).ready(function(){
	
	getCategoryList();
	
	$("#addCategoryBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 등록할 수 있습니다.");
			return;
		}
		if(tgtTypeCd=='P') {
			alert("상품 유형은 등록할 수 없습니다.");
			return;
		}
		
		addCategory();
	});
	
	$("#removeCategoryBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeCategory();
	});
	
	$("#removeAllTCategoryBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}

		
		removeAllTCategory();
	});
	
	$("#excelUploadCategoryBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 업로드할 수 있습니다.");
			return;
		}
		
		excelUploadCategory();
	});
	
	$("#excelDownCategoryBtn").click(function() {
		excelDownCategory();
	});
	
	$("#excelSampleCategoryBtn").click(function() {
		excelSampleCategory();
	});

});

</script>