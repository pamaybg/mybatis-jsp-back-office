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
var mbrListGrid;



//고객 목록
function getMbrtList(page){

  var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

  var jqGridOption = {
	serializeGridData : function( data ){

      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
              data.item = requestitem;
          //    alert("data.item: " + data.item);
          }
      	//페이지 설정
      	data.page = page;
          return data;
      },
      ondblClickRow : function (rowNo) {
    	  var data = mbrListGrid.getRowData()[rowNo-1];
		
      	goCustDetail(data.rid);
      },

      
      url : '<ifvm:action name="getMbrList"/>',
      
      colNames:[
          '<spring:message code="L00433"/>',
          '<spring:message code="L00435"/>',
          '<spring:message code="L00436"/>',
          '<spring:message code="L00786"/>',
          '<spring:message code="L00557"/>',
          '<spring:message code="L00187"/>',
          '<spring:message code="L00395"/>',
          '<spring:message code="L00651"/>',
          'rid'
        ],
		colModel:[
		         { name:'mbrNo', 	    index:'lm.mbr_no', 			width:'80px', 	align: 'center', 	resizable : false },
		         { name:'custNm', 	index:'lc.cust_nm', 		width:'120px', 	align: 'left', 		resizable : false },
		         { name:'hhpNo', 	    index:'lm.hhp_no', 			width:'120px', 	align: 'center', 	resizable : false },
		         { name:'birthDt', 	index:'lc.birth_dt', 		width:'80px', 	align: 'center', 	resizable : false,	formatter:insertDot },
		         { name:'memDiv', 	index:'cd.mark_name', 		width:'80px', 	align: 'center', 	resizable : false },
		         { name:'tierNm', 	index:'lt.tier_nm', 		width:'80px', 	align: 'center', 	resizable : false },
		         { name:'emailAddr', 	index:'lm.email_addr', 		width:'200px', 	align: 'center', 	resizable : false },
		         { name:'wbMemId', 	index:'lm.wb_mem_id', 		width:'80px', 	align: 'center', 	resizable : false },
		         { name:'rid', 		index:'lm.rid', 			hidden : true }
		],
     	sortname: 'lm.create_date',
        autowidth : true ,
        radio: true,
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
  };

  mbrListGrid = $("#mbrListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//고객 상세 이동
function goCustDetail(id) {
  //location.href = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
  qtjs.href('<ifvm:url name="mbrDetail"/>' + '?rid=' + id);
}




//생년월일 구분자 추가
function insertDot(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');;
	}
	else{
		return "";
	}
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","PLOY_006");
}

//공통 조회 호출
function mbrListSearch() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", getMbrtList);
}


//마스크해제
function clearMaskAction() {
    var v_rid;   
    if ($.fn.ifvmIsNotEmpty(mbrListGrid.getCheckedGridData()[0])) {
    	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
            $.ifvSyncPostJSON('<ifvm:action name="clearMaskMbr"/>', {
                rid: v_rid
            },
            function(result) {
            	var rowid = mbrListGrid.getRadioSelectedRowId();
            	mbrListGrid.opt.grid.setCell( rowid, 'emailAddr' , result.emailAddr ); //이메일
            	mbrListGrid.opt.grid.setCell( rowid, 'hhpNo' , result.hhpNo ); // 휴대폰 번호
            	

            });

    }
}





$(document).ready(function() {
    //공통 조회 조건 목록 설정
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
    	searchCondInit();
    });

    //신규 클릭시
   /*  $('#addBtn').on('click', function(){
    	//location.href = '<ifvm:url name="custDetail"/>';
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

<div class="page-title">
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
            <button class="btn btn-sm" id="searchCondBtn"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn">
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
        	<ifvm:inputNew type="text" id="ivrCode" maxLength="50"  dto="ivrCode"    label="L00805" labelClass="2" conClass="2" className="right"	disabled="true" />
        	<ifvm:inputNew type="button" id="vocDetailPopBtn" text="L00819"/><!-- 상담생성 -->
           <ifvm:inputNew type="button" id="clearMaskBtn" text="L00326" />
           	<ifvm:inputNew type="button" id="addBtn" text="M02874" btnFunc="certiOwn.pop" /> 
           	<script>
           	certiOwn = {
					id : "certiPopup",
					pop : function(){
						var url = '<ifvm:url name="certiOwnPop"/>';
	           			url += '?certiCase=001'
						$("#"+this.id).ifvsfPopup({
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
						if(obj){
							this.beforeClose(obj)
						}
						var _popObj = eval(this.id)
						_popObj._destroy();
					}
			}

           	$("#vocDetailPopBtn").click(function(){
        		var url = '<ifvm:url name="vocDetailPop"/>';
        		//url += '?ridMbr='+gMbrDetail.data.rid
        		window.open(url, 'vocDetailPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=1200,height=740')
        	})

           	</script>
        </div>
    </div>
    <div id="mbrListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="certiPopup" class="popup_container"></div>