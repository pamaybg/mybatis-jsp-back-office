<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var prodListGrid;
var id = diagram._selectedObject.actualTaskId;
//조회결과 그리드
function prodListGridFn() {

    var ejGridOption = {
        serializeGridData : function( data ) {
        		data.id = id;
            return data;
        },
        dataUrl: '<ifvm:action name="mktGetProdList"/>',
        columns:[
        	  {
	      		  field : 'prodNo', headerText : '<spring:message code="L00200"/>', width:'80px', textAlign : 'center',
	      		  customAttributes : {
	      			  index:'cp.PROD_NO',
	      			  searchable: true
	      		}
	      	  }, {
	      		  field : 'prodNm', headerText : '<spring:message code="L00232"/>', width:'140px',
	      		  customAttributes : {
	      			  index:'lp.PROD_NM',
	      			  searchable: true
	      			  
	      		}
	      	  }, {
	      		  field : 'catNm', headerText : '<spring:message code="L00291"/>', width:'60px',textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'pc.CAT_NM' }
	      	  }, {
	      		  field : 'chnlNm', headerText : '<spring:message code="L00565"/>', width:'60px',textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NM' }
	      	  }, {
	      		  field : 'id', headerText : 'id', visible : false
	      	  },
        ],
        requestGridData : {
          	 nd   : new Date().getTime(),
	    	 rows : 10,
	    	 sidx : 'cp.create_date',
	    	 sord : 'desc',
	    	 _search : false
	        },
		radio: true,
		rowList : [10,25,50,100],
        tempId : 'ifvGridOriginTemplete'
    };
    prodListGrid = $("#prodListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


function prodNewPopupOpen(){
	 var itCondition = [];
	    var obj = null;

	    gProdTree ={
	        id : "prodNewPopDialog",
	        fillter : obj
	    };
	    gProdTree.pop = $('#'+gProdTree.id).ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="mktAddProdPop"/>',
	        contentType: "ajax",
	        title: '상품목록',
	        width: 700,
	        close : 'prodNewPopClose'
	    });
}

function prodNewPopClose(){
	prodNewPopDialog._destroy();
}
function prodPopupClose(){
	 cDialog._destroy();
}
//상품 선택
function prodTreeSelect(){
	 var array = $('#prodTree').jstree('get_selected')
	    ,obj = [];

	 	if(array.length==0){
	 		alert("등록할 상품을 선택하여 주세요!");
	 		return;
	 	}
	 	
		for ( var i=0 ; i < array.length ; i++){
	    	 var node = $('#prodTree').jstree(true).get_node(array[i]);
	    	 var type = node.original.type;
	    	 
	    	 if(type=='P'){
	    		obj.push({
	    			prodId: node.original.prodId,
	    			id:node.original.id
	    		});
	    	 }
		}
		
		if (obj.length > 0) {
			$.ifvSyncPostJSON('<ifvm:action name="saveCampaignProd"/>', {
				camId: id,
				prodList: obj
			} ,function(result) {
						alert('<spring:message code="M00623"/>');
						prodListGridFn();
						prodNewPopClose();
					});
		}
	    
}

$(document).ready(function() {
    $("#dialog_title").append('상품 정보');
	prodListGridFn();

	  //신규버튼
    $('#prodNewBtn').on('click', function(){
    	prodNewPopupOpen();    		
    });
	
	
    // 삭제
    $('#prodDeleteBtn').on('click', function(){
        if (prodListGrid.opt.gridControl.getSelectedRecords().length==0) {
            // 목록을 선택하세요
            alert('<spring:message code="M01051"/>');
        }
        else {
            // 삭제하시겠습니까?
            if (confirm('<spring:message code="M01053"/>')) {

                var checkId = null;
                $(prodListGrid.opt.gridControl.getSelectedRecords()).each(function(index, item) {
                    checkId = item.id;
                });

                $.ifvSyncPostJSON('<ifvm:action name="removeProd"/>', {
                    id : checkId
                }, function(result) {
                    alert('<spring:message code="M01049"/>');
                    prodListGridFn();
                });
            }
        }
    });
    
    // 삭제
    $('#prodDeleteAllBtn').on('click', function(){
            // 삭제하시겠습니까?
            if (confirm('<spring:message code="M01053"/>')) {
                $.ifvSyncPostJSON('<ifvm:action name="removeAllProd"/>', {
                    id : id
                }, function(result) {
                    alert('<spring:message code="M01049"/>');
                    prodListGridFn();
                });
            }
    });

});

</script>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap">
		<div>
			<div class="page_btn_area">
				<div class="col-xs-12 searchbtn_r">
					<button class="btn btn-sm" id="prodNewBtn" objCode="prodNewBtn_OBJ">
						<spring:message code="M00274" />
					</button>
					<button class="btn btn-sm" id="prodDeleteBtn" objCode="prodDeleteBtn_OBJ">
						<spring:message code="M00165" />
					</button>
					<button class="btn btn-sm" id="prodDeleteAllBtn" objCode="prodDeleteAllBtn_OBJ">
						<spring:message code="O00082" />
					</button>
				</div>
			</div>
			<div id="prodListGrid" class="grid_bd0"></div>
		</div>
	</div>
	<div class="pop_btn_area">
	<ifvm:inputNew 
        type="button"
        btnType="cancel"
        text="닫기"
        id="prodPopupClose"
        nuc="true"
        btnFunc="prodPopupClose"
	/>
</div>
</div>
<div id="prodNewPopDialog" class="popup_container"></div>