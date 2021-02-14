<#
.DESCRIPTION
 Setup a web development environment that includes:
 * Download Chocolatey
 * Download Git
 * Setup Local Repos Folder
 * Install Powershell Core
#>
Param()

# This script is intentionally kept simple to demonstrate basic automation techniques.

Write-Output "You must run this script in an elevated command shell, using 'Run as Administator'"

$title = "Fun Zone setup" 
$message = "Select the appropriate option to continue"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Install Software using Chocolatey", `
  "I'm ready."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&Exit", `
  "Do not execute script."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 1)

switch ($result) {
    0 {

        Write-Output "Installing chocolatey"
        ###chocolatey
        ####chocolatey
        #####chocolatey
        ######chocolatey
        $CheckExecution = Get-ExecutionPolicy
        if ($CheckExecution -eq "Restricted") {
            Set-ExecutionPolicy Bypass -Scope Process.
        } 

        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


        Write-Output "Refreshing environment variables. If rest of the script fails, restart elevated shell and rerun script."
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")




        ### Rest of the Script is using Chocolatey to download/install what is needed
        Write-Output "Assuming chocolatey is already installed"

        ##Install GIT
        Write-Output "Installing Git"
        choco.exe upgrade git -y



        ###Install Powershell 
        Write-Output "Installing Powershell Core"
        choco.exe upgrade powershell-core

        ##Setup Local Repos Folder

        ##install Windows Terminal
        Write-Output "Installing Windows Terminal"
        choco.exe upgrade microsoft-windows-terminal

        ###Install Visual Studio Code
        Write-Output "Installing VS Code"
        choco.exe upgrade VisualStudioCode -y

    }
    1 { "Aborted." }
}