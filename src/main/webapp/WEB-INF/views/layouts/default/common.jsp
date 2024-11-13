<%@page import="com.icignal.common.util.CommonUtil"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
//조회조건 및 값 반환 객체
var requestitem = [];
var individualPageSearchBtn;
var mktSercOprtTypeList = null;

//공통 조건 조회 설정
//id: div 객체 아이디 값을 받는다.
$.fn.ifvmSetCommonCondList = function(id, screenId, gridId) {
    individualPageSearchBtn = $($('#' + id).siblings('.page_btn_area').find('.btn.btn-sm')[0]); // 검색조건 조회버튼
    var div = $("#"+ id); // 검색조건 div id
    div.empty(); // 검색조건 초기화
    $("#" + id + " #searchTextVal").empty(); // 검색조건 selectBox 초기화

    if(gridId) {
       localStorage.removeItem(screenId + '_SearchObj');
       localStorage.removeItem(gridId + '_PagerObj');
    }

    // 공통코드 검색조건 통신
    $.ifvSyncPostJSON('<ifvm:action name="getCommCondLIst"/>', {
          screenId : screenId
    }, function(result) {
      var condArr = result.rows;
        //defCon: "1" 초기 설정값
        //인덱스 추가, id 추가
        for(var k=0; k<condArr.length; k++){
            condArr[k].index = k;
           condArr[k].rid = condArr[k].condId;
           condArr[k].condId = "rows" + k;
        }
        //조건 리스트 전체 조회
        var temp = $("#ifvmSearchTemp").tmpl(condArr);   // 검색조건 rows setting
        div.append(temp).find('.ifvm_comm_cond_text').off().on('keydown', function(event){
            if (event.keyCode == 13)
               individualPageSearchBtn.trigger('click');
        }); // 검색조건 div row append enter클릭시 조회클릭이벤트 trigger

        // div screenId 속성 추가
        div.attr('data-screenId', screenId);
        //셀렉트박스 조건 명 조회
        var temp = $("#ifvmCommCondOptionList").tmpl(condArr); // 검색조건 select option value setting
        $("#" + id + " .searchTextVal").append(temp); // 검색조건 selectBox append
        $.fn.ifvmFlexMinusBtn(); // 필수 항목 1줄일 경우 마이너스 버튼 hide

        $.fn.ifvmInitCondition(); // = != LIKE BETWEEN 등  setting

        for(var i=0; i<condArr.length; i++){
        	  var condList = $("#" + id).children();
              var searchType  = condList.eq(i).children().eq(1).children();
              $.fn.initifvmSetSearchChangeSelect(id, i ,searchType.val()); // 초기 검색값입력 setting
        }
        for(var i=0; i<condArr.length; i++){
            var condList = $("#" + id).children();
            var searchType  = condList.eq(i).children().eq(1).children();
            //초기값 설정
                $("#" + id + " #" + condArr[i].condId + " #searchType option:eq("+ i +")").attr("selected", "selected");
                var _this = $("#" + id + " #" + condArr[i].condId + " #searchType");
               $.fn.ifvmInitCondition(_this);

                $.fn.ifvmSetSearchChangeSelect(_this.parent().parent().children().children("#searchCon"),searchType.val());

            //초기값 숨김 설정
            if(condArr[i].defCon != 1){
                $("#" + id + " #" + condArr[i].condId).hide();
            }
        }

       if(localStorage.getItem(screenId + '_SearchObj')) {
          var comSearchObj = JSON.parse(localStorage.getItem(screenId + '_SearchObj'));
          $.fn.ifvmSetSearchObj(id, comSearchObj);
          //localStorage.removeItem(screenId + '_SearchObj');
          $.fn.ifvmSubmitSearchCondition(id);
       }
    });
};

$.fn.ifvmAllDisabled = function(id) {
   $("#" + id + " select").attr('disabled',true)
   $("#" + id + " input").attr('disabled',true)
   $("#" + id + " textarea").attr('disabled',true)
   $("#" + id + " button").hide()
}

// localStorage에 검색데이터가 있을 경우 실행
$.fn.ifvmSetSearchObj = function(id, obj) {
   var len = obj.length;
   $('#'+id).find('.SearchCondition').attr('defcon', '0').hide();

   for(var i=0;i<len;i++) {
      $($('#'+id).find('.SearchCondition')[i]).find('#searchType [condName="'+obj[i].condName+'"]').attr('selected','selected');
   }

   $('.searchTextVal').trigger('change');

   for(var i=0;i<len;i++) {
	   
      $($('#'+id).find('.SearchCondition')[i]).find('#searchCon').val(obj[i].operationTypeVal);

      var whereVals = $($('#'+id).find('.SearchCondition')[i]).find('.changeTypeAreaCode');

      switch(obj[i].condType) {
      case "DDL" :
         whereVals.find("select").val(obj[i].whereVal);
         break;
      case "DATE" :
         whereVals.find(".start_date input[type=text]").val(obj[i].startDate.slice(0,10));
         whereVals.find(".end_date input[type=text]").val(obj[i].endDate.slice(0,10));
         break;
      default :
         whereVals.find("input[type=text]").val(obj[i].whereVal);
         break;

      }

      $($('#'+id).find('.SearchCondition')[i]).attr('defcon','1').show();
   }

   $.fn.ifvmFlexMinusBtn();
}



//검색 조건 초기 세팅 <,>,<= 등의 벼앨 적재
$.fn.ifvmInitCondition = function(_this) {
	if (mktSercOprtTypeList == null) {
	    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
	        groupCode : 'MKT_SERC_OPRT_TYPE'
	        , enableNA : true
	    },function(result) {
	        var temp = null;
		
	        //초기 값 세팅
	        if(_this == null)
	        {
	            for(var k=0; k<result.rows.length; k++){
	                result.rows[k].condType = $("#searchType").val();
	            }
	            temp = $("#ifvmConditionOptionList").tmpl(result.rows);
	            $(".searchCondition").append(temp);
	        }
	        //체인지 이벤트로 인한 조건 값 세팅
	        else{
	
	            $(_this).parent().parent().children().children("#searchCon").children().remove();
	            for(var k=0; k<result.rows.length; k++){
	                result.rows[k].condType = $(_this).val();
	            }
	            temp = $("#ifvmConditionOptionList").tmpl(result.rows);
	
	            $(_this).parent().parent().children().children("#searchCon").append(temp);
	            //라이크 조건 디폴트 선택
	            $(_this).parent().parent().children().children("#searchCon").find("option[value='LIKE']").prop("selected",true)
	        }
	        
	        mktSercOprtTypeList = result.rows;
	    });
	} else {
        var temp = null;
    	
        //초기 값 세팅
        if(_this == null)
        {
            for(var k=0; k < mktSercOprtTypeList.length; k++){
            	
            	mktSercOprtTypeList[k].condType = $("#searchType").val();
            }
            temp = $("#ifvmConditionOptionList").tmpl(mktSercOprtTypeList);
            $(".searchCondition").append(temp);
        }
        //체인지 이벤트로 인한 조건 값 세팅
        else{

            $(_this).parent().parent().children().children("#searchCon").children().remove();
            for(var k=0; k < mktSercOprtTypeList.length; k++){
            	mktSercOprtTypeList[k].condType = $(_this).val();
            }
            temp = $("#ifvmConditionOptionList").tmpl(mktSercOprtTypeList);

            $(_this).parent().parent().children().children("#searchCon").append(temp);
            //라이크 조건 디폴트 선택
            $(_this).parent().parent().children().children("#searchCon").find("option[value='LIKE']").prop("selected",true)
        }
	}
};

//필수항목 type별 컨트롤 제어
$.fn.ifvmSetSearchChangeSelect = function(_this,searchType) {
    var changeTypeArea = $(_this).parent().next('.changeTypeAreaCode');
    var groupdata;
    var tblSchma;
    var ddlCode;
    var ddlVwCnCol;
    var ddlVwMnCol;

    switch($(_this).val()) {
    //TEXT
    case "LIKE" :
        changeTypeArea.html('');
            changeTypeArea.append($("#ifvmTextTemp").tmpl());
            break;
    //DATE
    case "BETWEEN" :
             if(searchType == "DATE" || searchType == "DATE_YYYYMMDD" || searchType == "DATE_YYYYMM"){
            	 changeTypeArea.html('');
        		changeTypeArea.append($("#ifvmDateTemp").tmpl());
                pageSetUp();
                $.fn.channelSetCalendarDate(changeTypeArea)
        	}else if(searchType == "DATETIME"){
        		changeTypeArea.html('');
        		changeTypeArea.append($("#ifvmTimeDateTemp").tmpl());
                pageSetUp();
                $.fn.channelSetCalendarDateTime(changeTypeArea)
        	}

            break;
    //DDL
    case '=' :
        changeTypeArea.html('');
            changeTypeArea.append($("#ifvmSelectTemp").tmpl());
            break;
    default:
    	ddlCode = $(_this).parent().parent().children().children('#searchType').find('option:selected').attr('ddlCode');
        groupdata = $(_this).parent().parent().children().children('#searchType').find('option:selected').attr('grpcode');
		
        //공통 코드 값인지 아닌지 구분하여 공통 코드일 경우 셀렉트 박스를 뿌려준다.
        if(ddlCode == "CC"){
            $.fn.ifvmSetSearchCommCode(_this,groupdata);
        } else if(ddlCode == "VIEW") {
        	ddlVwCnCol = $(_this).parent().parent().children().children('#searchType').find('option:selected').attr('ddlVwCnCol');
    		ddlVwMnCol = $(_this).parent().parent().children().children('#searchType').find('option:selected').attr('ddlVwMnCol');
    		tblSchma = $(_this).parent().parent().children().children('#searchType').find('option:selected').attr('tblSchma'); 
    		$.fn.ifvmSetSearchViewTable(_this, groupdata, ddlCode, ddlVwCnCol, ddlVwMnCol, tblSchma);
        }
        //공통 코드가 아닐 경우 기본 텍스트 박스를 뿌려준다.
        else{
            changeTypeArea.html('');
            changeTypeArea.append($("#ifvmTextTemp").tmpl());
        }
        break;
        
    case 'GREATER(>)' :
    	changeTypeArea.html('');
      	changeTypeArea.append($("#ifvmGreaterTemp").tmpl());
        break;
    }

    changeTypeArea.find('.ifvm_comm_cond_text').off().on('keydown', function(event){
         if (event.keyCode == 13) individualPageSearchBtn.trigger('click');
     });
};

//필수항목 type별 컨트롤 제어
$.fn.initifvmSetSearchChangeSelect = function(id, i , searchType){
  _this = $("#"+id+" .searchTextVal").eq(i).children().eq(0)
  var changeTypeArea = $("#"+id+" #searchType").parent().parent().parent().children().eq(i).find('.changeTypeAreaCode')
  var groupdata;
  
  switch(_this.val()) {
  //TEXT
  case "LIKE" :
      changeTypeArea.html('');
          changeTypeArea.append($("#ifvmTextTemp").tmpl());
          break;
  //DATE
  case "BETWEEN" :
	  if(searchType == "DATE" || searchType == "DATE_YYYYMMDD" || searchType == "DATE_YYYYMM"){
          changeTypeArea.html('');
          changeTypeArea.append($("#ifvmDateTemp").tmpl());
          pageSetUp();
          $.fn.channelSetCalendarDate(changeTypeArea);
	  }else if(searchType == 'DATETIME'){
          changeTypeArea.html('');
          changeTypeArea.append($("#ifvmTimeDateTemp").tmpl());
          pageSetUp();
          $.fn.channelSetCalendarDateTime(changeTypeArea)
      }
      break;
  //DDL
  case '=' :
      changeTypeArea.html('');
          changeTypeArea.append($("#ifvmSelectTemp").tmpl());
          break;
      groupdata = _this.attr('grpCode');
      ddlCode = _this.attr('ddlCode');
      //공통 코드 값인지 아닌지 구분하여 공통 코드일 경우 셀렉트 박스를 뿌려준다.
      if(ddlCode == "CC"){
          $.fn.initifvmSetSearchCommCode(_this.parent().parent(),groupdata);
      } else if(ddlCode == "VIEW") {
    	  //사용자 정의테이블 셀렉트박스를 뿌려준다.
    	  ddlVwCnCol =this.attr('ddlVwCnCol');
          ddlVwMnCol =this.attr('ddlVwMnCol');
          tblSchma =this.attr('tblSchma');
    	  $.fn.initifvmSetSearchViewTable(_this.parent().parent(), groupdata, ddlCode, ddlVwCnCol, ddlVwMnCol, tblSchma);
      }
      //공통 코드가 아닐 경우 기본 텍스트 박스를 뿌려준다.
      else{
          changeTypeArea.html('');
          changeTypeArea.append($("#ifvmTextTemp").tmpl());
      }
          break;
          
 	 case 'DATE_GREATER' :
	  	changeTypeArea.html('');
      	changeTypeArea.append($("#ifvmGreaterTemp").tmpl());
       	break;     
          
 	}

     changeTypeArea.find('.ifvm_comm_cond_text').off().on('keydown', function(event){
         if (event.keyCode == 13) individualPageSearchBtn.trigger('click');
     });
};

//조건 절 병견 후 셀렉트 박스가 나올 시 체인지되는 값.
//그룹 코드를 받아 그에 맞는 값을 넣는다.
$.fn.ifvmSetSearchCommCode = function(_this, groupdata) {
var changeTypeArea = $(_this).parent().next('.changeTypeAreaCode');
//var SelectListTemp = $(_this).parent().next().children();
$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
          groupCode : groupdata
        , enableNA  : true
},function(result) {
        changeTypeArea.html('');
        changeTypeArea.append($("#ifvmSelectTemp").tmpl());
        var temp = $("#ifvmCommonListTemp").tmpl(result.rows);
        $(changeTypeArea).children().children("select").append(temp);

});

};

$.fn.ifvmSetSearchViewTable = function(_this, groupdata , ddlCode, ddlVwCnCol, ddlVwMnCol, tblSchma) {
	var changeTypeArea = $(_this).parent().next('.changeTypeAreaCode');
	//var SelectListTemp = $(_this).parent().next().children();
	$.ifvSyncPostJSON('<ifvm:action name="getSelectBoxList"/>',{
		    tableNm     : groupdata
		  , ddlVwCnCol  : ddlVwCnCol
		  , ddlVwMnCol  : ddlVwMnCol
		  , tblSchma    : tblSchma
	},function(result) {
	        changeTypeArea.html('');
	        changeTypeArea.append($("#ifvmSelectTemp").tmpl());
	        var temp = $("#ifvmCommonListTemp").tmpl(result.rows);
	        $(changeTypeArea).children().children("select").append(temp);

	});

	};

//조건 절 병견 후 셀렉트 박스가 나올 시 체인지되는 값.
//그룹 코드를 받아 그에 맞는 값을 넣는다.
$.fn.initifvmSetSearchCommCode = function(_this, groupdata) {
var changeTypeArea = _this.parent().find('.changeTypeAreaCode');
//var SelectListTemp = $(_this).parent().next().children();
$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
        groupCode : groupdata
      , enableNA  : true
},function(result) {
      changeTypeArea.html('');
      changeTypeArea.append($("#ifvmSelectTemp").tmpl());
      var temp = $("#ifvmCommonListTemp").tmpl(result.rows);
      $(changeTypeArea).children().children("select").append(temp);

});

};

$.fn.initifvmSetSearchViewTable = function(_this, groupdata, ddlCode, ddlVwCnCol, ddlVwMnCol, tblSchma) {
	var changeTypeArea = _this.parent().find('.changeTypeAreaCode');
	$.ifvSyncPostJSON('<ifvm:action name="getSelectBoxList"/>',{
		tableNm     : groupdata
	  , ddlVwCnCol  : ddlVwCnCol
	  , ddlVwMnCol  : ddlVwMnCol
	  , tblSchma    : tblSchma
	},function(result) {
	        changeTypeArea.html('');
	        changeTypeArea.append($("#ifvmSelectTemp").tmpl());
	        var temp = $("#ifvmCommonListTemp2").tmpl(result.rows);
	        $(changeTypeArea).children().children("select").append(temp);

	});

	};

//조회 조건 넘기기
$.fn.ifvmSubmitSearchCondition = function(id, callback){
    var size = $("#" + id).children().length;
    var condList = $("#" + id).children();
    var pushItem = {};
    requestitem = [];

    // localStorage Data reset
    var localObj = [];
    var isParameterNull = true;
    for(var i=0; i<size; i++){
       pushItem = {};
        if(condList.eq(i).attr('defcon') == "1"){

            var searchType      = condList.eq(i).children().eq(1).children();
            var searchCondition = condList.eq(i).children().eq(2).children();
            var capacity        = condList.eq(i).children().eq(3).children();
			
            //pushItem.activation =  condList.eq(i).attr('defcon');
            pushItem.condType         =  searchType.val();
            pushItem.condName         =  searchType.find('option:selected').attr('condName');
            pushItem.dropDownCD       =  searchType.find('option:selected').attr('grpcode');
            pushItem.baseTblAlias     =  searchType.find('option:selected').attr('baseTblAlias')
            pushItem.comprTgtTblAlias =  searchType.find('option:selected').attr('comprTgtTblAlias')
            pushItem.baseTable        =  searchType.find('option:selected').attr('baseTable');
            pushItem.tgTable          =  searchType.find('option:selected').attr('tgtTable');
            pushItem.tgCol            =  searchType.find('option:selected').attr('tgtCol');
            pushItem.comTgCol      =  searchType.find('option:selected').attr('joinTgtClm');
            /* pushItem.comTgCol         =  "EXE_CHNL_TYPE_CD"; */
            pushItem.srcCol           =  searchType.find('option:selected').attr('joinSrcClm');
            pushItem.operationType    =  searchCondition.find('option:selected').text();
            pushItem.operationTypeVal =  searchCondition.find('option:selected').val();
            pushItem.rid              =  condList.eq(i).children().last().text();
            if(pushItem.condType == "DATE" || pushItem.condType == "DATE_YYYYMMDD" || pushItem.condType == "DATE_YYYYMM"){
            	if(pushItem.operationType == "BETWEEN"){
               //임소원 - 날짜 컴포넌트에 빈값이 들어 왔을 때 처리 로직 추가
               if(capacity.find('input:text').eq(0).val() == "" ||capacity.find('input:text').eq(1).val() == "" ){
                  continue;
               }
               //장용 - 날짜 유형이 여러개 일 경우 아이디가 같아서 날짜 입력이 안되는 에러 문제로 변경
               pushItem.startDate = capacity.find('input:text').eq(0).val() + " 00:00:00";
                     pushItem.endDate = capacity.find('input:text').eq(1).val() + " 23:59:59";
                    //pushItem.startDate = capacity.find($("#searchStrDate")).val() + " 00:00:00";
                    //pushItem.endDate   = capacity.find($("#searchEndDate")).val() + " 00:00:00";
                } else {
                    pushItem.whereVal = capacity.children().val();
                };
            }
            else if(pushItem.condType == "DATETIME"){
            	if(pushItem.operationType == "BETWEEN"){
               //임소원 - 날짜 컴포넌트에 빈값이 들어 왔을 때 처리 로직 추가
               if(capacity.find('input:text').eq(0).val() == "" ||capacity.find('input:text').eq(1).val() == "" || capacity.find('input:text').eq(2).val() == "" ||capacity.find('input:text').eq(3).val() == "" ){
                  continue;
               }
               //장용 - 날짜 유형이 여러개 일 경우 아이디가 같아서 날짜 입력이 안되는 에러 문제로 변경
               pushItem.startDate = capacity.find('input:text').eq(0).val() //+ " 00:00:00";
               pushItem.startTime = capacity.find('input:text').eq(1).val() //+ " 00:00";
               pushItem.endDate = capacity.find('input:text').eq(2).val() //+ " 23:59:59";
               pushItem.endTime = capacity.find('input:text').eq(3).val() //+ " 23:59";
                } else {
                    pushItem.whereVal = capacity.children().val();
                };
            }else if(pushItem.condType =="DATE_GREATER"){
            	if(pushItem.operationTypeVal  =="GREATER(>)"){
             	   if(capacity.find('input:text').eq(0).val() == ""){
                         continue;
                     }
             	   pushItem.startDate=capacity.find('input:text').eq(0).val()+" 00:00:00";
            	}
            }
            else {
                pushItem.whereVal = capacity.children().val();
            };
            /* 다이소 웹취약점 요청으로 SQL Query에 사용되는 문자열에 대해 유효성 체크
             * 2019.01.21
             * jk.kim
             */
            /* var repCheck = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9_)]/gi; */
            /* var repCheck = /[#><!-/.*\n;]/gi;
            if(repCheck.test(pushItem.whereVal)){
               pushItem.whereVal = pushItem.whereVal.replace(repCheck,"")
            } */
            requestitem.push(pushItem);
        };
        if($.fn.ifvmIsNotEmpty(pushItem.whereVal) || ($.fn.ifvmIsNotEmpty(pushItem.startDate) && $.fn.ifvmIsNotEmpty(pushItem.endDate))) {
        	isParameterNull = false;
        }
        if(Object.keys(pushItem).length != 0)
           localObj.push(pushItem);
    }
   if(callback){
      if(isParameterNull) {
         callback(isParameterNull);
      } else {
         if($('#'+id).attr('data-screenId'))
             localStorage.setItem($('#'+id).attr('data-screenId')+'_SearchObj', JSON.stringify(localObj));
         callback();
      }
    }
};

//조회 조건 넘기기
//2018.11.30 hy.jun - 조회조건값 빈 경우 리턴하지 않는다.
$.fn.ifvmSubmitSearchCondition_NoAllSearch = function(id, callback){
    var size = $("#" + id).children().length;
    var condList = $("#" + id).children();
    var pushItem = {};
    requestitem = [];

    for(var i=0; i<size; i++){
        if(condList.eq(i).attr('defcon') == "1"){
            pushItem = {};

            var searchType      = condList.eq(i).children().eq(1).children();
            var searchCondition = condList.eq(i).children().eq(2).children();
            var capacity        = condList.eq(i).children().eq(3).children();

            //pushItem.activation =  condList.eq(i).attr('defcon');
            pushItem.condType         =  searchType.val();
            pushItem.condName         =  searchType.find('option:selected').attr('condName');
            pushItem.dropDownCD       =  searchType.find('option:selected').attr('grpcode');
            pushItem.baseTblAlias     =  searchType.find('option:selected').attr('baseTblAlias')
            pushItem.comprTgtTblAlias =  searchType.find('option:selected').attr('comprTgtTblAlias')
            pushItem.baseTable        =  searchType.find('option:selected').attr('baseTable');
            pushItem.tgTable          =  searchType.find('option:selected').attr('tgtTable');
            pushItem.tgCol            =  searchType.find('option:selected').attr('tgtCol');
            pushItem.comTgCol         =  searchType.find('option:selected').attr('joinTgtClm');
            pushItem.srcCol           =  searchType.find('option:selected').attr('joinSrcClm');
            pushItem.operationType    =  searchCondition.find('option:selected').text();
            pushItem.rid              =  condList.eq(i).children().last().text();

             if(pushItem.condType == "DATE" || pushItem.condType == "DATE_YYYYMMDD" || pushItem.condType == "DATE_YYYYMM"){
            	if(pushItem.operationType == "BETWEEN"){
               //임소원 - 날짜 컴포넌트에 빈값이 들어 왔을 때 처리 로직 추가
               if(capacity.find('input:text').eq(0).val() == "" ||capacity.find('input:text').eq(1).val() == "" ){
                  continue;
               }
               //장용 - 날짜 유형이 여러개 일 경우 아이디가 같아서 날짜 입력이 안되는 에러 문제로 변경
               pushItem.startDate = capacity.find('input:text').eq(0).val() + " 00:00:00";
                     pushItem.endDate = capacity.find('input:text').eq(1).val() + " 23:59:59";
                    //pushItem.startDate = capacity.find($("#searchStrDate")).val() + " 00:00:00";
                    //pushItem.endDate   = capacity.find($("#searchEndDate")).val() + " 00:00:00";
                } else {
                    pushItem.whereVal = capacity.children().val();
                };
            }
            else if(pushItem.condType == "DATETIME"){
            	if(pushItem.operationType == "BETWEEN"){
               //임소원 - 날짜 컴포넌트에 빈값이 들어 왔을 때 처리 로직 추가
               if(capacity.find('input:text').eq(0).val() == "" ||capacity.find('input:text').eq(1).val() == "" || capacity.find('input:text').eq(2).val() == "" ||capacity.find('input:text').eq(3).val() == "" ){/////////////////////////////////////////
                  continue;
               }
               //장용 - 날짜 유형이 여러개 일 경우 아이디가 같아서 날짜 입력이 안되는 에러 문제로 변경
               pushItem.startDate = capacity.find('input:text').eq(0).val() //+ " 00:00:00";
               pushItem.startTime = capacity.find('input:text').eq(1).val()// + " 00:00";
               pushItem.endDate = capacity.find('input:text').eq(2).val()// + " 23:59:59";
               pushItem.endTime = capacity.find('input:text').eq(3).val() //+ " 23:59";
                } else {
                    pushItem.whereVal = capacity.children().val();
                };
            }else if(pushItem.condType == "DATE_GREATER") {
            	
            }
            else {
                pushItem.whereVal = capacity.children().val();
            };

            if($.fn.ifvmIsNotEmpty(pushItem.whereVal) || ($.fn.ifvmIsNotEmpty(pushItem.startDate) && $.fn.ifvmIsNotEmpty(pushItem.endDate))) {
               requestitem.push(pushItem);
            }
        };
    }
    callback();
};

/**
 * 공통조회조건 통한 조회 로그 저장 
 * 2019.01.25 hy.jun
 * 2020.08.26 hr.noh - 수정 - 단순 조회할때는 로그를 남기지 않고 조회 후 그 회원 상세로 들어갔을때 로그를 남긴다.
 */

$.fn.ifvmComCondLogging = function(screenId, custRid){
    $.ifvSyncPostJSON('<ifvm:action name="setComCondLog"/>', {
       pageRid : screenId,
       itemRid : custRid,
       rsltCnt : '1'
   }, function(result) {

   });
};

//로그저장(이전 로직 - 개인 조회 건만 로그저장)
/* $.fn.ifvmComCondLogging = function(screenId, rsltCnt){
$.fn.ifvmComCondLogging = function(screenId, rsltCnt){
	
    $.ifvSyncPostJSON('<ifvm:action name="setComCondLog"/>', {
       pageRid : screenId,
       item : requestitem,
       rsltCnt : rsltCnt
   }, function(result) {

   });
}; */

/**
 * 고정된 조회조건 통한 조회 로그 저장
 * 2019.01.25 hy.jun
 */
$.fn.ifvmFixedCondLogging = function(screenId, rsltCnt, conds){
    $.ifvSyncPostJSON('<ifvm:action name="setComCondLog"/>', {
       pageRid : screenId,
       item : conds,
       rsltCnt : rsltCnt
   }, function(result) {

   });
};


//필수 항목 1줄일 경우 마이너스 버튼 hide
$.fn.ifvmFlexMinusBtn = function(){
    if( $('.SearchCondition[defcon=1]').length == 1){
        $('.itemMinusBtn').hide();
    }else{
        $('.itemMinusBtn').show();
    }
};

// 검색 조건이 BETWEEN이고 날짜라면, Datepicker 설정
$.fn.channelSetCalendarDate = function( target ) {
   var startDate = $( target ).find( ".datepicker" ).eq(0);
   var endDate = $( target ).find( ".datepicker" ).eq(1);

   startDate.val( $.ifvGetTodayDate());
   endDate.val( $.ifvGetTodayDate());

   startDate.ifvDateChecker({
      maxDate: endDate
   });

   endDate.ifvDateChecker({
      minDate: startDate
   });
};

//시분초 포함 캘린더 셋팅
$.fn.channelSetCalendarDateTime = function( target ) {
	var startDate = $( target ).find( ".datepicker" ).eq(0);
	var endDate = $( target ).find( ".datepicker" ).eq(1);


	startDate.val( $.ifvGetTodayDate());
	//다음날로 수정 2020.09.01 hr.noh
	endDate.val( $.ifvGetNewDate('d', +1).newDateS);

	startDate.ifvDateChecker({
	   maxDate: endDate
	});

	endDate.ifvDateChecker({
	   minDate: startDate
	});

	//시분시작시간
	$("#startTime").timepicker({
		showMeridian: false,
        defaultTime: '00:00',
        showSeconds: false,
        minuteStep: 5,
        secondStep: 1
    });

	//시분종료시간
	$("#endTime").timepicker({
		showMeridian: false,
        defaultTime: '00:00',
        showSeconds: false,
        minuteStep: 5,
        secondStep: 1
    });


};

$(document).ready(function() {

    //필수항목 플러스 버튼
    $('.itemPlusBtn').live('click', function(){
       var searchConditionList = $(this).parent().parent().parent().children(".SearchCondition");
        for(var i=0; i < searchConditionList.length; i++){
            var searchCondition = $(searchConditionList[i]);
            var defCon = searchCondition.attr('defcon');

            if(defCon != 1){
               searchCondition.show();
               searchCondition.attr('defcon', 1);
                break;
            };
        }
        $.fn.ifvmFlexMinusBtn();
    });

    //필수항목 마이너스 버튼
    $('.itemMinusBtn').live('click', function(){
        if($(this).parent().parent().attr('seq') != 0){
            $(this).parent().parent().hide();
            $(this).parent().parent().attr('defcon', 0);
        }
        $.fn.ifvmFlexMinusBtn();
    });
    //필수항목 type별 컨트롤 제어
    $('.searchTextVal').live('change', function(){
        $.fn.ifvmInitCondition($(this));
        $.fn.ifvmSetSearchChangeSelect($(this).parent().parent().children().children("#searchCon"), $(this).val());
    });
});

</script>

<script id="ifvmSearchTemp" type="text/x-jquery-tmpl">
<div class="row qt_border SearchCondition" id= ${'${'}condId} seq=${'${'}index} defCon = ${'${'}defCon} >
    <div class="flex_btn_area">
        <button class="btn_searchitem_add_remove itemPlusBtn">Plus</button>
        <button class="btn_searchitem_add_remove itemMinusBtn">Minus</button>
    </div>
    <div class="col-xs-2 mkt_input_pd_rt">
        <ifvm:input type="select" id="searchType" className = "searchTextVal" />
    </div>
    <div class="col-xs-2 mkt_input_pd_rt">
        <ifvm:input type="select" id="searchCon" className="searchCondition" />
    </div>
    <div class="changeTypeAreaCode">
        <div class="col-xs-2">
            <ifvm:input type="text" id="searchCondition"/>
        </div>
    </div>
    <div name="rid" style="visibility: hidden;">${'${'}rid}</div>
</div>
</script>

<script id="ifvmCommCondOptionList" type="text/x-jquery-tmpl">
{{if grpCode != null}}
<option value='${'${'}condType}' grpCode='${'${'}grpCode}' ddlCode='${'${'}ddlCode}' tblSchma='${'${'}tblSchma}' ddlVwCnCol='${'${'}ddlVwCnCol}' ddlVwMnCol='${'${'}ddlVwMnCol}' joinTgtClm='${'${'}joinTgtClm}'  comprTgtTblAlias='${'${'}comprTgtTblAlias}'
tgtTable='${'${'}tgtTable}' tgtCol='${'${'}tgtCol}' baseTable='${'${'}baseTable}' baseTblAlias='${'${'}baseTblAlias}' joinSrcClm='${'${'}joinSrcClm}' condName='${'${'}condName}'>${'${'}condName}</option>
{{else}}
<option value='${'${'}condType}' joinTgtClm='${'${'}joinTgtClm}' baseTblAlias='${'${'}baseTblAlias}' comprTgtTblAlias='${'${'}comprTgtTblAlias}'
tgtTable='${'${'}tgtTable}' tgtCol='${'${'}tgtCol}' baseTable='${'${'}baseTable}' joinSrcClm='${'${'}joinSrcClm}' condName='${'${'}condName}'>${'${'}condName}</option>{{/if}}
</script>

<script id="ifvmConditionOptionList" type="text/x-jquery-tmpl">
{{if condType == 'DDL'}}
    {{if codeName == '=' || codeName == '!='}}
<%--    {{if codeName == '=' || codeName == '!=' || codeName == 'IN' || codeName == 'NOT IN' }}--%>
        <option value= ${'${'}markName} > ${'${'}codeName} </option>{{/if}}
{{/if}}
{{if condType == 'TEXT' }}
    {{if codeName == '=' || codeName == '!=' || codeName == 'LIKE'}}
<%--    {{if codeName == '=' || codeName == '!=' || codeName == 'LIKE' || codeName == 'IN' || codeName == 'NOT IN' }}--%>
        <option value= ${'${'}markName} > ${'${'}codeName} </option>{{/if}}
{{/if}}
{{if condType == 'SECURITY_TEXT' }}
    {{if codeName == '='}}
<%--    {{if codeName == '=' || codeName == 'IN' || codeName == 'NOT IN' }}--%>
        <option value= ${'${'}markName} > ${'${'}codeName} </option>{{/if}}
{{/if}}
{{if condType == 'DATE' || condType == 'DATE_YYYYMMDD' || condType == 'DATETIME' || condType == 'DATE_YYYYMM' }}
    {{if codeName == 'BETWEEN'}}
        <option value=${'${'}markName}>${'${'}codeName}</option>{{/if}}
{{/if}}
{{if condType == 'INT'}}
    {{if codeName == '>' || codeName == '<' || codeName == '>=' || codeName == '<=' || codeName == '!=' }}
        <option value=${'${'}markName}>${'${'}codeName}</option>{{/if}}
{{/if}}
{{if condType == 'TEXT_EQUAL'}}
    {{if codeName == '='}}
<%--    {{if codeName == '=' || codeName == 'IN' || codeName == 'NOT IN'}}--%>
        <option value= ${'${'}markName} > ${'${'}codeName} </option>{{/if}}
{{/if}}
{{if condType == 'DATE_GREATER'}}
    {{if codeName == '>'}}
        <option value= ${'${'}markName} > ${'${'}codeName} </option>{{/if}}
{{/if}}
</script>

<script id="ifvmCommonListTemp" type="text/x-jquery-tmpl">
    <option value=${'${'}codeName}>${'${'}markName}</option>
</script>

<script id="ifvmCommonListTemp2" type="text/x-jquery-tmpl">
    <option value=${'${'}codeName}>${'${'}markName}</option>
</script>


<script id="ifvmTextTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="text" className="ifvm_comm_cond_text" />
</div>
</script>

<script id="ifvmDateTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2 cal_frt start_date">
    <ifvm:input type="date"/>
</div>
<div class="col-xs-1 swung_dash">~</div>
<div class="col-xs-2 cal_scd end_date">
    <ifvm:input type="date" />
</div>
</script>

<script id="ifvmTimeDateTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2 start_date">
    <ifvm:input type="date"/>
</div>
<div class="col-xs-1">
	<ifvm:inputNew type="time" id="startTime"/>
</div>
<div class="col-xs-1 swung_dash">~</div>
<div class="col-xs-2 cal_scd end_date">
    <ifvm:input type="date"/>
</div>
<div class="col-xs-1">
	<ifvm:inputNew type="time" id="endTime"/>
</div>
</script>

<script id="ifvmSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="select" />
</div>
</script>

<script id="ifvmGreaterTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2 start_date">
    <ifvm:input type="date"/>
</div>
</script>
