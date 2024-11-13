$.extend({
    ifvmNewUUID: function () {
        return UUID.generate().replace(/-/g, '').substring(0, 24);
    },
    //rowid 생성
    ifvmGetRowID: function () {
        var rowID = null;

        $.ajax({
            type: 'POST',
            url: PAGE_CONTEXT_PATH + '/common/getRowID.do',
            async: false,
            success: function (result) {
                rowID = result;
            }
        });

        return rowID;
    },

    ifvmGetSelectBoxNum: function () {
        var arr = [10, 25, 50, 100];
        return arr;
    },

    ifvmLnbSetting: function (lnbId) {
        if ($("#" + lnbId).length !== 0)
            $("#sideMenu li").removeClass('active');
        $("#" + lnbId).addClass("active");
    },
    ifvmLnbSettingForProgNum: function (lnbProgNum) {
        $("#sideMenu li").removeClass('active');
        $("#sideMenu li[prognum=" + lnbProgNum + "]").addClass('active')
    },


    ifvmLoadPop: function (obj) {
        obj.valign = 'top';
        $.ifvLoadPop(obj);
    },

    ifvmSmartEditor: function (fn, skinUrl, elem) {
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: elem,
            sSkinURI: skinUrl,
            fCreator: "createSEditor2",
            fOnAppLoad: fn
        });

        return oEditors;
    },
    ifvmGetTime: function (day) {
        return new Date(day).getTime();
    },

    deleteParam: function (arr, paramName) {
        var deleteParam = [];

        for (var i = 0; i < arr.length; i++) {

            if (arr[i].codeName != paramName) {
                deleteParam.push(arr[i]);
            }
        }
        return deleteParam;
    },

    ifvmUnixToDate: function (date) {
        var d = Number(date);
        var t = new Date(d);
        var formatted = t.format("yyyy-mm-dd");
        return formatted;
    },

    ifvFilePostJSON: function (url, formData, callback, errorCallback, btn, progressClass, fallback) {
        var progress;
        if (btn != null) {
            //이미 서비스 요청중일때( progress가 돌고있을때 )리턴
            var index = $.ifvRequestBtnSearch(btn);
            if (index > -1) {
                return;
            }

            progress = $.ifvLoading(btn, progressClass);
        }

        var config = {
            url: url,
            type: "POST",
            //data : jsonData ? JSON.stringify(jsonData) : null,
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                if ($.errorChecker(result, errorCallback) == false) {
                    return;
                }
                callback(result);
            },
            complete: function (xhr, status) {
                if (progress != null) {
                    $(progress).remove();
                }
                $.ifvRemoveRequestBtn(btn);
            },
            error: fallback
        };

        $.ajaxSetup(config);
        $.ajax();

        config = {
            url: null,
            type: "GET",
            data: null,
            async: true,
            dataType: null,
            contentType: "application/x-www-form-urlencoded",
            success: null
        };
        $.ajaxSetup(config);
    },

    ifvPrintPartOfPage: function (elId) {
        var printContent = document.getElementById(elId);
        var windowUrl = 'ifvPrint';
        var uniqueName = new Date();
        var windowName = 'ifvPrint' + uniqueName.getTime();
        var printWindow = window.open(windowUrl, windowName, 'left=50000,top=50000,width=0,height=0');
        printWindow.document.write(printContent.innerHTML);
        printWindow.document.close();
        printWindow.focus();
        printWindow.print();
        printWindow.close();
    }

});

(function ($) {

    $.extend($.fn.ifvGrid, $.fn.ifvGrid, {
        selRowIndex: function () {
            var selrowId = this.opt.grid.jqGrid('getGridParam', 'selrow');

            return selrowId;
        }
    });
});


$.fn.ifvmLoad = function (url) {

    this.attr({
        tabindex: '-1',
        role: 'dialog',
        ariaLabelledby: "myModalLabel",
        ariaHidden: "true"
    });
    this.addClass('modal');
    this.addClass('fade');
    this.load(url);
};

//String to JSON Object
$.fn.ifvmStringToJSONObject = function (val) {
    try {
        return JSON.parse(val);
    } catch (err) {
        return "";
    }
};

//Not Empty 여부
$.fn.ifvmIsNotEmpty = function (val) {
    if (this.val() != undefined) {
        val = this.val();
    }

    if (!$.fn.ifvmIsEmpty(val)) {
        return true;
    }

    return false;
};

//Empty 여부
$.fn.ifvmIsEmpty = function (mixed_var) {
    if (this.val() != undefined) {
        mixed_var = this.val();
    }

    try {
        var undefined, i, len;
        var emptyValues = [undefined, null, ''];
        for (i = 0, len = emptyValues.length; i < len; i++) {
            if (mixed_var === emptyValues[i]) {
                return true;
            }
        }

        if (typeof mixed_var === 'object') {
            if ($.isEmptyObject(mixed_var)) {
                return true;
            }
            if (mixed_var.length == 0) {
                return true;
            }
        }
    } catch (e) {
        console.log(e);
        return false;
    }

    return false;
};

//empty is null
$.fn.ifvmIsEmptyNull = function (val) {
    if ($.fn.ifvmIsEmpty(val)) {
        return null;
    } else {
        return val;
    }
}

// string to number
$.fn.ifvmStringToNumber = function (val) {
    if (isNotEmpty(val)) {
        val = Math.ceil(val);
        if (/^(\-|\+)?([0-9]+|Infinity)$/.test(val)) {
            return Number(val);
        }
    }

    return "";
};

/* 20171116 sjbaek obj비교 */
var ifvCompareObj = function (a, b, f) {
    var i = 0, j, barr = [], diff = [];

    function addDiff(j, a, b) {
        var obj = {};
        obj.key = j;
        obj.before = a;
        obj.after = b;
        diff.push(obj);
    }

    if (typeof a == "object" && a) {
        if (Array.isArray(a)) {
            if (!Array.isArray(b) || a.length != b.length) return false;
            for (j = a.length; i < j; i++) if (!ifvCompareObj(a[i], b[i])) return false;
            return true;
        } else {
            for (j in b) if (b.hasOwnProperty(j)) {
                i++;
                if (f) barr.push(j);
            }
            if (f) {
                for (i; i > 0; i--) {
                    if (!a.hasOwnProperty(barr[i - 1])) {
                        addDiff(barr[i], a[i], b[i]);
                    }
                }
            } else {
                for (j in a) if (a.hasOwnProperty(j)) {
                    if (ifvCompareObj(a[j], b[j])) {
                        i--;
                    } else {
                        addDiff(j, a[j], b[j]);
                    }
                }
            }
            return {success: !i, diff: diff};
        }
    }
    return a === b;
};

/* 20171122 sjbaek input number min max */
$.fn.ifvNumberRange = function () {
    this.min = Number($(this).attr('min'));
    this.max = Number($(this).attr('max'));
    this.regex = /^[0-9]*$/;
    var _this = this;
    $(this).on('keyup', function () {
        var t = $(_this).val();
        if (_this.regex.test(t) === false)
            _this.val("");
    });
    $(this).on('blur', function () {
        var t = Number($(_this).val());
        if (_this.regex.test(t) === false || t < _this.min || t > _this.max)
            _this.val("");
    });
}


$.fn.ifvmSetSelectOptionCommCodeNoSync = function (name, groupCode, selectCode, parCodeId, noBlank) {
    var _name = name;
    var _parCodeId = $.fn.ifvmIsNotEmpty(parCodeId) ? parCodeId : null;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;

    //초기화
    $("select[name='" + _name + "']").empty();

    if ($.fn.ifvmIsNotEmpty(_name)) {
        $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCodeList.do', {
            groupCode: groupCode, parCodeId: _parCodeId
            , enableNA: true
        }, function (result) {
            if (!_noBlank) {
                $("<option></option>")
                    .text("")
                    .attr("codeId", "")
                    .attr("value", "")
                    .appendTo("select[name='" + _name + "']");
            }

            $.each(result.rows, function (index, code) {
                var option =
                    $("<option></option>")
                        .text(code.markName)
                        .attr("codeId", code.codeId)
                        .attr("value", code.codeName)
                        .attr("attrib01", code.attrib01)
                ;
                //selectCode 가 있을경우 기본 선택
                if (_selectCode == code.codeName) {
                    option.attr("selected", "selected");
                }

                //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                if (index == 0 && _noBlank && _selectCode == "") {
                    option.attr("selected", "selected");
                }

                option.appendTo("select[name='" + _name + "']");
            });
        });
    }
};


/**
 * input Select 공통코드 option 생성
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * parCodeId : 상위코드
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 */
$.fn.ifvmSetSelectOptionCommCode = function (name, groupCode, selectCode, parCodeId, noBlank) {
    var _name = name;
    var _parCodeId = $.fn.ifvmIsNotEmpty(parCodeId) ? parCodeId : null;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;

    //초기화
    $("select[name='" + _name + "']").empty();


    if ($.fn.ifvmIsNotEmpty(_name)) {
        $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCodeList.do', {
            groupCode: groupCode, parCodeId: _parCodeId
            , enableNA: true
        }, function (result) {
            if (!_noBlank) {
                $("<option></option>")
                    .text("")
                    .attr("codeId", "")
                    .attr("value", "")
                    .appendTo("select[name='" + _name + "']");
            }

            $.each(result.rows, function (index, code) {
                var option =
                    $("<option></option>")
                        .text(code.markName)
                        .attr("codeId", code.codeId)
                        .attr("value", code.codeName)
                        .attr("attrib01", code.attrib01)
                ;
                //selectCode 가 있을경우 기본 선택
                if (_selectCode == code.codeName) {
                    option.attr("selected", "selected");
                }

                //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                if (index == 0 && _noBlank && _selectCode == "") {
                    option.attr("selected", "selected");
                }

                option.appendTo("select[name='" + _name + "']");
            });
        });
    }
};
/**
 * input Select 공통코드 option 생성
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * parCodeId : 상위코드
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 * defaultValue : select box 기본 값
 */
$.fn.ifvmSetSelectOptionCommCode = function (name, groupCode, selectCode, parCodeId, noBlank, defaultValue) {
    var _name = name;
    var _parCodeId = $.fn.ifvmIsNotEmpty(parCodeId) ? parCodeId : null;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;

    //초기화
    $("select[name='" + _name + "']").empty();

    if ($.fn.ifvmIsNotEmpty(_name)) {
        $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCodeList.do', {
            groupCode: groupCode, parCodeId: _parCodeId
            , enableNA: true
        }, function (result) {
            if (!_noBlank) {
                $("<option></option>")
                    .text(defaultValue)
                    .attr("codeId", "")
                    .attr("value", '')
                    .appendTo("select[name='" + _name + "']");
            }

            $.each(result.rows, function (index, code) {
                var option =
                    $("<option></option>")
                        .text(code.markName)
                        .attr("codeId", code.codeId)
                        .attr("value", code.codeName)
                        .attr("attrib01", code.attrib01)
                ;
                //selectCode 가 있을경우 기본 선택
                if (_selectCode == code.codeName) {
                    option.attr("selected", "selected");
                }

                //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                if (index == 0 && _noBlank && _selectCode == "") {
                    option.attr("selected", "selected");
                }

                option.appendTo("select[name='" + _name + "']");
            });
        });
    }
};

/**
 * input Select 공통코드 option 생성(상위객체 연동)
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 */
$.fn.ifvmSetSelectOptionCommCodeSync = function (name, groupCode, selectCode, parName, noBlank) {
    var _name = name;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;
    var _parName = $.fn.ifvmIsNotEmpty(parName) ? parName : null;
    var _commCodeList = [];

    //공통코드 목록 조회
    $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCodeList.do', {
        groupCode: groupCode
        , enableNA: true
    }, function (result) {
        if ($.fn.ifvmIsNotEmpty(result.rows)) {
            _commCodeList = result.rows;
        }
    });

    //select 설정
    function setSelect() {
        if ($.fn.ifvmIsNotEmpty(_name)) {
            if ($.fn.ifvmIsNotEmpty(_parName)) {
                var _parValue = $("[name='" + _parName + "']").val();
                var _parCodeId = $("[name='" + _parName + "'] [value='" + _parValue + "']").attr("codeid");

                //초기화
                $("select[name='" + _name + "']").empty();

                if (!_noBlank) {
                    $("<option></option>")
                        .text("")
                        .attr("codeId", "")
                        .attr("value", "")
                        .appendTo("select[name='" + _name + "']");
                }

                $.each(_commCodeList, function (index, code) {
                    //par 코드 확인
                    if (_parCodeId == code.parCodeId) {
                        var option =
                            $("<option></option>")
                                .text(code.markName)
                                .attr("codeId", code.codeId)
                                .attr("value", code.codeName)
                                .attr("attrib01", code.attrib01)
                        ;
                        //selectCode 가 있을경우 기본 선택
                        if (_selectCode == code.codeName) {
                            option.attr("selected", "selected");
                        }

                        //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                        if (index == 0 && _noBlank && _selectCode == "") {
                            option.attr("selected", "selected");
                        }

                        option.appendTo("select[name='" + _name + "']");
                    }
                });

                $("select[name='" + _name + "']").change();
            }
        }
    }

    setSelect();

    //parName 객체 변경시

    $("[name='" + _parName + "']").on('propertychange change keyup paste input', function () {
        typeCheck = false;
        setSelect();
    });


    //2018.11.30 hy.jun - parName 객체 option 목록 변경될 시
    /*$("[name='" + _parName + "']").bind('DOMSubtreeModified', function(e) {
        setSelect();
    });*/
};


/**
 * input Select 공통코드 option 생성(동일한 공통코드안의 상위id 연동) - 특정 1개의 공통코드를 상위로 놓기위해 만듬
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드- 필요없음
 * parName : 상위 코드 값
 * noBlank : 최상위 빈값 설정여부
 */
$.fn.ifvmSetSelectOptionCommCodeSyncSelfJoin = function (name, groupCode, selectCode, parName, noBlank) {
    var _name = name;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;
    var _parName = $.fn.ifvmIsNotEmpty(parName) ? parName : null;
    var _commCodeList = [];

    //공통코드 목록 조회
    $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCodeList.do', {
        groupCode: groupCode
        , parCode: parName
        , enableNA: true
    }, function (result) {
        if ($.fn.ifvmIsNotEmpty(result.rows)) {
            _commCodeList = result.rows;
        }
    });

    //select 설정
    function setSelect() {
        if ($.fn.ifvmIsNotEmpty(_name)) {
            if ($.fn.ifvmIsNotEmpty(_parName)) {

                //초기화
                $("select[name='" + _name + "']").empty();

                if (!_noBlank) {
                    $("<option></option>")
                        .text("")
                        .attr("codeId", "")
                        .attr("value", "")
                        .appendTo("select[name='" + _name + "']");
                }

                $.each(_commCodeList, function (index, code) {
                    var option =
                        $("<option></option>")
                            .text(code.markName)
                            .attr("codeId", code.codeId)
                            .attr("value", code.codeName)
                            .attr("attrib01", code.attrib01)
                    ;
                    //selectCode 가 있을경우 기본 선택
                    if (_selectCode == code.codeName) {
                        option.attr("selected", "selected");
                    }

                    //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                    if (index == 0 && _noBlank && _selectCode == "") {
                        option.attr("selected", "selected");
                    }

                    option.appendTo("select[name='" + _name + "']");
                });

                $("select[name='" + _name + "']").change();
            }
        }
    }

    setSelect();

    //parName 객체 변경시
    $("[name='" + _parName + "']").on('propertychange change keyup paste input', function () {
        typeCheck = false;
        setSelect();
    });

};

/** 2020.07.20 노형래 신규
 * input Select 공통코드내 원하는 id 만 option 생성
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * codeIdList : 공통코드에서 필요한 값의 id
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 */
$.fn.ifvmSetSelectListOptionCommCode = function (name, groupCode, selectCode, codeIdList, noBlank) {
    var _name = name;
    var _codeIdList = $.fn.ifvmIsNotEmpty(codeIdList) ? codeIdList : null;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;

    //초기화
    $("select[name='" + _name + "']").empty();

    if ($.fn.ifvmIsNotEmpty(_name)) {
        $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCodeList.do', {
            groupCode: groupCode, codeIdList: _codeIdList
            , enableNA: true
        }, function (result) {
            if (!_noBlank) {
                $("<option></option>")
                    .text("")
                    .attr("codeId", "")
                    .attr("value", "")
                    .appendTo("select[name='" + _name + "']");
            }

            $.each(result.rows, function (index, code) {
                var option =
                    $("<option></option>")
                        .text(code.markName)
                        .attr("codeId", code.codeId)
                        .attr("value", code.codeName)
                        .attr("attrib01", code.attrib01)
                ;
                //selectCode 가 있을경우 기본 선택
                if (_selectCode == code.codeName) {
                    option.attr("selected", "selected");
                }

                //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                if (index == 0 && _noBlank && _selectCode == "") {
                    option.attr("selected", "selected");
                }

                option.appendTo("select[name='" + _name + "']");
            });
        });
    }
};

/** LOY_CUST_AGRE_TYPE_CD 에서 상위코드 가 NULL인 애들 뽑기 위해 따로 ACTION 만들어줌
 * input Select 공통코드 option 생성 (PAR_CODE_ID  = NULL)
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * parCodeId : 상위코드(null 로 들어감)
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 */
$.fn.ifvmSetSelectOptionNullParCodeId = function (name, groupCode, selectCode, parCodeId, noBlank) {
    var _name = name;
    var _parCodeId = $.fn.ifvmIsNotEmpty(parCodeId) ? parCodeId : null;
    var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
    var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;

    //초기화
    $("select[name='" + _name + "']").empty();

    if ($.fn.ifvmIsNotEmpty(_name)) {
        $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getParIdNullCodeList.do', {
            groupCode: groupCode, parCodeId: _parCodeId
            , enableNA: true
        }, function (result) {
            if (!_noBlank) {
                $("<option></option>")
                    .text("")
                    .attr("codeId", "")
                    .attr("value", "")
                    .appendTo("select[name='" + _name + "']");
            }

            $.each(result.rows, function (index, code) {
                var option =
                    $("<option></option>")
                        .text(code.markName)
                        .attr("codeId", code.codeId)
                        .attr("value", code.codeName)
                        .attr("attrib01", code.attrib01)
                ;
                //selectCode 가 있을경우 기본 선택
                if (_selectCode == code.codeName) {
                    option.attr("selected", "selected");
                }

                //noBlank 이며 selectcode가 없을때 첫번째 값 선택
                if (index == 0 && _noBlank && _selectCode == "") {
                    option.attr("selected", "selected");
                }

                option.appendTo("select[name='" + _name + "']");
            });
        });
    }
};

//시간값을 받아 달 일 시간 분 으로 반환한다.
$.fn.ifvmGetCalculateTime = function (date) {
    var time_maximum = [
        {num: 30 * 24 * 60 * 60 * 1000, txt: MESSAGE.common.months},
        {num: 24 * 60 * 60 * 1000, txt: MESSAGE.common.days},
        {num: 60 * 60 * 1000, txt: MESSAGE.common.hours},
        {num: 60 * 1000, txt: MESSAGE.common.minutes}
    ];

    date = Number(date);
    var time = "";

    if (date == 0 || date / 1000 < 60) {
        return MESSAGE.common.justbefore;
    }

    $.each(time_maximum, function (index, data) {
        if ((date / (data.num)) >= 1) {
            var num = Math.round(date / (data.num));
            time = time + " " + String(num) + data.txt;
            date = date - (num * (data.num));
        }
    });

    if (time != "") {
        time += " " + MESSAGE.common.ago;
    }

    return time;
};


//url 구하기
$.fn.ifvmGetUrl = function () {
    return location.href;
};

//jqgrid 선택된 row index 반환 그리드의 첫번째 row 0부터 시작
$.fn.ifvmGridSelectRowIndex = function (name) {
    var rowIdx = -1;
    $.each($("#" + name + " tbody tr"), function (index, data) {
        if (data.getAttribute("aria-selected") == "true") {
            rowIdx = index - 1;
            return false;
        }
    });

    return rowIdx;
};

//jqgrid 선택된 row index 반환 그리드의 첫번째 row 0부터 시작
$.fn.ifvmGridSelRowIndex = function (grid) {
    var rowIdx = -1;

    if (grid.opt.grid.jqGrid('getGridParam', 'selrow') != null) {
        rowIdx = grid.opt.grid.jqGrid('getGridParam', 'selrow') - 1;
    }

    return rowIdx;
};

//자릿수만큼 문자열 채우기
//str_pad(변수, 총자릿수, 채울문자, 채울 방향);
//LEFT, RIGHT, BOTH
$.fn.ifvmStr_pad = function (input, length, string, type) {
    var result = "";
    if (input.length >= length) {
        return input;
    }
    string = string || '0';
    input = input + '';
    type = type || 'LEFT';
    inputLength = input.length;
    pad = Array(length - inputLength + 1).join(string);

    switch (type) {
        case 'LEFT':
            result = pad + input;
            break;
        case 'RIGHT':
            result = input + pad;
            break;
        case 'BOTH':
            var i = parseInt((length - inputLength) / 2);
            result = pad.substring(0, i) + input + pad.substring(i, length - i + 1);
            break;
    }
    return result;
};

var dateFormat = function () {
    var token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
        timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
        timezoneClip = /[^-+\dA-Z]/g,
        pad = function (val, len) {
            val = String(val);
            len = len || 2;
            while (val.length < len) {
                val = "0" + val;
            }
            return val;
        };

    // Regexes and supporting functions are cached through closure
    return function (date, mask, utc) {
        var dF = dateFormat;

        // You can't provide utc if you skip other args (use the "UTC:" mask prefix)
        if (arguments.length == 1 && Object.prototype.toString.call(date) == "[object String]" && !/\d/.test(date)) {
            mask = date;
            date = undefined;
        }

        // Passing date through Date applies Date.parse, if necessary
        date = date ? new Date(date) : new Date;
        if (isNaN(date)) {
            throw SyntaxError("invalid date");
        }

        mask = String(dF.masks[mask] || mask || dF.masks["default"]);

        // Allow setting the utc argument via the mask
        if (mask.slice(0, 4) == "UTC:") {
            mask = mask.slice(4);
            utc = true;
        }

        var _ = utc ? "getUTC" : "get",
            d = date[_ + "Date"](),
            D = date[_ + "Day"](),
            m = date[_ + "Month"](),
            y = date[_ + "FullYear"](),
            H = date[_ + "Hours"](),
            M = date[_ + "Minutes"](),
            s = date[_ + "Seconds"](),
            L = date[_ + "Milliseconds"](),
            o = utc ? 0 : date.getTimezoneOffset(),
            flags = {
                d: d,
                dd: pad(d),
                ddd: dF.i18n.dayNames[D],
                dddd: dF.i18n.dayNames[D + 7],
                m: m + 1,
                mm: pad(m + 1),
                mmm: dF.i18n.monthNames[m],
                mmmm: dF.i18n.monthNames[m + 12],
                yy: String(y).slice(2),
                yyyy: y,
                h: H % 12 || 12,
                hh: pad(H % 12 || 12),
                H: H,
                HH: pad(H),
                M: M,
                MM: pad(M),
                s: s,
                ss: pad(s),
                l: pad(L, 3),
                L: pad(L > 99 ? Math.round(L / 10) : L),
                t: H < 12 ? "a" : "p",
                tt: H < 12 ? "am" : "pm",
                T: H < 12 ? "A" : "P",
                TT: H < 12 ? "AM" : "PM",
                Z: utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
                o: (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
                S: ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
            };

        return mask.replace(token, function ($0) {
            return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
        });
    };
}();

// Some common format strings
dateFormat.masks = {
    "default": "ddd mmm dd yyyy HH:MM:ss",
    shortDate: "m/d/yy",
    mediumDate: "mmm d, yyyy",
    longDate: "mmmm d, yyyy",
    fullDate: "dddd, mmmm d, yyyy",
    shortTime: "h:MM TT",
    mediumTime: "h:MM:ss TT",
    longTime: "h:MM:ss TT Z",
    isoDate: "yyyy-mm-dd",
    isoTime: "HH:MM:ss",
    isoDateTime: "yyyy-mm-dd'T'HH:MM:ss",
    isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
};

// Internationalization strings
dateFormat.i18n = {
    dayNames: [
        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
        "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ],
    monthNames: [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
        "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
    ]
};

// For convenience...
Date.prototype.format = function (mask, utc) {
    return dateFormat(this, mask, utc);
};


//해당 div 모든 객체 disabled 설정
$.fn.ifvmAllDisabled = function (id) {
    $("#" + id + " select").attr('disabled', true);
    $("#" + id + " input").attr('disabled', true);
    $("#" + id + " textarea").attr('disabled', true);
    $("#" + id + " button").hide();
};

//아코디언 내 트리 생성
$.fn.ifvmSetAccordionTreeView = function (id, option, data) {
    //fields 있을경우 옵션 데이터 설정
    if ($.fn.ifvmIsNotEmpty(option.fields)) {
        option.fields.dataSource = data;
    } else {
        option.fields = {dataSource: data};
    }

    //트리 생성
    $("#" + id).ifvsfTree(option);
};

/*
 * 로지컬 컴포넌트 트리 생성
 * name: 객체명, option: 아코디언 설정
 * option.treeOption: 트리 설정
 * data: 아코디언 데이터
 * data.treeList: 트리 데이터
 */
$.fn.ifvmCreateAccordionTree = function (name, option, data) {
    if ($.fn.ifvmIsNotEmpty(name)) {
        option.data = data;
        $.each(data, function (index, data) {
            var temp = $("#ifvAccordionConTemplate").tmpl(data);
            $("#" + name).append(temp);

            var conId = "con_" + data.id;
            $.fn.ifvmSetAccordionTreeView(conId, option.treeOption, data.treeList);
        });
        enableMultipleOpen: true,
            $("#" + name).ifvsfAccordion(option);

        window[name];
        window[name] = $("#" + name).data("ejAccordion");

        window[name]._destroys = function () {
            window[name]._destroy();
            $("#" + name).html('');
        };
    } else {

    }
};

/*
 * 콘텍스트메뉴 생성
 * name: 객체명, option: 메뉴 설정
 * option.data: 메뉴 목록 설정
 * option.data.name: 메뉴명
 * option.data.selected: 메뉴 선택시 이벤트 함수명
 */
$.fn.ifvmCreateContextMenu = function (name, option) {
    var data = option.data;
    //data에 의한 메뉴 목록 html 추가
    $.each(data, function (index, data) {
        var id = '';
        //선택시 이벤트 함수
        if ($.fn.ifvmIsNotEmpty(data.id)) {
            id = data.id;
            id = 'id="' + id + '"';
        }
        $("#" + name).append('<li ' + id + '><a>' + data.name + '</a></li>');
    });

    option.name = name;

    //메뉴 생성
    $("#" + name).ifvsfContextMenu(option);
};

/**
 * 해당 태그에 이벤트 존재 여부 체크
 * .hasTriggerEvent([eventType]) or .hasTriggerEvent([eventType],[eventHandler]);
 * */
$.fn.hasTriggerEvent = function () {
    var ty = arguments[0], fn = arguments[1], da = $._data(this[0], 'events') || undefined;
    if (da === undefined || ty === undefined || da[ty] === undefined || da[ty].length === 0) {
        return false;
    }
    if (fn === undefined) {
        return true;
    }
    return Boolean(fn == da[ty][0].handler);
};

/*
 * export Image
 * 해당 div를 캡쳐하여 pdf로 다운로드한다.
*/
$.fn.ifvmExportImage = function (div, fileName) {
    var imgData = "";
    html2canvas($("#" + div), {
        useCORS: true,
        proxy: '/etc/proxy_image',
        onrendered: function (canvas) {
            imgData = canvas.toDataURL();
            if (imgData != "") {
                var link = document.createElement('a');
                link.download = "image.png";
                link.href = canvas.toDataURL('image/png').replace(/^data:image\/png/, 'data:application/octet-stream');
                link.click();
            }
        }
    });
};

/*
 * export PDF
 * 해당 div를 캡쳐하여 pdf로 다운로드한다.
*/
$.fn.ifvmExportPDF = function (div, fileName, size) {
    var imgData = "";
    html2canvas($("#" + div), {
        useCORS: true,
        proxy: '/etc/proxy_image',
        onrendered: function (canvas) {
            imgData = canvas.toDataURL();
            if (imgData != "") {
                var doc = new jsPDF();

                if ($.fn.ifvmIsEmpty(size)) {
                    var width = $("#" + div).width() / 4;
                    var height = $("#" + div).height() / 4;

                    if (width > 200) {
                        var val = width - 200;
                        width = 200;
                        height = height - val;
                    }

                    doc.addImage(imgData, 5, 5, width, height);
                } else {
                    doc.addImage(imgData, size[0], size[1], size[2], size[3]);
                }

                doc.save(fileName + '.pdf');
            }
        }
    });
};

/**
 * 프로그래스바 설정, targetId값이 있다면, 해당 영역 내에 프로그래스바를 설정한다.
 * */
$.fn.ifvmShowProgressControl = function (targetId) {
    var progressBar = $(".bigsize_progressRoll");
    if (!$.fn.ifvmIsNotEmpty(progressBar)) {
        if ($.fn.ifvmIsNotEmpty(targetId)) {
            $.ifvProgressControl(true, $("#" + targetId));
        } else {
            $.ifvProgressControl(true);
        }

        progressBar = $(".bigsize_progressRoll");
        progressBar.data("cnt", 0);
        progressBar.css("z-index", "2147483647");
    } else {
        var cnt = progressBar.data("cnt");
        progressBar.data("cnt", cnt + 1);
    }
};

/**
 * 프로그래스바 해제
 * */
$.fn.ifvmHideProgressControl = function () {
    var progressBar = $(".bigsize_progressRoll");
    if ($.fn.ifvmIsNotEmpty(progressBar)) {
        var cnt = progressBar.data("cnt");

        if (cnt > 0) {
            progressBar.data("cnt", cnt - 1);
        } else {
            $.ifvProgressControl(false);
        }
    }
};

/**
 * 숫자 콤마
 * */
$.fn.ifvmNumberWithCommas = function (x) {
    if ($.fn.ifvmIsEmpty(x)) {
        return null;
    }

    if (typeof x === 'number')
        x = x.toString();

    x = x.split(".");

    x[0] = x[0].replace(/[^0-9]/g, '');

    x[0] = x[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

    return x.join('.');
}

/**
 * 소수점, 콤마
 */
$.fn.ifvmDecimalWithCommas = function (x) {
    if ($.fn.ifvmIsEmpty(x)) {
        return null;
    }
    x = x.replace(/[^0-9\.]/g, '');
    var z = x.toString().split('.');
    return z[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (z.length > 1 ? '.' + z[1] : '');
}

/*
 * 소수점포함 숫자만 입력가능
 */
$.fn.ifvmNumberOnlyWithDecimal = function (id) {
    var _val;
    $("#" + id).on('keydown keypress', function () {
        _val = $(this).val();
    });

    $("#" + id).on('keyup', function () {
        var reg = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/;

        if (reg.test($(this).val())) {
            //$(this).val( $(this).val() );
        } else {
            var idx = _val.indexOf(".");

            if (idx > -1) {
                _val = _val.replace(/[^0-9]/g, '');
                _val = _val.substring(0, idx) + "." + _val.substring(idx);
            } else {
                _val = _val.replace(/[^\.0-9]/g, '');
            }

            $(this).val(_val);
        }
    });
}

//html url load
//load시 필요없는 항목 제거
$.fn.ifvmLoadUiSetting = function (name, url) {
    //html Load
    if ($.fn.ifvmIsNotEmpty(url)) {
        var obj = $.ifvCachedHtml(url);
        $('#' + name).html(obj.responseText);
    }

    //기본 ui 제거
    $('#' + name + ' #header').remove();
    $('#' + name + ' #sideMenu').remove();
    $('#' + name + ' .page-title').remove();
}

//브라우저 확인
$.fn.ifvmCheckBrowserForDiagram = function () {
    if (ej.browserInfo().name === "msie" && Number(ej.browserInfo().version) < 9) {
        alert(MESSAGE.diagram.error_MSG_D0001);

        return false;
    }

    return true;
}

//Ajax 파일 다운로드
$.fn.ifvmFileDownload = function (data) {
    var inputs = "";
    var url = "/common/fileDownload.do";
    var method = "post"

    //data를 입력받음
    if (data) {
        if ($.fn.ifvmIsNotEmpty(data.fileName) && $.fn.ifvmIsNotEmpty(data.filePath)) {
            inputs += '<input type="hidden" name="fileName" value="' + data.fileName + '" />';
            inputs += '<input type="hidden" name="filePath" value="' + data.filePath + '" />';

            // request를 보낸다.
//            jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
//            .appendTo('body').submit().remove();
            jQuery('<form action="' + url + '">' + inputs + '</form>')
                .appendTo('body').submit().remove();
        }
    }
    ;
};

//div의 모든 input value
$.fn.ifvmGetAllInputValues = function (id) {
    var inputs = $("#" + id + " :input");
    var rtn = [];

    $.each(inputs, function (index, data) {
        var nm = data.name;
        var val = data.value;
        rtn.push({name: nm, value: val});
    });

    return rtn;
}


/*
 * 체크박스 값 세팅
 * by knlee
 */
$.fn.ifvmSetChekBoxValue = function (id, value) {
    if (id.indexOf("#") != 0) id = "#" + id;
    if (value == "Y") $(id).attr("checked", true);
    else $(id).attr("checked", false);

};

/*
 * 체크박스 값 가져오기
 * by knlee
 */
$.fn.ifvmGetChekBoxValue = function (id, value) {
    if (id.indexOf("#") != 0) id = "#" + id;
    return $.fn.ifvmIsNotEmpty($(id).attr("checked")) ? "Y" : "N"

};


/* 팝업  오픈
 * by knlee
 */
$.fn.ifvmPopupOpen = function (divId, inputId, url, title, width, enableModal, enableResize) {

    if ($.fn.ifvmIsNotEmpty(inputId)) popSelectlId = inputId;	 //펍업에서 선택값 값을 받는 input id

    $("#" + divId).ifvsfPopup({
        enableModal: (typeof enableModal !== "undefined") ? enableModal : true,
        enableResize: (typeof enableResize !== "undefined") ? enableResize : true,
        contentUrl: url,
        contentType: "ajax",
        title: title,
        width: (typeof width !== "undefined") ? width : 860,
        open: function () {
            new ifvm.PopupCenter({
                popupDivId: divId
            });
        }
    });
};

$.fn.ifvmSearchHelpOpen = function (searchHelpProp, searchCond, divId, url, title, width, enableModal, enableResize) {
    // 공통 서치헬프 용 객체 초기화
    ifvGlobal.searchHelp = {field: {}, searchCond: {}};

    ifvGlobal.searchHelp.field = (searchHelpProp) ? searchHelpProp : {};
    ifvGlobal.searchHelp.searchCond = (searchCond) ? searchCond : {};

    $.fn.ifvmPopupOpen(divId, null, url, title, width, enableModal, enableResize);

};

$.fn.ifvmPopupClose = function () {
    var destroyedPopup = window.popups.pop();
    window[destroyedPopup]._destroy();
    delete window[destroyedPopup];
};

/*
 *page id 넣기, 빼기
 */
var condLogForPageId = [];
$.fn.ifvmPersonalCondLogPageId = function (screenId, inNout) {
    if (inNout) condLogForPageId.push(screenId);
    else return condLogForPageId.pop();
};

/*
 *json 배열 값 찾기
 */
$.fn.ifvmCheckJsonArrayValue = function (arr, key, val) {
    var rtnFlag = false;

    $.each(arr, function (index, data) {
        if (typeof data[key] != "undefined" && data[key] == val) {
            rtnFlag = true;

            return false;
        }
    });


    return rtnFlag;
}

/*
 * SelectBox 월 채우기
 */
$.fn.ifvmSetSelectBoxMonth = function (id) {
    var dt = new Date();

    for (var i = 1; i <= 12; i++) {

        var option =
            $("<option></option>")
                .text(i)
                .attr("value", i)
        ;

        if (i == dt.getMonth()) {
            option.selected = true;
        }

        $("#" + id).append(option)
    }
}

$.fn.ifvmGetNumber = function () {
    var val = this.val();

    return val.replace(/[^0-9]/g, '');
}

/**
 * 2017. 03. 30. 이기오
 * 공통 엑셀 다운로드 추가
 * @param excelDownloadUrl : 엑셀 다운로드 요청 URL
 * @param postData : JSON 형태의 엑셀 다운로드 관련 데이터. ex) 조회조건, 헤더정보 등등
 * */
$.fn.ifvmExecuteExcelDownload = function (excelDownloadUrl, postData) {
    $.fn.ifvmShowProgressControl();

    var xhr = new XMLHttpRequest();
    // post 방식으로 요청
    xhr.open("POST", excelDownloadUrl);
    xhr.responseType = "arraybuffer";

    xhr.onload = function () {
        $.fn.ifvmHideProgressControl();
        if (this.status === 200) {
            var fileName = "";
            var disposition = xhr.getResponseHeader("Content-Disposition");

            if (disposition && disposition.indexOf("attachment") !== -1) {
                var fileNameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                var matches = fileNameRegex.exec(disposition);

                if (matches != null && matches[1]) {
                    fileName = matches[1].replace(/['"]/g, "");
                }
            }

            var type = xhr.getResponseHeader("Content-Type");
            var blob = new Blob([this.response], {
                type: type
            });
            if (typeof window.navigator.msSaveBlob !== "undefined") {
                window.navigator.msSaveBlob(blob, fileName);
            } else {
                var URL = window.URL || window.webkitURL;
                var downloadUrl = URL.createObjectURL(blob);

                fileName = decodeURIComponent(fileName);
                if (fileName) {
                    var a = document.createElement("a");

                    if (typeof a.download === "undefined") {
                        window.location = downloadUrl;
                    } else {
                        a.href = downloadUrl;
                        a.download = fileName;
                        document.body.appendChild(a);
                        a.click();
                    }
                } else {
                    window.location = downloadUrl;
                }

                setTimeout(function () {
                    URL.revokeObjectURL(downloadUrl);
                }, 100);
            }
        }
    };

    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send(JSON.stringify(postData));
};

/**
 * grid 전체 데이터의 목록 엑셀 다운로드
 */
$.fn.ifvmGridExcelExport = function () {
    var _this = this;

    var listurl = _this.jqGridOption.url;
    var fileName = $.ifvmGetRowID();
    var serchText = _this.opt.searchBox.opt.select.getObj().key;
    var searchWord = _this.opt.searchBox.opt.input.val();

    $.ifvSyncPostJSON(listurl,
        {
            item: requestitem,
            appServiceId: _this.jqGridOption.appServiceId,
            country: _this.jqGridOption.country,
            lang: _this.jqGridOption.lang,
            searchText: serchText,
            searchWord: searchWord,
            sidx: _this.jqGridOption.sortname,
            sord: _this.jqGridOption.sortorder,
            rows: 99999999,
            _search: false
        },
        function (result) {
            $.ifvSyncPostJSON('/common/gridExcelExport.do',
                {
                    fileName: fileName,
                    header: _this.jqGridOption.colModel,
                    headerName: _this.jqGridOption.colNames,
                    data: result.rows
                },
                function (result) {
                    location.href = result.message;
                }
            );
        });
}

/**
 * 파일 업로드
 */
$.fn.ifvmFileUpload = function (name) {
    var formData = new FormData();
    formData.append("file", $("input:file[name=" + name + "]")[0].files[0]);
    var rtnValue = null;
    $.ajax({
        url: '/common/fileupload/fileUpload.do',
        data: formData, processData: false, contentType: false, type: 'POST', async: false,
        success: function (data) {
            rtnValue = data;
        }
    });

    return rtnValue;
}

/**
 * 17.07.03
 * dg.ryu
 * Object Merge
 */
$.fn.ifvmMergeObjectProperty = function (s, t) {
    var objectArray = [s, t];
    var resultObject = {};
    for (var i = 0, length = objectArray.length; i < length; i++) {
        var object = objectArray[i];
        for (var property in object) {
            if (object.hasOwnProperty(property)) {
                resultObject[property] = object[property];
            }
        }
    }

    return resultObject;
}

/**
 * 2017. 08. 25. 이기오
 *
 * @param base64Data
 *            Base64 형태의 데이터
 * @param contentType
 *            데이터의 타입. ex) application/vnd.ms-excel...
 * @param sliceSize
 *            자를 범위
 */
$.fn.ifvmConvertB64ToBlob = function (base64Data, contentType, sliceSize) {
    contentType = contentType || "";
    sliceSize = sliceSize || 512;

    var bChars = window.atob(base64Data);
    var bArrs = new Array();

    for (var offset = 0; offset < bChars.length; offset += sliceSize) {
        var slice = bChars.slice(offset, offset + sliceSize);
        var bNumbers = new Array(slice.length);
        for (var idx = 0; idx < slice.length; idx++) {
            bNumbers[idx] = slice.charCodeAt(idx);
        }

        bArrs.push(new Uint8Array(bNumbers));
    }

    var resBlob = new Blob(bArrs, {
        type: contentType
    });
    return resBlob;
};

/* ie Array find fallback */
if (!Array.prototype.find) {
    Array.prototype.find = function (predicate) {
        'use strict';
        if (this == null) {
            throw new TypeError('Array.prototype.find called on null or undefined');
        }
        if (typeof predicate !== 'function') {
            throw new TypeError('predicate must be a function');
        }
        var list = Object(this);
        var length = list.length >>> 0;
        var thisArg = arguments[1];
        var value;

        for (var i = 0; i < length; i++) {
            value = list[i];
            if (predicate.call(thisArg, value, i, list)) {
                return value;
            }
        }
        return undefined;
    };
}
$.fn.ifvGetCommCodeList = function (type, tarId, url, gc, sc, na, nainit, sync, def, attr01, attr02, attr03) {
    if (!sync) {
        sync = true;
    } else {
        sync = false;
    }
    if (!def) {
        def = false;
    } else {
        def = true;
    }
    $.fn.commCodeList(type, tarId, url, gc, sc, na, nainit, sync, def, attr01, attr02, attr03);
}
$.fn.commCodeList = function (type, tarId, url, gc, sc, na, nainit, sync, def, attr01, attr02, attr03) {
    var commJson = {};
    commJson["groupCode"] = gc;
    commJson['attrib01'] = attr01;
    commJson['attrib02'] = attr02;
    commJson['attrib03'] = attr03;

    if (typeof sc !== "undefined") {
        commJson['schemas'] = sc;
    }

    if (na === true) {
        commJson['enableNA'] = true;
    }

    if (sync) {
        $.ifvSyncPostJSON(url, commJson, function (result) {
            getPostSon(result);
        });
    } else {
        $.ifvPostJSON(url, commJson, function (result) {
            getPostSon(result);
        });
    }

    function getPostSon(result) {
        if (!result.rows) {
            result.rows = result;
        }

        if (result.rows.length < 1) return false;
        if (type == "select") {
            if (def === true) {
                var defamp = "<option value=''>--선택해주세요-- </option>";
                $("#" + tarId).append(defamp);
            }
            var aptemp = $("#commCodeSelectTemplate").tmpl(result.rows);
            $("#" + tarId).append(aptemp);
            if (nainit === true) $('#' + tarId).val('NA');
        } else if (type == "checkbox") {
            for (var i = 0; i < result.rows.length; i++) {
                result.rows[i].codeId = result.rows[i].codeName + 'Checkbox' + i;
                result.rows[i].domName = tarId + 'Checkbox';
            }

            var aptemp = $("#commCodeCheckboxTemplate").tmpl(result.rows);
            $("#" + tarId).append(aptemp);
        } else if (type == "radio") {
            for (var i = 0; i < result.rows.length; i++) {
                result.rows[i].codeId = result.rows[i].codeName + 'Radio' + i;
                result.rows[i].domName = tarId + 'Radio';
            }

            var aptemp = $("#commCodeRadioTemplate").tmpl(result.rows);
            $("#" + tarId).append(aptemp);
        }
    }


}
$.fn.ifvGetHierarchySelect = function (tarId, url, gc, parCode, def) {

    $("#" + tarId).find("option").remove();
    var commJson = {};
    commJson["groupCode"] = gc;
    commJson["parCode"] = parCode

    $.ifvSyncPostJSON(url, commJson, function (result) {
        getPostSon(result);
    });


    function getPostSon(result) {
        if (!result.rows) {
            result.rows = result;
        }

        if (result.rows.length < 1) {
            $("#" + tarId).find("option").remove();
            return;
        }
        if (def === true) {
            var defamp = "<option value=''>--선택해주세요-- </option>";
            $("#" + tarId).append(defamp);
        } else {
            var defamp = "<option value=''></option>";
            $("#" + tarId).append(defamp);
        }
        var aptemp = $("#commCodeSelectTemplate").tmpl(result.rows);
        $("#" + tarId).append(aptemp);
    }


}

var fnIfvExcelDownload = function (gridId) {

    var grid = null;
    var gridId = "gridId" + gridId;
    if (gridId instanceof jQuery) {
        grid = gridId;
    } else {
        grid = $("#" + gridId);
    }

    grid = $("#" + gridId).data('ejGrid');
    var columns = grid.model.columns;

    var colNames = [], colModels = [];

    for (var i = 0; i < columns.length; i++) {
        if (columns[i].type == "checkbox" || columns[i].type == "radio") continue;
        colNames.push(columns[i].headerText);
        var colModelObj = {};
        colModelObj.name = columns[i].field;
        colModelObj.index = columns[i].customAttributes.index;
        colModels.push(colModelObj);
    }

    var actionUrl = grid.model.dataUrl;
    var records = grid.model.requestGridData.records;
    var postData = $.extend(grid.model.requestGridData, {page: 1, rows: records});

    var d = new Date();
    var fileName = gridId + "_" + d.getFullYear() + "" + (d.getMonth() + 1) + "" + d.getDate() + "" + d.getHours() + "" + d.getMinutes() + "" + d.getSeconds();


    $.ifvSyncPostJSON(actionUrl, postData
        ,
        function (result) {
            if (result.rows.length == 0) {
                alert("데이터가 존재하지 않습니다.");
            } else {
                $.ifvSyncPostJSON('/loyalty/common/excelExport.do',
                    {
                        fileName: fileName,
                        header: colModels,
                        headerName: colNames,
                        data: result.rows
                    },
                    function (result) {
                        location.href = result.message;
                    }
                );
            }
        }, function (result) {
            alert("엑셀 다운로드를 실패 하였습니다. 관리자에게 문의하십시오.");
        }
    );
}

var fnIfvExcelDownload2 = function (gridId) {

    var grid = null;
    var gridId = "gridId" + gridId;
    if (gridId instanceof jQuery) {
        grid = gridId;
    } else {
        grid = $("#" + gridId);
    }

    var gridObj = grid.getGridParam();
    var colNames = gridObj.colNames; // Grid Names
    var colModels = gridObj.colModel; // Grid Models
    var actionUrl = gridObj.url;
    actionUrl = actionUrl.split(".")[0] + "Excel." + actionUrl.split(".")[1];
    var record = gridObj.records;
    var orderby = gridObj.sortname;
    var d = new Date();
    var fileName = gridObj.gridId + "_" + d.getFullYear() + "" + (d.getMonth() + 1) + "" + d.getDate() + "" + d.getHours() + "" + d.getMinutes() + "" + d.getSeconds();
    var postData = gridObj.postData;
    postData.rows = record;
    postData.page = 1;
    postData.excelObj = {
        headerName: colNames,
        header: colModels,
        fileName: fileName
    };


    $.ifvSyncPostJSON(actionUrl, postData
        ,
        function (result) {
            console.log(result);
            location.href = result.message;

        }, function (result) {
            alert("엑셀 다운로드를 실패 하였습니다. 관리자에게 문의하십시오.");
        }
    );
}

var fnExcelUpload = function (obj, cbFn, afterSelectFile) {
    var dbClick = true;
    $("#fileUpload").remove();
    $("body").append("<input id='fileUpload' type='file' name='fileUpload' charset=utf-8  style='display: none;'>");

    fnExcelUpload.data = null;
    fnExcelUpload.fileName = null;

    fnExcelUpload.upload = function () {
        //$.ajaxSetup({async:true});
        $.ifvProgressControl(true);
        $.ajaxSetup({async: false});

        if (!fnExcelUpload.data) {
            alert("파일이 선택 되지 않았습니다.");
            return false;
        }
        if (dbClick) {
            fnExcelUpload.data.submit();
            dbClick = false;
            //$('body').append('<div class="loading">처리중<div>');
        }

        return true;
    };

    $("#fileUpload").fileupload({
        url: obj.url
        , type: "POST"
        , dataType: "json"
        , contentType: "application/json"
        , cache: false
        , processData: false
        , contentType: false
        , add: function (e, data) {
            var uploadFile = data.files[0];
            var fileName = uploadFile.name;// 현재 업로드 된 파일의 이름을 가져온다.
            var ext = fileName.substring(fileName.lastIndexOf(".") + 1); // 파일 이름에서 확장자만 뽑아낸다.

            data.formData = {param: JSON.stringify(obj)};

            var isValid = true;

            if (!(ext == "xlsx") && !(ext == "xls")) { // 확장자가 xls가 아니라면 오류 메시지 출력
                alert("Excel File (xlsx, xls)만 가능 합니다.");
                isValid = false;
            } else if (uploadFile.size > 20000000) { // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
                alert("파일 용량은 12메가를 초과할 수 없습니다.");
                isValid = false;
            }
            if (isValid) {
                fnExcelUpload.data = data;
                fnExcelUpload.fileName = data.files[0].name;
                afterSelectFile();
            }
        }
        , success: function (data) {
            dbClick = true;
            $.ifvProgressControl(false);
            cbFn(data.data);
        }
        , fail: function (e, data) {
            dbClick = true;
            $.ifvProgressControl(false);
            alert("서버와 통신 중 문제가 발생했습니다");

        }
        , complete: function (xhr, status) {
            $.ajaxSetup({async: false});
            $.ifvProgressControl(false);
        }
    });

    $("#fileUpload").trigger("click");
};

//일괄등록 엑셀다운
$.fn.ifvmBatchRgstExcelDownload = function (data) {
    var inputs = "";
    var url = "/loyalty/batchRgst/gridExcelDown.do";
    var method = "post"
    //data를 입력받음
    if (data) {
        if ($.fn.ifvmIsNotEmpty(data.fileName) && $.fn.ifvmIsNotEmpty(data.filePath)) {
            inputs += '<input type="hidden" name="fileName" value="' + data.fileName + '" />';
            inputs += '<input type="hidden" name="filePath" value="' + data.filePath + '" />';
            inputs += '<input type="hidden" name="rid" value="' + data.fileRid + '" />';

            // request를 보낸다.
            jQuery('<form action="' + url + '" method="' + (method || 'post') + '">' + inputs + '</form>')
                .appendTo('body').submit().remove();
        }
    }
    ;
};

$.fn.DrawTab = function (options) {
    this.options = $.extend({
        item: []
        , term: 30
        , tabWidth: 0
        , moveWidth: 0
        , template: {
            wrap: '<div class="tab-mask"></div>',
            list: '<div class="tab-list-mask"><ul class="tab-list"></ul></div>',
            listItem: '<li><a></a></li>',
            scrollControl: '<div class="scroll-control"><button type="button" class="scroll-prev"></button><button type="button" class="scroll-next"></button></div>',
            hideTabWrap: '<div class="hide-tab"><button type="button" class="btn-open-tab"><i class="fa fa-chevron-down" aria-hidden="true"></i></button></div>',
            hideTabList: '<ul class="hide-tab-list"></ul>',
            hideTabListItem: '<li><a></a></li>',
            tabContent: '<div class="tab-contents"></div>'
        }
        , afterContentLoad: null
        , scrollControl: false
    }, options);

    this.baseSetting = function () {
        this.options.tabContainer = $(this.options.template.wrap).appendTo($(this));
        this.options.tabListMask = $(this.options.template.list).appendTo(this.options.tabContainer);
        this.options.tabList = this.options.tabListMask.find('.tab-list');

        for (var i = 0; i < this.options.item.length; i++) {
            var obj = $(this.options.template.listItem);
            obj.appendTo(this.options.tabList);
            var objCode = this.options.item[i]["objCode"];

            if (objCode) {
                obj.attr("objCode", objCode);
            }

            this.options.tabList.find('> li').eq(i).find('a').attr({'href': this.options.item[i].href}).html(this.options.item[i].label);
            this.options.tabWidth += $('.tab-list > li').eq(i).outerWidth() + 3;
        }

        $(this.options.tabList).css({'width': this.options.tabWidth, 'margin-left': 0});
        this.options.tabContent = $(this.options.template.tabContent).appendTo($(this));
    }

    this.scrollingSetting = function () {
        this.options.hideTabContainer = $(this.options.template.hideTabWrap).appendTo(this.options.tabContainer);
        this.options.hideTabList = $(this.options.template.hideTabList).appendTo(this.options.hideTabContainer);
        for (var i = 0; i < this.options.item.length; i++) {
            $(this.options.template.hideTabListItem).appendTo(this.options.hideTabList);
            this.options.hideTabList.find('> li').eq(i).find('a').attr({'href': this.options.item[i].href}).html(this.options.item[i].label);
        }

        if (this.options.scrollControl)
            this.options.scrollController = $(this.options.template.scrollControl).appendTo(this.options.tabListMask);
    }

    this.moveHighlightTab = function (idx) {
        var itemOffsetLeft = this.options.tabList.find('> li').eq(idx).offset().left + this.options.tabList.find('> li').eq(idx).outerWidth() - parseInt(this.options.tabList.css('margin-left'), 10) - $(this).offset().left;

        if ($(this.options.tabListMask).width() < itemOffsetLeft) {
            $(this.options.tabList).css({
                'margin-left': this.options.tabListMask.width() - itemOffsetLeft + 'px'
            });
        } else {
            this.options.tabList.css({
                'margin-left': '0px'
            });
        }
    }

    this.eventSetting = function () {
        var _this = this;
        this.options.tabList.find('> li > a').off().on('click', function (e) {
            e.preventDefault();
            var itemIdx = $(this).parent().index();
            _this.options.tabList.find('> li.on').removeClass('on');
            $(this).parent().addClass('on');
            _this.options.hideTabList.find('> li.on').removeClass('on');
            _this.options.hideTabList.find('> li').eq(itemIdx).addClass('on');
            _this.contentSetting($(this).attr('href'));
        });

        this.options.hideTabContainer.find('button').off().on('click', function () {
            _this.options.hideTabList.toggle();
        });

        this.options.hideTabList.find('> li > a').off().on('click', function (e) {
            e.preventDefault();
            var itemIdx = $(this).parent().index();
            _this.options.hideTabList.find('> li.on').removeClass('on');
            $(this).parent().addClass('on');
            _this.options.tabList.find('> li').eq(itemIdx).find('> a').trigger('click');
            _this.moveHighlightTab(itemIdx);
            _this.options.hideTabList.hide();
        });

        if (this.options.scrollControl) {
            this.options.tabListMask.hover(
                function () {
                    _this.options.scrollController.show();
                },
                function () {
                    _this.options.scrollController.hide();
                }
            );

            this.options.scrollController.find('.scroll-next').off().on('click', function (e) {
                e.stopPropagation();
                var totalW = _this.options.tabListMask.outerWidth() - parseInt(_this.options.tabList.css('margin-left'));
                if (_this.options.tabList.outerWidth() <= totalW) {
                    return;
                } else {
                    _this.options.tabList.css({
                        'margin-left': (parseInt(_this.options.tabList.css('margin-left')) - _this.options.term) + 'px'
                    });
                }
            });

            this.options.scrollController.find('.scroll-prev').off().on('click', function (e) {
                e.stopPropagation();
                if (parseInt(_this.options.tabList.css('margin-left')) !== 0) {
                    var ml = parseInt(_this.options.tabList.css('margin-left')) + _this.options.term < 0 ? parseInt(_this.options.tabList.css('margin-left')) + _this.options.term : 0;
                    _this.options.tabList.css({
                        'margin-left': ml + 'px'
                    });
                }
            });
        }
    }

    this.contentSetting = function (url) {
        var _this = this;
        this.options.tabContent.empty().html("").load(url, this.options.afterContentLoad);
        /*$.ifvCachedHtml( url ).done( function(script, textStatus){
            _this.options.tabContent.empty().html("").append(script);
            //if( window[fileName + '_init'] != null ) window[fileName + '_init']();
        });*/
    }

    this.moveTabIndex = function (idx) {
        this.options.hideTabList.find('> li.on').removeClass('on');
        this.options.hideTabList.find('> li').eq(idx).addClass('on');

        this.options.tabList.find('> li.on').removeClass('on');
        this.options.tabList.find('> li').eq(idx).addClass('on');
        this.contentSetting(this.options.tabList.find('> li.on > a').attr('href'));

        this.moveHighlightTab(idx);
        this.options.hideTabList.hide();
        //this.options.hideTabList.children('li').eq(idx).children('a').trigger('click');
    }

    this.resizeEvent = function () {
        //console.log('tab wrap width : ' + $(this).width());
        //console.log('tab total width : ' + this.options.tabList.width());
        if ($(this).width() < this.options.tabList.width()) {
            this.options.tabContainer.css({'padding-right': '26px'});
            this.options.hideTabContainer.find('button').show();
            this.eventSetting();
            this.moveHighlightTab(this.options.tabList.find('li.on').index());
        } else {
            this.options.tabContainer.css({'padding-right': '0px'});
            this.options.tabList.css({'margin-left': '0px'});
            this.options.hideTabContainer.find('button').hide();
            this.options.hideTabList.hide();
            this.options.tabListMask.off();
            this.options.tabContainer.off();
        }
    }

    this.resizeEventSetting = function () {
        var _this = this;
        this.options.resizeTimeout = '';

        window.onresize = function () {
            var __this = _this;
            clearTimeout(_this.options.resizeTimeout);
            _this.options.resizeTimeout = setTimeout(function () {
                __this.resizeEvent();
            }, 100);
        };

    }

    //disabled tab 추가
    this.disabledTab = function (idxArr) {
        var $disabledItem = $(this).find(".tab-list");
        for (var i = 0; i < idxArr.length; i++) {
            var tabIdx = idxArr[i];
            $disabledItem.find("> li").eq(tabIdx).addClass("disabled");
        }
    }

    this.abledTab = function (idxArr) {
        var $disabledItem = $(this).find(".tab-list");
        for (var i = 0; i < idxArr.length; i++) {
            var tabIdx = idxArr[i];
            $disabledItem.find("> li").eq(tabIdx).removeClass("disabled");
        }
    }

    this.disabledTabAll = function () {
        $(this).find(".tab-list li").addClass('disabled');
    }

    this.abledTabAll = function () {
        $(this).find(".tab-list li").removeClass('disabled');
    }

    /* 2018-02-05 sjbaek 현재 액티브 탭 index 반환 */
    this.getActiveIndex = function () {
        return this.find('.tab-list li.on').index();
    }

    /* 2018-02-05 sjbaek 현재 액티브인 탭 reload */
    this.reloadCurrentTab = function () {
        this.moveTabIndex(this.getActiveIndex());
    }

    /* 2020-01-07 sjbaek tabid값 기준으로 tab 이동기능 추가 */
    this.moveTabByTabId = function (tabid) {
        var targetTab = $(this).find('a[data-tabid=' + tabid + ']')
        if (targetTab.length === 1) {
            targetTab.trigger('click')
        }
    }

    this.init = function () {
        this.baseSetting();
        this.scrollingSetting();
        this.eventSetting();
        this.resizeEventSetting();
        this.resizeEvent();
        this.moveTabIndex(0);

        if (window["fnLayoutAuth"]) {
            fnLayoutAuth();
        }
    }

    this.init();

    return this;
}

/* 20180723 sjbaek 함수위치이동(캠페인워크플로우 -> util.js */
/**
 * validation 실패 메세지 출력
 */
function validFailMessage(input, msg) {

    input.addClass('ifv_vali_wrong');
    input.parent().css('position', 'relative');

    var valiItem = $("<div class='vali_tooltip'>");
    var valiContent = $("<div class='vali_content'>");
    var valiArrow = $("<div class='vali_arrow'>");

    valiItem.append(valiContent);
    valiItem.append(valiArrow);

    valiContent.text(msg);

    var offset = input.offset();
    valiItem.css({left: offset.left, top: offset.top, opacity: 0});
    $('body').append(valiItem);

    var vwidth = valiItem.outerWidth();
    var vheight = valiItem.outerHeight();

    valiItem.css({left: offset.left, top: offset.top - vheight - 10,});

    valiItem.stop().animate({opacity: 1}, 200, function () {
        valiItem.delay(1000).animate({opacity: 0}, 50, function () {
            valiItem.remove();
            input.removeClass('ifv_vali_wrong');
        });
    });
}

$.fn.ifvmExcelSampleDown = function (data) {
    var inputs = "";
    var url = "/common/excelSampleDown.do";
    var method = "post"
    //data를 입력받음
    if (data) {
        if ($.fn.ifvmIsNotEmpty(data.offerType)) {
            inputs += '<input type="hidden" name="offerType" value="' + data.offerType + '" />';
        }

        if ($.fn.ifvmIsNotEmpty(data.fileName)) {
            inputs += '<input type="hidden" name="fileName" value="' + data.fileName + '" />';
        }

        // request를 보낸다.
        jQuery('<form action="' + url + '" method="' + (method || 'post') + '">' + inputs + '</form>')
            .appendTo('body').submit().remove();
    }
    ;
}
var QTExcelUpload = function (params) {
    var clickFlag = false;
    var uploadData = null;
    var init = function (params) {
        $('#uploadFile').remove();

        var uploadDom = $('<input type="file" id="uploadFile" name="uploadFile" style="display: none;">');
        $('body').append(uploadDom);

        var _params = $.extend(true, {
            type: 'POST',
            cache: false,
            processData: false,
            contentType: false,
            async: true,
            add: function (e, data) {
                var uploadFile = data.files[0];
                var fileName = uploadFile.name;

                var isValid = true;
                if (!(/\.(xls|xlsx)$/.test(fileName))) { // 확장자가 엑셀 확장자가 아니라면 처리 X
                    alert("Excel File (XLSX, XLS)만 가능 합니다.");
                    isValid = false;
                }

                if (uploadFile.size > 12000000) { // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
                    alert("파일 용량은 12메가를 초과할 수 없습니다.");
                    isValid = false;
                }

                if (isValid) {
                    uploadData = data;

                    if (_params.fileNameDom && _params.fileNameDom.length !== 0) {
                        _params.fileNameDom.val(fileName);
                    }
                }
            },
            success: function (data) {
                $.ifvProgressControl(false);

                var callback = params.callbackSuccess;
                if (callback && typeof (callback) === 'function') {
                    callback(data);
                }
            },
            fail: function (e, data) {
                alert('서버와 통신 중 문제가 발생했습니다.');
                $.ifvProgressControl(false);
            },
            complete: function (xhr, status) {
                clickFlag = true;
                $.ifvProgressControl(false);
            }
        }, params);

        uploadDom.fileupload(_params);
        uploadDom.trigger('click');
        clickFlag = true;
    };

    this.setupFormData = function (formData) {
        uploadData.formData = formData || {};
    }

    this.executeUpload = function () {
        if (!uploadData) {
            alert("파일이 선택 되지 않았습니다.");
            return false;
        }

        if (clickFlag) {
            $.ifvProgressControl(true);

            uploadData.submit();
            clickFlag = false;
        }
    };

    init(params);

    return this;
};

var QTExcelDownload = function (url, params) {
    $.ifvProgressControl(true);

    var _params = $.extend(params, {
        appServiceId: window.appServiceId,
        country: window.country,
        lang: window.lang
    });

    $.ifvPostJSON(url, _params, function (response) {
        $.ifvProgressControl(false);

        $.fn.ifvmExcelDownload({
            realFileName: response.fileName,
            fileName: response.fileName,
            filePath: response.filePath,
            isResource: false
        });
    }, function (response) {
        $.ifvProgressControl(false);

        alert(response.message);
    });
};

$.fn.findMaxZIndex = function () {
    return Math.max(
        ...Array.from(
            document.querySelectorAll('body *'),
            el => parseFloat(window.getComputedStyle(el).zIndex)
        ).filter(zIndex => !Number.isNaN(zIndex)),
        0,
    );
};

$.fn.setupHelpMessage = function () {
    this.hover(function () {
        $('.tooltip').remove();

        var text = $(this).children(".helptxt").html();
        var max_z_index = $.fn.findMaxZIndex() + 1;

        $('<p class="tooltip" style="z-index: ' + max_z_index + '"></p>')
            .html(text)
            .prependTo('body')
            .fadeIn('slow');
    }, function () {
        $('.tooltip').remove();
    }).mousemove(function (e) {
        var mousex = e.pageX + 20; //Get X coordinates
        var mousey = e.pageY + 10; //Get Y coordinates
        $('.tooltip')
            .css({top: mousey, left: mousex})
    });
};