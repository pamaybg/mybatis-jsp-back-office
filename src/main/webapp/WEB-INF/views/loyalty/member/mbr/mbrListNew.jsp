<%@ page trimDirectiveWhitespaces="true" %>
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

<script type="text/javascript">
var mbrNo = '<%= cleanXss(request.getParameter("mbrNo")) %>';
var ivrSvcCd  = '<%= cleanXss(request.getParameter("ivrSvcCd")) %>';
var mbrListGrid = null;



//고객 목록
function getMbrtList() {
//   var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

  	var ejGridOption = {
        loadComplete : function(obj){
    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("PLOY_006", mbrListGrid.opt.data.records);
        },
      	serializeGridData : function(data) {

      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
			data.item = requestitem;
        //  alert("data.item: " + data.item);
        }
      	//페이지 설정
//       	data.page = page;
          return data;
      	},
//       ONDBLCLICKROW : FUNCTION (ROWNO) {
//       	VAR DATA = MBRLISTGRID.GETROWDATA()[ROWNO-1];

//       	GOCUSTDETAIL(DATA.RID);
//       },

      	recordDoubleClick : function(args) {
    	  	var data = args.data.rid ;
    	  	goCustDetail(data);
      	},
//       cellSelecting: function (args) {
//     	 console.log(args)
//       },
//       cellSelecting : true,
      	dataUrl : '<ifvm:action name="getMbrList"/>',
      	columns: [
    	  /* {
    		  type : "checkbox",width : 50
    	  }, */
    	  {
    		  field : 'mbrNo', headerText : '<spring:message code="L00433"/>', headerTextAlign : 'center', textAlign : 'center' ,
    		  customAttributes : {
    			  index : 'lm.mbr_no',
    			  title : '{{:mbrNo}}'
    		  }
    	  },
    	  
    	  
    	  {
    		  field : 'custNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lc.cust_nm',
    			  title : '{{:custNm}}'
    		  }
    	  },
    	  {
    		  field : 'wbMemId', headerText : '<spring:message code="L00651"/>',headerTextAlign : 'center',
    		  customAttributes : {
//     			  index : 'lm.wb_mem_id',
    			  index : 'lm.web_id',
    			  title : '{{:wbMemId}}'
    		  }
    	  },
    	  {
    		  field : 'tierNm', headerText : '<spring:message code="L00187"/>',headerTextAlign : 'center', textAlign : 'center' ,
    		  customAttributes : {
    			  index : 'lt.tier_nm',
    			  title : '{{:tierNm}}'
    		  }
    	  },
    	  {
    		  field : 'hhpNo', headerText : '<spring:message code="L00436"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lm.hhp_no',
    			  title : '{{:hhpNo}}'
    		  }
    	  },
    	  {
		      field : 'identiTypeNm', headerText : '<spring:message code="L00343"/>', headerTextAlign : 'center', textAlign : 'center' ,
		      customAttributes : {
			     index : 'aa.identiTypeCd',
			     title : '{{:identiTypeNm}}'
		 	 }
	  	  },
    	  
    	  {
		      field : 'realnmCertiDate', headerText : '<spring:message code="L00345"/>', headerTextAlign : 'center', textAlign : 'center' ,
		      customAttributes : {
			     index : 'lc.realnm_certi_date',
			     title : '{{:realnmCertiDate}}'
		 	 }
	  	  },
    	  /* {
    		  field : 'birthDt', headerText : '<spring:message code="L00786"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lc.birth_dt',
    			  title : '{{:birthDt}}'
    		  }
    	  }, */
//     	  {
//     		  field : 'memDiv', headerText : '<spring:message code="L00557"/>',headerTextAlign : 'center',
//     		  customAttributes : {
//     			  index : 'cd.mark_name',
//     			  title : '{{:memDiv}}'
//     		  }
//     	  }, /* 다이소 회원구분 미사용 */
       	  /* {
    		  field : 'custTypeCd', headerText : '<spring:message code="L00318"/>',headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'cd1.mark_name',
    			  title : '{{:custTypeCd}}'
    		  }
    	  }, */
       	  /* {
    		  field : 'identiTypeCd', headerText : '<spring:message code="L00343"/>',headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'cd.mark_name',
    			  title : '{{:identiTypeCd}}'
    		  }
    	  }, */
    	  /* {
    		  field : 'identiVal', headerText : '<spring:message code="L00342"/>',headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lc.identi_val',
    			  title : '{{:identiVal}}'
    		  }
    	  }, */
    	  /* {
    		  field : 'realnmCertiDate', headerText : '<spring:message code="L00345"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lc.realnm_certi_date',
    			  title : '{{:realnmCertiDate}}'
    		  }
    	  }, */
/*     	  {
    		  field : 'underForteenYn', headerText : '14세미만여부',headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lm.MKT_AGRE_PARENT_DT',
    			  title : '{{:underForteenYn}}'
    		  }
    	  }, */
/*     	  {
    		  field : 'wipointUserYn', headerText : '위포인트여부',headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'lm.WIPOINT_USER_YN',
    			  title : '{{:wipointUserYn}}'
    		  }
    	  }, */
    	  {
    		  field : 'mbrLockYn', headerText : '휴면여부',headerTextAlign : 'center', textAlign : 'center' ,
    		  customAttributes : {
    			  index : 'lm.mbr_lock_yn',
    			  title : '{{:mbrLockYn}}'
    		  }
    	  },
    	  {
    		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
    		  customAttributes : {
    			  index : 'lm.rid',
    			  title : '{{:rid}}'
    		  }
    	  }

      ],
      	requestGridData : {
    	  	nd   	: new Date().getTime(),
    	  	rows 	: 10,
    	  	sidx 	: 'lm.mbr_no',
    	  	sord 	: 'desc',
    	  	_search : false
      	},
      	rowList : [10,25,50,100],
      	gridDataInit: false,
      	radio: true,
      	tempId : 'ifvGridSimplePageTemplete2'
 	};

  	mbrListGrid = $("#mbrListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동
function goCustDetail(id) {
	$.fn.ifvmPersonalCondLogPageId("PLOY_006", true);
  	qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + id);
}

//생년월일 구분자 추가
function insertDot(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	}
	else{
		return "";
	}
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","PLOY_006",gridId);
}

//공통 조회 호출
function mbrListSearch() {

	$.fn.ifvmSubmitSearchCondition("commSearchList",function(bool){
		bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrListGrid.searchGrid({item: requestitem});
	});
}


//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(mbrListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = mbrListGrid.opt.gridControl.getSelectedRecords()[0].rid;
//     	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = mbrListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.mbrNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'), result.hhpNo);
        	/* gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('emailAddr'), result.emailAddr); */
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('identiVal'), result.identiVal);
        });
    }
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정2
    searchCondInit();

   	// gMbrList.init();
   	//  $("#mbrListGrid").ifvGrid({ jqGridOption : gMbrList.jqGridOptionInit });
    getMbrtList();

  	//조회
    $('#searchCondBtn').on('click', function(){
    	mbrListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("mbrListGrid");
    });

    //신규 클릭시
   	/*
   	$('#addBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="custDetail"/>');
    });
	 */
    //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });

    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
});

</script>

<div id="pop_main_div_offer">

<div class="page-title" >
    <h1>
        <spring:message code="L00890"/>
        &gt; <spring:message code="L00081"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="mbrListsearchCondBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="mbrListsearchCondInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<%--
        	<ifvm:inputNew type="text" id="ivrCode" dto="ivrCode" label="L00805" maxLength="50" labelClass="2" conClass="2" className="right" disabled="true" />
        	<!-- 상담생성 -->
        	<ifvm:inputNew type="button" id="vocDetailPopBtn" text="L00819"/>
        	 --%>
        	<!-- 마스킹해제 -->
            <ifvm:inputNew type="button" id="clearMaskBtn" text="L00326" objCode="mbrListclearMaskBtn_OBJ"/>
            <%--
            <!-- 신규생성 -->
           	<ifvm:inputNew type="button" id="addBtn" text="M02874" btnFunc="certiOwn.pop" />
           	 --%>
           	<script>
           	certiOwn = {
					id : "certiPopup",
					pop : function() {
						var url = '<ifvm:url name="certiOwnPop"/>';
	           			url += '?certiCase=001'
						$("#" + this.id).ifvsfPopup({
				            enableModal : true,
				            enableResize : false,
				            contentUrl : url,
				            contentType : "ajax",
				            title : '<spring:message code="M02874"/>', // 신규가입
				            width : '500px'
				        });
					},
					beforeClose : function(obj){

					},
					close: function(obj){
						if (obj) {
							this.beforeClose(obj)
						}
						var _popObj = eval(this.id)
						_popObj._destroy();
					}
			}

           	$("#vocDetailPopBtn").click(function() {
        		var url = '<ifvm:url name="vocDetailPop"/>';
        		//url += '?ridMbr='+gMbrDetail.data.rid
        		window.open(url, 'vocDetailPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=1200,height=740')
        	});

           	</script>
        </div>
    </div>
    <div id="mbrListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="certiPopup" class="popup_container"></div>
</div>