<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var dbType = null;
	var tolCnt = 0;
	var idxCnt = 0;
	var tblCnt = 0; // 불러올 테이블 수
	var tblLgcCnt = 0; // L.C에 연결된 테이블 수
	var targetTreeData = null;
	var sourceTreeData = null;

	// source table List	
	function sourceTreeListInit() {
		try {
			sourceTreeData.destroy();
		} catch (err) {

		}

		sourceTreeData = null;

		$.ifvSyncPostJSON("<ifvm:action name='getSourceTreeData' />", {
			dbInformId : $("#creatServiceNm").val()
		}, function (resData) {
			sourceTreeData = resData;
		}, function () {
			alert("DB Connection Error");
		});

		$("#sourceTreeList").ifvsfTree({
			allowDragAndDrop : true,
			allowDropChild : false,
			allowDropSibling : false,
			enableMultipleExpand : true,
			allowDragAndDropAcrossControl : true,
			allowMultiSelection : true,
			expanded : true, //전체 열기
			fields : {
				id : "id",
				text : "text",
				parentId : "parentId",
				dataSource : sourceTreeData,
				schmaNm : "schmaNm",
				tblNm : "tblNm",
				comment : "comment"
			},
			nodeDropped : sourceNodeDropped,
			template : "#baseTreeTemplate3"
		});
	}
	// 주제영역
	function targetTreeListInit() {
		try {
			targetTreeList.destroy();
		} catch (err) {

		}

		targetTreeData = null;

		//로지컬컴포넌트 트리 목록 조회
		$.ifvSyncPostJSON('<ifvm:action name="getTargetTreeData"/>', {
			dbInformId : $("#creatServiceNm").val()
		}, function(result) {
			targetTreeData = result;
		});

		$("#targetTreeList").ifvsfTree({
			allowDragAndDrop : true,
			allowDropChild : true,
			allowDropSibling : true,
			allowDragAndDropAcrossControl : true,
			allowMultiSelection : true,
			expanded : true, //전체 열기
			fields : {
				id : "id",
				text : "text",
				parentId : "parentId",
				dataSource : targetTreeData,
				schmaNm : "schmaNm",
				tblNm : "tblNm",
				comment : "comment"
			},
			setBtn : {
				add : false,
				mod : false,
				del : true
			},
			nodeSelect : targetNodeSelect,
			template : "#baseTreeTemplate2"
		});
	}

	// 테이블 불러오기 팝업종료시 재조회/메세지처리
	function popupClose() {
		/* 불러올 테이블수와 L.C에 연결된 테이블 수가 같으면 팝업종료 / 틀리면 메세지처리 후 그리드 재조회*/
		if (tblCnt == idxCnt) {
			if (tblCnt == tblLgcCnt) {
				getTableMstList();
				tableMstPopClose();
			} else if (tblCnt != tblLgcCnt) {
				alert('<spring:message code="M01608" />');
				getTableMstList();
				tableMstPopClose();
			}
		}
	}

	/**
	 * - 테이블 정보 조회 및 import
	 * - 테이블에 연결된 컬럼 정보 조회 (타DB)
	 * - 각 컬럼에 필요한 값을 추가하여 하나씩 insert 
	 * 
	 * @param obj
	 * @returns
	 */
	function tableColImport(obj) {
		var colImporData = null;
		// 테이블 정보 불러오기
		$.ifvPostJSON('<ifvm:action name="setTableImport"/>', obj, function(result) {

			// 테이블에 연결된 컬럼정보 조회
			$.ifvPostJSON('<ifvm:action name="getTableColImport"/>', obj, function(result) {
				colImporData = result;
				if (colImporData.length > 0) {
					colImporData.forEach(function(thisObj, idx) {
						obj.colNm = thisObj.colNm;
						obj.dataTypeCd = (thisObj.dataTypeCd).toUpperCase();
						obj.len = thisObj.len;
						obj.nullYn = thisObj.nullYn;
						obj.pkYn = thisObj.pkYn;
						obj.seq = thisObj.seq;
						obj.deftVal = thisObj.deftVal;
						obj.dpNm = thisObj.dpNm;
						obj.colTypeCd = 'DIMENSION';
						obj.gropCode = 'DB_DATA_TYPE_CD';

						// 컬럼정보 불러오기 (저장)
						$.ifvPostJSON('<ifvm:action name="setTableColImport"/>', obj, function(result) {
						});
					});
				}
			});
		});
	}

	//채널 관계 저장
	function tableImportSave() {
		var targetTreeData = $("#targetTreeList").data("ejTreeView");
		var targetDataSource = targetTreeData.dataSource();

		dbTypeCheck();

		var requestDataList = new Array();
		$.ifvProgressControl(true);
		$.each(targetDataSource, function(dataIdx, dataObject) {
			if ($.fn.ifvmIsNotEmpty(dataObject.parentId)) {
				idxCnt++;

				var tempObject = new Object();
				tempObject.tblNm = dataObject.tblNm;
				tempObject.schmaNm = dataObject.schmaNm;
				tempObject.subjectDbRelId = dataObject.parentId;
				tempObject.dbInformId = dbInformId;

				requestDataList.push(tempObject);
			}
		});

		if (requestDataList.length !== 0) {
			$.ifvPostJSON("<ifvm:action name='saveTableImport' />", {
				dbType: dbType
				, tableDataList : requestDataList
			}, function(resData) {
				var message = resData.message;
				if($.fn.ifvmIsNotEmpty(message)) {
					alert(message);
				}
				
				tblCnt = resData.totalTableCnt;
				tblLgcCnt = resData.failureTableCnt;
				
				$.ifvProgressControl(false);
				popupClose();
			});
		} else {
			$.ifvProgressControl(false);
			alert("<spring:message code='M01695' />");
		}
	}

	// DB유형 체크
	function dbTypeCheck() {
		$.ifvSyncPostJSON('<ifvm:action name="getDbType"/>', {
			dbInformId : dbInformId
		}, function(result) {
			if (result.conDbType == "MySQL") {
				dbType = "MySQL";
			} else if (result.conDbType == "POSTGRESQL") {
				dbType = "PostgerSQL";
			} else {
				dbType = "Oracle";
			}
		});
	}

	//공통코드 조회 - db 유형
	function getDbServiceComboList() {
		$.ifvSyncPostJSON('<ifvm:action name="getDbServiceComboList"/>', {}, function(result) {
			var obj = {
				id : "",
				text : "선택하세요."
			};

			result.rows.unshift(obj);
			var temp = $("#selectTmp").tmpl(result.rows);
			$("#creatServiceNm").append(temp);
		});
	};

	//노드 클릭 이벤트
	function targetNodeSelect(args) {
		//상위 아이디 없을겨우 버튼 삭제
		if ($.fn.ifvmIsEmpty(args.parentId)) {
			$("[btnId=btnArea]").remove();
		} else {
			// $(".plus_minus_btn").parent().css("left", ($(".plus_minus_btn").parent().css("left") - 41) + "px");
			var numberRegExp = new RegExp("^[0-9]*");
			var leftPx = $(".plus_minus_btn").parent().css("left");
			leftPx = numberRegExp.exec(leftPx);
			leftPx = Number(leftPx);
			$(".plus_minus_btn").parent().css("left", (leftPx - 41) + "px");

			//삭제 버튼
			$(".plus_minus_btn").on('click', function() {
				deleteTarget();
			});
		}
	}

	//노드 드랍 이벤트
	function sourceNodeDropped(args) {
	}

	//삭제 버튼
	function deleteTarget() {
		var allowMultiSelection = targetTreeList.model.allowMultiSelection;
		targetTreeList.model.allowMultiSelection = false;
		//선택 노드 데이터
		var node = targetTreeList.getTreeData()[targetTreeList.getSelectedNodeIndex()];
		targetTreeList.model.allowMultiSelection = allowMultiSelection;

		//소스 트리에 해당 노드 추가
		node.parentId = node.schmaNm;
		sourceTreeList.addNode(node);
		//선택 노드 삭제
		targetTreeList.removeNode();
	}

	$(document).ready(function() {
		getDbServiceComboList();
		dbInformId = $("#creatServiceNm").val();

		if (dbInformId != '') {
			dbTypeCheck();
			sourceTreeListInit();
			targetTreeListInit();
		}

		/* 신규연결 */
		$("#btnNewConn").on('click', function() {
			qtjs.href('<ifvm:url name="dbInfoNew"/>');
		});
		/* 저장 */
		$("#btnColSave").on('click', function() {
			tableImportSave();
		});
		/* 취소 */
		$("#btnColcan").on('click', function() {
			tableMstPopClose();
		});
		/* 서비스명 변경 */
		$("#creatServiceNm").change(function(e) {
			var thisValue = this.value;
			if ($.fn.ifvmIsNotEmpty(thisValue)) {
				targetTreeData = null;
				sourceTreeData = null;
				dbInformId = $("#creatServiceNm").val();
				dbTypeCheck();
				sourceTreeListInit();
				targetTreeListInit();
			} else {
				$("#sourceTreeList").data("ejTreeView").destroy();
				$("#targetTreeList").data("ejTreeView").destroy();
			}
		});
	});
</script>

<div id="tableImportPopFormArea" class="import_form_area pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row">
			<div id="sourceForm" class="col-xs-6 pr5">
				<label class="title-box"><spring:message code="M01440" /></label>

				<div class="left-box">
					<ifvm:input type="select" id="creatServiceNm" className="select-box" />
					<button class="btn btn-sm btn_lightGray2" id="btnNewConn" objCode="btnNewConn_OBJ">
						<spring:message code="M01584" />
					</button>

					<label class="label-box"><spring:message code="M01567" /></label>
					<div id="sourceTreeList" class="analysis_tree"></div>
				</div>
			</div>

			<div id="targetForm" class="col-xs-6 pl5">
				<label class="label-box"><spring:message code="M01568" /></label>
				<div class="right-box">
					<div id="targetTreeList" class="analysis_tree"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnColSave" objCode="btnColSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnColcan" objCode="btnColcan_OBJ">
		<spring:message code="M00284" />
	</button>
</div>

<script id="selectTmp" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}text}</option>
</script>