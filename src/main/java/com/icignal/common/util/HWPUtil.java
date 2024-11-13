package com.icignal.common.util;

import java.io.Writer;

public class HWPUtil {
	final static public String XML_ENCODING = "UTF-8";
	final static private String HWPML_VERSION = "2.9";
	final static private String HWPML_SUB_VERSION = "9.0.1.0";
	final static private String HWPML_STYLE = "embed";

	final static public Integer HWPML_PRE_OFFSET = 1500;
	final static public Integer HWPML_PAGE_WIDTH = 41944;
	final static public Integer HWPML_TABLE_CELL_HEIGHT = 282;

	/**
	 * 한글 HWPML Root 엘리먼트를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openRoot(Writer w) throws Exception {
		w.write("<?xml version=\"1.0\" encoding=\"" + XML_ENCODING + "\"?>\n");
		w.write("<HWPML Style=\"" + HWPML_STYLE + "\" Version=\"" + HWPML_VERSION + "\" SubVersion=\"" + HWPML_SUB_VERSION + "\">\n");
	}

	static public void closeRoot(Writer w) throws Exception {
		w.write("</HWPML>\n");
	};

	//
	//

	/**
	 * 한글 HWPML Head 엘리먼트를 설정한다.
	 * 
	 * @param w
	 * @param secCnt
	 *            : 구역 갯수
	 * @throws Exception
	 */
	static public void openHead(Writer w, Integer secCnt) throws Exception {
		w.write("<HEAD SecCnt=\"" + secCnt + "\">\n");
	}

	static public void closeHead(Writer w) throws Exception {
		w.write("</HEAD>\n");
	};

	/**
	 * 한글 HWPML 문서 글꼴/스타일 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openMappingTable(Writer w) throws Exception {
		w.write("<MAPPINGTABLE>\n");
	}

	static public void closeMappingTable(Writer w) throws Exception {
		w.write("</MAPPINGTABLE>\n");
	}
	
	static public void createFontList(Writer w) throws Exception {
		w.write("<FACENAMELIST>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"Hangul\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"Latin\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"Hanja\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"Japanese\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"Other\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"Symbol\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("	<FONTFACE Count=\"1\" Lang=\"User\">\n");
		w.write("		<FONT Id=\"0\" Name=\"굴림\" Type=\"ttf\">\n");
		w.write("			<TYPEINFO ArmStyle=\"1\" Contrast=\"0\" FamilyType=\"2\" Letterform=\"1\" Midline=\"1\" Proportion=\"0\" StrokeVariation=\"1\" Weight=\"6\" XHeight=\"1\" />\n");
		w.write("		</FONT>\n");
		w.write("	</FONTFACE>\n");
		w.write("</FACENAMELIST>\n");
	}

	/**
	 * 한글 HWPML 표 테두리 정보를 설정한다.
	 * 1번은 테이블에서 사용
	 * 2번은 폰트 설정에서 사용
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void createBorderFillList(Writer w) throws Exception {
		w.write("<BORDERFILLLIST Count=\"1\">\n");
		w.write("	<BORDERFILL BackSlash=\"0\" BreakCellSeparateLine=\"0\" CenterLine=\"0\" CounterBackSlash=\"0\" CounterSlash=\"0\" CrookedSlash=\"0\" Id=\"1\" Shadow=\"false\" Slash=\"0\" ThreeD=\"false\">\n");
		w.write("		<LEFTBORDER Type=\"Solid\" Width=\"0.12mm\" />\n");
		w.write("		<RIGHTBORDER Type=\"Solid\" Width=\"0.12mm\" />\n");
		w.write("		<TOPBORDER Type=\"Solid\" Width=\"0.12mm\" />\n");
		w.write("		<BOTTOMBORDER Type=\"Solid\" Width=\"0.12mm\" />\n");
		w.write("		<DIAGONAL Type=\"Solid\" Width=\"0.12mm\" />\n");
		w.write("	</BORDERFILL>\n");
		w.write("	<BORDERFILL BackSlash=\"0\" BreakCellSeparateLine=\"0\" CenterLine=\"0\" CounterBackSlash=\"0\" CounterSlash=\"0\" CrookedSlash=\"0\" Id=\"2\" Shadow=\"false\" Slash=\"0\" ThreeD=\"false\">\n");
		w.write("		<LEFTBORDER Type=\"None\" Width=\"0.1mm\" />\n");
		w.write("		<RIGHTBORDER Type=\"None\" Width=\"0.1mm\" />\n");
		w.write("		<TOPBORDER Type=\"None\" Width=\"0.1mm\" />\n");
		w.write("		<BOTTOMBORDER Type=\"None\" Width=\"0.1mm\" />\n");
		w.write("		<DIAGONAL Type=\"Solid\" Width=\"0.1mm\" />\n");
		w.write("	</BORDERFILL>\n");
		w.write("</BORDERFILLLIST>\n");
	}
	
	static public void createCharShapeList(Writer w) throws Exception {
		w.write("<CHARSHAPELIST Count=\"2\">\n");
		w.write("	<CHARSHAPE BorderFillId=\"2\" Height=\"1000\" Id=\"0\" ShadeColor=\"4294967295\" SymMark=\"0\" TextColor=\"0\" UseFontSpace=\"false\" UseKerning=\"false\">\n");
		w.write("		<FONTID Hangul=\"0\" Hanja=\"0\" Japanese=\"0\" Latin=\"0\" Other=\"0\" Symbol=\"0\" User=\"0\" />\n");
		w.write("		<RATIO Hangul=\"100\" Hanja=\"100\" Japanese=\"100\" Latin=\"100\" Other=\"100\" Symbol=\"100\" User=\"100\" />\n");
		w.write("		<CHARSPACING Hangul=\"0\" Hanja=\"0\" Japanese=\"0\" Latin=\"0\" Other=\"0\" Symbol=\"0\" User=\"0\" />\n");
		w.write("		<RELSIZE Hangul=\"100\" Hanja=\"100\" Japanese=\"100\" Latin=\"100\" Other=\"100\" Symbol=\"100\" User=\"100\" />\n");
		w.write("		<CHAROFFSET Hangul=\"0\" Hanja=\"0\" Japanese=\"0\" Latin=\"0\" Other=\"0\" Symbol=\"0\" User=\"0\" />\n");
		w.write("		<BOLD />\n");
		w.write("	</CHARSHAPE>\n");
		w.write("	<CHARSHAPE BorderFillId=\"2\" Height=\"1000\" Id=\"1\" ShadeColor=\"4294967295\" SymMark=\"0\" TextColor=\"0\" UseFontSpace=\"false\" UseKerning=\"false\">\n");
		w.write("		<FONTID Hangul=\"0\" Hanja=\"0\" Japanese=\"0\" Latin=\"0\" Other=\"0\" Symbol=\"0\" User=\"0\" />\n");
		w.write("		<RATIO Hangul=\"100\" Hanja=\"100\" Japanese=\"100\" Latin=\"100\" Other=\"100\" Symbol=\"100\" User=\"100\" />\n");
		w.write("		<CHARSPACING Hangul=\"0\" Hanja=\"0\" Japanese=\"0\" Latin=\"0\" Other=\"0\" Symbol=\"0\" User=\"0\" />\n");
		w.write("		<RELSIZE Hangul=\"100\" Hanja=\"100\" Japanese=\"100\" Latin=\"100\" Other=\"100\" Symbol=\"100\" User=\"100\" />\n");
		w.write("		<CHAROFFSET Hangul=\"0\" Hanja=\"0\" Japanese=\"0\" Latin=\"0\" Other=\"0\" Symbol=\"0\" User=\"0\" />\n");
		w.write("	</CHARSHAPE>");
		w.write("</CHARSHAPELIST>");
	}
	
	static public void createParaShapeList(Writer w) throws Exception {
		w.write("<PARASHAPELIST Count=\"2\">\n");
		w.write("	<PARASHAPE Align=\"Justify\" AutoSpaceEAsianEng=\"false\" AutoSpaceEAsianNum=\"false\" BreakLatinWord=\"KeepWord\" BreakNonLatinWord=\"true\" Condense=\"0\" FontLineHeight=\"false\" HeadingType=\"None\"\n");
		w.write("		Id=\"0\" KeepLines=\"false\" KeepWithNext=\"false\" Level=\"0\" LineWrap=\"Break\" PageBreakBefore=\"false\" SnapToGrid=\"true\" TabDef=\"0\" VerAlign=\"Baseline\" WidowOrphan=\"false\">\n");
		w.write("		<PARAMARGIN Indent=\"0\" Left=\"0\" LineSpacing=\"160\" LineSpacingType=\"Percent\" Next=\"0\" Prev=\"0\" Right=\"0\" />\n");
		w.write("		<PARABORDER BorderFill=\"2\" Connect=\"false\" IgnoreMargin=\"false\" />\n");
		w.write("	</PARASHAPE>\n");
		w.write("	<PARASHAPE Align=\"Right\" AutoSpaceEAsianEng=\"false\" AutoSpaceEAsianNum=\"false\" BreakLatinWord=\"KeepWord\" BreakNonLatinWord=\"false\" Condense=\"0\" FontLineHeight=\"false\" HeadingType=\"None\"\n");
		w.write("		Id=\"1\" KeepLines=\"false\" KeepWithNext=\"false\" Level=\"0\" LineWrap=\"Break\" PageBreakBefore=\"false\" SnapToGrid=\"true\" TabDef=\"0\" VerAlign=\"Baseline\" WidowOrphan=\"false\">\n");
		w.write("		<PARAMARGIN Indent=\"0\" Left=\"0\" LineSpacing=\"160\" LineSpacingType=\"Percent\" Next=\"0\" Prev=\"0\" Right=\"0\" />\n");
		w.write("		<PARABORDER BorderFill=\"2\" Connect=\"false\" IgnoreMargin=\"false\" />\n");
		w.write("	</PARASHAPE>\n");
		w.write("</PARASHAPELIST>\n");
	}

	/**
	 * 한글 HWPML 이미지 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openBinDataList(Writer w, Integer imgCnt) throws Exception {
		w.write("<BINDATALIST Count=\"" + imgCnt + "\">\n");
	}

	static public void closeBinDataList(Writer w) throws Exception {
		w.write("</BINDATALIST>\n");
	}

	/**
	 * 한글 HWPML 이미지 파일 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void createBinItem(Writer w, String dataId, String format) throws Exception {
		w.write("<BINITEM BinData=\"" + dataId + "\" Format=\"" + format + "\" Type=\"Embedding\" />\n");
	}

	//
	//

	/**
	 * 한글 HWPML 본문 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openBoby(Writer w) throws Exception {
		w.write("<BODY>\n");
	}

	static public void closeBody(Writer w) throws Exception {
		w.write("</BODY>\n");
	}

	/**
	 * 한글 HWPML 구역 정보를 설정한다.
	 * 
	 * @param w
	 * @param sectionId
	 * @throws Exception
	 */
	static public void openSection(Writer w, Integer sectionId) throws Exception {
		w.write("<SECTION Id=\"" + sectionId + "\">\n");
	}

	static public void closeSection(Writer w) throws Exception {
		w.write("</SECTION>\n");
	}

	/**
	 * 한글 HWPML 문자/이미지 등등 정보를 설정하기 위한 공간을 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openText(Writer w, Boolean pageBreak, Boolean tableCell, Integer style, Integer align) throws Exception {
		w.write("<P ParaShape=\"" + align + "\" ");
		if (!tableCell) {
			if (pageBreak) {
				w.write("PageBreak=\"true\" ColumnBreak=\"false\" ");
			} else {
				w.write("PageBreak=\"false\" ColumnBreak=\"true\" ");
			}
		}

		w.write(">\n<TEXT CharShape=\"" + style + "\">\n");
	}

	static public void closeText(Writer w) throws Exception {
		w.write("</TEXT>\n");
		w.write("</P>\n");
	}

	/**
	 * 한글 HWPML 페이지의 방향(가로, 세로) 를 설정한다.
	 * 
	 * @param w
	 * @param landScope
	 * @throws Exception
	 */
	static public void setHWPPageLandscape(Writer w, Integer landscape) throws Exception {
		w.write("<SECDEF TextDirection=\"0\">\n");
		w.write("	<PAGEDEF Landscape=\"" + landscape + "\" GutterType=\"LeftOnly\" Height=\"84188\" Width=\"59528\">\n");
		w.write("		<PAGEMARGIN Bottom=\"4252\" Footer=\"4252\" Gutter=\"0\" Header=\"4252\" Left=\"8504\" Right=\"8504\" Top=\"5668\" />\n");
		w.write("	</PAGEDEF>\n");
		w.write("</SECDEF>\n");
		w.write("<COLDEF Count=\"1\" Layout=\"Left\" SameGap=\"0\" SameSize=\"true\" Type=\"Newspaper\" />\n");
	}

	/**
	 * 한글 HWPML 일반 입력 문자를 설정한다.
	 * 
	 * @param w
	 * @param text
	 * @throws Exception
	 */
	static public void createText(Writer w, String text) throws Exception {
		w.write("<CHAR>" + text + "</CHAR>\n");
	}

	/**
	 * 한글 HWPML 이미지 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void createPicture(Writer w, String dataId, Integer oriWidth, Integer oriHeight, Integer width, Integer height, Integer vertOffset, Integer horiOffset) throws Exception {
		w.write("<PICTURE Reverse=\"false\">\n");

		w.write("	<SHAPEOBJECT>\n");
		w.write("		<SIZE Width=\"" + width + "\" Height=\"" + height + "\" WidthRelTo=\"Absolute\" />\n");
		w.write("		<POSITION TreatAsChar=\"false\" HorzRelTo=\"Page\" HorzAlign=\"Left\" HorzOffset=\"" + horiOffset + "\" VertRelTo=\"Page\" VertAlign=\"Top\" VertOffset=\"" + vertOffset
				+ "\" />\n");
		w.write("	</SHAPEOBJECT>\n");

		w.write("	<SHAPECOMPONENT OriWidth=\"" + oriWidth + "\" OriHeight=\"" + oriHeight + "\">\n");
		w.write("		<ROTATIONINFO Angle=\"0\" CenterX=\"0\" CenterY=\"0\" />\n");
		w.write("		<RENDERINGINFO>\n");
		w.write("			<TRANSMATRIX E1=\"1.00000\" E2=\"0.00000\" E3=\"0.00000\" E4=\"0.00000\" E5=\"1.00000\" E6=\"0.00000\" />\n");
		w.write("			<SCAMATRIX E1=\"1.00000\" E2=\"0.00000\" E3=\"0.00000\" E4=\"0.00000\" E5=\"1.00000\" E6=\"0.00000\" />\n");
		w.write("			<ROTMATRIX E1=\"1.00000\" E2=\"0.00000\" E3=\"0.00000\" E4=\"0.00000\" E5=\"1.00000\" E6=\"0.00000\" />\n");
		w.write("		</RENDERINGINFO>\n");
		w.write("	</SHAPECOMPONENT>\n");

		w.write("	<IMAGERECT X0=\"0\" X1=\"" + oriWidth + "\" X2=\"" + oriWidth + "\" X3=\"0\" Y0=\"0\" Y1=\"0\" Y2=\"" + oriWidth + "\" Y3=\"" + oriWidth + "\" />\n");

		w.write("	<IMAGE BinItem=\"" + dataId + "\" Effect=\"RealPic\" />\n");

		w.write("</PICTURE>\n");
	}

	/**
	 * 한글 HWPML 표 정보를 설정한다.
	 * 
	 * @param w
	 * @param width
	 * @param height
	 * @param vertOffset
	 * @param horiOffset
	 * @param rowCount
	 * @param colCount
	 * @throws Exception
	 */
	static public void openTable(Writer w, Integer width, Integer height, Integer vertOffset, Integer horiOffset, Integer rowCount, Integer colCount) throws Exception {
		w.write("<TABLE RowCount=\"" + rowCount + "\" ColCount=\"" + colCount + "\" BorderFill=\"1\" CellSpacing=\"0\" PageBreak=\"Cell\" RepeatHeader=\"true\" >\n");

		w.write("	<SHAPEOBJECT>\n");
		w.write("		<SIZE Width=\"" + width + "\" Height=\"" + height + "\" WidthRelTo=\"Page\" />\n");
		w.write("		<POSITION TreatAsChar=\"false\" HorzRelTo=\"Page\" HorzAlign=\"Left\" HorzOffset=\"" + horiOffset + "\" VertRelTo=\"Page\" VertAlign=\"Top\" VertOffset=\"" + vertOffset
				+ "\" FlowWithText=\"true\" AllowOverlap=\"true\" />\n");
		w.write("	</SHAPEOBJECT>\n");
	}

	static public void closeTable(Writer w) throws Exception {
		w.write("</TABLE>\n");
	}

	/**
	 * 한글 HWPML 표의 행 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openRow(Writer w) throws Exception {
		w.write("<ROW>\n");
	}

	static public void closeRow(Writer w) throws Exception {
		w.write("</ROW>\n");
	}

	/**
	 * 한글 HWPML 표의 셀 정보를 설정한다.
	 * 
	 * @param w
	 * @param colAddr
	 * @param rowAddr
	 * @param colSpan
	 * @param rowSpan
	 * @param width
	 * @param height
	 * @throws Exception
	 */
	static public void openCell(Writer w, Integer colAddr, Integer rowAddr, Integer colSpan, Integer rowSpan, Integer width, Integer height) throws Exception {
		w.write("<CELL BorderFill=\"1\" ColAddr=\"" + colAddr + "\" RowAddr=\"" + rowAddr + "\" ColSpan=\"" + colSpan + "\" RowSpan=\"" + rowSpan + "\" Width=\"" + width + "\" Height=\"" + height
				+ "\" Dirty=\"false\" Editable=\"false\" HasMargin=\"false\" Header=\"false\">\n");
		w.write("	<PARALIST>\n");
	}

	static public void closeCell(Writer w) throws Exception {
		w.write("	</PARALIST>\n");
		w.write("</CELL>\n");
	}

	//
	//

	/**
	 * 한글 HWPML 꼬리 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openTail(Writer w) throws Exception {
		w.write("<TAIL>\n");
	}

	static public void closeTail(Writer w) throws Exception {
		w.write("</TAIL>\n");
	}

	/**
	 * 한글 HWPML 이미지 저장공간 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void openBinDataStorage(Writer w) throws Exception {
		w.write("<BINDATASTORAGE>\n");
	}

	static public void closeBinDataStorage(Writer w) throws Exception {
		w.write("</BINDATASTORAGE>\n");
	}

	/**
	 * 한글 HWPML 이미지 정보를 설정한다.
	 * 
	 * @param w
	 * @throws Exception
	 */
	static public void createBinData(Writer w, String dataId, String encoding, Integer size, String binaryData) throws Exception {
		w.write("<BINDATA Id=\"" + dataId + "\" Encoding=\"" + encoding + "\" Size=\"" + size + "\">\n");
		w.write(binaryData + "\n");
		w.write("</BINDATA>\n");
	}
}