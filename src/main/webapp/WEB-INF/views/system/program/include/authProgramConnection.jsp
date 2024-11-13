<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var pgmId = pgmId;
var pgmChildId = null;

function programGridList() {
	var ejGridOption = {
			serializeGridData : function (data) {
				data.prgId = pgmId;
				return data;
			},
			rowSelected : function(args) {
				pgmChildId = args.data.id;
			},
			dataUrl : '<ifvm:action name="getProgramAuthList"/>',
			columns:[
	        	{
	        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', customAttributes :{searchable : true}
	        	  },{
	          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'pgmType', headerText : '<spring:message code="I02046"/>', textAlign : 'center', customAttributes :{index : 'pgmTypeCd'}
	          	  },{
	          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'prog_crea', headerText : '<spring:message code="I02055"/>', textAlign : 'center', customAttributes :{index : 'name'}
	          	  },{
	          		  field : 'createDate', headerText : '<spring:message code="I02056"/>', textAlign : 'center', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'id', headerText : 'id',visible : false ,
	          	  },
	        ],
	        requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : 'createDate',
	        	  sord : 'desc',
	        	  _search : false
	          },
	           rowList : [10,25,50,100],
	          radio : true,
	          rowList: $.ifvmGetSelectBoxNum(),
	    };
	programListCon = $("#programAddListCon").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function programListCheck() {
	if(progList.opt.gridControl.getSelectedRecords().length==0) {
		alert('<spring:message code="M00285"/>');
		return;
	}
	if(progList.opt.gridControl.getSelectedRecords()[0].menuChkYn!="Y") {
		alert('<spring:message code="M02930"/>');
		return;
	}
	if(pgmId!=null) {
		programListPop();
	}else {
		alert("선택된 프로그램 목록이 없습니다.");
	}
}

function programDelAuthBtn() {
	if(programListCon.opt.gridControl.getSelectedRecords().length==0){
		alert('<spring:message code="M00285"/>');
	} else {
		if( confirm('<spring:message code="I01500"/>') == true ) {
		removeProgramAuthBtn();
		$.ifvSyncPostJSON('<ifvm:action name="removeProgramDown"/>', {
			childprgId : pgmChildId
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00622"/>');
	                programListCon._doAjax();
	            }
	        }
		});
	}
  }
}

function programListPop() {
	$("#programPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="getProgramList"/>',
        contentType: "ajax",
        title: '권한관련 프로그램 목록',
        width: '1000px',
        close : 'programPopupClose'
	});
}

function programPopupClose() {
	programPopup._destroy();
}


function removeProgramAuthBtn() {
	$.ifvSyncPostJSON('<ifvm:action name="removeProgramAuth"/>', {
		childprgId : pgmChildId
	}, function(result) {
		if ($.fn.ifvmIsNotEmpty(result)) {
            if (result.success == true) {
                alert('<spring:message code="M00622"/>');
                programListCon._doAjax();
            }
        }
	});
}

$(document).ready(function(){
	programGridList();
	$("#programAddAuthBtn").click(function(){
		programListCheck();
	});
	$("#programDelAuthBtn").click(function(){
		programDelAuthBtn();
	});

});

</script>

<div class="page_btn_area" id="programGridList">
	<div class="col-xs-7"></div>
	<div class="col-sm-5 searchbtn_r">
 		<ifvm:inputNew type="button" className="dataAddlBtn" id="programAddAuthBtn"  text="I00887" btnType="plus" objCode="programAddAuthBtn_OBJ"/>
 		<ifvm:inputNew type="button" className="dataDelBtn" id="programDelAuthBtn"  text="I00888" btnType="minus" objCode="programDelAuthBtn_OBJ"/>
	</div>
</div>
<div id="programAddListCon"></div>
<div id="programPopup" class="popup_container content_container"></div>
