var gulp = require('gulp');

// gulp plugin 호출
var concat = require('gulp-concat'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  sourcemaps = require('gulp-sourcemaps'),
  scss = require('gulp-sass');

var dist = 'ifvDefault';
var jspaths = [
"ifvCommon/js/util.js",
"ifvCommon/js/lib.js",
"ifvPager/js/ifvPager.js",
"ifvPager/js/ifvSimplePager.js",
"ifvCalendar/js/ifvCalendarPop.js",
"ifvPopup/js/ifvPopup.js",
"ifvSearchBox/js/ifvSearchBox.js",
"ifvSelectBox/js/ifvSelectBox.js",
"ifvValidation/js/ifvValidation.js",
"ifvGrid/js/ifvGrid.js",
"ifvGrid/js/ifvJSONPGrid.js",
"ifvUI/js/ifvAddRemove.js",
"ifvFileUploader/js/MultiUploader.js",
"ifvExcelReader/js/ifvExcelReader.js",
"ifvsfPopup/js/ifvsfPopup.js",
"ifvsfDialog/js/ifvsfDialog.js",
"ifvsfTab/js/ifvsfTab.js",
"ifvsfMenu/js/ifvsfMenu.js",
"ifvsfTree/js/ifvsfTree.js",
"ifvsfAccordion/js/ifvsfAccordion.js",
"ifvsfChart/js/ifvsfChart.js",
"ifvsfDiagram/js/ifvsfDiagram.js",
"ifvsfPivotGrid/js/ifvsfPivotGrid.js",
"ifvsfPivotChart/js/ifvsfPivotChart.js",
"ifvsfSymbolPalette/js/ifvsfSymbolPalette.js",
"ifvsfRTE/js/ifvsfRTE.js",
"ifvsfToolbar/js/ifvsfToolbar.js",
"ifvsfColorPicker/js/ifvsfColorPicker.js",
"ifvsfCircularGauge/js/ifvsfCircularGauge.js",
"ifvsfDateTimePicker/js/ifvsfDateTimePicker.js",
"ifvTab/js/tab.js",
"ifvsfGrid/js/ifvsfGrid.js",
"ifvsForm/js/ifvsForm.js",
"ifvExcelDn/js/ifvExcelDn.js"
];

var csspaths = [
'ifvCommon/css/ifvDefault.min.scss'
]

gulp.task('js_concat', function() {
  return gulp.src(jspaths)
    .pipe(concat('ifvDefault.js'))
    .pipe(gulp.dest(dist + '/js'))
    .pipe(uglify())
    .pipe(rename('ifvDefault.min.js'))
    .pipe(gulp.dest(dist + '/js'))
});

var scssOptions = {
  outputStyle: 'compressed', //values : nested, expanded, compact, compressed
  indentType: 'space',
  indentWidth: 4, //outpusStyle이 nested, expanded인 경우 사용
  precision: 6 //컴파일된 css 소수점 자리수
}

gulp.task('scss_compile', function() {
    return gulp.src(csspaths)
      .pipe(sourcemaps.init())
      .pipe(scss(scssOptions).on('error', scss.logError))
      .pipe(sourcemaps.write('sourcemaps'))
      .pipe(gulp.dest(dist + '/css'))
});

gulp.task('watch', function() {
  gulp.watch(jspaths, gulp.series('js_concat'));
  gulp.watch(csspaths, gulp.series('scss_compile'));
});

gulp.task('default', gulp.parallel('js_concat', 'scss_compile', 'watch'));
