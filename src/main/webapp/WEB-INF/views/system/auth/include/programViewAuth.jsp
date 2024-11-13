<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
var pgmId = null;
var setDtoData;
var programAuthList=null;
var programChildList=null;
var childprgId=null;

function programChildLists(authId,pgmId) {
	$("#programChildArea").show();
	var ejGridOption = {
			recordClick : function(args){
				setDtoData=args.data;
	    	},rowSelected : function (args) {
	    		childprgId=args.data.pgmRid;
	        },
			serializeGridData : function( data ){
				data.authId = authId;
				data.prgId = pgmId;
				return data;
			},
			dataUrl : '<ifvm:action name="getAuthProgram"/>', //프로그램 하위목록 권한
			columns:[
				  {
	        		  field : 'pgmNo', headerText : '<spring:message code="L00036"/>',  width : 120, textAlign : 'center', customAttributes :{searchable : true, index : 'pgmNo'}
	        	  },{
	        		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>',  width : 200, textAlign : 'center', customAttributes :{searchable : true , index : 'pgmNm'}
	        	  },{
	        		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>',  width : 200, customAttributes :{searchable : true , index : 'pgmPath'}
	        	  },{
	        		  field : 'pgmType', headerText : '<spring:message code="I02046"/>',  width : 100, textAlign : 'center', customAttributes :{ index : 'pgmTypeCd'}
	        	  },{
	        		  field : 'createDate', headerText : '<spring:message code="I02056"/>',  width : 120, textAlign : 'center'
	        	  },{
	        		  field : 'pgmRid', headerText : 'id', visible : false
	        	  }
	        ],
	        requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : '1',
	        	  sord : 'desc',
	        	  _search : false
	          },
	          radio : true,
	          rowList: $.ifvmGetSelectBoxNum(),
	    };
		programChildList = $("#programChildList").ifvsfGrid({ ejGridOption : ejGridOption });

}


function programAuthLists() {
	var ejGridOption = {
			serializeGridData : function( data ){
				data.authId = authId;
				return data;
			},
			rowSelected : function(args) {

				pgmId = args.data.pgmRid;
				programChildLists(authId, args.data.pgmRid);
			},
			dataUrl : '<ifvm:action name="getProgAuthList"/>', //메인 프로그램 권한
			columns:[
	        	  {
	        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', textAlign : 'center', width : 160, customAttributes :{searchable : true, index : 'pgmNo'}
	        	  },{
	          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', textAlign : 'center', width : 200, customAttributes :{searchable : true, index : 'pgmNm'}
	          	  },{
	          		  field : 'pgmTypeNm', headerText : '<spring:message code="I02046"/>', textAlign : 'center', width : 140, customAttributes :{index : 'pgmTypeCd'}
	          	  },{
	          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', width : 220, customAttributes :{searchable : true, index : 'pgmPath'}
	          	  },{
	          		  field : 'createDate', headerText : '<spring:message code="I02056"/>', textAlign : 'center', width : 160,
	          	  },{
	          		  field : 'pgmRid', headerText : 'pgmRid', visible : false ,
	          	  },
	        ],
	        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : '1',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        radio : true,
	        rowList: $.ifvmGetSelectBoxNum(),
	    };
		programAuthList = $("#programAuthList").ifvsfGrid({ ejGridOption : ejGridOption });
	};

//프로그램 권한 설정 팝업
function programAddAuthBtn(){
	$("#programAuthDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="programAuthpop"/>',
        contentType: "ajax",
        title: '프로그램 목록',
        width: '1000px',
        close : 'programPopupClose'
    });
}

function programPopupClose() {
	programAuthDialog._destroy();
}

//프로그램 목록 팝업
function programChildAddAuthBtn() {
	if(programAuthList.opt.gridControl.getSelectedRecords().length==0){
		alert('<spring:message code="M00285"/>');
		return;
	}

	$("#programChildAuthDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="programChildAuthpop"/>',
        contentType: "ajax",
        title: '권한관련 프로그램 목록',
        width: '1000px',
        close : 'programChildPopupClose'
    });
}

function programChildPopupClose() {
	programChildAuthDialog._destroy();
}

function programDelAuthBtn() {
	if(programAuthList.opt.gridControl.getSelectedRecords().length==0){
		alert('<spring:message code="M00285"/>');
	} else {
		if( confirm('<spring:message code="I01500"/>') == true ) {
		$.ifvSyncPostJSON('<ifvm:action name="removeProgramPrarentAuth"/>', {
			prgId :  pgmId,
			authId : authId
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00622"/>');
	                programAuthList._doAjax();
	            }
	        }
		});
	}
  }
}

function programChildDelAuthBtn() {
	if(programChildList.opt.gridControl.getSelectedRecords().length==0){
		alert('<spring:message code="M00285"/>');
	} else {
		if( confirm('<spring:message code="I01500"/>') == true ) {
		$.ifvSyncPostJSON('<ifvm:action name="removeProgramChildAuth"/>', {
			prgId  :  childprgId,
			authId : authId
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00622"/>');
	                programChildList._doAjax();
	            }
	        }
		});
	}
  }
}

$(document).ready(function() {
	$("#programChildArea").hide();
	programAuthLists();
});

</script>
<div class="page_btn_area" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="I02111" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
	<ifvm:inputNew type="button" className="dataDelBtn" id="programAddAuthBtn" btnFunc="programAddAuthBtn" text="L00078" btnType="plus" objCode="programAddAuthBtn_OBJ"/>
	<ifvm:inputNew type="button" className="dataDelBtn" id="programDelAuthBtn" btnFunc="programDelAuthBtn" text="L00080" btnType="minus" objCode="programDelAuthBtn_OBJ"/>
	</div>
</div>


<div id="programAuthList"></div>

<div class="page_btn_area" id="programChildArea" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="I02035" /></span>
	</div>

	 <div class="col-sm-5 searchbtn_r">
 <ifvm:inputNew type="button" className="dataAddBtn" id="programChildAddAuthBtn" btnFunc="programChildAddAuthBtn" text="L00078" btnType="plus" objCode="programChildAddAuthBtn_OBJ"/>
 <ifvm:inputNew type="button" className="dataDelBtn" id="programChildDelAuthBtn" btnFunc="programChildDelAuthBtn" text="I00888" btnType="minus" objCode="programChildDelAuthBtn_OBJ"/>
	</div>

</div>
<div id="programChildList"></div>
<div id="programAuthDialog" class="popup_container"></div>
<div id="programChildAuthDialog" class="popup_container"></div>