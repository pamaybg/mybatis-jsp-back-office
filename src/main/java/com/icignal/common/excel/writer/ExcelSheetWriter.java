package com.icignal.common.excel.writer;

import com.icignal.common.excel.annotations.ExcelField;
import com.icignal.common.excel.annotations.ExcelHeader;
import com.icignal.common.excel.vo.ExcelCellMergeVo;
import com.icignal.common.excel.vo.ExcelCustomDataVo;
import com.icignal.common.excel.vo.ExcelFieldVo;
import com.icignal.core.exception.DataFailException;
import org.apache.poi.ss.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

public class ExcelSheetWriter {

    final protected Sheet sheet;
    final protected Map<String, CellStyle> styleMap;
    final protected List<String> headerKeyList = new ArrayList<>();
    final protected AtomicInteger headerIndex = new AtomicInteger(0);
    final protected Map<String, ExcelFieldVo> fieldMap = new HashMap<>();

    protected Boolean setupHeaderMerges = false;
    protected ExcelCellMerger cellMerger;

    protected Boolean setupHeaders = false;
    protected Boolean useHeader = true;
    protected Integer rowNum = 0;
    protected Integer rowDataStartNum = 0;
    protected Class<?> clazz;

    public ExcelSheetWriter(Workbook workbook, String sheetName, Map<String, CellStyle> styleMap) {
        this.sheet = workbook.createSheet(sheetName);
        this.styleMap = styleMap;
    }

    public ExcelSheetWriter(Sheet sheet, Map<String, CellStyle> styleMap) {
        this.sheet = sheet;
        this.styleMap = styleMap;
    }

    public void setupTargetClass(Class<?> clazz) {
        this.clazz = clazz;

        if (clazz.isAnnotationPresent(ExcelHeader.class)) {
            ExcelHeader header = clazz.getAnnotation(ExcelHeader.class);

            this.useHeader = header.useHeader();

            int startLineNum = header.startLineNum();
            if (startLineNum > -1) {
                this.rowNum = startLineNum;
            }

            if (header.mergeCellsList().length > 0) {
                this.cellMerger = ExcelCellMerger.getInstance(this.sheet, this.styleMap, header.mergeCellsList());
            }

            if (header.fields().length > 0) {
                this.fieldMap.putAll(
                        Arrays.stream(header.fields())
                                .collect(
                                        Collectors.toMap(
                                                ExcelField::headerKey,
                                                a -> new ExcelFieldVo(a, this.headerIndex.getAndIncrement()),
                                                (prev, next) -> prev
                                        )
                                )
                );
            }
        }

        Field[] fields = clazz.getDeclaredFields();
        this.fieldMap.putAll(
                Arrays.stream(fields)
                        .filter(f -> f.isAnnotationPresent(ExcelField.class))
                        .collect(
                                Collectors.toMap(
                                        Field::getName,
                                        f -> new ExcelFieldVo(f, f.getAnnotation(ExcelField.class), this.headerIndex.getAndIncrement()),
                                        (prev, next) -> prev
                                )
                        )
        );

        this.setupHeaderKeyList();
    }

    public void addSheetDataList(List<?> dataList) {
        if (this.useHeader) {
            this.checkHeaderMerges();
            this.checkHeaderKeyList(dataList);
        }

        this.rowDataStartNum = this.rowNum;

        Row row;
        for (Object data : dataList) {
            row = this.getRow();

            this.setupSheetData(row, data);
        }
    }

    protected void checkHeaderMerges() {
        if (!this.setupHeaderMerges && this.cellMerger != null) {
            this.rowNum = this.cellMerger.execute(this.rowNum);
        }
        this.setupHeaderMerges = true;
    }

    protected void checkHeaderKeyList(List<?> dataList) {
        if (!this.setupHeaders && dataList != null && !dataList.isEmpty() && dataList.get(0) instanceof Map) {
            Map<?, ?> dataMap = (Map<?, ?>) dataList.get(0);
            Set<?> keySet = dataMap.keySet();

            Map<String, ExcelFieldVo> fieldMap = keySet.stream()
                    .map(String::valueOf)
                    .collect(Collectors.toMap(key -> key, key -> new ExcelFieldVo(key, key, this.headerIndex.getAndIncrement())));
            this.fieldMap.putAll(fieldMap);

            List<String> headerKeyList = keySet.stream()
                    .map(String::valueOf)
                    .collect(Collectors.toList());

            this.setupHeaders = true;
            this.headerKeyList.addAll(headerKeyList);
        }

        this.setupHeaderCell();
    }

    protected void setupHeaderKeyList() {
        List<String> headerKeyList;

        if (this.clazz != null) {
            headerKeyList = this.fieldMap.values().stream()
                    .sorted(Comparator.comparing(ExcelFieldVo::getIndex))
                    .map(ExcelFieldVo::getHeaderKey)
                    .collect(Collectors.toList());
        } else {
            throw new DataFailException("엑셀을 생성할 수 없습니다.\n관리자에게 문의해주세요.");
        }

        this.setupHeaders = true;
        this.headerKeyList.addAll(headerKeyList);
    }

    protected void setupHeaderCell() {
        Row row = this.getRow();

        Cell cell;
        for (String headerKey : this.headerKeyList) {
            ExcelFieldVo vo = this.fieldMap.get(headerKey);
            String headerName = vo.getHeaderName();
            if (vo.getHeaderName() != null && !headerName.isEmpty()) {
                int index = vo.getIndex();

                cell = row.getCell(index, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                cell.setCellStyle(this.styleMap.get("HEADER"));
                cell.setCellValue(vo.getHeaderName());
            }
        }
    }

    public void addTitle(String title) {
        Row row = this.getRow();
        Cell cell = row.createCell(0);
        cell.setCellStyle(this.styleMap.get("TITLE"));
        cell.setCellValue(title);
    }

    public void addHeaderNameList(List<ExcelFieldVo> headerDataList) {
        Map<String, ExcelFieldVo> appendFieldMap = headerDataList.stream()
                .collect(
                        Collectors.toMap(
                                ExcelFieldVo::getHeaderKey,
                                vo -> new ExcelFieldVo(vo, this.headerIndex.getAndIncrement()),
                                (prev, next) -> prev
                        )
                );
        this.fieldMap.putAll(appendFieldMap);

        List<String> appendHeaderKeyList = headerDataList.stream()
                .map(ExcelFieldVo::getHeaderKey)
                .collect(Collectors.toList());
        this.headerKeyList.addAll(appendHeaderKeyList);
    }

    public void addSheetHorizontalCustomDataList(List<ExcelCustomDataVo> customDataList) {
        Row row = this.getRow();
        Cell cell;

        int column = 0;
        for (ExcelCustomDataVo customData : customDataList) {
            cell = row.createCell(column++);
            cell.setCellStyle(this.styleMap.get("HEADER"));
            cell.setCellValue(customData.getHeader());

            cell = row.createCell(column++);
            Object value = customData.getValue();
            if (value != null && !"".equals(value)) {
                this.convertValue(cell, value);
            } else {
                cell.setCellValue("");
            }
        }
    }

    public void addSheetVerticalCustomDataList(List<ExcelCustomDataVo> customDataList) {
        Row row = this.getRow();
        Cell cell;

        int column = 0;
        for (ExcelCustomDataVo customData : customDataList) {
            cell = row.createCell(column++);
            cell.setCellStyle(this.styleMap.get("HEADER"));
            cell.setCellValue(customData.getHeader());
        }

        row = this.getRow();
        column = 0;
        for (ExcelCustomDataVo customData : customDataList) {
            cell = row.createCell(column++);

            Object value = customData.getValue();
            if (value != null && !"".equals(value)) {
                this.convertValue(cell, value);
            } else {
                cell.setCellValue("");
            }
        }
    }

    public void addEmptyRow() {
        this.sheet.createRow(this.rowNum++);
    }

    public Integer getRowDataStartNum() {
        return this.rowDataStartNum;
    }

    protected Row getRow() {
        if (this.sheet.getRow(this.rowNum) != null) {
            return this.sheet.getRow(this.rowNum++);
        }

        return this.sheet.createRow(this.rowNum++);
    }

    protected void setupSheetData(Row row, Object data) {
        int column = 0;
        Cell cell;
        for (String headerKey : this.headerKeyList) {
            ExcelFieldVo vo = this.fieldMap.get(headerKey);

            cell = row.createCell(vo.getIndex());
            cell.setCellStyle(this.styleMap.get(vo.getStyleName()));

            if (!vo.getSequence()) {
                Object value = this.getValue(vo, data);

                if (value != null && !"".equals(value)) {
                    this.convertValue(cell, value);
                } else {
                    cell.setCellValue("");
                }
            } else {
                cell.setCellValue(this.rowNum - 1);
            }
        }
    }

    protected Object getValue(ExcelFieldVo vo, Object data) {
        Object value;
        try {
            if (this.clazz != null) {
                value = this.getFieldValue(vo, data);
            } else if (data instanceof Map) {
                value = this.getMapValue(vo, data);
            } else {
                value = "";
            }
        } catch (Exception e) {
            value = "";
        }

        return value;
    }

    protected Object getFieldValue(ExcelFieldVo vo, Object data) throws IllegalAccessException {
        Field f = vo.getField();
        if (f != null) {
            f.setAccessible(true);
            return f.get(data);
        } else if (data instanceof Map) {
            return this.getMapValue(vo, data);
        } else {
            throw new DataFailException("알 수 없는 데이터 유형 입니다.");
        }
    }

    protected Object getMapValue(ExcelFieldVo vo, Object data) {
        return ((Map<?, ?>) data).get(vo.getHeaderKey());
    }

    protected void convertValue(Cell cell, Object value) {
        if (Number.class.isAssignableFrom(value.getClass())) {
            cell.setCellValue(new BigDecimal(value.toString()).doubleValue());
        } else {
            cell.setCellValue(value.toString());
        }
    }

    public void setupMergeCells(ExcelCellMergeVo mergeCell) {
        this.setupMergeCells(mergeCell, false);
    }

    public void setupMergeCells(ExcelCellMergeVo mergeCell, boolean changeStyle) {
        this.setupMergeCells(Collections.singletonList(mergeCell), changeStyle);
    }

    public void setupMergeCells(List<ExcelCellMergeVo> mergeCellList) {
        this.setupMergeCells(mergeCellList, false);
    }

    public void setupMergeCells(List<ExcelCellMergeVo> mergeCellList, boolean changeStyle) {
        ExcelCellMerger.getInstance(this.sheet, this.styleMap, mergeCellList).execute(changeStyle);
    }

    public void cleanupSetting() {
        this.headerKeyList.clear();
        this.headerIndex.set(0);
        this.fieldMap.clear();

        this.setupHeaderMerges = false;
        this.cellMerger = null;

        this.setupHeaders = false;
    }

}