<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>
 
<script>
var objectList = null;

function objectListSetting(){
	var ejGridOption = {
		recordDoubleClick : function (args) {
			objectDetail(args.data.id);
		},
		serializeGridData : function( data ){
			return data;
		},
		dataUrl : '<ifvm:action name="getObjectList"/>',
		columns:[ 
        	{
        		  field : 'objTypeCd', headerText : '<spring:message code="I02088"/>',  textAlign : 'center'
        	  },{
          		  field : 'objCd', headerText : '<spring:message code="I02100"/>', customAttributes : {searchable : true}
          	  },{
          		  field : 'objNm', headerText : '<spring:message code="I02101"/>', textAlign : 'center',
          	  },{
          		  field : 'objDesc', headerText : '<spring:message code="I00075"/>', customAttributes : {searchable : true}
          	  },{
          		  field : 'modifyBy', headerText : '<spring:message code="I02055"/>', textAlign : 'center',
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id', visible : false ,
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'modifyDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId : 'ifvGridOriginTemplete',
    };
	objectList = $("#objectListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function objectDetail(id){
	qtjs.href('<ifvm:url name="objectDetail"/>' + '?id=' + id);
};

function objectNew(){
	qtjs.href('<ifvm:url name="objectDetail"/>');
};

function deleteObject() {
		var checkedList = objectList.opt.gridControl.getSelectedRecords();
		var objectIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			objectIdList.push( checkedList[i].id );	
		}
		
		if(objectIdList.length > 0){
			
			if( confirm('<spring:message code="I01500"/>') == true ){
			
				$.ifvSyncPostJSON('<ifvm:action name="deleteObjectList"/>',{
					ids : objectIdList,
				},
				function(result) {
					objectList._doAjax();
					alert('<spring:message code="I00726"/>');
				});
			}
		}else{
			alert('<spring:message code="I00728"/>');
		}
};

$(document).ready(function() {
	
	objectListSetting();
	
	$.ifvmAdminCheck(true,true,true);
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="I02105"/> &gt; <spring:message code="M01899"/>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02087"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" className="objectCretBtn" btnFunc="objectNew()" text="I00887" btnType="plus" objCode="objectListNewCretBtn_OBJ"/>
			<ifvm:inputNew type="button" className="objectDelBtn" btnFunc="deleteObject()" text="I00888" btnType="minus" objCode="objectListNewDelBtn_OBJ"/>
		</div>
	</div>
	
	<div id="objectListGrid"></div>
</div>