<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    .main_sub_grids {
        padding-left: 20px;
    }
</style>

<!-- 타이틀 -->
<div class="page-title">
    <h1>
        <spring:message code="O00187"/>
        &gt; <spring:message code="L00030"/>
    </h1>
</div>

<!-- 조회조건 및 버튼영역 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <!-- 조회버튼 / 초기화버튼 -->
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="operationPolicySearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="operationPolicyInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pgmSearchList"></div>
</div>

<!-- 조회결과가 뜨는 본문 영역 -->
<div>
    <div>
        <!-- [메인 그리드] -->
        <div class="page_btn_area">
            <!-- 조회 결괴 -->
            <div class="col-xs-7">
                <span><spring:message code="M00277"/></span>
            </div>
            <!-- 신규버튼 / 삭제버튼 -->
            <div class="col-xs-5 searchbtn_r">
                <ifvm:inputNew type="button" btnType="plus" text="M01852" id="addBtn_mg" objCode="operationPolicyAdd_OBJ"/>
                <ifvm:inputNew type="button" text="수정" id="updateBtn_mg" objCode="operationPolicyUpdate_OBJ"/>
                <ifvm:inputNew type="button" btnType="minus" text="M01854" id="deleteBtn_mg" objCode="operationPolicyDelete_OBJ"/>
            </div>
        </div>
        <!-- 메인그리드 화면이 담기는 div컨테이너-->
        <div id="pgmList" class="main_sub_grids"></div>

        <!-- [서브그리드1] -->
        <div class="page_btn_area">
            <!-- 조회 결괴 -->
            <div class="col-xs-7">
                <span><spring:message code="O00170"/></span>
            </div>
            <!-- 신규버튼 / 삭제버튼 -->
            <div class="col-xs-5 searchbtn_r">
                <ifvm:inputNew type="button" btnType="plus" text="M01852" id="addBtn_sg1" objCode="operationPolicyAddSg_OBJ"/>
                <ifvm:inputNew type="button" text="수정" id="updateBtn_sg1" objCode="operationPolicyUpdateSg_OBJ"/>
                <ifvm:inputNew type="button" btnType="minus" text="M01854" id="deleteBtn_sg1" objCode="operationPolicyDeleteSg_OBJ"/>
                <ifvm:inputNew type="button" text="이력" id="histBtn_sg1" objCode="operationPolicyHistSg_OBJ"/>
            </div>
        </div>
        <!-- 서브 그리드 1 화면이 담기는 div컨테이너 -->
        <div id="pgmList_sub_1" class="main_sub_grids"></div>

        <!-- [서브그리드2] -->
        <div class="page_btn_area">
            <!-- 조회 결괴 -->
            <div class="col-xs-7">
                <span><spring:message code="O00171"/></span>
            </div>
            <!-- 신규버튼 / 삭제버튼 -->
            <div class="col-xs-5 searchbtn_r">
                <ifvm:inputNew type="button" btnType="plus" text="M01852" id="addBtn_sg2" objCode="operationPolicyAddSg2_OBJ"/>
                <ifvm:inputNew type="button" text="수정" id="updateBtn_sg2" objCode="operationPolicyUpdateSg2_OBJ"/>
                <ifvm:inputNew type="button" btnType="minus" text="M01854" id="deleteBtn_sg2" objCode="operationPolicyDeleteSg2_OBJ"/>
                <ifvm:inputNew type="button" text="이력" id="histBtn_sg2" objCode="operationPolicyHistSg2_OBJ"/>
            </div>
        </div>
        <!-- 서브 그리드 2 화면이 담기는 div컨테이너 -->
        <div id="pgmList_sub_2" class="main_sub_grids"></div>

        <!-- 신규 팝업 -->
        <div id="addPopContainer" class="popup_container"></div>
        <!-- 수정 팝업 -->
        <div id="updatePopContainer" class="popup_container"></div>
        <!--  이력 팝업 1  -->
        <div id="histPop1" class="popup_container"></div>
        <!--  이력 팝업 2  -->
        <div id="histPop2" class="popup_container"></div>
        <!-- 기타 각종 팝업 컨테이너 -->
        <div id="commonPopContainer" class="popup_container"></div>
    </div>
</div>


<script type="text/javascript">
    // 각 그리드 별 전역 rid값
    var mgRid = null;
    var sg1Rid = null;
    var sg2Rid = null;
    // 메인그리드를 담는 변수
    var mainGridList = null;
    // 서브그리드 1,2를 담는 변수(정책속성값그리드, 세부사항그리드)
    var subGrid1List = null;
    var subGrid2List = null;
    // 서브그리드1,2에서 신규/수정 등의 작용이 일어날 때 마다 이 사항들이 저장되는 LOY_OPR_PLCY_DTL_HIST테이블에서, 저장되는 데이터의 원래 rid값을 담아두는 변수(HIST테이블의 row의 rid가 아닌, 그 row에 적혀있는 데이터들의 원래 rid값)
    var oprDtlRid = null;
    // 어느 서브그리드인지 구분하는 flag변수  ex) sg1 인지, sg2 인지 ... etc
    var sgFlag = null;
    // '운영정책명'에 대한 전역변수
    var plcyCd = null;


    // 운영정책 신규추가 팝업창
    function addOprPlcyPopup() {
        $.fn.ifvmSearchHelpOpen(null, null, 'addPopContainer', '<ifvm:url name="addOperationPolicyPop"/>', '운영정책등록');
    }

    function addPopClose() {
        addPopContainer._destroy();
        mainGridList.opt.gridControl.selectRows(data.rowIndex);
    }

    // 운영정책 수정팝업창
    function updateOprPlcyPopup() {
        if (mgRid == null) {
            alert('수정할 운영정책 항목을 선택해주세요.');
        } else {
            $.fn.ifvmSearchHelpOpen(mgRid, null, 'updatePopContainer', '<ifvm:url name="updateOperationPolicyPop"/>', '운영정책수정');
        }
    }

    function updatePopClose() {
        updatePopContainer._destroy();
    }

    // 운영정책 삭제팝업창
    function deleteOprPlcyPopup(mgRid) {
        var answer = confirm("해당 데이터를 정말 삭제하시겠습니까?");
        if (answer == true) {
            //삭제
            var url = '<ifvm:action name="deleteOperationPolicy"/>';
            var varData = null;
            varData = {
                rid: mgRid
            };

            $.ifvSyncPostJSON(url, varData, function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    alert('<spring:message code="삭제가 완료되었습니다"/>');
                }
            }, function (result) { // 실패했을 경우
                if (result.message != null) // 메세지 있으면 메세지 표사
                    alert(result.message);
                else						// 메세지도 없으면 그냥 실패 메세지 표시
                    alert('<spring:message code="M02248"/>');
            });
            // 새로고침
            mainGridList._doAjax();
        } else {
            return;
        }
    }// end deleteOprPlcyPopup

    // [서브그리드1,2의 신규/수정/삭제 함수: 1,2 모두 본 함수를 사용한다]
    function addOprPlcyDetailPopup(ridOpr, parRid) {
        // 파라미터로 받은 mgRid값은 운영정책상세테이블에서 rid_opr값이 됨.
        var ridOpr = ridOpr;
        var parRid = parRid;
        var data = {
            ridOpr: ridOpr,
            parRid: parRid
        };

        var popupTitle = null;
        if (sgFlag == 'sg2') {
            popupTitle = '세부속성 등록';
        } else if (sgFlag == 'sg1') {
            popupTitle = '정책속성값 등록';
        }

        $.fn.ifvmSearchHelpOpen(data, null, 'addPopContainer', '<ifvm:url name="addOperationPolicyDetailPop"/>', popupTitle);
    }// addOprPlcyDetailPopup로 생긴 팝업창의 닫기는, addOprPlcyPopup를 닫는 addPopClose를 동일하게 사용한다.

    function sgUpdatePopBySgFlag(sgFlag) {
        if (sgFlag == 'sg1') {
            if (sg1Rid == null) {
                alert('수정할 정책속성값 항목을 선택해주세요.');
            } else {
                var popupTitle = '정책속성값 수정';
                $.fn.ifvmSearchHelpOpen(sg1Rid, null, 'updatePopContainer', '<ifvm:url name="updateOperationPolicyDetailPop"/>', popupTitle);
            }
        } else if (sgFlag == 'sg2') {
            if (sg1Rid != null && sg2Rid != null) { // 세부사항그리드 수정가능 조건 - '정책속성값그리드 rid값과 세부사항그리드 rid값 둘 다 존재하고 있을 경우'
                var popupTitle = '세부사항 수정';
                $.fn.ifvmSearchHelpOpen(sg2Rid, null, 'updatePopContainer', '<ifvm:url name="updateOperationPolicyDetailPop"/>', popupTitle);
            } else {
                alert('수정할 세부사항 항목을 선택해주세요.');
            }
        }
    }//end sgUpdatePopBySgFlag

    // 수정 팝업 열기
    function updateOprPlcyDetailPopup() {
        if (sgFlag == 'sg1') {
            sgUpdatePopBySgFlag('sg1');
        } else if (sgFlag == 'sg2') {
            sgUpdatePopBySgFlag('sg2');
        }
    }// updateOprPlcyDetailPopup로 생긴 팝업창의 닫기는, updateOprPlcyPopup를 닫는 updatePopClose를 동일하게 사용한다.

    function deleteOprPlcyDetailPopup(sgRid) {
        /*
        * 매개변수 sgRid
        *: sg1Rid 일 수도 있고, sg2Rid일 수도 있음
        *  어차피 서브그리드 1,2의 내용(정책속성값항목, 세부사항 항목) 데이터들은 같은 테이블 LOY_OPR_PLCY_DTL에 들어있음
        *  따라서 각 row의 rid에 따라 논리삭제처리 되도록, 호출 시 투입한 sgRid가 이용되어 처리가 이루어진다.
        */
        var answer = confirm("해당 데이터를 정말 삭제하시겠습니까?");
        if (answer == true) { //삭제
            var url = '<ifvm:action name="deleteOperationPolicyDetail"/>';
            var varData = {
                rid: sgRid
            };
            $.ifvSyncPostJSON(url, varData, function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    alert('<spring:message code="삭제가 완료되었습니다"/>');
                }
            }, function (result) { // 실패했을 경우
                if (result.message != null) // 메세지 있으면 메세지 표사
                    alert('error: ' + result.message);
                else						// 메세지도 없으면 그냥 실패 메세지 표시
                    alert('<spring:message code="M02248"/>');
            });
            // 새로고침
            if (sgFlag == 'sg1') {
                subGrid1List._doAjax();
                // 한 그리드 리스트를 새로고침해주면, 그 그리드리스트의 하위 그리드리스트 역시 (새로고침격으로)초기화 해주어야 하므로 초기상태 그리드로 만들어준다.
                callSubGrid2List(null, null);
            } else if (sgFlag == 'sg2') {
                subGrid2List._doAjax();
            }

        } else {
            return;
        }
    }// end deleteOprPlcyDetailPopup

    // 서브그리드1(정책속성값 그리드)에서 '이력'창을 여는 함수
    function histPopup1(rid) {
        var subGrid1ClickedRowRid = rid;

        if (subGrid1ClickedRowRid == null) {	// 클릭된 항목은 있는데 rid가 제대로 넘어오지 않았을 경우 => 다시 한번 항목을 클릭하라고 한다(rid제대로 넘어오도록)
            alert('<spring:message code="목록을 다시 한번 선택해주세요"/>'); // I00728: '목록을 선택해주세요'
            return;
        }
        var url = '<ifvm:url name="oprDtlHist"/>';
        url += '?subGrid1ClickedRowRid=' + subGrid1ClickedRowRid;

        $("#histPop1").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: url, // road
            contentType: "ajax",
            title: '정책속성값 이력',
            width: 1000,
            close: 'oprDtlHist1PopupClose'
        });
    }

    // 서브그리드2(세부사항 그리드)에서 '이력'창을 여는 함수
    function histPopup2(rid) {
        var subGrid2ClickedRowRid = rid;

        if (subGrid2ClickedRowRid == null) {	// 클릭된 항목은 있는데 rid가 제대로 넘어오지 않았을 경우 => 다시 한번 항목을 클릭하라고 한다(rid제대로 넘어오도록)
            alert('<spring:message code="목록을 다시 한번 선택해주세요"/>'); // I00728: '목록을 선택해주세요'
            return;
        }
        var url = '<ifvm:url name="oprDtlHist"/>';
        url += '?subGrid2ClickedRowRid=' + subGrid2ClickedRowRid;

        $("#histPop2").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: url, // road
            contentType: "ajax",
            title: '세부속성 이력',
            width: 1000,
            close: 'oprDtlHist2PopupClose'
        });
    }

    function oprDtlHist1PopupClose() {
        histPop1._destroy();
    }

    function oprDtlHist2PopupClose() {
        histPop2._destroy();
    }

    function removeRowPopupClose() {
        removePop._destroy();
    }

    // 모든 그리드들의 '신규,수정,삭제' 버튼 설정 (메인그리드,서브그리드1,서브그리드2)
    function setMgButtons() {
        $('#addBtn_mg').click(function () {
            addOprPlcyPopup();
        });
        $('#updateBtn_mg').click(function () {
            if (mgRid == null) {
                alert('수정할 운영정책 항목을 선택해주세요');
            } else {
                // 메인그리드(운영정책 부분 그리드)는 혼자만 사용하는 양식으로 되어있기 때문에, (서브그리드 경우처럼)그리드 구분용 flag가 필요 없음.
                updateOprPlcyPopup();
            }
        });
        $('#deleteBtn_mg').click(function () {
            /* 운영정책 항목 제거(논리삭제) 실행 */
            if (mgRid == null) {
                alert('삭제할 운영정책 항목을 선택해주세요');
            } else {
                deleteOprPlcyPopup(mgRid);
            }
        });

    }

    function setSg1Buttons() {
        $('#addBtn_sg1').click(function () {
            if (mgRid == null) {
                alert('운영정책항목을 선택하세요');
            } else {
                sgFlag = 'sg1';
                addOprPlcyDetailPopup(mgRid, null);
            }
        });
        $('#updateBtn_sg1').click(function () {
            if (sg1Rid == null) {
                alert('수정할 정책속성값 항목을 선택해주세요.');
            } else {
                sgFlag = 'sg1';
                updateOprPlcyDetailPopup();
            }
        });
        $('#deleteBtn_sg1').click(function () {
            if (sg1Rid == null) {
                alert('삭제할 정책속성값 항목을 선택해주세요.');
            } else {
                sgFlag = 'sg1';
                deleteOprPlcyDetailPopup(sg1Rid);
            }
        });
        $('#histBtn_sg1').click(function () {
            if (subGrid1List.opt.gridControl.getSelectedRecords()[0] == null) {
                alert('항목을 선택해주세요');
                return;
            }
            sgFlag = 'sg1';
            var subGrid1ClickedRowRid = subGrid1List.opt.gridControl.getSelectedRecords()[0].rid;
            histPopup1(subGrid1ClickedRowRid);
        });
    }

    function setSg2Buttons() {
        $('#addBtn_sg2').click(function () {
            if (sg1Rid == null) {
                alert('정책속성값 항목을 먼저 선택해주세요.');
            } else {
                sgFlag = 'sg2'; // 서브그리드2 의 상황이다
                addOprPlcyDetailPopup(mgRid, sg1Rid);
            }
        });
        $('#updateBtn_sg2').click(function () {
            if (sg2Rid == null) {
                alert('수정할 세부사항 항목을 먼저 선택해주세요.');
            } else {
                sgFlag = 'sg2';
                updateOprPlcyDetailPopup();
            }
        });
        $('#deleteBtn_sg2').click(function () {
            if (sg2Rid == null) {
                alert('삭제할 세부사항 항목을 먼저 선택해주세요.');
            } else {
                sgFlag = 'sg2';
                deleteOprPlcyDetailPopup(sg2Rid);
            }
        });

        $('#histBtn_sg2').click(function () {
            if (subGrid2List.opt.gridControl.getSelectedRecords()[0] == null) {
                alert('항목을 선택해주세요');
                return;
            }
            sgFlag = 'sg2';
            var subGrid2ClickedRowRid = subGrid2List.opt.gridControl.getSelectedRecords()[0].rid;
            histPopup2(subGrid2ClickedRowRid);
        });
    }


    //서브그리드 1 호출 함수
    function callSubGrid1List(mgRid) {
        var ridOpr = mgRid;	// 서브그리드1의 내용 호출에 필요한 rid값

        var ejGridOption = {
            serializeGridData: function (data) {
                data.ridOpr = ridOpr;
                return data;
            },
            loadComplete: function (obj) {
                subGrid1List.opt.gridControl.selectRows(0);
            },
            rowSelected: function (args) { // 서브그리드 1의 row가 클릭될 시 => 이에 대응되는 서브그리드2의 내용들 호출된다
                sg1Rid = args.data.rid;    // 서브그리드1의 row의 rid값
                sg2Rid = null;			   // 서브그리드1의 row의 매 선택이 일어날 때마다, 기존에 있던 sg2Rid같은 rid값은 null로 초기화 (//기존에 서브그리드2의 row를 선택했을 때 초기화되어 있던 sg2Rid값 등을 (값이 남아있을 경우를 대비해) null로 초기화)
                oprDtlRid = args.data.rid; // 서브그리드1의 (선택된)row에 대한 '이력'정보를 얻을 때 필요한 rid값을, oprDtlRid에 초기화해둔다.
                // 서브그리드1 row클릭 시 => 서브그리드2도 호출된다
                callSubGrid2List(sg1Rid, ridOpr);
            },
            dataUrl: '<ifvm:action name="getOperationPolicyDetail1"/>',
            allowResizing: false,
            columns: [
                {field: 'attrCdNm', headerText: '속성명', width: '100px', textAlign: 'center', customAttributes: {searchable: true, index: 'T.attr_Cd_Nm'}}
                , {field: 'dataTypeNm', headerText: '데이터유형', width: '80px', textAlign: 'center', customAttributes: {searchable: true, index: 'T.data_Type_Nm'}}
                , {field: 'dataValMarkNm', headerText: '값', width: '200px', customAttributes: {searchable: true, index: 'T.data_Val_Mark_Nm'}}
                , {field: 'contents', headerText: '설명', width: '200px'}
                , {field: 'singleValYn', headerText: '단일값여부', width: '60px', textAlign: 'center', customAttributes: {searchable: true, index: 'T.single_Val_Yn'}}
                , {field: 'useYn', headerText: '사용여부', width: '60px', textAlign: 'center'}
                , {field: 'createBy', headerText: '등록자', width: '75px', textAlign: 'center'}
                , {field: 'createDate', headerText: '등록일', width: '80px', textAlign: 'center'}
                , {field: 'modifyBy', headerText: '수정자', width: '75px', textAlign: 'center'}
                , {field: 'modifyDate', headerText: '수정일', width: '80px', textAlign: 'center'}
                , {field: 'rid', headerText: 'rid', visible: false}
            ],
            // 그리드 리스트에 출력되는 데이터들의 정렬(order by)기준
            requestGridData: {
                sidx: 'createDate',
                sord: 'desc'
            },
            // 맨 처음 화면 호출 시, 데이터 출력되도록 하는 여부
            gridDataInit: true,
            // 건 수 클릭 시 선택되어짐을 위한 radio 버튼 존재 여부
            radio: true,
            //tempId: 'ifvGridSimplePageTemplete2'
        };
        // 서브그리드1의 div컨테이너에 붙인다
        subGrid1List = $("#pgmList_sub_1").ifvsfGrid({ejGridOption: ejGridOption});
    }// end callSubGrid1List

    //서브그리드2 호출 함수
    function callSubGrid2List(sg1Rid, ridOpr) {
        var parRid = sg1Rid; // 선택한 row의 '상위 코드'값
        var ridOpr = ridOpr; // 선택한 row의 '운영정책 코드'값(메인그리드의)

        var ejGridOption = {
            serializeGridData: function (data) {
                data.parRid = parRid; // 상위코드
                data.ridOpr = ridOpr; // 운영정책 코드
                return data;
            },
            loadComplete: function (obj) {
                subGrid2List.opt.gridControl.selectRows(0);
            },
            rowSelected: function (args) {
                // 서브그리드2의 클릭된 각 row건에 대한 sg2Rid, oprDtlRid값을 변수에 초기화
                sg2Rid = args.data.rid;
                oprDtlRid = args.data.rid;
                sub2DataPopGrid = subGrid2List.opt.gridControl.getSelectedRows()[0];
            },
            allowResizing: false,
            dataUrl: '<ifvm:action name="getOperationPolicyDetail2"/>',
            columns: [
                {field: 'attrCdNm', headerText: '속성명', width: '100px', textAlign: 'center', customAttributes: {searchable: true, index: 'T.attr_Cd_Nm'}}
                , {field: 'dataTypeNm', headerText: '데이터유형', width: '80px', textAlign: 'center', customAttributes: {searchable: true, index: 'T.data_Type_Nm'}}
                , {field: 'dataValMarkNm', headerText: '값', width: '200px', customAttributes: {searchable: true, index: 'T.data_Val_Mark_Nm'}}
                , {field: 'contents', headerText: '설명', width: '200px'}
                , {field: 'singleValYn', headerText: '단일값여부', width: '60px', textAlign: 'center', customAttributes: {searchable: true, index: 'T.single_Val_Yn'}}
                , {field: 'useYn', headerText: '사용여부', width: '60px', textAlign: 'center'}
                , {field: 'createBy', headerText: '등록자', width: '75px', textAlign: 'center'}
                , {field: 'createDate', headerText: '등록일', width: '80px', textAlign: 'center'}
                , {field: 'modifyBy', headerText: '수정자', width: '75px', textAlign: 'center',}
                , {field: 'modifyDate', headerText: '수정일', width: '80px', textAlign: 'center'}
                , {field: 'rid', headerText: 'rid', visible: false}
            ],
            // 그리드 리스트에 출력되는 데이터들의 정렬(order by)기준
            requestGridData: {
                sidx: 'createDate',
                sord: 'desc'
            },
            // 맨 처음 화면 호출 시, 데이터 출력되도록 하는 여부
            gridDataInit: true,
            // 건 수 클릭 시 선택되어짐을 위한 radio 버튼 존재 여부
            radio: true,
            //tempId: 'ifvGridSimplePageTemplete2'
        };
        // 서브그리드2의 div컨테이너에 붙인다
        subGrid2List = $("#pgmList_sub_2").ifvsfGrid({ejGridOption: ejGridOption});
    }// end callSubGrid2List


    // 메인 그리드(운영정책) 호출 함수
    function callMainGridList() {

        var ejGridOption = {
            serializeGridData: function (data) {
                return data;
            },
            loadComplete: function (obj) {
                mainGridList.opt.gridControl.selectRows(0);
            },
            rowSelected: function (args) {
                mgRid = args.data.rid;       // 클릭한 데이터row의 rid값(mgRid)를 넣어둔다
                plcyCd = args.data.plcyCdNm; // 클릭한 데이터row의 운영정책명값을 넣어둔다
                //기존에 서브그리드1의 row, 서브그리드2의 row를 선택했을 때 초기화되어 있던 sg1Rid,sg2Rid값 등을 (값이 남아있을 경우를 대비해) null로 초기화
                sg1Rid = null;
                sg2Rid = null;
                // 메인그리드 상의 row가 클릭되었을 시 서브그리드1,2 동시 호출
                callSubGrid1List(mgRid);      // '운영정책 상세(서브그리드1)' 내용 조회
                callSubGrid2List(null, null); // 메인그리드의 각 row 클릭 시 마다 서브그리드2 부분은 초기화 시킨다(일종의 새로고침)
            },
            dataUrl: '<ifvm:action name="getOperationPolicyList"/>',
            allowResizing : false,
            columns: [
                {field: 'pgmNm', headerText: '로열티프로그램', textAlign: 'left', width: '130px', customAttributes: {searchable: true}}
                , {field: 'ctg1CdNm', headerText: '분류', textAlign: 'center', width: '70px', customAttributes: {searchable: true, index: 'CC.MARK_NAME'}}
                , {field: 'ctg2CdNm', headerText: '분류상세', textAlign: 'center', width: '80px', customAttributes: {searchable: true, index: 'CC2.MARK_NAME'}}
                , {field: 'plcyCdNm', headerText: '정책명', width: '195px', customAttributes: {searchable: true, index: 'CC3.MARK_NAME'}}
                , {field: 'contents', headerText: '설명', width: '195px'}
                , {field: 'useYn', headerText: '사용여부', width: '50px', textAlign: 'center'}
                , {field: 'createBy', headerText: '등록자', textAlign: 'center', width: '90px'}
                , {field: 'createDate', headerText: '등록일', textAlign: 'center', width: '80px'}
                , {field: 'modifyBy', headerText: '수정자', textAlign: 'center', width: '90px'}
                , {field: 'modifyDate', headerText: '수정일', textAlign: 'center', width: '80px'}
                , {field: 'rid', headerText: 'rid', visible: false}
            ],
            // 그리드 리스트에 출력되는 데이터들의 정렬(order by)기준
            requestGridData: {
                sidx: 'ctg1CdNm ASC, ctg2CdNm ASC, modifyDate',
                sord: 'DESC',
                rows: 100
            },
            radio: true,
            rowList: [100],  // 한 번에 출력될 데이터row의 갯수 설정(100개)
            rowNum: 100
            //tempId: 'ifvGridSimplePageTemplete2',
        };// end ejGridOption       

        mainGridList = $("#pgmList").ifvsfGrid({ejGridOption: ejGridOption});
    };// end callMainGridList


    // 조회조건 입력한대로 조회하기
    function searchForMainGridList() {
        $.fn.ifvmSubmitSearchCondition("pgmSearchList", function () {
            mainGridList.searchGrid({item: requestitem});
        });
    }

    // 조회 조건에 공통 코드 지정(초기화)
    function initSearchConditions() {
        $.fn.ifvmSetCommonCondList("pgmSearchList", "OPRL_PLCY_MGT", "pgmList");
    }


    // 시행
    $(document).ready(function () {

        // 메인그리드(운영정책) 조회
        callMainGridList();
        // 조회조건 초기화
        initSearchConditions();

        // 서브그리드1(정책속성값 그리드) 처음 로드
        callSubGrid1List(null);
        // 서브그리드2(세부사항 그리드) 처음 로드
        callSubGrid2List(null, null);
        // 그리드 종류 별 버튼들 기능 활성화
        setMgButtons();
        setSg1Buttons();
        setSg2Buttons();
        // 컨텐츠팝업 버튼 클릭 시
        $('#contentPop').on('click', function () {
            openContentPop();
        });

        // 조회버튼 클릭 시
        $('#searchCondBtn').on('click', function () {
            searchForMainGridList(); // 조회하기
        });
        // 조회의 초기화버튼 클릭 시
        $("#searchCondInitBtn").on('click', function () {
            initSearchConditions(); // 초기화
        });


    });


</script>


