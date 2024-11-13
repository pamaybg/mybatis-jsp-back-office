package com.icignal.common.excel.writer;

import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.ExcelStyles;
import com.icignal.core.exception.DataFailException;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

public class ExcelWriter {

    final static private Logger log = LoggerFactory.getLogger(ExcelWriter.class);

    final private String excelFileName;
    final private Workbook workbook;
    final private Map<String, CellStyle> styleMap;

    public ExcelWriter(String excelFileName) {
        String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String fileName = String.join("_", excelFileName, currentDate);
        this.excelFileName = String.join(".", fileName, "xlsx");

        int excelChunkSize = BeansUtil.getApplicationProperty("excel.chunk-size", Integer.class);
        this.workbook = new SXSSFWorkbook(excelChunkSize);
        this.styleMap = ExcelStyles.createStyles(this.workbook);
    }

    public ExcelWriter(File file) throws IOException {
        String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String fileFullName = file.getName();

        String fileName = FilenameUtils.getName(fileFullName);
        String fileExtension = FilenameUtils.getExtension(fileFullName);

        this.excelFileName = String.format("%s_%s.%s", fileName, currentDate, fileExtension);
        this.workbook = WorkbookFactory.create(file);
        this.styleMap = ExcelStyles.createStyles(this.workbook);
    }

    public ExcelWriter(File file, String excelFileName) throws IOException {
        this.excelFileName = excelFileName;
        this.workbook = WorkbookFactory.create(file);
        this.styleMap = ExcelStyles.createStyles(this.workbook);
    }

    public ExcelSheetWriter createSheet() {
        return this.createSheet("");
    }

    public ExcelSheetWriter createSheet(String sheetName) {
        return new ExcelSheetWriter(this.workbook, sheetName, this.styleMap);
    }

    public <W extends ExcelSheetWriter> W createSheet(String sheetName, Class<W> clazz) {
        try {
            return clazz.getConstructor(Workbook.class, String.class, Map.class).newInstance(this.workbook, sheetName, this.styleMap);
        } catch (InstantiationException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
            log.error("생성자가 없습니다.", e);
            throw new DataFailException(e, "생성자가 없습니다.");
        }
    }

    public ExcelSheetWriter getSheetWriter() {
        return new ExcelSheetWriter(this.workbook.getSheetAt(0), this.styleMap);
    }

    public Pair<String, String> save() throws Exception {
        return this.save("common");
    }

    public Pair<String, String> save(String businessName) throws Exception {
        String fileCreatePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadFullPath");
        String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        String directorySubPath = Paths.get(businessName, currentDate).toString();

        File directory = Paths.get(fileCreatePath, directorySubPath).toFile();
        if (!directory.exists()) {
            directory.mkdirs();
        }

        Path filePath = Paths.get(fileCreatePath, directorySubPath, this.excelFileName);
        FileOutputStream outputStream = new FileOutputStream(filePath.toFile());
        this.workbook.write(outputStream);

        outputStream.close();

        if (this.workbook instanceof SXSSFWorkbook) {
            ((SXSSFWorkbook) this.workbook).dispose();
        }

        return Pair.of(directorySubPath, this.excelFileName);
    }
}