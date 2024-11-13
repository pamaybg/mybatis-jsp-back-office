<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<div class="page-title">
	    <h1>
	        <spring:message code="L02913" /> &gt; <spring:message code="M00273" /> 
	    </h1>
	</div>
	
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="L02914" /></span> 
	    </div>
	    <div class="col-sm-5 searchbtn_r">
	        <ifvm:inputNew type="button" btnType="plus" id="addNewGrp" text="V00002" objCode="addNewGrp_OBJ" />
	       <ifvm:inputNew type="button" id="modiGrp" text="M00259" objCode="modiGrp_OBJ" />
	        <ifvm:inputNew type="button" btnType="minus" id="delGrp" text="C00163" objCode="delGrp_OBJ" />
	    </div>
	</div>
	<div class="well form-horizontal well_bt5" id="termsGrpListGrid"></div>
</div>

<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="L02915" /></span>
	    </div>
	    <div class="col-sm-5 searchbtn_r">
	        <ifvm:inputNew type="button" btnType="plus" id="addGrpTerms" text="V00002" objCode="addGrpTerms_OBJ" />
	        <ifvm:inputNew type="button" id="modiGrpTerms" text="M00259" objCode="modiGrpTerms_OBJ" />
	        <ifvm:inputNew type="button" btnType="minus" id="delGrpTerms" text="C00163" objCode="delGrpTerms_OBJ" />
	    </div>
	</div>
	<div class="well form-horizontal well_bt5" id="termsListGrid"></div>
</div>

<div id="termsGrpListPopupContainer" class="popup_container"></div>
<div id="termsGrpModiListPopupContainer" class="popup_container"></div>

<div id="termsListPopupContainer" class="popup_container"></div>

<div id="termsGrpListTermsPopupContainer" class="popup_container"></div>


<script type="text/javascript">
   var rid;
   var ridTerms;
   var termsGrpCd
   var termsGrpCdGrid = null;



	// 약관그룹 조회 리스트
	function getTermsGrpList() {
	
	    var ejGridOption = {
	        serializeGridData : function(data) {
	            if ($.fn.ifvmIsNotEmpty(requestitem)) {
	                data.item = requestitem;
	            }
	            return data;
	        },
            rowSelected : function (args) {
                termsGrpCdGrid = args.data.termsGrpCd;
                getTermsList(termsGrpCdGrid);
          },
	        loadComplete : function(obj){
	            termsGrpListGrid.opt.gridControl.selectRows(0);
	        },
	        dataUrl : '<ifvm:action name="getTermsGrp"/>',
	        columns : [
	                {
	                    field : 'termsGrpCdNm', headerText : '<spring:message code="L02917"/>', textAlign : 'center',width:320,
	                    customAttributes: {index: 'termsGrpCd'}
	                }, {
	                    field : 'createBy', headerText : '<spring:message code="M00221"/>',  textAlign : 'center',width:123,
	                }, {
	                    field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center',width:127,
	                }, {
	                    field : 'modifyBy', headerText : '<spring:message code="L01604"/>', textAlign : 'center',width:141,
	                },{
	                    field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center',width:127,
	                }
	         ],
	        requestGridData : {
	            nd : new Date().getTime(),
	            rows : 10,
	            sidx : 'createDate',
	            sord : 'asc',
	            _search : false
	        },
	        rowList : [ 10, 25, 50, 100 ],
	        radio : true,
	        tempId : 'ifvGridNotSearchTemplete',
	    };
	
	    termsGrpListGrid = $("#termsGrpListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	}
	
    // 약관그룹에 해당하는 목록 조회 리스트
	function getTermsList(termsGrpCdGrid) {

	    var ejGridOption = {
	        serializeGridData : function(data) {
	            data.termsGrpCd = termsGrpCdGrid;
	            return data;
	        },
	        rowSelected : function (args) {
	            rid = args.data.rid;
				ridTerms = args.data.termRid;
	        },
	        loadComplete : function(obj){
	            //termsListGrid.opt.gridControl.selectRows(0);
	        },
	           dataUrl : '<ifvm:action name="getTermsGrpTermsList"/>',
	        columns :           [ 
	            {
	                field : 'termsNo', headerText : '약관순서', textAlign : 'center',width:64,
	                customAttributes: {index: 'termsNo'}, format : '{0:n0}'
	            }
	            ,{
                field : 'termsType', headerText : '<spring:message code="L02323"/>', textAlign : 'center',width:64,
                customAttributes: {index: 'termsTypeCd'}
            }
            , {
                field : 'termsNm', headerText : '<spring:message code="L02324"/>', textAlign : 'center',width:215, 
                customAttributes: {index: 'termsTypeSubCd'}
            }
            , {
                field : 'statCdNm', headerText : '<spring:message code="C00125"/>', textAlign : 'center',width:64,
                customAttributes: {index: 'statCd'}
            }, {
                field : 'createBy', headerText : '<spring:message code="M00221"/>',  textAlign : 'center',width:123,
            }, {
                field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center',width:127,
            }, {
                field : 'modifyBy', headerText : '<spring:message code="L01604"/>', textAlign : 'center',width:141,
            },{
                field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center',width:127,
            }
            , {
                field : 'rid', headerText : 'rid', visible : false,
            }
            , {
                field : 'termRid', headerText : 'termRid', visible : false,
            } ],
	        requestGridData : {
	            nd : new Date().getTime(),
	            rows : 10,
	            sidx : 'termsNo,termsTypeSubCd',
	            sord : 'asc',
	            _search : false
	        },
	        rowList : [ 10, 25, 50, 100 ],
	        radio : true,
	        tempId : 'ifvGridNotSearchTemplete'
	    };
	
	    termsListGrid = $("#termsListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	}
    
    function addNewGrpPop(){
        $("#termsGrpListPopupContainer").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="termsGrpPop"/>',
            contentType: "ajax",
            title: '<spring:message code="L02918"/>',
            width: 600,
            close : 'termsGrpPopupClose',
            open : function(){
                new ifvm.PopupCenter({
                    popupDivId : 'popupContainer'
                })
            }
        });
    }
    function termsGrpPopupClose() {
        termsGrpListPopupContainer._destroy();
    } 
    
    function modNewGrpPop(){
        if(termsGrpListGrid.opt.gridControl.getSelectedRecords()[0] != null){ 
            termsGrpCd = termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd;
	        $("#termsGrpModiListPopupContainer").ifvsfPopup({
	            enableModal : true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="termsGrpModPop"/>',
	            contentType: "ajax",
	            title: '<spring:message code="L02921"/>',
	            width: 600,
	            close : 'termsModGrpPopupClose',
	            open : function(){
	                new ifvm.PopupCenter({
	                    popupDivId : 'popupContainer'
	                })
	            }
	        });
        } else {
            alert('<spring:message code="M01051"/>');
        }
    }
    function termsModGrpPopupClose() {
        termsGrpModiListPopupContainer._destroy();
    } 
    
    function delGrpFun(){
        var v_rid;
        if ($.fn.ifvmIsNotEmpty(termsGrpListGrid.opt.gridControl.getSelectedRecords()[0])) {
            v_rid = termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd;
        }
        else {
            alert('<spring:message code="M00104"/>');
        }
        if ($.fn.ifvmIsNotEmpty(v_rid)) {
            if( confirm('<spring:message code="I01500"/>') == true ){
					 $.ifvSyncPostJSON('<ifvm:action name="deleteTermsGrp"/>', {
					           termsGrpCd : termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd
					  }, function(result) {
					           getTermsGrpList();
					           termsGrpListGrid.opt.gridControl.selectRows(0);
					           termsListGrid.opt.gridControl.selectRows(0);
					  });
		        }
          } else {
              alert('<spring:message code="M01051"/>');
          }
    }
    
    function addNewGrpTermsPop() {
        if(termsGrpListGrid.opt.gridControl.getSelectedRecords()[0] != null){ 
            $("#termsGrpListTermsPopupContainer").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="termsGrpListPop"/>',
                contentType: "ajax",
                title: '<spring:message code="L02919"/>',
                width: 600,
                close : 'termsGrpListPopPopupClose',
                open : function(){
                    new ifvm.PopupCenter({
                        popupDivId : 'popupContainer'
                    })
                }
            });
        } else {
            alert('<spring:message code="M01051"/>');
        }
    }
    
    function termsGrpListPopPopupClose() {
        termsGrpListTermsPopupContainer._destroy();
    }
    
    function modiGrpTermsPop() {
        if(termsListGrid.opt.gridControl.getSelectedRecords()[0] != null){
            termsGrpCd = termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd;
            $("#termsGrpModiListPopupContainer").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="termsGrpListModPop"/>',
                contentType: "ajax",
                title: '<spring:message code="L02920"/>',
                width: 600,
                close : 'termsModGrpPopupClose',
                open : function(){
                    new ifvm.PopupCenter({
                        popupDivId : 'popupContainer'
                    })
                }
            });
        } else {
            alert('<spring:message code="M01051"/>');
        }
    }    
    
    function termsGrpModiListPopupClose() {
        termsGrpModiListPopupContainer._destroy();
    } 
    
    function delGrpTermsFun() {
        var v_rid;
        if ($.fn.ifvmIsNotEmpty(termsListGrid.opt.gridControl.getSelectedRecords()[0])) {
            v_rid = termsListGrid.opt.gridControl.getSelectedRecords()[0].rid;
        }
        else {
            alert('<spring:message code="M00104"/>');
        }
        if ($.fn.ifvmIsNotEmpty(v_rid)) {
            if( confirm('<spring:message code="I01500"/>') == true ){
		            termsGrpCd = termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd;
		            $.ifvSyncPostJSON('<ifvm:action name="deleteGrpTerms"/>', {
		                ridTerms : termsListGrid.opt.gridControl.getSelectedRecords()[0].rid
		                ,termsGrpCd : termsGrpCd
		            }, function(result) {
		                getTermsList(termsGrpCd)
		                termsListGrid.opt.gridControl.selectRows(0);
		            });
            }
        } else {
            alert('<spring:message code="M01051"/>');
        }
        if(termsListGrid.opt.gridControl.model.dataSource[0] == null){
            getTermsGrpList();
         }
    }
    
	$(document).ready(function() {
	    
	    getTermsGrpList();
	    getTermsList();
	    //신규 그룹
	    $("#addNewGrp").on('click', function() {
	        addNewGrpPop();
	    });
	    
	    //수정 그룹
        $("#modiGrp").on('click', function() {
            modNewGrpPop();
        });
	    
	    //삭제 그룹
	    $("#delGrp").on('click', function() {
            delGrpFun();
	    });
	    
	    //신규 약관
        $("#addGrpTerms").on('click', function() {
            addNewGrpTermsPop();
        });
	    
        //수정 약관
        $("#modiGrpTerms").on('click', function() {
            modiGrpTermsPop();
        });
        
        //삭제 약관
        $("#delGrpTerms").on('click', function() {
            delGrpTermsFun();
        });
	       
	});
</script>