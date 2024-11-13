package com.icignal.common.excel.writer;

import com.icignal.common.excel.annotations.ExcelMergeCells;
import com.icignal.common.excel.vo.ExcelCellMergeVo;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ExcelCellMerger {

    final private Sheet sheet;
    final private List<List<ExcelCellMergeVo>> mergeCellsList;
    final private Map<String, CellStyle> styleMap;

    private ExcelCellMerger(Sheet sheet, Map<String, CellStyle> styleMap, List<ExcelCellMergeVo> mergeCells) {
        this.sheet = sheet;

        this.mergeCellsList = new ArrayList<>();
        this.mergeCellsList.add(mergeCells);

        this.styleMap = styleMap;
    }

    private ExcelCellMerger(Sheet sheet, Map<String, CellStyle> styleMap, ExcelMergeCells[] mergeCells) {
        this.sheet = sheet;
        this.mergeCellsList = Arrays.stream(mergeCells)
                .map(cells ->
                        Arrays.stream(cells.mergeCells())
                                .map(ExcelCellMergeVo::new)
                                .collect(Collectors.toList())
                )
                .collect(Collectors.toList());

        this.styleMap = styleMap;
    }

    static public ExcelCellMerger getInstance(Sheet sheet, Map<String, CellStyle> styleMap, List<ExcelCellMergeVo> mergeCells) {
        return new ExcelCellMerger(sheet, styleMap, mergeCells);
    }

    static public ExcelCellMerger getInstance(Sheet sheet, Map<String, CellStyle> styleMap, ExcelMergeCells[] mergeCells) {
        return new ExcelCellMerger(sheet, styleMap, mergeCells);
    }

    public Integer execute(int rowNum) {
        int num = 0;
        List<CellRangeAddress> addressList = new ArrayList<>();
        for (List<ExcelCellMergeVo> mergeCells : this.mergeCellsList) {
            Row row = this.sheet.createRow(rowNum);

            for (ExcelCellMergeVo mergeCell : mergeCells) {
                if (mergeCell.checkMergeRegion()) {
                    addressList.add(mergeCell.convertCellRangeAddress(rowNum));
                }

                Cell cell = row.getCell(mergeCell.convertStartReference(), Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                cell.setCellStyle(this.styleMap.get("HEADER"));
                cell.setCellValue(mergeCell.getTitle());

                if (num < mergeCell.getMergeRows()) {
                    num = mergeCell.getMergeRows();
                }
            }

            num--;
            rowNum++;
        }

        this.addMergedRegions(addressList, true);

        return rowNum + num;
    }

    public void execute() {
        this.execute(false);
    }

    public void execute(boolean changeStyle) {
        List<CellRangeAddress> addressList = new ArrayList<>();
        for (List<ExcelCellMergeVo> mergeCells : this.mergeCellsList) {
            for (ExcelCellMergeVo mergeCell : mergeCells) {
                int rowNum = mergeCell.getRowNum();
                Row row = this.sheet.getRow(rowNum);

                if (mergeCell.checkMergeRegion()) {
                    addressList.add(mergeCell.convertCellRangeAddress(rowNum));
                }

                Cell cell = row.getCell(mergeCell.convertStartReference(), Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                cell.setCellValue(mergeCell.getTitle());
                if (changeStyle) {
                    cell.setCellStyle(this.styleMap.get("HEADER"));
                }
            }
        }

        this.addMergedRegions(addressList, changeStyle);
    }

    private void addMergedRegions(List<CellRangeAddress> addressList, boolean changeStyle) {
        for (CellRangeAddress address : addressList) {
            this.sheet.addMergedRegion(address);

            if (changeStyle) {
                RegionUtil.setBorderTop(BorderStyle.THIN, address, this.sheet);
                RegionUtil.setBorderBottom(BorderStyle.THIN, address, this.sheet);
                RegionUtil.setBorderLeft(BorderStyle.THIN, address, this.sheet);
                RegionUtil.setBorderRight(BorderStyle.THIN, address, this.sheet);
            }
        }
    }
}