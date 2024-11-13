<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

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

var authList = '<%= cleanXss(request.getParameter("authList")) %>';
var setAuthId = '<%= cleanXss(request.getParameter("setAuthId")) %>';


function authListSetting(){
	
	var ejGridOption = {
			recordDoubleClick : function (args) {
			authDetail(args.data.id);
		},
		serializeGridData : function( data ){
			return data;
		},rowSelected : function (args) {
			setAuthId=args.data.id;
        },
        dataUrl : '<ifvm:action name="getAuthList"/>',
        columns:[ 
        	{
        		  field : 'autNum', headerText : '<spring:message code="I02059"/>', textAlign : 'center', customAttributes :{searchable : true}
        	  },{
          		  field : 'autNm', headerText : '<spring:message code="I02060"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'autDesc', headerText : '<spring:message code="I00075"/>',customAttributes :{searchable : true}
          	  },{
          		  field : 'authCreater', headerText : '<spring:message code="I02055"/>', textAlign : 'center'
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center'
          	  },{
          		  field : 'id', headerText : 'id', visible : false
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'createDate DESC, autNum',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        multiselect: true
    };
	authList = $("#authListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function authDetail(authId){
	qtjs.href('<ifvm:url name="authDetail"/>' + '?authId=' + authId);
};


function authNew(){
	qtjs.href('<ifvm:url name="authDetail"/>');
};

function deleteAuth() {

		var checkedList = authList.opt.gridControl.getSelectedRecords();
		var authIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			authIdList.push( checkedList[i].id );	
		}
		
		if(authIdList.length > 0){
			
			if( confirm('<spring:message code="I01500"/>') == true ){
			
				$.ifvSyncPostJSON('<ifvm:action name="deleteAuthList"/>',{
					authIds : authIdList,
				},
				function(result) {
					authList._doAjax();
					alert('<spring:message code="I00726"/>');
				});
			}
			
		}else{
			alert('<spring:message code="I00728"/>');
		}
	
};
	
function authCopy(){
	
	if(setAuthId==null){
		alert("선택된 권한 목록이 없습니다.");
	}else{
		$("#authCopyDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="getAuthCopyPopup"/>',
        contentType: "ajax",
        title: '권한',
        width: 1000,
        close : 'objAuthPopupClose'
    	}); 
	}
    
       
}	

function objAuthPopupClose(){
	authCopyDialog._destroy();
}
$(document).ready(function() {
	authListSetting();
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="I02061"/>
		&gt; <spring:message code="M00273"/>
	</h1>
</div>
<div id="authCopyDialog" class="popup_container"></div>
<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02062"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" className="authCopyBtn" btnFunc="authCopy()" text="D10275" btnType="copy" objCode="authListNewCopyAuth_OBJ" />
			<ifvm:inputNew type="button" className="authCretBtn" btnFunc="authNew()" text="I00887" btnType="plus" objCode="authListNewCretBtn_OBJ" />
			<ifvm:inputNew type="button" className="authDelBtn" btnFunc="deleteAuth()" text="I00888" btnType="minus" objCode="authListNewDeltBtn_OBJ" />
		</div>
	</div>
	<div id="authListGrid"></div>
</div>
<div id="accountNameModal"></div>
<div id="storeNameModal"></div>
