<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="O00197" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="D00003" /></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="noticeListbtnNew_OBJ" />		
	    	<ifvm:inputNew type="button" id="BtnRemove" btnFunc="btnRemoveClick" btnType="minus" text="M01854" objCode="BtnRemove_OBJ" />
	    </div>
	</div>
	<div id="noticeGrid"></div>
</div>

<script>
var noticeListGrid;

function makeNoticeGrid(){
	var ejGridOption = {
			recordDoubleClick : function(args){
				rid = args.data.rid;
				noticeDetail(rid);
			},
			serializeGridData : function(data){
				if($.fn.ifvmIsNotEmpty(requestitem)){
					data.item = requestitem;
				}
				return data;
			},
	       	rowSelected : function(args){
	       		rid = args.data.rid;
	       	},
			dataUrl : '<ifvm:action name="getNoticeList"/>',
			columns : [
				{
					field : 'noticeNm', headerText : '<spring:message code="M00377"/>', textAlign : 'center', 
					customAttributes: {searchable : true}
				},{
					field : 'hitCnt', headerText : '<spring:message code="M01732"/>',  textAlign : 'center',
				},{
					field : 'createBy', headerText : '<spring:message code="M01810"/>', textAlign : 'center',
				},{
					field : 'createDate', headerText : '<spring:message code="M01860"/>',  textAlign : 'center',
				},{
					field : 'openDate', headerText : '<spring:message code="L02457"/>',  textAlign : 'center',
				},{
					field : 'notice_status', headerText : '<spring:message code="C00125"/>',  textAlign : 'center',
				},{
					field : 'rid', headerText : 'rid', textAlign : 'center', visible : false,
				}
			],
			requestGridData : {
				nd : new Date().getTime(),
				row : 100,
				sidx : "createDate",
				sord : 'desc',
				_search : false
			},
			rowList : [100,50,30],
			autowidth : true,
			radio : true,
			tempId : 'ifvGridOriginTemplete',
	};
	
	noticeListGrid = $('#noticeGrid').ifvsfGrid({ ejGridOption : ejGridOption});
}


$(document).ready(function() {
	makeNoticeGrid();
});

function btnRemoveClick(){
	if($.fn.ifvmIsEmpty(noticeListGrid.opt.gridControl.getSelectedRecords()[0])){
		alert('목록을 선택해주세요.');
	}else{
		var rid = noticeListGrid.opt.gridControl.getSelectedRecords()[0].rid
		$.ifvSyncPostJSON('<ifvm:action name="removeNotice"/>', {
			rid : rid
	    },function(result){
	    	makeNoticeGrid();
	    	alert('삭제되었습니다.');
	    },function(result){
	    	alert('삭제 실패하였습니다.');
	    });
	}
}

function noticeDetail(rid) {
	location.href = '<ifvm:url name="noticeDetailUrl"/>' + '?rid=' + rid;
} 

function btnNewClick() {
	location.href = '<ifvm:url name="noticeDetailUrl"/>';
}

</script>