package com.icignal.common.base.dto.request;

public class ExcelMergeDto {

	private String mergeTarget;
	private int startRow;
	private int startCol;
	private int rowMergeCount;
	private int colMergeCount;

	public ExcelMergeDto(String mergeTarget, Integer startRow, Integer startCol, int rowMergeCount, int colMergeCount) {
		//public MergeInfo(String mergeTarget, Integer startRow, Integer startCol, int rowMergeCount, int colMergeCount) {
		this.mergeTarget = mergeTarget;
		this.startRow = startRow;
		this.startCol = startCol;
		this.rowMergeCount = rowMergeCount;
		this.colMergeCount = colMergeCount;
	}

	public String getMergeTarget() {
		return mergeTarget;
	}

	public void setMergeTarget(String mergeTarget) {
		this.mergeTarget = mergeTarget;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getStartCol() {
		return startCol;
	}

	public void setStartCol(int startCol) {
		this.startCol = startCol;
	}

	public int getRowMergeCount() {
		return rowMergeCount;
	}

	public void setRowMergeCount(int rowMergeCount) {
		this.rowMergeCount = rowMergeCount;
	}

	public int getColMergeCount() {
		return colMergeCount;
	}

	public void setColMergeCount(int colMergeCount) {
		this.colMergeCount = colMergeCount;
	}
}
