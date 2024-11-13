<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<div class="content_pop_wrap">
    <div id="mktSurveyListGridDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="saveOfrBtn" objCode="ofrListPopupSaveBtn_OBJ">         
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00282"/>
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="ofrPopCloseBtn" objCode="ofrListPopuClosepBtn_OBJ">         
        <spring:message code="M00284"/>
    </button> 
</div>


<script type="text/javascript">


var mktSurveyListGridDialogv;
var surveyNm;
var surveyNo;
var surveyId;
var contsId = '<%= cleanXss(request.getParameter("id")) %>';

function getOfrList(){
    var ejGridOption = {
        rowSelected : function (args) {
            var data = args.data;
            surveyId = data.ridSurvey;
            surveyNm = data.surveyName;
            surveyNo = data.surveyNo;
        },
        serializeGridData : function( data ){
            return data;
        },
        dataUrl : '<ifvm:action name="getContentSurveyList"/>',
        columns : [
           {
                field : 'surveyNo', headerText : '설문번호', headerTextAlign : 'center',textAlign : 'center', width : '100px', customAttributes : {searchable : true, index : 'LSM.SURV_NO'}
            },{
                field : 'surveyName', headerText : '<spring:message code="S00074"/>', headerTextAlign : 'center',textAlign : 'left', width : '200px', customAttributes : {searchable : true, index: 'LSM.SURV_NM'}
            },{
                field : 'validStartDate', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center', width : '90px'
            },{
                field : 'validEndDate', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center', width : '90px'
            },{
                field : 'statusCodeName', headerText : '상태', headerTextAlign : 'center', width : '70px', textAlign : 'center', customAttributes : {index : 'statusCode'}
            },{
                field : 'targetCount', headerText : '대상자수', headerTextAlign : 'center', width : '85px', textAlign : 'center', customAttributes : {index : 'targetCount'}
            },{
                field : 'surveyCount', headerText : '참여인원수', headerTextAlign : 'center', width : '85px', textAlign : 'center', customAttributes : {index : 'surveyCount'}
            },{
                field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', width : '150px', textAlign : 'center', customAttributes : {index : 'createDate'}
            }
            ,{
                field : 'ridSurvey', headerText : 'ridSurvey',visible : false
            }
        ],
        requestGridData : {
            nd   : new Date().getTime(),
            rows : 10,
            sidx : 'createDate',
            sord : 'desc',
        }
        ,isHorizontalScroll : true
        ,radio: true
    };
    mktSurveyListGridDialogv = $("#mktSurveyListGridDialog").ifvsfGrid({ ejGridOption : ejGridOption });
}

function saveContsOfr(){
	$('#surveyNm').val(surveyNm);
	$('#ridSurvey').val(surveyId);
    surveyListPopClose();
}


$(document).ready(function() {

	$('#ofrPopCloseBtn').on('click', function(){
        surveyListPopClose();
    });
	
	$('#saveOfrBtn').on('click', function(){
    	saveContsOfr();
    });
	
	getOfrList();

});
</script>


