package com.icignal.common.util;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTHMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTVMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;

public class WordUtil {
	final static public Integer WORD_IMAGE_FIXVALUE = 450;

	static public Integer getPictureType(String imageExtension) {
		String imageExtensiondata = imageExtension;
		if (ObjectUtil.isNotEmpty(imageExtensiondata)) {
			imageExtensiondata = imageExtensiondata.toUpperCase();

			switch (imageExtensiondata) {
			case "PNG":
				return XWPFDocument.PICTURE_TYPE_PNG;

			case "JPEG":
			case "JPG":
				return XWPFDocument.PICTURE_TYPE_JPEG;

			case "GIF":
				return XWPFDocument.PICTURE_TYPE_GIF;
			default :
				return -1;

			}
		}
		return -1;
	}

	static public void mergeCellVertically(XWPFTable table, int col, int fromRow, int toRow) {
		for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {
			CTVMerge vmerge = CTVMerge.Factory.newInstance();
			if (rowIndex == fromRow) {
				// The first merged cell is set with RESTART merge value
				vmerge.setVal(STMerge.RESTART);
			} else {
				// Cells which join (merge) the first one, are set with CONTINUE
				vmerge.setVal(STMerge.CONTINUE);
			}
			XWPFTableCell cell = table.getRow(rowIndex).getCell(col);
			// Try getting the TcPr. Not simply setting an new one every time.
			CTTcPr tcPr = cell.getCTTc().getTcPr();
			if (tcPr != null) {
				tcPr.setVMerge(vmerge);
			} else {
				// only set an new TcPr if there is not one already
				tcPr = CTTcPr.Factory.newInstance();
				tcPr.setVMerge(vmerge);
				cell.getCTTc().setTcPr(tcPr);
			}
		}
	}

	static public void mergeCellHorizontally(XWPFTable table, int row, int fromCol, int toCol) {
		for (int colIndex = fromCol; colIndex <= toCol; colIndex++) {
			CTHMerge hmerge = CTHMerge.Factory.newInstance();
			if (colIndex == fromCol) {
				// The first merged cell is set with RESTART merge value
				hmerge.setVal(STMerge.RESTART);
			} else {
				// Cells which join (merge) the first one, are set with CONTINUE
				hmerge.setVal(STMerge.CONTINUE);
			}
			XWPFTableCell cell = table.getRow(row).getCell(colIndex);
			// Try getting the TcPr. Not simply setting an new one every time.
			CTTcPr tcPr = cell.getCTTc().getTcPr();
			if (tcPr != null) {
				tcPr.setHMerge(hmerge);
			} else {
				// only set an new TcPr if there is not one already
				tcPr = CTTcPr.Factory.newInstance();
				tcPr.setHMerge(hmerge);
				cell.getCTTc().setTcPr(tcPr);
			}
		}
	}
}