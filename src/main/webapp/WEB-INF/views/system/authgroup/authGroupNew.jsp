<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script>

var GroupList = null;


function authGroupListSetting(){
	var ejGridOption = {
		recordDoubleClick : function (args) {
			authGroupDetail(args.data.id);
		},
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getAuthGroupList"/>',
        columns:[ 
        	{
        		  field : 'groupName', headerText : '<spring:message code="I02071"/>', textAlign : 'center', customAttributes : {searchable : true , index: 'ag.aut_group_nm'}
        	  },{
          		  field : 'groupDesc', headerText : '<spring:message code="I00075"/>', textAlign : 'center', customAttributes : {searchable : true, index : 'ag.aut_group_desc'}
          	  },{
          		  field : 'groupStatus', headerText : '<spring:message code="I02072"/>', textAlign : 'center', 
          	  },{
          		  field : 'group_Creater', headerText : '<spring:message code="I02055"/>', textAlign : 'center',
          	  },{
          		  field : 'group_Create_Date', headerText : '<spring:message code="I02056"/>', textAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id', visible : false ,
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'group_Create_Date',
      	  sord : 'desc',
      	  _search : false
        },
        radio: true,
        multiselect: true,
        rowList: $.ifvmGetSelectBoxNum()
    };
	GroupList = $("#GroupListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function authGroupDetail(groupId){
	qtjs.href('<ifvm:url name="authGroupDetail"/>' + '?groupId=' + groupId);
};


function authNew(){
	qtjs.href('<ifvm:url name="authGroupDetail"/>');
};

function deleteAuth() {

		var checkedList = GroupList.opt.gridControl.getSelectedRecords();
		var groupIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			groupIdList.push( checkedList[i].id );	
		}
		
		if(groupIdList.length > 0){
			
			if( confirm('<spring:message code="I01500"/>') == true ){
				
				$.ifvSyncPostJSON('<ifvm:action name="deleteAuthGroupList"/>',{
					groupId : groupIdList
				},
				function(result) {
					GroupList.searchGrid( { groupId : groupIdList } )
					alert('<spring:message code="I00726"/>');
				});
			}
			
		}else{
			alert('<spring:message code="I00728"/>');
		}
	
};
	
$(document).ready(function() {
	$.ifvmAdminCheck();
	pageSetUp();
	authGroupListSetting();
	$.ifvmAdminCheck(true,true,true);
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="I02084"/>
		&gt; <spring:message code="M00273"/>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02084"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" className="authCretBtn" btnFunc="authNew()" text="I00887" btnType="plus" objCode="authGroupNewCreBtn_OBJ"/>
			<ifvm:inputNew type="button" className="authDelBtn" btnFunc="deleteAuth()" text="I00888" btnType="minus" objCode="authGroupNewDelBtn_OBJ"/>
		</div>
	</div>
	<div id="GroupListGrid"></div>
</div>

