<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
  function OfferList() {
     var ejGridOption = {
         serializeGridData : function(data) {
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
          data.item = requestitem;
        }
        data.ofrCtg='M';
            //페이지 설정
          return data;
      },rowSelected : function (args) {
            setBtnActive(args.data.statCd);
    },
      recordDoubleClick : function (args) {
        var data = args.data.rid;
        
        goToDetail(data);
       },
                dataUrl: '<ifvm:action name="getOfferPointList"/>',
                columns: [ // '번호', '오퍼 명', '대유형', '소유형', '유효시작일자', '유효종료일자','등록자','등록일자'
                	{
                        field: 'ofrCtgNm',
                        headerText: '<spring:message code="구분"/>',
                        width: '30px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'statCd'
                        }
                    },{
                        field: 'ofrNo',
                        headerText: '<spring:message code="O00006"/>',
                        width: '50px',
                        textAlign: 'center',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'ofrNm',
                        headerText: '<spring:message code="O00007"/>',
                        width: '200px',
                        textAlign: 'left',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'ofrTypeNm',
                        headerText: '<spring:message code="O00008"/>',
                        width: '40px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'ofrType'
                        }
                    }, {
                        field: 'ofrSubTypeNm',
                        headerText: '<spring:message code="O00009"/>',
                        width: '40px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'ofrSubType'
                        }
                    },{
                        field: 'expirTypeNm',
                        headerText: '<spring:message code="만료유형"/>',
                        width: '60px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'expirType'
                        }
                    },{
                        field: 'expirCnt',
                        headerText: '<spring:message code="만료기간"/>',
                        width: '130px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'expirCnt'
                        }
                    },{
                        field: 'vocYn',
                        headerText: '<spring:message code="VOC지급"/>',
                        width: '50px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'vocYn'
                        }
                    },{
                        field: 'empYn',
                        headerText: '<spring:message code="임직원지급"/>',
                        width: '50px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'empYn'
                        }
                    },{
                        field: 'statCdNm',
                        headerText: '<spring:message code="상태"/>',
                        width: '50px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'statCd'
                        }
                    },{
                        field: 'createBy',
                        headerText: '<spring:message code="O00080"/>',
                        width: '60px',
                        textAlign: 'center'
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="O00116"/>',
                        width: '40px',
                        textAlign: 'center'
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false
                    }, {
                        field: 'statCd',
                        headerText: 'statCd',
                        visible: false
                    }],
                requestGridData: {
                    sidx: 'createDate',
                    search : false,
                },
                isHorizontalScroll : true,
        };
         ofrList = $("#ofrList").ifvsfGrid({
                ejGridOption: ejGridOption
            });
  }
  
//중지
  function stopOfr(){
  	var list = ofrList.opt.gridControl.getSelectedRecords();
  	if($.fn.ifvmIsNotEmpty(list)) {
  		
  		if (list[0].statCd == 'A') {
  			if(!confirm('오퍼를 중지하시겠습니까?')) return;
  				
  			$.ifvSyncPostJSON('<ifvm:action name="updateOfrStatCdStop"/>', {
  				rid: list[0].rid
  			}, function(result) {
  				alert('중지되었습니다.');
  				OfferList();
  			});
  		} else {
  			alert('활성중인 오퍼만 중지 하실수 있습니다.');
  		} 
  	} else {
  		alert('목록을 선택해 주세요.');
  	}
  }
  
//판매일자 startDate를 3개월 날짜값으로 초기화해주기
  function startDateInitialize(){ 
  	
  	$('.changeTypeAreaCode .end_date input').val('2099-12-31');
  }
  

  
//활성
  function startOfr(){
  	var list = ofrList.opt.gridControl.getSelectedRecords();
  	if($.fn.ifvmIsNotEmpty(list)) {
  				if (list[0].statCd == 'W' || list[0].statCd == 'E') {
  		  			if(!confirm('오퍼를 활성 하시겠습니까?')) return;
  		  			
  		  			$.ifvSyncPostJSON('<ifvm:action name="updateOfrStatCdStart"/>', {
  		  				rid: list[0].rid
  		  			}, function(result) {
  		  				alert('활성되었습니다.');
  		  				OfferList();
  		  			});
  		  		} else {
  		  			alert('작성 또는 중지된 오퍼만 활성 하실수 있습니다.');
  		  		}
  		
  	} else {
  		alert('목록을 선택해 주세요.');
  	}
  }
  
  function setBtnActive(type) {

		//작업중
		if (type == "W") {
			$("#btnRemove").removeAttr('disabled');
			$("#btnStopBtn").attr('disabled',true);
			$("#btnStartBtn").attr('disabled', false);
		}

		//활성
		else if (type == "A") {
			$("#btnRemove").attr('disabled', true);
			$("#btnStopBtn").removeAttr('disabled');
			$("#btnStartBtn").attr('disabled', true);
		}

		//그외
		else {
			$("#btnRemove").attr('disabled',true);
			$("#btnStopBtn").attr('disabled',true);
			$("#btnStartBtn").attr('disabled', false);

		}
	}
  
  function removeAction(){
	  var v_rid;
	    if ($.fn.ifvmIsNotEmpty(ofrList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = ofrList.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="C00113"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	    	if( confirm('<spring:message code="I01500"/>') == true ){
	        $.ifvSyncPostJSON('<ifvm:action name="removeOffer"/>', {
	            rid: v_rid
	        },
	        function(result) {
	        	ofrList._doAjax();
				alert('<spring:message code="I00726"/>');
	        });
	    }
	  }
  }
  
function goToDetail(rid){
     var _rid =  rid;
         qtjs.href('<ifvm:url name="offerPointDetail"/>' + "?rid=" + _rid);
}

function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("offerSearchList", "OFFER_POINT_LIST", gridId);
}

  
  $(document).ready(function () {
     searchCondInit();
     startDateInitialize();
     OfferList();
    $('#searchCondBtn').on('click', function () {
               $.fn.ifvmSubmitSearchCondition("offerSearchList", function () {
              ofrList.searchGrid({ item: requestitem });
            });
        });
        // 초기화
        $("#searchCondInitBtn").on('click', function () {
          searchCondInit("offerList")
        });
        // 신규 클릭시
        $('#btnAdd').on('click', function () {
            qtjs.href('<ifvm:url name="offerPointDetail"/>');
        });

        // 삭제
        $('#btnRemove').on('click', function () {
            removeAction();
        });
     	// 중지
        $('#btnStopBtn').on('click', function () {
        	stopOfr();
        });
     	// 활성
        $('#btnStartBtn').on('click', function () {
        	startOfr();
        });
     	
        $("select option[value='E']").attr("selected", true);
        $("#rows2 select option[value='NOT']").attr("selected", true);
        $("#searchCondBtn").trigger("click");
  });
</script>

<div class="page-title">
  <h1>
    <spring:message code="멤버십적립금" />
    &gt; <spring:message code="O00105" />
  </h1>
</div>

<div>
  <div class="page_btn_area">
    <div class="col-xs-7">
      <span><spring:message code="L01838" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
      <button class="btn btn-sm" id="searchCondBtn" objCode="offerListMainSearch_OBJ">
        <i class="fa fa-search"></i>
        <spring:message code="O00105" />
      </button>
      <button class="btn btn-sm" id="searchCondInitBtn" objCode="offerListMainSearchInit_OBJ">
        <spring:message code="O00106" />
      </button>
    </div>
  </div>
  <div class="well form-horizontal well_bt5" id="offerSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
  <div class="page_btn_area" id=''>
    <div class="col-xs-7">
      <span><spring:message code="O00108" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
      <ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAdd" objCode="offerListAdd_OBJ"/>
      <ifvm:inputNew type="button"  text="활성" id="btnStartBtn" objCode="offerListStart_OBJ"/>
      <ifvm:inputNew type="button"  text="중지" id="btnStopBtn" objCode="offerListStop_OBJ"/>
      <ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemove" objCode="offerListRemove_OBJ"/>
    </div>
  </div>
  <div id="ofrList" class="white_bg grid_bd0"></div>
</div>