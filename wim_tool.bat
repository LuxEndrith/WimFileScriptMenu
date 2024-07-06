@echo off
cls
echo Running script as administrator...

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as administrator.
    pause
    exit /b
)

:menu
cls
echo =======================================
echo ==        Wim File Script Menu        ==
echo =======================================
echo 1. Decompile install.wim
echo 2. Compile install.wim
echo 3. Exit
echo =======================================
set /p choice=Choose an option (1-3): 

if %choice%==1 goto decompile
if %choice%==2 goto compile
if %choice%==3 goto exit

:decompile
cls
echo Decompiling a .wim file

echo Please select the .wim file to decompile:
set "wimfile="
set "temp="
for /f "delims=" %%I in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.InitialDirectory = 'C:\'; $f.Filter = 'WIM Files (*.wim)|*.wim'; $f.Multiselect = $false; $f.ShowDialog([System.Windows.Forms.Form]::ActiveForm) | Out-Null; $f.FileName"') do set "temp=%%I"
if defined temp set "wimfile=%temp%"

if not exist "%wimfile%" (
    echo The selected file does not exist or no file was selected.
    pause
    goto menu
)

if not exist "C:\mount" mkdir "C:\mount"

echo Mounting the .wim file to C:\mount...
wmic process where name="dism.exe" CALL setpriority "high" >nul 2>&1
dism /Mount-Wim /WimFile:"%wimfile%" /Index:1 /MountDir:C:\mount /ReadOnly

echo Decompilation completed.
pause
goto menu

:compile
cls
echo Compiling a folder into a new .wim file

if not exist "C:\mount" (
    echo The 'mount' folder does not exist. Please decompile a .wim file first.
    pause
    goto menu
)

echo Please select the folder where you want to save the new .wim file:
set "outputfolder="
set "temp="
for /f "delims=" %%I in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; $f.RootFolder = [System.Environment+SpecialFolder]::Desktop; $f.Description = 'Select the destination folder'; $f.ShowDialog() | Out-Null; $f.SelectedPath"') do set "temp=%%I"
if defined temp set "outputfolder=%temp%"

if not defined outputfolder (
    echo No destination folder selected.
    pause
    goto menu
)

set /p wimname="Specify the name of the new .wim file (without extension): "

echo Capturing content of C:\mount into %outputfolder%\%wimname%.wim...
wmic process where name="dism.exe" CALL setpriority "high" >nul 2>&1
dism /Capture-Image /ImageFile:"%outputfolder%\%wimname%.wim" /CaptureDir:C:\mount /Name:%wimname% /Description:"Image captured from C:\mount folder" /Compress:maximum

echo Compilation completed.
pause
goto menu