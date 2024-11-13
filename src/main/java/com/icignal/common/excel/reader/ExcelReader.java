package com.icignal.common.excel.reader;

import com.icignal.common.excel.annotations.ExcelHeader;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.util.XMLHelper;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler;
import org.apache.poi.xssf.model.SharedStringsTable;
import org.apache.poi.xssf.model.StylesTable;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.function.Consumer;

public class ExcelReader<T> {

    final private Class<T> clazz;
    final private OPCPackage opc;
    final private Iterator<InputStream> sheetList;
    final private SharedStringsTable sst;
    final private StylesTable styles;

    private int startLineNum = 0;

    public ExcelReader(String filePath, Class<T> clazz) throws Exception {
        this.clazz = clazz;
        this.opc = OPCPackage.open(filePath);

        XSSFReader xssfReader = new XSSFReader(this.opc);
        this.styles = xssfReader.getStylesTable();
        this.sst = xssfReader.getSharedStringsTable();

        this.sheetList = xssfReader.getSheetsData();

        this.setupExcelData();
    }

    private void setupExcelData() {
        boolean useExcelHeader = this.clazz.isAnnotationPresent(ExcelHeader.class);
        if (useExcelHeader) {
            ExcelHeader header = this.clazz.getAnnotation(ExcelHeader.class);
            this.startLineNum = header.startLineNum();
        }
    }

    public Pair<Integer, Integer> proceed(Consumer<List<T>> consumer) throws Exception {
        ExcelSheetContentsHandler<T> contentsHandler = new ExcelSheetContentsHandler<>(this.startLineNum, this.clazz, consumer);

        XMLReader reader = XMLHelper.newXMLReader();
        ContentHandler handler = new XSSFSheetXMLHandler(this.styles, this.sst, contentsHandler, true);
        reader.setContentHandler(handler);

        while (this.sheetList.hasNext()) {
            InputStream sheet = this.sheetList.next();
            InputSource source = new InputSource(sheet);

            reader.parse(source);

            sheet.close();
        }

        return contentsHandler.getRowCounts();
    }

    public void uploadDone() throws IOException {
        if (this.opc != null) {
            this.opc.close();
        }
    }
}