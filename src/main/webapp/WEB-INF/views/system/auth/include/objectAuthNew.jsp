<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var pgmId = null;
/* 팝업창을 담을 변수  */
var authPopup;	
var setDtoData;
var objAuthList;
var objAuthGridID;
var objID;
var pgmId = null;


//오브젝트 권한 설정 Grid
function programListInit(){

	var ejGridOption = {
		serializeGridData : function( data ){
			data.authId = authId;
			return data;
		},
		rowSelected : function(args) {
			pgmId = args.data.id;
			//오브젝트 목록 Grid
			objectListSetting(authId, pgmId);
			//오브젝트 권한 Grid
			setObjAuthGrid(null);
			if(objAuthGridID == null){
				$("#objAuthGridList").empty();
				$('#objAuthListArea').hide();
			}

		},
		dataUrl : '<ifvm:action name="getProgList"/>',
		columns:[
			{
				field : 'pgmNo', headerText : '<spring:message code="I02044"/>', headerTextAlign : 'center', textAlign : 'center', width : 120, customAttributes :{searchable : true}
			},{
				field : 'pgmNm', headerText : '<spring:message code="I02045"/>', headerTextAlign : 'center', textAlign : 'center', width : 160, customAttributes :{searchable : true}
			},{
				field : 'pgmType', headerText : '<spring:message code="I02046"/>', headerTextAlign : 'center', textAlign : 'center', width : 90, customAttributes :{searchable : true},
				customAttributes : {
					index : 'pgmTypeCd' }
			},{
				field : 'pgmPath', headerText : '<spring:message code="I02047"/>', headerTextAlign : 'center', width : 220,
			},{
				field : 'prog_crea', headerText : '<spring:message code="I02055"/>', headerTextAlign : 'center', textAlign : 'center', width : 100,
			},{
				field : 'createDate', headerText : '<spring:message code="I02056"/>', headerTextAlign : 'center', textAlign : 'center', width : 120,
			},{
				field : 'id', headerText : 'id', visible : false
			},
		],
		requestGridData : {
			nd   : new Date().getTime(),
			rows : 10,
			sidx : 'apr.create_date',
			sord : 'desc',
			_search : false
		},
		radio : true,
		rowList: $.ifvmGetSelectBoxNum(),
	};
	groupListCon = $("#programAddListCon").ifvsfGrid({ ejGridOption : ejGridOption });
};

//오브젝트 목록 부분
function uiObjectDetail(id){
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
	objDialog.ejDialog('destroy');
}

//오브젝트 목록 Grid
function objectListSetting(authId, pgmId){
	$("#objListArea").show();
	var ejGridOption = {
			rowSelected : function (args) {
	        	rowData = args.data;
				objID=args.data.id;
				// 오브젝트 목록 Grid
	        	setObjAuthGrid(rowData);
	       	},
			serializeGridData : function( data ){
				data.pgmId = pgmId;
				data.authId = authId;
				return data;
			},
			dataUrl : '<ifvm:action name="getUIObjectList"/>',
	        columns:[
	        	{
	        		  field : 'objTypeCd', headerText : '<spring:message code="I02088"/>', textAlign : 'center'
	        	  },{
	          		  field : 'objCd', headerText : '<spring:message code="I02100"/>', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'objNm', headerText : '<spring:message code="I02101"/>', textAlign : 'center', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'uiObjNm', headerText : '<spring:message code="I02090"/>', textAlign : 'center', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'uiObjDesc', headerText : '<spring:message code="I02091"/>', headerTextAlign : 'center', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'modifyBy', headerText : '<spring:message code="I02055"/>', textAlign : 'center'
	          	  },{
	          		  field : 'modifyDate', headerText : '<spring:message code="I02056"/>', textAlign : 'center'

	          	  },{
	          		  field : 'id', headerText : 'id', visible : false
	          	  },
	        ],
	        requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : 'modifyDate',
	        	  sord : 'desc',
	        	  _search : false
	          },
	          radio : true,
	          rowList: $.ifvmGetSelectBoxNum(),
	    };
		objectListCon = $("#objectAddListCon").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function deleteObjectAuth() {
	var checkedList = objectListCon.opt.gridControl.getSelectedRecords();
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
				objectListCon._doAjax();
				objAuthListSearch(); 
				alert('<spring:message code="I00726"/>');
			});
		}

	}else{
		alert('<spring:message code="I00728"/>');
	}
};

function objAuthListSearch() {
	   objAuthList = null;
	   $("#objAuthGridList").empty();
}


//오브젝트 권한 Grid
function setObjAuthGrid(rowData){
	$('#objAuthListArea').show();
	  var ejGridOption = {
	           	rowSelected : function (args) {
	          	     objAuthGridID = args.data.id;
	            },
	          	serializeGridData : function( data ){
				   if($.fn.ifvmIsNotEmpty(rowData)){
					   data.rid= rowData.id;
				   }
	           	},
	           	dataUrl : '<ifvm:action name="getObjAuthList"/>',
	            columns:[
	            	  {
	            		  field : 'autNum', headerText : '권한코드', textAlign : 'center', customAttributes :{searchable : true}
	            	  },{
	            		  field : 'autNm', headerText : '권한', textAlign : 'center', customAttributes :{searchable : true}
	            	  },{
	              		  field : 'autDesc', headerText : '권한 설명', textAlign : 'center', customAttributes :{searchable : true}
	            	  },{
	              		  field : 'authCreateDate', headerText : '등록일시', textAlign : 'center', customAttributes :{searchable : true}
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

//권한관리 오브젝트 권한 -> 오브젝트 목록 -> 오브젝트 권한 등록 팝업
function addObjAuthPop(){
	objAuthPopup = $("#objAuthDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="getObjAuthPopup"/>',
        contentType: "ajax",
        title: '권한 등록',
        width: 1000,
        close : 'objAuthPopupClose'
    });
	
}

function objAuthPopupClose(){

	objAuthPopup.ejDialog('destroy');
}

$(document).ready(function() {
	
	$("#objListArea").hide();
	$('#objAuthListArea').hide();
	programListInit();
	
	 $("#objectNewAuthBtn").click(function(){
		 uiObjectDetail();
	});
	
	$("#objectDelAuthBtn").click(function(){
		deleteObjectAuth();
	});
	
	
});


</script>
 
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="I02098" /></span>
	</div>
</div>


<div id="programAddListCon"></div>

<div class="page_btn_area" id="objListArea" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="I02087" /></span>
	</div>
	
	 <div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" className="dataSaveBtn" id="objectNewAuthBtn" text="I00887" btnType="plus" objCode="uiObjectNew_OBJ"/>
 		<ifvm:inputNew type="button" className="dataDelBtn" id="objectDelAuthBtn"  text="I00888" btnType="minus" objCode="objectDelAuthBtn_OBJ"/>
	</div> 
</div>
<!-- 오브젝트 목록 -->
<div id="objectAddListCon"></div>

<div class="page_btn_area" id="objAuthListArea">
	<div class="col-xs-7">
		<span>오브젝트 권한</span>
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
<!-- 권한등록 목록 -->
<div id="objAuthGridList"></div>

<div id="objDialog"></div>
<div id="objAuthDialog"></div>
<div id="authDialog" class="popup_container"></div>

