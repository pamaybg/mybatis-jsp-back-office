<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">

    <div>
        <div class="col-xs-6" style="margin: 12px;">
            <img src="/resources/demo/eastarJet/demopoplogo_estar.png"/>
        </div>
        <div class="col-xs-5" style="text-align: right; padding-top:25px;">
            <span>마케팅관리자(10000001)</span>
        </div>
    <div>
        <img src="/resources/demo/eastarJet/demopopmain_estar.png"/>
    </div>
    <div style="padding:13px 18px 0px 18px;background: white;border-bottom: 1px solid #ddd;color: #F52A0E">
        <h6>EASTAR JET CRM System Demo</h6>
    </div>

    <div class="underline half_wrap top_well" id="transChnlPopWrap">

        <div class="form-horizontal">
            <div class="page_btn_area">
                <div class="row col-xs-5">
                    <span>회원조회</span><!-- 수신자 정보 조회 -->
                </div>
                <div class="col-xs-7 searchbtn_r">
                    <ifvm:inputNew type="button" btnFunc="gDemo.getUser" text="실 행" nuc="false"  /><!-- 회원조회 -->
                </div>
            </div>
            <div class="form-horizontal top_well clearfix" id="111aa">
                <div class="row clearfix">
                    <span>회원 선택 : </span>
                    <select class="selUser" id="userSel" style="width: 200px;">
                    </select>
                </div>
                <div class="row clearfix">
                    <span>회원 등급 : </span>
                    <span id="userTier"></span>
                </div>
                <div class="row clearfix">
                    <span>스타 포인트 : </span>
                    <spani id="userPoint"></spani>
                </div>
            </div>
        </div>

        <div class="form-horizontal">
            <div class="page_btn_area">
                <div class="row col-xs-5">
                    <span>포인트 적립</span><!-- 수신자 정보 조회 -->
                </div>
                <div class="col-xs-7 searchbtn_r">
                    <ifvm:inputNew type="button" btnFunc="gDemo.point.acrl" text="실 행" nuc="false"  /><!-- 회원조회 -->
                </div>
            </div>

            <div class="form-horizontal top_well clearfix">
                <div class="row clearfix">
                    <span>기본적립 : </span>
                    <span>탑승당 5% 정율 적립</span>
                </div>
                <div class="row clearfix">
                    <span>등급가산적립 : 1%씩 가산 추가적립 </span>
                </div>
                <div class="row clearfix">
                    <span>적립시점 : 탑승일 익일 적립 </span>
                </div>
                <div class="row clearfix">
                    <span>E CLS 이하제외 </span>
                </div>

                <div class="row clearfix">
                    <span>상품선택 : </span>
                    <select class="selProduct" id="acrlProduct" style="width: 200px;">
                    </select>
                </div>

                <div class="row clearfix">
                    <span>좌석선택 : </span>
                    <select id="acrlSeat" style="width: 200px;">
                    </select>
                </div>

                <div class="row clearfix">
                    <span>결제금액 : </span>
                    <input type="text" id="acrlAmt" style="width: 120px;"/>
                    <sapn>원</sapn>
                </div>

                <div class="row clearfix">
                    <span>구매채널 : </span>
                    <input type="text" id="acrlStore" style="width: 120px;" value="20038"/>
                </div>
            </div>
        </div>

        <div class="form-horizontal">
            <div class="page_btn_area">
                <div class="row col-xs-5">
                    <span>포인트 사용</span><!-- 수신자 정보 조회 -->
                </div>
                <div class="col-xs-7 searchbtn_r">
                    <ifvm:inputNew type="button" btnFunc="gDemo.point.use" text="실 행" nuc="false"  /><!-- 회원조회 -->
                </div>
            </div>

            <div class="form-horizontal top_well clearfix">
                <%--<div class="row clearfix">--%>
                <%--<span>상품구분 : 항공권/부가서비스 </span>--%>
                <%--</div>--%>
                <div class="row clearfix">
                    <span>상품코드 : </span>
                    <select class="selProduct" id="useProduct" style="width:120px;"></select>
                </div>

                <div class="row clearfix">
                    <span>사용포인트 : </span>
                    <input type="text" id="usePoint" style="width:120px;" onkeyup="gDemo.point.util.inputNumberFormat(this)"/>
                    <span>PT</span>
                </div>
            </div>
        </div>

        <div class="form-horizontal">
            <div class="page_btn_area">
                <div class="row col-xs-5">
                    <span>포인트 양도</span><!-- 수신자 정보 조회 -->
                </div>
                <div class="col-xs-7 searchbtn_r">
                    <ifvm:inputNew type="button" btnFunc="gDemo.point.assignment" text="실 행" nuc="false" /><!-- 회원조회
-->
                </div>
            </div>

            <div class="form-horizontal top_well clearfix">
                <div class="row clearfix">
                    <span>양도&nbsp;&nbsp;&nbsp;대상 : </span>
                    <select class="selUser" id="assignMbrNo" style="width: 120px">
                    </select>
                </div>
                <div class="row clearfix">
                    <span>양도포인트 : </span>
                    <input type="text" id="assignPoint" style="width:120px;" onkeyup="gDemo.point.util.inputNumberFormat(this)"/>
                    <span>PT</span>
                </div>
            </div>
        </div>

        <div class="form-horizontal">
            <div class="page_btn_area">
                <div class="row col-xs-5">
                    <span>포인트 구매</span><!-- 수신자 정보 조회 -->
                </div>
                <div class="col-xs-7 searchbtn_r">
                    <ifvm:inputNew type="button" btnFunc="gDemo.point.buy" text="실 행" nuc="false"  /><!-- 회원조회 -->
                </div>
            </div>

            <div class="form-horizontal top_well clearfix">
                <div class="row clearfix">
                    <span>1원 = 1PT </span>
                </div>
                <div class="row clearfix">
                    <span>구매포인트 : </span>
                    <input type="text" id="buyPoint" style="width:120px;" onkeyup="gDemo.point.util.inputNumberFormat(this)"/>
                    <span>PT</span>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="searchMbrPopCon" class="popup_container"></div>
<!--검색-->
<script>
    var gDemo = {
        init: function () {
            gDemo.draw.userInfo(".selUser");
            gDemo.draw.productInfo(".selProduct");
            gDemo.draw.seat("#acrlSeat");

            $(".btn-sm").mouseover(function (e) {
                $(e.target).parents(".form-horizontal")
                    .find(".top_well").css({"background-color": "#bee1ea"});

            });

            $(".btn-sm").mouseout(function (e) {
                $(e.target).parents(".form-horizontal")
                    .find(".top_well").css({"background-color": "#FFFFFF"});
            });


        },
        draw: {
            ddl: function (t, list) {
                list.forEach(function(item,index) {
                    var option =
                        "<option value='" + item.code + "'>"
                        + item.value
                        + "</option>";
                    $(t).append(option)
                });
            },
            seat: function (t) {
                var list = [
                    {
                        code: "E-CLASS",
                        value: "E-CLASS"
                    },
                    {
                        code: "F-CLASS",
                        value: "F-CLASS"
                    },
                    {
                        code: "C-CLASS",
                        value: "C-CLASS"
                    },
                    {
                        code: "D-CLASS",
                        value: "D-CLASS"
                    },
                ];

                gDemo.draw.ddl(t, list);
            },
            userInfo: function (t) {
                var list = [
                    {
                        code: "M1776",
                        value: "회원1 (M1776)"
                    },
                    {
                        code: "M1777",
                        value: "회원2 (M1777)"
                    },
                    {
                        code: "10961350",
                        value: "회원3 (10961350 등급:우수)"
                    }
                ];
                gDemo.draw.ddl(t, list);
            },
            productInfo: function (t) {
                $.ifvSyncPostJSON(
                    "/loyalty/product/getProductByBrd.do",
                    {
                        brdId: "eastarJet"
                    },
                    function (r) {
                        gDemo.draw.ddl(t, r);
                    });
            },
            productAir: function (t) {
                $.ifvSyncPostJSON(
                    "/loyalty/product/getProductByBrd.do",
                    {
                        brdId: "eastarJet"
                    },
                    function (r) {
                        gDemo.draw.ddl(t, r);
                    });
            }
        },

        getUser: function () {
        	$.ifvProgressControl(true);
            $.ifvSyncPostJSON(
                "/demo/api/point/getUser",
                {
                    mbrNo: $("#userSel").val()
                },
                function (r) {
                    $("#userTier").text(r.tiersNm);
                    $("#userPoint").text($.ifvNumberFormat(r.point));
                });
            setTimeout(function(){
                $.ifvProgressControl(false);
              }, 0);


        },

        point: {
            util: {
                getTranNo: function () {
                    var d = new Date();
                    var pad = function (n, width) {
                        n = n + "";
                        return n.length >= width ? n
                            : new Array(width - n.length + 1).join("0") + n;
                    };

                    return d.format("yyyymmddhhmmss") + pad(Math.floor(Math.random() * 100), 2);
                },

                alert: function (r) {
                    if (!r.message) {
                        r.message = "정상 처리 되었습니다";
                    }
                    alert(r.message);
                },

                inputNumberFormat: function (obj) {
                    obj.value = this.comma(this.uncomma(obj.value));
                },
                comma: function (str) {
                    str = String(str);
                    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
                },
                uncomma: function (str) {
                    str = String(str);
                    return str.replace(/[^\d]+/g, '');
                }
            },

            acrl: function () {
            	$.ifvProgressControl(true);
                var p = false;
                if (p = gDemo.valid.payment($("#acrlAmt").val())) {
                    $.ifvSyncPostJSON(
                        "/demo/api/point/acrl",
                        {
                            tranNo: gDemo.point.util.getTranNo(),
                            mbrNo: $("#userSel").val(),
                            txnAmt: gDemo.point.util.uncomma(p),
                            product: $("#acrlProduct").val(),
                            classCd: $("#acrlSeat").val(),
                            storeId: $("#acrlStore").val()
                        },
                        function (r) {
                            alert(r.totOccurPnt + "Point 가 적립되었습니다");
                        },
                        gDemo.point.util.alert
                    );
                }
                setTimeout(function(){
                    $.ifvProgressControl(false);
                  }, 0);
            },

            use: function () {
                var p = false;
                if (p = gDemo.valid.point($("#usePoint").val())) {
                    $.ifvSyncPostJSON(
                        "/demo/api/point/use",
                        {
                            tranNo: gDemo.point.util.getTranNo(),
                            mbrNo: $("#userSel").val(),
                            usePoint: gDemo.point.util.uncomma(p),
                            useType: "01", // 01 부가서비스 구매사용 , 02 항공권 구매사용 03, 기타사용
                            product: "ADD_SVC_0002",
                            storeId: "20038"
                        },
                        gDemo.point.util.alert,
                        gDemo.point.util.alert
                    );
                }
            },

            assignment: function () {
                var p = gDemo.valid.point($("#assignPoint").val());

                if (!p) return;

                var data =
                    {
                        tranNo: gDemo.point.util.getTranNo(),
                        mbrNo: $("#userSel").val(),
                        assignPoint: gDemo.point.util.uncomma(p),
                        assignType: "01", // 01선물 02 가족양도
                        assginMbrNo: $("#assignMbrNo").val(),
                        storeId: "20038"
                    };

                $.ifvSyncPostJSON(
                    "/demo/api/point/assignment",
                    data,
                    gDemo.point.util.alert,
                    gDemo.point.util.alert
                );
            },

            buy: function () {
                var p = false;
                if (p = gDemo.valid.point($("#buyPoint").val())) {
                    $.ifvSyncPostJSON(
                        "/demo/api/point/buy",
                        {
                            tranNo: gDemo.point.util.getTranNo(),
                            mbrNo: $("#userSel").val(),
                            buyPoint: gDemo.point.util.uncomma(p),
                            buyType: "01", // 01 구매
                            buyStore: "20038"
                        },
                        gDemo.point.util.alert,
                        gDemo.point.util.alert
                    );
                }
            }
        },

        valid: {
            msg: {
                KR: {buy: "사용할 포인트를 입력 해주세요.",
                	save: "결제금액을 입력 해주세요."}
            },
            lang: "KR",

            point: function (p) {
                if (!p) {
                    alert(gDemo.valid.msg.KR.buy);
                    return false;
                }
                return p.replaceAll(",");
            },
            payment: function (p) {
                if (!p) {
                    alert(gDemo.valid.msg.KR.save);
                    return false;
                }
                return p.replaceAll(",");
            }
        }
    };

    gDemo.init();
</script>
