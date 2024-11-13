<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="알림 이력" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnFunc="showContents" text="내용보기" objCode="mbrAlterHistShowContents_OBJ"/>
	</div>
</div>
<div id="mbrAlterHistListGrid" class="white_bg grid_bd0"></div>

<div id="mbrAlterHistPopupContainer"></div>


<script type="text/javascript">
var mbrAlterHistListGrid = null;
var alterHistRid = null;
var title = null;

//내용보기 팝업 함수
function showContents(){
	// 클릭된 항목이 있는지부터 체크
	var selectedRecord = mbrAlterHistListGrid.opt.gridControl.getSelectedRecords()[0];
	if(selectedRecord == null) {
		alert("항목을 선택해주세요");
		return;
	}
	
	var url = '<ifvm:url name="mbrAlterHistContsPop"/>'+ '?alterHistRid=' + alterHistRid;
	$('#mbrAlterHistPopupContainer').ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentType: 'ajax',
		contentUrl: url,
		width: '600px',
		title: '<spring:message code="내용보기"/>',
		close: 'closeMbrAlterHistContsPop'
	});
}

function getAlterHistList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
			data.ridMbr = mbr_rid;
			return data;
		},
		loadComplete: function(result){
			mbrAlterHistListGrid.opt.gridControl.selectRows(0);
		},
		rowSelected : function(args){
			alterHistRid = args.data.rid;
			title = args.data.title;
		},
        dataUrl : '<ifvm:action name="getAlterHistList"/>',
        columns : [
        	{
      		  field : 'sendDate', headerText : '전송일시', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'sendDate'}
      	  }
        	,{
    		  field : 'altTypeCd', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',  customAttributes : { index : 'altTypeCd'}
    	  }
      	  ,{
    		  field : 'sendChnlType', headerText : '채널', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'sendChnlType'}
    	  }
    	  ,{
    		  field : 'title', headerText : '제목', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true,index : 'mcm.CONTS_TITLE'}
    	  }
          ,{
              field : 'userRecvCheck', headerText : '사용자 확인여부', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'userRecvCheck'}
          }
          ,{
              field : 'userRecvDate', headerText : '사용자 확인일시', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'userRecvDate'}
          }
    	  ,{
    		  field : 'rid', headerText : 'rid', visible: false
    	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'sendDate',
      	  sord : 'desc',
      	  _search : false,
        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
        //tempId: 'ifvGridSimplePageTemplete'
    };

    mbrAlterHistListGrid = $("#mbrAlterHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
    getAlterHistList();
});

</script>