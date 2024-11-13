<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="chnlGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnChnlSave" objCode="stampBingoChnlSave_OBJ">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnChnlCancle" objCode="stampBingoChnlCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var ChnlListPop = function () {
	    var _rid = null;
	    var _ridStbg = ifvGlobal["stampBingoRid"];
	    this.getRid = function () {
	        return _rid;
	    },
        this.setRid = function (rid) {
            _rid = rid;
        },
        this.getRidStbg = function () {
            return _ridStbg;
         },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
                dataUrl: '<ifvm:action name="getChnlPopup"/>',
                columns: [
                    {
                        field: 'chnlNo',
                        headerText: '<spring:message code="L00128"/>',
                        textAlign : 'center',
                        customAttributes: { searchable: true }
                    }, {
                        field: 'chnlNm',
                        headerText: '<spring:message code="L00129"/>',
                        customAttributes: { searchable: true  }
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false,
                    }],
                requestGridData: {
                    sidx: 'chnlNo',
                },
                radio: true
            };
            $("#chnlGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnChnlSave").on('click', function () {
                this.saveAction();
    			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnChnlCancle").on('click', function () {
    			$.fn.ifvmPopupClose();
            }.bind(this));
        },
       /* Form 데이터 제출 */
        this.onSubmit = function () {

            var submitUrl = '<ifvm:action name="addStampBingoChnl"/>';

            /* 제출 후 알럿창 및 화면 이동*/
            var _afterSubmit = function () {
                alert('<spring:message code="L00127"/>');
                // 팝업 창 닫고
                $.fn.ifvmPopupClose();
                // 리스트 리로드
                ifvGlobal.stampBingoChnlGrid.setGridAndDataLoad();
            };

            $.ifvSyncPostJSON(submitUrl, { ridChnl : this.getRid(), ridStbg: this.getRidStbg() }, _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            this.onSubmit();
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
	    var chnlListPop = new ChnlListPop();
	    chnlListPop.init();
	});
</script>
