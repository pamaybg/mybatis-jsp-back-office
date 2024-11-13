package com.icignal.common.util;

import com.icignal.common.util.ExcelUtil.ExcelSpreadSheetWriter;
import org.apache.poi.ss.usermodel.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;


/**
 * Excel Style Utility
 *
 * @author qtsys-m07
 */
public class ExcelStyles {

    public enum COL_FORMAT {
        ALIGN_L // 좌측
        , ALIGN_C // 가운데
        , ALIGN_R // 우측
        , YEARTEXT // YYYY
        , YEARMONTHTEXT // YYYYMM
        , DATETEXT // YYYYMMDD
        , TIMETEXT // HHMISS
    }

    public enum MERGE_CELL {
        M // MULTIPLE
        , R // ROW
        , C // COLUMN
    }

    /**
     * XSSF 엑셀 스타일 설정
     *
     * @param workbook workbook
     */
    public static Map<String, CellStyle> createStyles(Workbook workbook) {
        Map<String, CellStyle> styles = new HashMap<>();
        DataFormat fmt = workbook.createDataFormat();

        short fontSize_15 = 0x12c; //300
        short fontSize_11 = 0xdc; //220

        CellStyle point = workbook.createCellStyle();
        point.setAlignment(HorizontalAlignment.RIGHT);
        point.setVerticalAlignment(VerticalAlignment.CENTER);
        point.setDataFormat(fmt.getFormat("#,##0"));
        styles.put("POINT", point);

        Font titleCommonFont = workbook.createFont();
        titleCommonFont.setBold(true);
        titleCommonFont.setFontHeight(fontSize_15);

        CellStyle title = workbook.createCellStyle();
        title.setFont(titleCommonFont);
        title.setAlignment(HorizontalAlignment.CENTER);
        title.setVerticalAlignment(VerticalAlignment.CENTER);
        styles.put("TITLE", title);

        CellStyle titleBg = workbook.createCellStyle();
        titleBg.setFont(titleCommonFont);
        titleBg.setAlignment(HorizontalAlignment.CENTER);
        titleBg.setVerticalAlignment(VerticalAlignment.CENTER);
        titleBg.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        titleBg.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        titleBg.setBorderTop(BorderStyle.THIN);
        titleBg.setBorderBottom(BorderStyle.THIN);
        titleBg.setBorderLeft(BorderStyle.THIN);
        titleBg.setBorderRight(BorderStyle.THIN);
        styles.put("TITLE_BG", title);

        CellStyle search = workbook.createCellStyle();
        Font searchFont = workbook.createFont();
        searchFont.setBold(true);
        search.setAlignment(HorizontalAlignment.LEFT);
        search.setVerticalAlignment(VerticalAlignment.CENTER);
        search.setFont(searchFont);
        styles.put("SEARCH", search);

        CellStyle header = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setFontHeight(fontSize_11);
        header.setAlignment(HorizontalAlignment.CENTER);
        header.setVerticalAlignment(VerticalAlignment.CENTER);
        header.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
        header.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        header.setFont(headerFont);
        header.setBorderTop(BorderStyle.THIN);
        header.setBorderBottom(BorderStyle.THIN);
        header.setBorderLeft(BorderStyle.THIN);
        header.setBorderRight(BorderStyle.THIN);
        styles.put("HEADER", header);

        CellStyle alignLeft = workbook.createCellStyle();
        alignLeft.setAlignment(HorizontalAlignment.LEFT);
        alignLeft.setVerticalAlignment(VerticalAlignment.CENTER);
        styles.put("ALIGN_L", alignLeft);

        CellStyle alignCenter = workbook.createCellStyle();
        alignCenter.setAlignment(HorizontalAlignment.CENTER);
        alignCenter.setVerticalAlignment(VerticalAlignment.CENTER);
        styles.put("ALIGN_C", alignCenter);

        CellStyle alignRight = workbook.createCellStyle();
        alignRight.setAlignment(HorizontalAlignment.RIGHT);
        alignRight.setVerticalAlignment(VerticalAlignment.CENTER);
        styles.put("ALIGN_R", alignRight);

        CellStyle emptyHeader = workbook.createCellStyle();
        emptyHeader.setBorderTop(BorderStyle.THIN);
        emptyHeader.setBorderBottom(BorderStyle.THIN);
        emptyHeader.setBorderLeft(BorderStyle.THIN);
        emptyHeader.setBorderRight(BorderStyle.THIN);
        styles.put("EMPTY_HEADER", emptyHeader);

        CellStyle yearText = workbook.createCellStyle();
        yearText.setAlignment(HorizontalAlignment.CENTER);
        yearText.setVerticalAlignment(VerticalAlignment.CENTER);
        yearText.setDataFormat(fmt.getFormat("yyyy"));
        styles.put("YEARTEXT", yearText);

        CellStyle yearMonthText = workbook.createCellStyle();
        yearMonthText.setAlignment(HorizontalAlignment.CENTER);
        yearMonthText.setVerticalAlignment(VerticalAlignment.CENTER);
        yearMonthText.setDataFormat(fmt.getFormat("yyyy-mm"));
        styles.put("YEARMONTHTEXT", yearMonthText);

        CellStyle dateText = workbook.createCellStyle();
        dateText.setAlignment(HorizontalAlignment.CENTER);
        dateText.setVerticalAlignment(VerticalAlignment.CENTER);
        dateText.setDataFormat(fmt.getFormat("yyyy-mm-dd"));
        styles.put("DATETEXT", dateText);

        CellStyle dateFullText = workbook.createCellStyle();
        dateFullText.setAlignment(HorizontalAlignment.CENTER);
        dateFullText.setVerticalAlignment(VerticalAlignment.CENTER);
        dateFullText.setDataFormat(fmt.getFormat("yyyy-mm-dd hh:mm:ss"));
        styles.put("DATEFULLTEXT", dateFullText);

        CellStyle timeText = workbook.createCellStyle();
        timeText.setAlignment(HorizontalAlignment.CENTER);
        timeText.setVerticalAlignment(VerticalAlignment.CENTER);
        timeText.setDataFormat(fmt.getFormat("hh:mm:ss"));
        styles.put("TIMETEXT", timeText);

        CellStyle footerStyle = workbook.createCellStyle();
        footerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        footerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        styles.put("FOOTER", footerStyle);

        CellStyle style1 = workbook.createCellStyle();
        style1.setAlignment(HorizontalAlignment.RIGHT);
        style1.setDataFormat(fmt.getFormat("#0.0#%"));
        styles.put("percent", style1);

        CellStyle style2 = workbook.createCellStyle();
        style2.setAlignment(HorizontalAlignment.CENTER);
        style2.setDataFormat(fmt.getFormat("0.0X"));
        styles.put("coeff", style2);

        CellStyle style3 = workbook.createCellStyle();
        style3.setAlignment(HorizontalAlignment.RIGHT);
        style3.setDataFormat(fmt.getFormat("$#,##0.00"));
        styles.put("currency", style3);

        CellStyle style6 = workbook.createCellStyle();
        style6.setShrinkToFit(true);
        styles.put("guide", style6);

        CellStyle style7 = workbook.createCellStyle();
        Font hlink_font = workbook.createFont();
        hlink_font.setUnderline(Font.U_SINGLE);
        hlink_font.setColor(IndexedColors.BLUE.getIndex());
        style7.setFont(hlink_font);
        styles.put("hyperlink", style7);

        CellStyle amount = workbook.createCellStyle();
        amount.setAlignment(HorizontalAlignment.RIGHT);
        amount.setDataFormat(fmt.getFormat("###,###,##0"));
        styles.put("AMOUNT", amount);

        CellStyle ratio = workbook.createCellStyle();
        ratio.setAlignment(HorizontalAlignment.RIGHT);
        ratio.setDataFormat(fmt.getFormat("###,###,##0.0#%"));
        styles.put("RATIO", ratio);

        CellStyle p1 = workbook.createCellStyle();
        p1.setAlignment(HorizontalAlignment.RIGHT);
        p1.setDataFormat(fmt.getFormat("###,###,##0.0"));
        styles.put("P1", p1);

        CellStyle p2 = workbook.createCellStyle();
        p2.setAlignment(HorizontalAlignment.RIGHT);
        p2.setDataFormat(fmt.getFormat("###,###,##0.00"));
        styles.put("P2", p2);

        CellStyle amountMillion = workbook.createCellStyle();
        amountMillion.setAlignment(HorizontalAlignment.RIGHT);
        amountMillion.setDataFormat(fmt.getFormat("#,##0,,"));
        styles.put("AMOUNT_MILLION", amountMillion);

        return styles;
    }

    private final static SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy", Locale.KOREA);
    private final static SimpleDateFormat yearmonthFormat = new SimpleDateFormat("yyyyMM", Locale.KOREA);
    private final static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
    private final static SimpleDateFormat dateFullFormat = new SimpleDateFormat("yyyyMMddhhmmss", Locale.KOREA);
    private final static SimpleDateFormat timeFormat = new SimpleDateFormat("hhmmss", Locale.KOREA);

    public static void excelFormat(Integer colNum, ExcelSpreadSheetWriter sw, Map<String, CellStyle> styles, Object value, Class<?> type, Integer pointIndex) throws Exception {
        if (String.class == type) { // 문자열일 경우, 엑셀 포맷을 통해 확인
            String excelFormat = "ALIGN_L";
            //	keyVO.getExcelFormat();
            ExcelStyles ces = new ExcelStyles();
            Calendar calendar = Calendar.getInstance();

            if (COL_FORMAT.YEARTEXT.name().equals(excelFormat)) { // 년
                calendar.setTime(ces.yearFormat.parse(value.toString()));
                sw.createCell(colNum, calendar, styles.get(excelFormat).getIndex());
            } else if (COL_FORMAT.YEARMONTHTEXT.name().equals(excelFormat)) { // 년월
                calendar.setTime(ces.yearmonthFormat.parse(value.toString()));
                sw.createCell(colNum, calendar, styles.get(excelFormat).getIndex());
            } else if (COL_FORMAT.TIMETEXT.name().equals(excelFormat)) { // 시분초
                calendar.setTime(ces.timeFormat.parse(value.toString()));
                sw.createCell(colNum, calendar, styles.get(excelFormat).getIndex());
            } else if (COL_FORMAT.DATETEXT.name().equals(excelFormat)) { // 년월일 or 년월일 시분초
                String dateValue = value.toString();
                if (dateValue.length() > 8) { // 값이 8자리 초과라면 시분초까지 있는 경우 이므로
                    calendar.setTime(ces.dateFullFormat.parse(value.toString()));
                    sw.createCell(colNum, calendar, styles.get("DATEFULLTEXT").getIndex());
                } else {
                    calendar.setTime(ces.dateFormat.parse(value.toString()));
                    sw.createCell(colNum, calendar, styles.get("DATETEXT").getIndex());
                }
            } else {
                sw.createCell(colNum, value.toString(), styles.get(excelFormat).getIndex());
            }
        } else {
            sw.createCell(colNum, Double.valueOf(value.toString()), pointIndex);
        }
    }
}
