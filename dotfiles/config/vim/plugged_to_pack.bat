@echo off
setlocal enabledelayedexpansion

:: =============================================================================
:: plugged_to_pack.bat
:: Copia plugins da pasta plugged para pack\plugins\start
:: Remove arquivos e pastas relacionados ao git durante a copia
:: Compativel com Windows Server 2012+
::
:: Uso:
::   1. No vimrc, ative o plug (g:is_plug_active = 1) e instale os plugins
::   2. Desative o plug (g:is_plug_active = 0) e feche o Vim
::   3. Execute este script
::
:: Estrutura esperada (script deve estar na raiz do vim portátil):
::   vim_portavel\
::     plugged\          <- origem
::     pack\             <- criado automaticamente se nao existir
::       plugins\
::         start\        <- destino
::     plugged_to_pack.bat
:: =============================================================================

:: --- configuracoes -----------------------------------------------------------

:: plugins a ignorar — adicionar ou remover conforme necessidade
:: nomes exatos das pastas dentro de plugged, separados por espaco
set "SKIP_LIST=vim-devicons vim-dadbod vim-dadbod-ui"

:: pastas relacionadas ao git a excluir durante a copia
set "EXCLUDE_DIRS=.git .github .gitlab .circleci"

:: arquivos relacionados ao git/ci a excluir durante a copia
set "EXCLUDE_FILES=.gitignore .gitattributes .gitmodules .editorconfig .travis.yml"

:: --- nao alterar abaixo daqui ------------------------------------------------

set "SCRIPT_DIR=%~dp0"
set "PLUGGED_DIR=%SCRIPT_DIR%plugged"
set "PACK_DIR=%SCRIPT_DIR%pack\plugins\start"

:: =============================================================================
echo.
echo ============================================================
echo  plugged to pack
echo ============================================================
echo  Origem : %PLUGGED_DIR%
echo  Destino: %PACK_DIR%
echo.
echo  Ignorados: %SKIP_LIST%
echo ============================================================
echo.

:: verificar se a pasta plugged existe
if not exist "%PLUGGED_DIR%\" (
    echo [ERRO] Pasta plugged nao encontrada:
    echo        %PLUGGED_DIR%
    echo.
    echo        Certifique-se de que o script esta na raiz do vim portavel.
    echo.
    pause
    exit /b 1
)

:: verificar se o robocopy esta disponivel
where robocopy >nul 2>&1
if !errorlevel! neq 0 (
    echo [ERRO] robocopy nao encontrado.
    echo        Este script requer Windows Server 2008 ou superior.
    echo.
    pause
    exit /b 1
)

:: criar pack\plugins\start se nao existir
if not exist "%PACK_DIR%\" (
    mkdir "%PACK_DIR%" 2>nul
    if !errorlevel! neq 0 (
        echo [ERRO] Nao foi possivel criar a pasta:
        echo        %PACK_DIR%
        echo.
        pause
        exit /b 1
    )
    echo [CRIADO] %PACK_DIR%
    echo.
)

set "COUNT_OK=0"
set "COUNT_SKIP=0"
set "COUNT_ERR=0"

:: processar cada plugin na pasta plugged
for /d %%P in ("%PLUGGED_DIR%\*") do (
    set "PLUGIN_NAME=%%~nxP"

    :: verificar se o plugin esta na lista de ignorados
    call :check_skip "%%~nxP"

    if "!IS_SKIP!"=="1" (
        echo [IGNORADO] !PLUGIN_NAME!
        set /a COUNT_SKIP+=1
    ) else (
        :: copiar excluindo pastas e arquivos de git/ci
        robocopy "%%P" "%PACK_DIR%\!PLUGIN_NAME!" /E /NFL /NDL /NJH /NJS /NC /NS /NP ^
            /XD %EXCLUDE_DIRS% ^
            /XF %EXCLUDE_FILES% >nul 2>&1

        :: robocopy: exit code <= 7 indica sucesso (0=nada, 1=copiado, etc.)
        if !errorlevel! LEQ 7 (
            echo [OK] !PLUGIN_NAME!
            set /a COUNT_OK+=1
        ) else (
            echo [ERRO] !PLUGIN_NAME! ^(cod: !errorlevel!^)
            set /a COUNT_ERR+=1
        )
    )
)

:: exibir resumo final
echo.
echo ============================================================
echo  Resumo
echo ============================================================
echo  Copiados : !COUNT_OK!
echo  Ignorados: !COUNT_SKIP!
echo  Erros    : !COUNT_ERR!
echo ============================================================
echo.

if !COUNT_ERR! gtr 0 (
    echo [ATENCAO] Alguns plugins nao foram copiados corretamente.
    echo           Verifique os itens marcados com [ERRO] acima.
    echo.
)

echo Concluido!
echo Lembre de manter g:is_plug_active = 0 no vimrc ao usar no ambiente portavel.
echo.
pause
exit /b 0

:: =============================================================================
:check_skip
:: verifica se o plugin passado em %1 esta na SKIP_LIST
:: resultado disponivel em !IS_SKIP! (0 = copiar, 1 = ignorar)
set "IS_SKIP=0"
for %%S in (%SKIP_LIST%) do (
    if /i "%~1"=="%%S" set "IS_SKIP=1"
)
exit /b 0

