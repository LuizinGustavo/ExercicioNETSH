@echo off
cls

:menu
echo Escolha o comando que deseja realizar
echo A - Verificar a configuracao do endereco TCP-IP atual
echo B - Alterar a configuracao de IP e Mascara
echo C - Alterar a configuracao de Gateway e DNS
echo D - Alterar a configuracao de enderecamento geral: IP, Mascara, Gateway e DNS
echo E - Alterar a configuracao de IP para o modo automatico
echo F - Exportar a configuracao TCP-IP para o arquivo Log_IP.txt
echo G - Sair

choice /c abcdefg /m "Escolha uma opcao"
if errorlevel 7 goto fim
if errorlevel 6 goto geraLog
if errorlevel 5 goto modoAutomatico
if errorlevel 4 goto alterarEndGeral
if errorlevel 3 goto alterarGatewayDns
if errorlevel 2 goto alterarIpMasc
if errorlevel 1 goto verificarConfig

:verificarConfig
netsh interface ip show config
goto menu

:alterarIpMasc
SET /P $conexao=Digite o nome da conexao a ser alterada:

SET /P $endIP=Digite o novo endereco IP:

SET /P $mascara=Digite a nova Mascara:

netsh interface ip set address name="%$conexao%" static %$endIP% %$mascara%

goto menu

:alterarGatewayDns
SET /P $conexao=Digite o nome da conexao a ser alterada:

SET /P $endGateway=Digite o endereco do Gateway:

SET /P $endDNS=Digite o endereco do DNS:

SET /P $metGate=Digite a métrica do DNS:

netsh interface ip set address name="%$conexao%" static gateway="%$endGateway%" gwmetric=%$metGate%

netsh interface ip set dns "%$conexao%" static %$endDNS%

goto menu

:alterarEndGeral
SET /P $conexao=Digite o nome da conexao a ser alterada:

SET /P $endIP=Digite o novo endereco IP:

SET /P $mascara=Digite a nova Mascara:

SET /P $endGateway=Digite o endereco do Gateway:

SET /P $endDNS=Digite o DNS:

netsh interface ip set address name="%$conexao%" static %$endIP% %$mascara% %$endGateway% 1

netsh interface ip set dns "%$conexao%" static %$endDNS%

goto menu

:modoAutomatico
SET /P $conexao=Digite o nome da conexao a ser alterada:

netsh interface ip set address name="%$conexao%" dhcp

netsh interface ip set dns "%$conexao%" dhcp
goto menu

:geraLog
netsh -c interface dump > c:\Log_IP.txt
goto menu

:fim
PAUSE