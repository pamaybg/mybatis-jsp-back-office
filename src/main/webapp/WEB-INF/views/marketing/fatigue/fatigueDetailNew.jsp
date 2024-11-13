<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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


<script>


  var fatigueid = '<%= cleanXss(request.getParameter("id")) %>';
  var detail = false;  //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
  var validation;
  var isValid;


  //상세 페이지인지 체크
  function idCheck(){

    if(fatigueid != "null") {
      //상세 내용 적용
      $.ifvSyncPostJSON('<ifvm:action name="getFatigueDetail"/>', {
        id : fatigueid
      }, function(result) {
        ifvGlobal["fatiDetailInfo"] = result;
        $("#fatiTitle").val(result.fatiTitle);
        $("#fatiState").val(result.fatiStateNm);
        var ableValue = [];

        ableValue.push("fatiMaxRestrictionDayCnt")
        ableValue.push("fatiRestrictionDay")

        $("#fatiMaxRestrictionDayCnt").val(result.fatiMaxRestrictionDayCnt);
        $("#fatiRestrictionDay").val(result.fatiRestrictionDay);

        // disabledId(ableValue, false, false)
        $("#fatiDesc").val(result.fatiDesc);

        $("#createBy").val(result.createBy);
        $("#createDate").val(result.createDate);
        $("#modifyBy").val(result.modifyBy);
        $("#modifyDate").val(result.modifyDate);

        $("#smsFlag").prop("checked", (result.smsFlag == true));
        $("#lmsFlag").prop("checked", (result.lmsFlag == true));
        $("#mmsFlag").prop("checked", (result.mmsFlag == true));
        $("#pushFlag").prop("checked", (result.pushFlag == true));
        $("#emailFlag").prop("checked", (result.emailFlag == true));
        $("#kakaoFrFlag").prop("checked", (result.kakaoFrFlag == true));


        // $("#chnlTypeCd").val(result.chnlTypeCd);
        // $('#periodDiv').val(result.periodDiv);
        // $("#maxRstrtnTmscnt").val(result.maxRstrtnTmscnt);
        // $("#non_react_day").val(result.non_react_day);
        // $("#non_react_cnt").val(result.non_react_cnt);
        // $("#startDate").val(result.startDate);
        // $("#endDate").val(result.endDate);
        // $("#description").text(result.fatigueDesc);
        // $("#create_by").val(result.createBy);
        // $("#create_date").val(result.createDate);
        // $("#modify_by").val(result.modifyBy);
        // $("#modify_date").val(result.modifyDate);
        // $("#maxDayCnt").val(result.maxDayCnt);
      });
      detail = true;
    }else{
      $("#fatiState").val("미적용")
      //신규
      $('#createBy').val($.ifvmGetUserInfo().empName);
      $('#createDate').val($.ifvFormatDate( 'yyyy-mm-dd', new Date()));
    }
    var numArr = ['fatiMaxRestrictionDayCnt', 'fatiRestrictionDay'
    ];
    NumberOnly(numArr);

  }

  //콤마 없이 숫자만
  function NumberOnly(array){
    for(var i = 0; i<array.length; i++) $("#"+array[i]).onlyNumber();
  }
  //달력
  function setCalendarDate() {
    //해당달의 마지막 날짜 계산
    var todayDate = new Date();
    var year = todayDate.getFullYear();
    var month = todayDate.getMonth()+1;
    var lastDay = (new Date(year,month,0)).getDate();
    var lastDate = year+"-" +month+"-"+lastDay;

    var startDate = $(".start_date").find('input');
    var endDate = $(".end_date").find('input');
    startDate.val($.ifvGetNewDate('d', 0).newDateS);
    endDate.val(lastDate);

    startDate.ifvDateChecker({
      maxDate : endDate
    });

    endDate.ifvDateChecker({
      minDate : startDate
    });

  }


  //저장 버튼클릭 시 동작
  function saveFatigue() {
    isValid = validation.confirm();
    //DataValidationCheck();

    var chnlCheckedList = new Array();
    if($('#smsFlag').is(':checked') === true) {
      chnlCheckedList.push('SMS');
    }
    if($('#lmsFlag').is(':checked') === true) {
      chnlCheckedList.push('LMS');
    }
    if($('#mmsFlag').is(':checked') === true) {
      chnlCheckedList.push('MMS');
    }
    if($('#pushFlag').is(':checked') === true) {
      chnlCheckedList.push('PUSH');
    }
    if($('#emailFlag').is(':checked') === true) {
      chnlCheckedList.push('EMAIL');
    }
    if($('#kakaoFrFlag').is(':checked') === true) {
      chnlCheckedList.push('KAKAOFR');
    }
    console.log(chnlCheckedList.toString());

    if(isValid){
      //상세 페이지일 시 수정 작업 동작
      var obj = {
        fatiTitle : $("#fatiTitle").val()
        , fatiState : $("#fatiState").val()
        , fatiMaxRestrictionDayCnt : $("#fatiMaxRestrictionDayCnt").val()
        , fatiRestrictionDay : $("#fatiRestrictionDay").val()
        , fatiDesc : $("#fatiDesc").val()
        , chnlCheckedList : chnlCheckedList.toString()
      }

      if(detail) { //피로도 수정
        obj.id = fatigueid;
        $.ifvSyncPostJSON('<ifvm:action name="updateFatigue"/>', obj/*{
					   id : fatigueid
					 , chnlTypeCd : $("#chnlTypeCd").val()
					 , periodDiv : $("#periodDiv").val()
					 , maxRstrtnTmscnt : $("#maxRstrtnTmscnt").val()
					 , non_react_day : $("#non_react_day").val()
					 , non_react_cnt : $("#non_react_cnt").val()
					 , startDate : $("#startDate").val()
					 , endDate : $("#endDate").val()
					 , fatigueDesc : $("#description").val()
					 , maxDayCnt : $("#maxDayCnt").val()
			}*/, function(result) {
          if(result.success){
            alert('<spring:message code="M01048"/>');
          }
          else{
            alert('<spring:message code="M01050"/>');
          }
          location.reload();
        }, function(result){

          if(result.message == 1){
            alert('<spring:message code="M01389"/>');
          }
          else{
            alert('<spring:message code="M01050"/>');
          }

        });
      }
      //상세 페이지가 아닐 시 insert 동작
      else
      {
        //language code
        $.ifvSyncPostJSON('<ifvm:action name="insertFatigue"/>', obj/*{
						   chnlTypeCd : $("#chnlTypeCd").val()
						 , periodDiv : $("#periodDiv").val()
						 , maxRstrtnTmscnt : $("#maxRstrtnTmscnt").val()
						 , non_react_day : $("#non_react_day").val()
						 , non_react_cnt : $("#non_react_cnt").val()
						 , startDate : $("#startDate").val()
						 , endDate : $("#endDate").val()
						 , fatigueDesc : $("#description").val()
						 , maxDayCnt : $("#maxDayCnt").val()
			}*/, function(result) {
          if(result.success){
            alert('<spring:message code="M01047"/>');
          }
          else{
            alert('<spring:message code="M01050"/>');
          }
          qtjs.href('<ifvm:url name="fatigueDetail"/>'+'?id='+result.message);


        }, function(result){

          if(result.message == 1){
            alert('<spring:message code="M01389"/>');
          }
          else{
            alert('<spring:message code="M01050"/>');
          }

        });
      }
    }
    else{
      alert('<spring:message code="M01055"/>');
    }

  }



  $(document).ready(function(){

    $.ifvmLnbSetting('fatigueListNew');
    //setCalendarDate();
    var arr = ["fatiMaxRestrictionDayCnt","fatiRestrictionDay"];
    // disabledId(arr, true);
    $("#btnfatigueSave").click(function () {
      saveFatigue();
    });
    validation = $("#selectForm").ifvValidation();

    $.fn.ifvmSetSelectOptionCommCode("fatiRestrictionDayYn", "COM_STAT_TYPE_3_CD", "N", null, true);

    $("#fatiRestrictionDayYn").change(function(){
      isChecked("fatiRestrictionDayYn",["fatiRestrictionDay","fatiMaxRestrictionDayCnt"]);
    })

    idCheck();

  });

  //사용여부 체크
  function isChecked(id, value){ //id : checkBox ID, vale : 제어해줄 inputBox
    if($("#"+ id).val() == "Y"){
      disabledId(value, false)
      return true;
    }else{
      disabledId(value, true)
      return false;
    }
  }

  function btnFatigueList(){
    qtjs.href('<ifvm:url name="fatigueListNew"/>');
  }

  /*로딩 시 세팅해주는 부분.
  * 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
  */
  $(function () {


    //채널 유형 조회
    <%--$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{--%>
    <%--	groupCode : 'MKT_CAM_CHNL_TYPE_CD'--%>
    <%--	, enableNA : true--%>
    <%--},function(result) {--%>
    <%--	var temp = $("#mktFatigueTemp").tmpl(result.rows);--%>
    <%--	$("#chnlTypeCd").append(temp);--%>
    <%--});--%>

    //날짜입력
    <%--$.ifvSyncPostJSON('<ifvm:action name="getDateInfo"/>',{--%>
    <%--},function(result) {--%>
    <%--	$(".end_date").find('input').val(result.message);--%>
    <%--});--%>

    //기간구분명 조회
    <%--$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{--%>
    <%--	groupCode : 'MKT_STAND_TYPE_CD'--%>
    <%--	, enableNA : true--%>
    <%--},function(result) {--%>
    <%--	var temp = $("#mktPeroidTemp").tmpl(result.rows);--%>
    <%--	$("#periodDiv").append(temp);--%>
    <%--});--%>

  });


</script>

<script id="mktFatigueTemp" type="text/x-jquery-tmpl">
{{if markName !='MMS' && markName !='LMS' }}
<option value="${'${'}codeName}">${'${'}markName}</option>
{{/if}}
</script>

<script id="mktPeroidTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
  .well{margin-bottom:0;}
  .top_well{border-bottom:0;}
  .fatigue_description{height:100px;}
</style>

<div class="page-title">
  <h1>
    <spring:message code="M01030"/> &gt;  <spring:message code="M00274"/>( <spring:message code="M00283"/>)
  </h1>
</div>

<div>
  <div class="page_btn_area">
    <div class="col-xs-7">
      <span><spring:message code="M01037"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
      <button class="btn btn-sm" id="btnfatigueSave" objCode="btnfatigueSave_OBJ">
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00573"/>
      </button>
      <ifvm:inputNew type="button" btnFunc="btnFatigueList" text="목록" objCode="btnFatigueList_OBJ"/>
    </div>
  </div>
  <div class="well form-horizontal underline" id="selectForm" >
    <div class="row  qt_border">
      <ifvm:inputNew type="text"  id="fatiTitle" dto="fatiTitle" names="fatiTitle" label="피로도명" labelClass="1" conClass="2" required="true"/>
      <ifvm:inputNew type="text" id="fatiState" names="fatiState" dto="fatiState" label="상태" labelClass="3" conClass="3" disabled="true" required="true"/>
    </div>

    <div class="row qt_border">
      <ifvm:inputNew type="text" id="fatiRestrictionDay" dto="fatiRestrictionDay" label="제한일" labelClass="1" conClass="2" required="true"/>
      <ifvm:inputNew type="text" id="fatiMaxRestrictionDayCnt" dto="fatiMaxRestrictionDayCnt" label="최대 제한횟수" labelClass="3" conClass="3" required="true"/>
    </div>
    <div class="row qt_border">
      <ifvm:inputNew type="checkBox" id="smsFlag" label="SMS" labelClass="1" conClass="1" />
      <ifvm:inputNew type="checkBox" id="emailFlag" label="EMAIL" labelClass="4" conClass="1" />
    </div>
    <div class="row qt_border">
      <ifvm:inputNew type="checkBox" id="lmsFlag" label="LMS" labelClass="1" conClass="1" />
      <ifvm:inputNew type="checkBox" id="kakaoFrFlag" label="친구톡" labelClass="4" conClass="1" />
    </div>
    <div class="row qt_border">
      <ifvm:inputNew type="checkBox" id="mmsFlag" label="MMS" labelClass="1" conClass="1" />
      <ifvm:inputNew type="checkBox" id="pushFlag" label="PUSH" labelClass="4" conClass="1" />
    </div>
    <div class="row qt_border">
      <ifvm:inputNew type="textarea" className="fatigue_description" id="fatiDesc" label="설명" labelClass="1" conClass="10" maxLength='100' rows="3"/>
    </div>
    <div class="row qt_border">
      <ifvm:inputNew type="text" id="createBy" dto="createBy" label="M01042" labelClass="1" conClass="2" disabled="true"/>
      <ifvm:inputNew type="text" id="createDate" dto="createDate" label="M01044" labelClass="3" conClass="3" disabled="true"/>
    </div>
    <div class="row qt_border">
      <ifvm:inputNew type="text" id="modifyBy" dto="modifyBy" label="M01045" labelClass="1" conClass="2" disabled="true"/>
      <ifvm:inputNew type="text" id="modifyDate" dto="modifyDate" label="M01046" labelClass="3" conClass="3" disabled="true"/>
    </div>
  </div>
</div>