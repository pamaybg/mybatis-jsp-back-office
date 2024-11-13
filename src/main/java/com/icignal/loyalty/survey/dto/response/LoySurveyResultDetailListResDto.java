package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.excel.annotations.ExcelField;
import com.icignal.common.excel.annotations.ExcelHeader;

import java.math.BigDecimal;
import java.util.HashMap;

@ExcelHeader(fields = {
        @ExcelField(headerKey = "no", headerName = "순번", cellType = Integer.class, styleName = "ALIGN_C"),
        @ExcelField(headerKey = "memberNo", headerName = "회원 번호", styleName = "ALIGN_C"),
        @ExcelField(headerKey = "joinDate", headerName = "참여 일시", styleName = "ALIGN_C"),
        @ExcelField(headerKey = "genderCodeName", headerName = "성별", styleName = "ALIGN_C"),
        @ExcelField(headerKey = "age", headerName = "나이대", styleName = "ALIGN_C"),
        @ExcelField(headerKey = "tierName", headerName = "등급", styleName = "ALIGN_C"),
        @ExcelField(headerKey = "productNames", headerName = "구입 제품"),
        @ExcelField(headerKey = "salesTotalAmount", headerName = "구매 금액", cellType = BigDecimal.class, styleName = "AMOUNT"),
        @ExcelField(headerKey = "salesActualAmount", headerName = "실 결제 금액", cellType = BigDecimal.class, styleName = "AMOUNT"),
        @ExcelField(headerKey = "storeType", headerName = "구입 점포 유형"),
        @ExcelField(headerKey = "area1Name", headerName = "구입 점포 지역"),
        @ExcelField(headerKey = "area2Name", headerName = "구입 점포 상세 지역"),
        @ExcelField(headerKey = "commercialName", headerName = "구입 점포 상권"),
        @ExcelField(headerKey = "storeName", headerName = "구입 점포명"),
        @ExcelField(headerKey = "salesDate", headerName = "구입 일자"),
        @ExcelField(headerKey = "salesWeekendType", headerName = "구입 요일"),
        @ExcelField(headerKey = "salesWeekend", headerName = "구입 요일_Raw"),
        @ExcelField(headerKey = "salesDateTimeType", headerName = "구입 시간대"),
        @ExcelField(headerKey = "salesDateTime", headerName = "구입 시간대_Raw"),
        @ExcelField(headerKey = "salesTypeName", headerName = "결제 접점"),
        @ExcelField(headerKey = "heartAmount", headerName = "제공 하트 수", cellType = BigDecimal.class, styleName = "AMOUNT"),
        @ExcelField(headerKey = "couponName", headerName = "제공 쿠폰 명"),
        @ExcelField(headerKey = "couponNo", headerName = "쿠폰 번호", styleName = "ALIGN_C")
})
public class LoySurveyResultDetailListResDto extends HashMap<String, Object> {
}