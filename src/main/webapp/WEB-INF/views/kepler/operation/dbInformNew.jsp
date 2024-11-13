<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var dbInformList;
var dbGubn = null;
var delChk = false;

//더블 클릭 -> 수정 페이지 이동 시 사용
var dbInformId = null;

//클릭으로 인한 선택값 -> 선택 시 테이블쪽에 넘길 값 세팅
var selectDbInformId = null;
var selectDbInformNm = null;


/* 팝업 닫기 */
function adminTargetingPopClose() {
	adminTargetingPop._destroy();
}

//타겟 레벨 삭제
function removeDbInforms(){
	var selectData = dbInformList.opt.gridControl.getSelectedRecords();
	delChk = false;

	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var dbInformIdList = [];

			for(var i=0; i<selectData.length; i++){
				dbInformIdList.push(selectData[i].dbInformId);
			}
			$.ifvSyncPostJSON('<ifvm:action name="dbInformDelChk"/>',{
				dbInformId1 : dbInformIdList
		    },function(result) {
				if(result.delFlag == "1"){
					alert('<spring:message code="M01556"/>');
					delChk = true;
				}
			});
			if(delChk == false){
				$.ifvSyncPostJSON('<ifvm:action name="removeDbInform"/>',{
					dbInformId	: dbInformIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					dbInformListInit();
				});
			}
		}
	}

}
//타겟 레벨 수정
function editDbInforms(){
	var selRecord = dbInformList.opt.gridControl.getSelectedRecords();

	if(selRecord.length > 0) {
		if($.fn.ifvmIsNotEmpty(selRecord[0].dbInformId)) {
			dbInformId = selRecord[0].dbInformId;

			dbGubun = "U";
	 		dbInformPopInit('<spring:message code="M01554" />');
		} else {
			alert('<spring:message code="L01609" />');
		}
	} else {
		alert('<spring:message code="M00004" />');
	}
}

//Target Level List
function dbInformListInit(){
	var ejGridOption = {
		recordDoubleClick : function(args){
  			var data = args.data;
			dbInformId = data.dbInformId;
			dbGubun = "U";
 			dbInformPopInit('<spring:message code="M01554" />');
		},
		dataUrl: '<ifvm:action name="getDbInformList"/>',
		columns:[
	    	  {
	      		  field : 'serviceNm', headerText : '<spring:message code="M01440"/>', customAttributes : {searchable : true}
	      	  },{
	      		  field : 'secretNm', headerText : '<spring:message code="M02893"/>', customAttributes : { index : 'secretNm' }
	      	  },{
	      		  field : 'conDbTypeName', headerText : '<spring:message code="M00508"/>', textAlign : 'center', 
	      	  },{
	      		  field : 'conIp', headerText : '<spring:message code="M01125"/>', customAttributes : {searchable : true}

	      	  },{
	      		  field : 'conPort', headerText : '<spring:message code="M01126"/>',customAttributes : {searchable : true}

	      	  },{
	      		  field : 'conId', headerText : '<spring:message code="M01127"/>', textAlign : 'center', customAttributes : {searchable : true}

	      	  },{
	      		  field : 'conUrl', headerText : '<spring:message code="M00471"/>',customAttributes : {searchable : true}

	      	  },{
	      		  field : 'dbDesc', headerText : '<spring:message code="M00324"/>',customAttributes : {searchable : true}

	      	  },{
	      		  field : 'dbInformId', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			  index : 'd.id' }
	      	  }
	      ],
	      requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'd.service_nm',
	    	  sord : 'desc',
	    	  _search : false
	      },
	    rowList : [10,25,50,100],
	    radio: true,
	    tempId : 'ifvGridOriginTemplete'
	};
	dbInformList = $("#dbInformList").ifvsfGrid({ ejGridOption : ejGridOption });
	gridIddbInformList = $("#gridIddbInformList");
}

//팝업.
function dbInformPopInit(title){
	$("#adminTargetingPop").ifvsfPopup({
		enableModal: true
		, enableResize: false
		, contentUrl: "<ifvm:url name='dbRegistPop' />"
		, contentType: "ajax"
		, title: title
		, width: "650"
		, close : "adminTargetingPopClose"
	});
}

function connectionTest() {

	var rst=null;
	$.ifvSyncPostJSON('<ifvm:action name="getDatabaseConCheck"/>',{
			dbInformId	: dbInformList.opt.gridControl.getSelectedRecords()[0].dbInformId
		},function(result) {
			alert(result.message);
			rst = 1;
		});
		if(rst==null){
			alert("연결실패: db정보를 확인해주세요");
		}
	}
    


$(document).ready(function(){
	dbInformListInit();

    //타겟 레벨 추가
	$("#addDbInformList").on("click", function(){
		dbInformId = null;
		dbGubun = "I";
 		dbInformPopInit('<spring:message code="M01554"/>');
 		$("#gridIddbInformList").trigger('reloadGrid');
	});

	//타겟 레벨 수정
	$("#editDbInformList").on("click", function(){
		editDbInforms();
	});

	//타겟 레벨 삭제
	$("#removeDbInformList").on("click", function(){
		removeDbInforms();
	});
	
	//연결확인
	$("#connectionTest").on("click", function(){
		connectionTest();
	});

	$("#databaseSchemaAdd").click(function(evt) {
		var checkedList = dbInformList.opt.gridControl.getSelectedRecords();
		if ($.fn.ifvmIsNotEmpty(checkedList)) {
			var checkedData = checkedList[0];
			var tagId = "databaseUseSchemaAddPop";
			var tempPopObject = $("#" + tagId);

			if ($.fn.ifvmIsEmpty(tempPopObject)) {
				tempPopObject = $("<div class='popup_container' />");
				tempPopObject.attr("id", tagId);
			}

			tempPopObject.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifvm:url name='databaseUseSchemaAddPop' />",
				contentType : "ajax",
				title : "<spring:message code='M02402' />",
				ajaxSuccess : function(args) {
					setDatabaseUseSchema(tagId, checkedData.dbInformId);
				}
			});
		} else {
			alert("<spring:message code='M00004' />");
		}
	});
});

</script>
<div class="page-title">
    <h1>
         <spring:message code="O00184" /> &gt; <spring:message code="M00273" />
    </h1>
</div>
<div>
<div class="page_btn_area">
	<div class="col-xs-7">
		 <span><spring:message code="M01555"/></span> 
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="databaseSchemaAdd" objCode="databaseSchemaAdd_OBJ">
			<i class="fa fa-bookmark"></i>
			<spring:message code="M02402" />
		</button>
		<button class="btn btn-sm" id="addDbInformList" objCode="addDbInformList_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M00136"/>
		</button>
 		<button class="btn btn-sm" id="editDbInformList" objCode="editDbInformList_OBJ">
			<spring:message code="M00259"/>
		</button>
		<button class="btn btn-sm" id="removeDbInformList" objCode="removeDbInformList_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button>
		<button class="btn btn-sm" id="connectionTest" objCode="connectionTest_OBJ">
			<i class="fa fa-minus"></i>
			연결확인
		</button>
	</div>
</div>
<div id="dbInformList" class="white_bg grid_bd0"></div>
</div>

<div id="adminTargetingPop" class="popup_container"></div>