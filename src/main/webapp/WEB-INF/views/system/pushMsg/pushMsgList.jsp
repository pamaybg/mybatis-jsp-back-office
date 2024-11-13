<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="O00206" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="D00016" /></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="pushMsgListAdd_OBJ"/>
			<ifvm:inputNew type="button" id="btnCancel" btnFunc="btnCancelClick" btnType="minus" text="D00017" objCode="pushMsgListCancel_OBJ" />
	    </div>
	</div>
	<div id="pushMsgGrid"></div>
</div>

<script>
var pushMsgGrid;

function makePushMsgGrid() {
	var jqGridOption = {
			serializeGridData : function( data ){
			},

			ondblClickRow : function (rowNo) {
	        	var data = pushMsgGrid.getRowData()[rowNo-1];
	        	
	        	pushDetail(data.rid);
	        },
			loadComplete : function(obj){

			},
		    url: '<ifvm:action name="getPushMsgList"/>', 
		    colNames:[
		    		  '언어',
		              '제목', 
		              '메시지', 
		              '작성자', 
		              '등록일',
		              '발송일',
		              '발송유형',
		              '대상 고객',
		              '상태',
		              '상태코드',
		              'rid'
		              ],
		              
		    colModel:[
		        {name:'pushLang',index:'pushLang', width:'80x', resizable : false, align: 'center'},
		        {name:'pushTitle',index:'pushTitle', width:'160px', resizable : false, align: 'left'},
		        {name:'pushMessage',index:'pushMessage', width:'200px', resizable : false, align: 'left'},
		        {name:'createBy',index:'createBy', width:'80px', resizable : false, align: 'center'},
		        {name:'createDate',index:'createDate', width:'80px', resizable : false, align: 'center', formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'sendDate',index:'sendDate', width:'80px', resizable : false, align: 'center', formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'sendType',index:'sendType', width:'80px', resizable : false, align: 'center'},
		        {name:'targetMbrType',index:'targetMbrType', width:'80px', resizable : false, align: 'center'},
		        {name:'pushStatus',index:'pushStatus', width:'80px', resizable : false, align: 'center'},
		        {name:'pushStatusCd', resizable : false, hidden : true, searchable : false},
		        {name:'rid',index:'rid', resizable : false, hidden : true, searchable : false},
		    ],
		    radio : true,
		    sortname: 't1.createDate',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
	};
	
	pushMsgGrid = $('#pushMsgGrid').ifvGrid({jqGridOption : jqGridOption});
}

$(document).ready(function() {
	makePushMsgGrid();
	$('td[aria-describedby*="gridIdpushMsgGrid_radio"]').change(function(){
		
	})
});


function btnNewClick() {
	location.href = '<ifvm:url name="pushMsgDetailUrl"/>';
}

function btnCancelClick() {
	if(pushMsgGrid.getCheckedList()[0].pushStatusCd == "BEFORE"){
		$.ifvSyncPostJSON('<ifvm:action name="getPushMsgCancel"/>', {
			pushMsgId : pushMsgGrid.getCheckedList()[0].rid,
		}, function(result) {
				if(result.success == true){
					alert("예약 취소 되었습니다.");
					makePushMsgGrid();
				}
			})	
	}
	else if(pushMsgGrid.getCheckedList()[0].pushStatusCd == "COMPLETE"){
		alert("상태가 완료인 것은 예약 취소 할 수 없습니다.")
	}
	else{
		alert("상태가 예약인 것을 선택해주세요.")
	}
}

function pushDetail(id){
	location.href = '<ifvm:url name="pushMsgDetailUrl"/>' + '?rid=' +id;
}

</script>