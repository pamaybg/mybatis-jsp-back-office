<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">

function programGridList() {
	var ejGridOption = {
			serializeGridData : function (data) {
				data.prgId = pgmId;
				return data;
			},
			rowSelected : function(args) {
				pgmChildId = args.data.id;
			},
			dataUrl : '<ifvm:action name="getLowProgramRel"/>',
			columns:[
				{
	        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', customAttributes :{searchable : true}
	        	  },{
	          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'progType', headerText : '<spring:message code="I02046"/>'
	          	  },{
	          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'prog_crea', headerText : '<spring:message code="I02055"/>', customAttributes :{index : 'name'}
	          	  },{
	          		  field : 'createDate', headerText : '<spring:message code="I02056"/>', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'id', headerText : 'id',visible : false 
	          	  }
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
	if(pgmId!=null) {
		programLowListPop();
	}else {
		alert("선택된 프로그램 목록이 없습니다.");
	}
}

function programLowListPop() {
	$("#programLowPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="getAddLowProgList"/>',
        contentType: "ajax",
        title: '하위 프로그램 목록',
        width: '1000px',
        close : 'programLowPopupClose'
	});
}

function programLowDelBtn() {
	if(programListCon.opt.gridControl.getSelectedRecords().length==0){
		alert('<spring:message code="M00285"/>');
	} else {
		if( confirm('<spring:message code="I01500"/>') == true ) {
		$.ifvSyncPostJSON('<ifvm:action name="removeParProgramDown"/>', {
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

$("#progRelExcelDown").on('click', function() {
	//DB에서 헤더 값 가져오기
  	$.ifvDBExcelDn('/system/program/apiSpecExcelDown.do', $("#progRelExcelDown").attr("objcode"));
});
function programLowPopupClose() {
	programLowPopup._destroy();
}

$(document).ready(function(){
	programGridList();
	
	$("#addParProg").click(function(){
		programListCheck();
	});
	
	$("#delParProg").click(function(){
		programLowDelBtn();
	});
	
});

</script>

<div class="page_btn_area">
	<div class="col-xs-7"></div>
	<div class="col-sm-5 searchbtn_r">
<%--
		<ifvm:inputNew type="button" id="progRelExcelDown" text="M01218" objCode="progRelExcelDown_OBJ"/>
--%>
 		<ifvm:inputNew type="button"  id="addParProg"  text="I00887" btnType="plus" objCode="progRelAdd_OBJ"/>
 		<ifvm:inputNew type="button"  id="delParProg"  text="I00888" btnType="minus" objCode="progRelDel_OBJ"/>
	</div>
</div>
<div id="programAddListCon"></div>
<div id="programLowPopup" class="popup_container content_container"></div>