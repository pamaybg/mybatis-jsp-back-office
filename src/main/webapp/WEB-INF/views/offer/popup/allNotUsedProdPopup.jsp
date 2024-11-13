<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="notUsedProdListSearchBtn" objCode="notUsedProdListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="notUsedProdListSearchInitBtn" objCode="notUsedProdListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="notUsedProdSearchList" >
    </div>
</div>
<div id="notUsedProdListNotGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_lightGray2" id="btnNotUsedProdCancel" objCode="notUsedProdListCancel_OBJ">
        <spring:message code="O00059" />
    </button>
</div>

<script type="text/javascript">
    
    var notUsedProdListNotGrid = null;
    var prodRid = null;
    var prodNm = null;
    var prodId = null;
    

    //공통 조회 조건 목록 설정
    function notUsedProdListSearchInit(gridId) {
        $.fn.ifvmSetCommonCondList("notUsedProdSearchList","PRGO_PRODUCT",'notUsedProdListNotGrid');
    }

    //공통 조회 호출
    function notUsedProdListSearch() {
        $.fn.ifvmSubmitSearchCondition("notUsedProdSearchList", function () {
        	notUsedProdListNotGrid.searchGrid({
                item : requestitem
            });
        });
    }
    function programListSetting(){
        var ejGridOption = {
            serializeGridData : function( data ){
            	return data;
            },
            dataUrl : '<ifvm:action name="getAllowNotUseProdList"/>',
            columns: [
                {
                    field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
                    ,headerTextAlign : ej.TextAlign.Center,customAttributes : {index : 'prodId'  }//자재코드 
                }                  
                ,{
                    field : 'mmzzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
                    ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'mmzzItemCd' }//아이템코드
                
                }
                ,{
                    field : 'prodNm', headerText : '<spring:message code="E00105"/>', textAlign : ej.TextAlign.Left, width: 400
                    ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'prodNm'  }//자재이름
                }
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
                  sidx : '1',
                  sord : 'desc',
              },
            rowList : [10,25,50,100],
            radio: true,
            isHorizontalScroll : true,
            tempId : 'ifvGridSimplePageTemplete'

          };
        notUsedProdListNotGrid = $("#notUsedProdListNotGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    };
    
    
    $(document).ready(function() {
        programListSetting();

        notUsedProdListSearchInit();

        $("#btnNotUsedProdCancel").on('click', function(){
            $("#popupContainer_closebutton").trigger('click');
        }); 
        
        //조회
        $('#notUsedProdListSearchBtn').on('click', function(){
            notUsedProdListSearch();
        });

        //초기화
        $("#notUsedProdListSearchInitBtn").on('click', function(){
        	notUsedProdListSearchInit("notUsedProdListNotGrid");
        });
        
    });

</script>
