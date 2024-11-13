<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var logicalComponentListGrid;
var segmentNewPopValidation;

//로지컬 컴포넌트 목록
function getLogicalComponentListGrid(){
    //그리드 생성
    var ejGridOption = {
        dataUrl : '<ifvm:action name="getSegmentLogicalComponentList"/>',
        columns:[ 
        	{
	      		  field : 'logicalCompName', headerText : '<spring:message code="M01427"/>', headerTextAlign : 'center', width: "230px",
	      		  customAttributes : {
	      			  index : 'l.LGC_COMP_NM',
	      				searchable: true}
	      	  },{
	      		  field : 'createByName', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center', width: "120px",
	      		  customAttributes : {
	      			  index : 'e.NAME' }
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="M00185"/>', headerTextAlign : 'center', width: "160px", textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'l.CREATE_DATE' }
	      	  },{
	      		  field : 'logicalCompUseFlag', headerText : '<spring:message code="M01472"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "100px",
	      		  customAttributes : {
	      			  index : 'l.logicalCompUseFlag' }
	      	  },{
	      		  field : 'logicalCompId', headerText : 'id', visible : false,
	      		  customAttributes : {
	      			  index : 'l.id' }
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'l.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false
        },
        radio: true,
        rowList: [5, 10],
        tempId : 'ifvGridOriginTemplete'
    };
    
    logicalComponentListGrid = $("#logicalComponentListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function saveSegment() {
    //validation 확인
  	if (segmentNewPopValidation.confirm()) {
        //로지컬 컴포넌트 아이디 확인
        if ($.fn.ifvmIsNotEmpty(logicalComponentListGrid.opt.gridControl.getSelectedRecords())) {
            var id = null;
            var segmentName = $("#segmentName").val();     //세그먼트명
            var logicalCompId = logicalComponentListGrid.opt.gridControl.getSelectedRecords()[0].logicalCompId;   //로지컬 컴포넌트 아이디
            var segmentTypeCode="CUST_SEG_LIST";
            	
            $.ifvProgressControl(true);
            
            //세그먼트 등록
            $.ifvPostJSON('<ifvm:action name="addSegment"/>', {
                segmentName: segmentName,
                logicalCompId: logicalCompId,
                segmentTypeCode : segmentTypeCode
            }
            , function(result) {
                id = result.message;
                
                //세그먼트 상세 화면 이동
                var url = '<ifvm:url name="custSegmentRuleDetail"/>';
                if( id != null ) url = url + '?segmentId=' + id;
                qtjs.href(url);
                
                $.ifvProgressControl(false);
            }
            , function(result) {
                segmentMessageCheckr(result.message);
                
                $.ifvProgressControl(false);
            });
            segmentNewPopClose();
        } else {
            alert('<spring:message code="M01471"/>');
        }
  	}
}

//세그먼트 메세지 확인
function segmentMessageCheckr(str) {
    var isMessage = false;
    switch( str ){
    	case 'MSG_S0001' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0001 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0002' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0002 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0003' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0003 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0004' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0004 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0005' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0005 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0006' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0006 );
    		isMessage = true;
    	break;
    }
    
    if (!isMessage)
    	$.messageCheckr(str);
    
}

$(document).ready(function() {
    getLogicalComponentListGrid();
    
    segmentNewPopValidation = $("#segmentNewPop").ifvValidation();
	
	//확인 클릭시
    $('#segmentNewPopAddBtn').on('click', function(){
        saveSegment();
    });
    
	//닫기 클릭시
    $('#segmentNewPopCloseBtn').on('click', function(){
        segmentNewPopClose();
    });
});
</script>

<div id="dialogProgPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="segmentNewPop" >
		<header class="temp_title_bb">
			<spring:message code="M01470"/>
		</header>
        <header class="temp_title">
            <label class="col-xs-10 control_content"><span class="asterisk">*</span><spring:message code="M00672"/></label>
        </header>
        <div class="row qt_border">
            <div class="col-xs-12 control_content">
                <ifvm:input type="text" required="true" maxLength="25" id="segmentName" />
            </div>
        </div>
        
        <header class="temp_title">
			<label class="col-xs-10 control_content"><spring:message code="M01471"/></label>
		</header>
        <div id="logicalComponentListGrid" class="grid_scroll10"></div>
	</div>
	<div class="pop_btn_area" style="height:60px;">
	    <button class="btn btn-sm btn_gray" id="segmentNewPopAddBtn" objCode="segmentNewPopAddBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00804"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="segmentNewPopCloseBtn" objCode="segmentNewPopCloseBtn_OBJ">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>