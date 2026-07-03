rem -- use local build folder
mkdir _build
cd _build

rem -- configure
cmake ^
  %CMAKE_ARGS% ^
  -G "NMake Makefiles" ^
  -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen:BOOL=true ^
  -DCMAKE_INSTALL_SYSCONFDIR:PATH="%LIBRARY_PREFIX%\etc" ^
  -DCMAKE_POLICY_VERSION_MINIMUM:STRING=3.5 ^
  -DWITH_GSSAPI:PATH="%LIBRARY_PREFIX%" ^
  -DWITH_SASL=no ^
  "%SRC_DIR%"
if %ERRORLEVEL% neq 0 exit 1

rem -- build
cmake --build . --parallel "%CPU_COUNT%" --verbose
if %ERRORLEVEL% neq 0 exit 1

rem -- test
ctest --parallel "%CPU_COUNT%" --verbose -C "Debug"
if %ERRORLEVEL% neq 0 exit 1

rem -- install
cmake --build . --parallel "%CPU_COUNT%" --verbose --target install
if %ERRORLEVEL% neq 0 exit 1
