<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="cardTypeGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnCardTypeSelect" objCode="cardTypeListSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCardTypeCancle" objCode="cardTypeListCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var CardTypeListPop = function () {
	    var _cardTypeRid = null;
	    var _cardTypeNm = null;

	    this.getCardTypeRid = function () {
	        return _cardTypeRid;
	    },
        this.setCardTypeRid = function (cardTypeRid) {
            _cardTypeRid = cardTypeRid;
        },
        this.getCardTypeNm = function () {
            return _cardTypeNm;
        },
        this.setCardTypeNm = function (cardTypeNm) {
            _cardTypeNm = cardTypeNm;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {

            var _serializeGridData = function (data) {
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setCardTypeRid(_data.rid);
                this.setCardTypeNm(_data.cardKindNm);
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData,
                rowSelected: _rowSelected.bind(this),
                dataUrl: '<ifvm:action name="getCardTypeList"/>',
                columns: [
                    {
                        field: 'cardKindNo',
                        headerText: '<spring:message code="M02110"/>',
                        width: '80px', textAlign : 'center',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'cardKindNm',
                        headerText: '<spring:message code="L00415"/>',
                        width: '200px', textAlign : 'center',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'cardTypeNm',
                        headerText: '<spring:message code="M02111"/>',
                        width: '100px', textAlign : 'center',
                        customAttributes :{index : 'cardType'}
                    }, {
                       field: 'makeTypeNm',
                       headerText: '<spring:message code="M02112"/>',
                       width: '70px', textAlign : 'center',
                       customAttributes :{index : 'makeType'}
                    }, {
                        field: 'createBy',
                        headerText: '<spring:message code="O00012"/>',
                        width: '100px', textAlign : 'center',
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="O00013"/>',
                        width: '120px', textAlign : 'center',
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false,
                   }],
                requestGridData: {
                    sidx: 'cardKindNo',
                },
                radio: true
            }
            this.cardTypeGridOptions = $("#cardTypeGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnCardTypeSelect").on('click', function () {
                var targetFields = ifvGlobal.searchHelp.field;
                var cardTypeRid = this.getCardTypeRid();
                var cardTypeNm = this.getCardTypeNm();

                $('#' + targetFields.rid).val(cardTypeRid);
                $('#' + targetFields.name).val(cardTypeNm);
            	$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnCardTypeCancle").on('click', function () {
            	$.fn.ifvmPopupClose();
            }.bind(this));
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
	    var cardTypeListPop = new CardTypeListPop();
	    cardTypeListPop.init();
	});
</script>
