<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="prodListSearchBtn" objCode="prodListprodListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="prodListSearchInitBtn" objCode="prodListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="prodSearchList" >
    </div>
</div>

<div id="prodListAgreeGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray"  id="btnProdSave" objCode="prodListprodListSave_OBJ">
        <spring:message code="O00058" />
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="btnProdCancel" objCode="prodListprodListCancel_OBJ">
        <spring:message code="닫기" />
    </button>
</div>

<script type="text/javascript">
    
    var prodListAgreeGrid = null;
    var prodRid = null;
    var prodNm = null;
    var prodId = null;
    
  //공통 조회 조건 목록 설정
    function prodListSearchInit(gridId) {
        $.fn.ifvmSetCommonCondList("prodSearchList","PRGO_PRODUCT",'prodListAgreeGrid');
    }

    //공통 조회 호출
    function prodListSearch() {
        $.fn.ifvmSubmitSearchCondition("prodSearchList", function () {
            prodListAgreeGrid.searchGrid({
                item : requestitem
            });
        });
    }
    
    function programListSetting(){
        var ejGridOption = {
            rowSelected : function (args) {
                var data = args.data;
                prodRid = data.rid;
                prodNm  = data.prodNm;
                prodId  = data.prodId;
            },
            serializeGridData : function( data ){
            	data.ridOfr= ifvGlobal["offerRid"];
            	data.prodUseType='PU';
                return data;
            },
            dataUrl : '<ifvm:action name="getAllowUseProdList"/>',
            columns: [
                {
                    field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'prodId' }//자재코드 
                }                  
//                 ,{
//                     field : 'mmzzStdItemCd', headerText : '<spring:message code="E00100"/>', textAlign : 'center', width: 120
//                     ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'mmzzStdItemCd' }//표준아이템코드
//                 }
                ,{
                    field : 'mmzzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmzzItemCd' }//아이템코드
                
                }
//                 ,{
//                     field : 'mmzzRepCd1', headerText : '<spring:message code="E00102"/>', textAlign : 'center' , width: 120
//                     ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'mmzzRepCd1' }//수요할당코드
//                 }
//                 ,{
//                     field : 'mmzzRepCd2', headerText : '<spring:message code="E00103"/>', textAlign : 'center' , width: 100
//                     ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmzzRepCd2' }//대체코드
//                 }
//                 ,{
//                     field : 'mmSkucd', headerText : '<spring:message code="E00104"/>', textAlign : 'center' , width: 120
//                     ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmSkucd' }//SKU채널코드
//                 }
                ,{
                    field : 'prodNm', headerText : '<spring:message code="E00105"/>', textAlign : ej.TextAlign.Left, width: 400
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'prodNm'  }//자재이름
                }
//                 ,{
//                     field : 'shGoodsNo', headerText : '<spring:message code="E00106"/>', textAlign : 'center', width: 100
//                     ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'shGoodsNo' }//자사몰구분
//                 }
//                 ,{
//                     field : 'shGoodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center', width: 100
//                     ,headerTextAlign : ej.TextAlign.Center    ,customAttributes : {index : 'shGoodsCode' }//상품코드
//                 }
//                 ,{
//                     field : 'shGoodsName', headerText : '<spring:message code="E00108"/>', textAlign : 'left', width: 400
//                     ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'shGoodsName' }//상품명 제품명 코드
//                 }
//                 ,{
//                     field : 'mmMtart', headerText : '<spring:message code="E00109"/>', textAlign : 'center', width: 100
//                     ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmMtart' }//자재유형
//                 }
                ,{
                    field : 'lCtg', headerText : '<spring:message code="E00110"/>', textAlign : 'center', width: 140
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'lCtg' }//카테고리(대)
                }
                ,{
                    field : 'mCtg', headerText : '<spring:message code="E00111"/>', textAlign : 'center', width: 140
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'mCtg' }//카테고리(중)
                }
                ,{
                    field : 'sCtg', headerText : '<spring:message code="E00112"/>', textAlign : 'center', width: 140
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'sCtg' }//카테고리(소)
                }
                ,{
                    field: 'rid', headerText: 'rid', visible: false
                }
            ],
            requestGridData : {
                  sidx : 'prodId',
                  sord : 'desc'
              },
            rowList : [10,25,50,100],
            radio: true,
            isHorizontalScroll : true,
            tempId : 'ifvGridSimplePageTemplete'

          };
        prodListAgreeGrid = $("#prodListAgreeGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    };
    
    function checkReload(){
		   $.ifvSyncPostJSON('<ifvm:action name="getOfferDetail"/>', {
				rid : ifvGlobal["offerRid"]
			},function(result){
				 if(result.useProdLimitYn=="Y"){
					$("#useProdLimitYn").prop("checked", true); 
				}else if(result.useProdLimitYn=="N"){
					$("#useProdLimitYn").prop("checked", false); 
				}
				
			}); 
	}
	
    function saveOfferLoyProd() {
    	
        if(prodListAgreeGrid.opt.gridControl.getSelectedRecords().length==0){
            alert('<spring:message code="O00066"/>');
        }else{
            var url = '<ifvm:action name="addOfferJoinProd"/>';
            var offerRid = ifvGlobal["offerRid"];
            var varData = null;
            varData = {
                    ridOfr : offerRid,
                    ridProdM : prodRid,
                    prodUseType : "PU"
            };
            
            //등록처리
            $.ifvSyncPostJSON(url, varData, function(result) {
              	 if ($.fn.ifvmIsNotEmpty(result)) {
              		if (result.message=="dupProd"){
                    	alert("사용 가능 상품에서 사용중인 상품입니다.");
                    }else{
                    	alert(result.message);
                        //$("#popupContainer_closebutton").trigger('click'); //요청사항으로 닫기버튼 자동실행x
                    }
                    checkReload();
                }
            }, function(result) {
                if (result.message)
            	     alert(result.message);
                else
                    alert("<spring:message code="O00070" />");	
            });
            
            var offerJoinProdGrid = new OfferJoinProdList();
            offerJoinProdGrid.init();
        }
    }
    
    $(document).ready(function() {
        programListSetting();
    
        prodListSearchInit();
        //조회
        $('#prodListSearchBtn').on('click', function(){
            prodListSearch();
        });
        
        //초기화
        $("#prodListSearchInitBtn").on('click', function(){
            prodListSearchInit("prodListAgreeGrid");
        });
        
        $("#btnProdCancel").on('click', function(){
            $("#popupContainer_closebutton").trigger('click');
        }); 
        
        $("#btnProdSave").click(function() {
            saveOfferLoyProd();
        });
        
    });

</script>
