<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="prodGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnProdSelect" objCode="">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnProdCancle" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var prodListPop = function () {
	    var _prodRid = null;
	    var _prodNm = null;
	    var _prodId = null;

	    this.getProdRid = function () {
	        return _prodRid;
	    },
        this.setProdRid = function (prodRid) {
	    	_prodRid = prodRid;
        },
        this.getProdNm = function () {
            return _prodNm;
        },
        this.setProdNm = function (prodNm) {
        	_prodNm = prodNm;
        },
        this.getProdId = function () {
            return _prodId;
        },
        this.setProdId = function (prodId) {
        	_prodId = prodId;
        },


        /* 그리드 생성 */
        this.setProdGridDataLoad = function () {

            var _rowSelected = function (args) {
                var data = args.data;
                this.setProdRid(data.rid);
                this.setProdNm(data.prodNm);
                this.setProdId(data.prodId);
            };

            var _getSearchCond = function() {
                if (typeof ifvGlobal.searchHelp !== 'undefined' && typeof ifvGlobal.searchHelp.searchCond !== 'undefined' ) {
                    $.extend(ejGridOption.requestGridData, ifvGlobal.searchHelp.searchCond);
                    delete ifvGlobal.searchHelp.searchCond;
                }
            }


            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                    return data;
                },recordDoubleClick : function(args){
                    var data = args.data;
                    $('#prodNm').val(data.prodNm);
                    $('#prodRid').val(data.rid);
                    $('#prodId').val(data.prodId);
        			$.fn.ifvmPopupClose();
               	},
                dataUrl: '<ifvm:action name="getProdListPop"/>',
                columns : [
   				 {
   		      		  field : 'prodId', headerText :'<spring:message code="M02124" />' , headerTextAlign : 'center', textAlign : 'left', width: '100px',customAttributes :{searchable : true},
   		      	  },{
   		    		  field : 'prodNm', headerText : '<spring:message code="L00232"/>', headerTextAlign : 'center', textAlign : 'center', width: '150px',customAttributes :{searchable : true},

   		    	  },{
   		    		  field : 'prodAmt', headerText : '<spring:message code="M02125"/>', headerTextAlign : 'center', textAlign : 'center', width: '80px',

   		    	  },{
   		    		  field : 'brdNm', headerText : '<spring:message code="L00290"/>', headerTextAlign : 'center', textAlign : 'center', width: '150px',

   		    	  },{
   		    		  field : 'catNm', headerText : '<spring:message code="L00291"/>', headerTextAlign : 'center', textAlign : 'center',width: '140px',

   		    	  },{
   		    		  field : 'chnlNm', headerText : '<spring:message code="L00288"/>', headerTextAlign : 'center', textAlign : 'center', width: '150px',

   		    	  },{
   		    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
   		    	  }
   		    	  ],
   		          requestGridData : {
   		        	  sidx : 'lp.create_date',
   		        	  sord : 'desc'
   		          },
                radio: true
            };
            _getSearchCond();
            $("#prodGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.prodSetButtons = function () {
            $("#btnProdSelect").on('click', function () {
                $('#prodNm').val(this.getProdNm());
                $('#prodRid').val(this.getProdRid());
                $('#prodId').val(this.getProdId());
                this.prodPopupClose();
            }.bind(this));

            $("#btnProdCancle").on('click', function () {
                this.prodPopupClose();
            }.bind(this));
        },
        this.prodPopupClose = function () {
        	$.fn.ifvmPopupClose();
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setProdGridDataLoad();
            this.prodSetButtons();
        }
	};

	$(document).ready(function () {
	    var prodListPopObj = new prodListPop();
	    prodListPopObj.init();
	});
</script>
