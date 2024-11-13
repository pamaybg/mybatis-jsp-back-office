package com.icignal.common.base.dto.response;

/*
 * 1. 클래스명	: ExcelMetaDataResDto
 * 2. 파일명	: ExcelMetaDataResDto.java
 * 3. 패키지명	: com.icignal.common.base.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 4. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *		엑셀 메타데이터 사용 DTO
 * </PRE>
 */ 
public class ExcelMetaDataResDto {
	private String field;				//헤더가 들어가는 필드값
	private String text;				//헤더 명
	private String colrow;			//행 열
	private int colNum;				//열의 번호
	private int rowNum;				// 행의 번호
	private String title;					//제목
	private int excelSeq;				//엑셀다운 순번
	private String excelType;		//엑셀 타입(일반, 템플릿)
	private String tempFilePath;	//템플릿 파일 경로
	
	public String getField() {
		return field;
	}
	
	public void setField(String field) {
		this.field = field;
	}
	
	public String getText() {
		return text;
	}
	
	public void setText(String text) {
		this.text = text;
	}
	
	public String getColrow() {
		return colrow;
	}
	
	public void setColrow(String colrow) {
		this.colrow = colrow;
		
		StringBuilder sb = new StringBuilder();
		String col="";
		if(colrow.length()>=3) {
			 col = colrow.substring(0, 2);
		} else{
			 col = colrow.substring(0, 1);
		}
		char[] ch = col.toUpperCase().toCharArray();
		sb.append((int) ch[0] -64);
		if(colrow.length()>=3) {
			rowNum = Integer.parseInt(colrow.substring(2, colrow.lastIndexOf("")));
		} else {
			rowNum = Integer.parseInt(colrow.substring(1, colrow.lastIndexOf("")));

		}
		colNum = Integer.parseInt(sb.toString());
	}
	
	public int getColNum() {
		return colNum;
	}
	
	public void setColNum(int colNum) {
		this.colNum = colNum;
	}
	
	public int getRowNum() {
		return rowNum;
	}
	
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getExcelSeq() {
		return excelSeq;
	}

	public void setExcelSeq(int excelSeq) {
		this.excelSeq = excelSeq;
	}

	public String getExcelType() {
		return excelType;
	}

	public void setExcelType(String excelType) {
		this.excelType = excelType;
	}

	public String getTempFilePath() {
		return tempFilePath;
	}

	public void setTempFilePath(String tempFilePath) {
		this.tempFilePath = tempFilePath;
	}
	
}
