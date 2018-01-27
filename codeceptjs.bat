 @SETLOCAL
@SET PATHEXT=%PATHEXT:;.JS;=;%
echo Executing local codeceptjs (windows workaround)
node  "%~dp0\node_modules\codeceptjs\bin\codecept.js" %*
