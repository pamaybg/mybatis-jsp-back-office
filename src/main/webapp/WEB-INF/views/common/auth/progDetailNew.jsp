<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script>

var progId = '<%= cleanXss(request.getParameter("progId")) %>';
if( progId == 'null' ) progId = null;
var validation;
var objAuthList;
var objAuthGridID;
var objID;

/* 팝업창을 담을 변수  */
var objAuthPopup;	
var objDialog;
//파라메터 설정
function setParameter() {
	var dashboardId = $.ifvGetParam( "dashboardId" );
	var dashboardNm = decodeURIComponent($.ifvGetParam( "dashboardNm" ));
	var dashboardType = $.ifvGetParam("dashboardType");

	var dashboardPath = "";
	if (dashboardType === "LAYOUT_VIEW") {
		dashboardPath = "<ifvm:url name='dashboardView' />";
	} else {
		dashboardPath = "<ifvm:url name='dashboardListView' />";
	}
	dashboardPath += "?dashboardId=" + dashboardId + ".jsp";
	dashboardPath = dashboardPath.substr( 1 );

	var analysisId = $.ifvGetParam( "analysisId" );
	var analysisNm = decodeURIComponent($.ifvGetParam( "analysisNm" ));
	var analysisEmbedType = $.ifvGetParam( "analysisEmbedType" );
	var analysisPath = "<ifvm:url name='analysisView' />" + "?analysisId=" + analysisId + "&analysisEmbedType=" + analysisEmbedType + ".jsp";
	analysisPath = analysisPath.substr( 1 );

	/* kj.kang 추가 :: 대시보드에서 해당 페이지 호출 시, 대시보드 관련 정보를 INPUT BOX에 세팅해줌. */
	if( $.fn.ifvmIsNotEmpty( dashboardId ) ) {
		$("#progNo").val(dashboardId);

		if( $.fn.ifvmIsNotEmpty(dashboardNm) ) {
			$("#progName").val(dashboardNm);
		}

		if( $.fn.ifvmIsNotEmpty(dashboardPath) ) {
			$("#progPath").val(dashboardPath);
		}
	}

	if( $.fn.ifvmIsNotEmpty( analysisId ) ) {
		$("#progNo").val(analysisId);

		if( $.fn.ifvmIsNotEmpty(analysisNm) ) {
			$("#progName").val(analysisNm);
		}

		if( $.fn.ifvmIsNotEmpty(analysisPath) ) {
			$("#progPath").val(analysisPath);
		}
	}
}

function getCommonCode(){
	//대상자 구분 코드 가져오기
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : "ADMIN_PROG_TYPE"
	},function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#progType").append(temp);
	});
};


//저장 버튼 클릭시 수정
function updateProgDetail(){

	if( validation.confirm() == true ){

	    var jsonData = {
			//empId : ifvmUserInfo.empId,
			progId : progId,
			progNo : $("#progNo").val(),
			progName : $("#progName").val(),
			progType : $("#progType").val(),
			progPath : $("#progPath").val(),
			//progCreater : $("#progCreater").val(),
			//progCreateDate : $("#progCreateDate").val(),
		}
		if( progId == null ){ //신규
			url = '<ifvm:action name="insertProgramDetail"/>';
			if(confirm('<spring:message code="I01881"/>') === false) return;
		}else{					//수정
			url = '<ifvm:action name="updateProgramDetail"/>';
			jsonData.progId = progId;
			if(confirm('<spring:message code="I01882"/>') === false) return;
		}

		$.ifvSyncPostJSON( url, jsonData, function(result) {
			if(result.success == true){
				alert('<spring:message code="I00741"/>');
				qtjs.href('<ifvm:url name="progListNew"/>');
			}
			else{
				alert('<spring:message code="I00742"/>');
			}
		}, null, null, "#btnSave" );
	}
};

function progList(){
	if( progId != null ){
		$.ifvSyncPostJSON('<ifvm:action name="progListDetail"/>',{
			prgId : progId,
		},
		function(result) {
			$('#progCreater').val(result.progCreater);
			$('#progCreateDate').val(result.progCreateDate.substring(0,19));
			$('#progNo').val(result.progNo);
			$('#progName').val(result.progName);
			$('#progType').val(result.progType).attr("selected", "selected");
			$('#progPath').val(result.progPath);
		});
	}

};


function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}

	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	}



function showPop(){
	$("#storeNameModal").ifvmLoad('<ifvm:url name="storeNameModal"/>');
	}

function showPop1(){
	$("#appIdListModal").ifvmLoad('<ifvm:url name="appIdListModal"/>');
	}

function authProgDetail(){

	if(progId != null){

		$("#btnSave").addClass('authUpdateBtn');
	}
	else{
		$("#btnSave").addClass('authCretBtn');
	}

	$.ifvmAdminCheck(false, true, true);
}

//오브젝트 목록 부분
function uiObjectDetail(id){
/* 	$.ifvLoadPop({url : '<ifvm:url name="uiObjectDetailModal"/>?id='+id});
 */
 
 objDialog = $("#objDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="uiObjectDetailModal"/>',
        contentType: "ajax",
        title: '오브젝트 목록',
        width: 1000,
        close : 'objClosePop'
    });

};

function objClosePop(){
	//objPopup._doAjax();
	objDialog.ejDialog('destroy');
}

function objectListSetting(){
	var ejGridOption = {
        recordDoubleClick : function (args) {
			uiObjectDetail(args.data.id);
		},rowSelected : function (args) {
        	rowData = args.data;
			objID=args.data.id;
        	setObjAuthGrid(rowData);        	            	            	
       	},
		serializeGridData : function( data ){
			data.pgmId = progId;
			return data;
		},
		dataUrl : '<ifvm:action name="getUIObjectList"/>',
        columns:[
        	{
        		  field : 'objTypeCd', headerText : '<spring:message code="I02088"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : 'cc.mark_name' } //
        	  },{
          		  field : 'objCd', headerText : '<spring:message code="I02100"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'o.OBJ_cd' } //
          	  },{
          		  field : 'objNm', headerText : '<spring:message code="I02101"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'o.OBJ_nm' } //
          	  },{
          		  field : 'uiObjNm', headerText : '<spring:message code="I02090"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'uo.ui_obj_nm' } //
          	  },{
          		  field : 'uiObjDesc', headerText : '<spring:message code="I02091"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'uo.ui_OBJ_DESC' } //
          	  },{
          		  field : 'modifyBy', headerText : '<spring:message code="I02055"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'e.name' } //
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="I02056"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'uo.MODIFY_DATE' } //
          	  },{
          		  field : 'id', headerText : 'id', visible : false ,
          		  customAttributes : {
          			  } //
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'uo.MODIFY_DATE',
      	  sord : 'desc',
      	  _search : false
        },
        radio: true,
        multiselect: true,
        rowList: $.ifvmGetSelectBoxNum()
    };
	objectList = $("#objectListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


/* 오브젝트 권한 Grid 2020.01.31 추가  */
function setObjAuthGrid(rowData){
	  var ejGridOption = {
	           	rowSelected : function (args) {
	          	     objAuthGridID = args.data.id;
	            },
	          	serializeGridData : function( data ){
	          		data.rid= rowData.id;
	           	},
	           	dataUrl : '<ifvm:action name="getObjAuthList"/>',
	            columns:[
	            	{
	            		  field : 'autNum', headerText : '권한코드', headerTextAlign : 'center',
	            		  customAttributes : {
	            			  index : 'h.AUT_NUM' } 
	            	  },
	            	{
	            		  field : 'autNm', headerText : '권한', headerTextAlign : 'center',
	            		  customAttributes : {
	            			  index : 'h.AUT_NM' } //
	            	  },{
	              		  field : 'autDesc', headerText : '권한 설명', headerTextAlign : 'center',
	              		  customAttributes : {
	              			  index : 'h.AUT_DESC' } //
	            	  },{
	              		  field : 'authCreateDate', headerText : '권한 설명', headerTextAlign : 'center',
	              		  customAttributes : {
	              			  index : 'h.CREATE_DATE' } //
	            	  }
	            ],
	            requestGridData : {
		        	  nd   : new Date().getTime(),
		        	  rows : 10,
		        	  sidx : 'h.CREATE_DATE',
		        	  sord : 'ASC',
		        	  _search : false
		          },
		        rowList : [10,25,50,100],
		        radio: true,
		        multiselect: true,
	            tempId : 'ifvGridOriginTemplete'
	        };

	  objAuthList = $("#objAuthGridList").ifvsfGrid({ ejGridOption : ejGridOption });
}


function objAuthListSearch() {
   objAuthList = null;
    $("#objAuthGridList").empty();
}

function deleteObject() {
		var checkedList = objectList.opt.gridControl.getSelectedRecords();
		var objectIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			objectIdList.push( checkedList[i].id );
		}

		if(objectIdList.length > 0){

			if( confirm('<spring:message code="I01500"/>') == true ){

				$.ifvSyncPostJSON('<ifvm:action name="deleteUIObjectList"/>',{
					ids : objectIdList,
				},
				function(result) {
					objectList._doAjax();
					objAuthListSearch(); 
					alert('<spring:message code="I00726"/>');
				});
			}

		}else{
			alert('<spring:message code="I00728"/>');
		}
};

function uiObjectNew(){
	if(progId == null){
		alert('<spring:message code="I02108"/>');
	}else{
		uiObjectDetail();
	}
}

/*권한 등록 팝업 */
function objectAuth(){
	if(objID!=null){
		addObjAuthPop();
	}else{
		alert("선택된 오브젝트 목록이 없습니다.")
	}
 }

/*권한 삭제*/
 function delObjectAuth(){
	if(objAuthGridID==null){
		alert("선택된 오브젝트 권한이 없습니다.");
	}else{
	 	$.ifvSyncPostJSON('<ifvm:action name="delAuthObjRel"/>',{
			id : objAuthGridID
	 	},function(result) {
		 	alert("삭제되었습니다.");
			objAuthList._doAjax();
		},function(result){

		});
	}
}

function addObjAuthPop(){
	
	objAuthPopup = $("#objAuthDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="getObjAuthPopup"/>',
        contentType: "ajax",
        title: '권한',
        width: 1000,
        close : 'objAuthPopupClose'
    });
	
}

function objAuthPopupClose(){

	objAuthPopup.ejDialog('destroy');
}

//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="progListNew"/>');
}



$(document).ready(function() {

	$.ifvmLnbSetting('progListNew');

	getCommonCode();

	setParameter()

/* 	if( progId != null ){
		$("#titleDetailName").html('&gt; <spring:message code="I00195"/>');
	} */

	progList();

	pageSetUp();

	objectListSetting();

	validation = $("#formArea").ifvValidation();

	authProgDetail();

 });
 
 

</script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="I02054"/>
		&gt; <spring:message code="I00195"/>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="I02035"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew id="btnSave" type="button" className="authUpdateBtn" btnFunc="updateProgDetail" text="I00745" btnType="save" objCode="updateProgDetail_OBJ"/>
		<ifvm:inputNew type="button" id="goProgListNew" btnFunc="goList" text="L00824" objCode="goProgListNew_OBJ"/>
	</div>
</div>

<div><!-- style ="width:100%;" -->
	<div class="well" id="formArea" style="margin-bottom:0;">
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="progNo" required="true" maxLength="100" label="I02044" labelClass="1" conClass="3"/>
			</div>
		</div>

		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="progName" required="true" maxLength="100" label="I02045" labelClass="1" conClass="3"/>
			</div>
		</div>



		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="select"  id="progType" dto="progType" names="progType" label="I02046" labelClass="1" conClass="3"/>
			</div>
		</div>

		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" required="true" id="progPath" maxLength="1000" label="I02047" labelClass="1" conClass="8"/>
			</div>
		</div>

		<div class="row qt_border" id="choice">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="progCreater" maxLength="300" disabled="true" label="I02055" labelClass="1" conClass="3"/>
				<ifvm:inputNew type="text" id="progCreateDate"  label="I02056" disabled="true" labelClass="2" conClass="3"/>
			</div>
		</div>

	</div>

</div>

<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02087"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" className="objectCretBtn" btnFunc="uiObjectNew()" text="I00887" btnType="plus" objCode="uiObjectNew_OBJ"/>
			<ifvm:inputNew type="button" className="objectDelBtn" btnFunc="deleteObject()" text="I00888" btnType="minus" objCode="deleteObject_OBJ"/>
		</div>
	</div>
	

<div id="objectListGrid"></div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="I02110"/> </span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm btn_blue" id='objectAuthBtn' onClick="objectAuth()" objCode="objectAuthBtn_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="I02075"/>
		</button>
		<button class="btn btn-sm btn_blue" id='delobjectAuthBtn' onClick="delObjectAuth()" objCode="delobjectAuthBtn_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="L00029"/>
		</button>
	</div>
</div>
<div id="objAuthGridList"></div>
<div id="uiObjectDetailModal"></div>
<div id="objAuthDialog" class="popup_container"></div>
<div id="objDialog" class="popup_container"></div>

