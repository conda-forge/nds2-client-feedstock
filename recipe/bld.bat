setlocal EnableDelayedExpansion

:: use local build folder
mkdir build
cd build

:: configure
cmake .. ^
    -G "%CMAKE_GENERATOR%" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=true ^
    -DWITH_GSSAPI:PATH="%LIBRARY_PREFIX%" ^
    -DWITH_SASL=no ^
    -DPYTHON=false ^
    -DPYTHON_EXECUTABLE=false ^
    -DCMAKE_INSTALL_SYSCONFDIR:PATH="%LIBRARY_PREFIX%\etc" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1
if errorlevel 1 exit 1

:: build
cmake --build . --config Release
if errorlevel 1 exit 1

:: install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
