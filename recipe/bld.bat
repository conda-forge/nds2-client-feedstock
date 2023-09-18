:: use local build folder
mkdir _build
cd _build

:: configure
cmake ^
	"%SRC_DIR%" ^
	-G "%CMAKE_GENERATOR%" ^
	-DCMAKE_BUILD_TYPE:STRING=Release ^
	-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen:BOOL=true ^
	-DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
	-DCMAKE_INSTALL_SYSCONFDIR:PATH="%LIBRARY_PREFIX%\etc" ^
	-DWITH_GSSAPI:PATH="%LIBRARY_PREFIX%" ^
	-DWITH_SASL=no
if errorlevel 1 exit 1

:: build
cmake --build . --parallel "%CPU_COUNT%" --verbose
if errorlevel 1 exit 1

:: test
ctest --parallel "%CPU_COUNT%" --verbose -C "Debug"
if errorlevel 1 exit 1

:: install
cmake --build . --parallel "%CPU_COUNT%" --verbose --target install
if errorlevel 1 exit 1
