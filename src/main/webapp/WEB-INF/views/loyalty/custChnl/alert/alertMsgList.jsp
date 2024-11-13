<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="page-title">
    <h1>
		<spring:message code="M01735" />
        &gt; <spring:message code="L02647" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
        	<button class="btn btn-sm" id="alertMsgPopBtn" objCode="alertMsgPopBtn_OBJ">
            	<spring:message code="L00027"/>
            </button>
            <button class="btn btn-sm" id="alertMsgRemoveBtn" objCd="alertMsgRemoveBtn_OBJ">
            	<spring:message code="M01854"/>
            </button>
            <button class="btn btn-sm" id="alertExcelUploadBtn" objCd="alertExcelUploadBtn_OBJ">
            	엑셀 업로드
            </button>
		</div>
	</div>
	<div class="white_bg grid_bd0" id="alertMsgListGrid"></div>
</div>
<div id="popupContainer" class="popup_container"></div>
<script>
var alertMsgGrid;
var rid=null;

$(document).ready(function(){
	getAlertMsgList();
	
	$('#alertMsgPopBtn').on('click',function(){
		alertMsgPopup();
	});
	
	$('#alertMsgRemoveBtn').on('click',function(){
		alertMsgRemove();
	});
});

//팝업
function alertMsgPopup(rid) {
    $("#popupContainer").ifvsfPopup({
     	enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="alertMsgPop"/>'+'?rid='+rid,
        contentType: "ajax",
        title: '알림공지',
        width: '700px',
        close : 'alertMsgPopupClose'
    });
}
function alertMsgPopupClose() {
	rid=null;
	popupContainer._destroy();
}

//삭제
function alertMsgRemove(){
	var list = alertMsgGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		var rid = list[0].rid;
		
		if(!confirm('<spring:message code="C00079" />')) return;
		$.ifvSyncPostJSON('<ifvm:action name="deleteAlertMsg"/>', {
			rid: rid
		}, function(result) {
			alert('<spring:message code="M01266" />');
			getAlertMsgList();
		});
	} else {
		alert('<spring:message code="C00035" />');
	}
}


function getAlertMsgList(){
    var ejGridOption = {
    	 serializeGridData : function(data) {
    		rid=null;
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		recordDoubleClick : function(args){
       		rid = args.data.rid;
       		alertMsgPopup(rid);
    	},
       	rowSelected : function(args){
       	},
        dataUrl : '<ifvm:action name="getAlertMsgList"/>',
        columns : [
        	{
      		  field : 'msgType', headerText : '유형', headerTextAlign : 'center', textAlign :  'center', width:'120px',
      		  customAttributes : {
      			  index : 'cc.CODE_NAME'
      		  }
      	  },{
      		  field : 'msg', headerText : '메시지', headerTextAlign : 'center', textAlign :  'left',
      		  customAttributes : {
      			  index : 'lmam.MSG'
      		  }
      	  },{
    		  field : 'status', headerText : '상태', headerTextAlign : 'center', textAlign :  'center', width:'90px',
    		  customAttributes : {
    			  index : 'cc2.CODE_NAME'
    		  }
   		  },{
      		  field : 'actionDt', headerText : '발생일', headerTextAlign : 'center', textAlign :  'center', width:'120px',
      		  customAttributes : {
      			  index : 'lmam.ACTION_DT'
      		  }
      	  },{
      		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign :  'center', width:'150px',
      		  customAttributes : {
      			  index : 'lmam.CREATE_BY'
      		  }
      	  },{
      		  field : 'createDt', headerText : '등록일시', headerTextAlign : 'center', textAlign :  'center', width:'160px',
      		  customAttributes : {
      			  index : 'lmam.CREATE_DATE'
      		  }
      	  },{
    		  field : 'rid', headerText : '', headerTextAlign : '' ,visible: false,
    		  customAttributes : {
    			  index : 'lmam.RID'
    		  }
    	  }
        ],

        requestGridData : {
          nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'cc2.CODE_NAME, lmam.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false,
        },
        rowList : [10,25,50],
        autowidth : true,
        radio: true,
        tempId : 'ifvGridNotSearchTemplete'
    };

    alertMsgGrid = $("#alertMsgListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
</script>