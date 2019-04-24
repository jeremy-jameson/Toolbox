# Visual Studio Code installation and configuration

## Install Visual Studio Code

```PowerShell
net use \\TT-FS01\IPC$ /USER:TECHTOOLBOX\jjameson
```

> **Note:**
>
> When prompted, type the password to connect to the file share.

```PowerShell
$setupPath = "\\TT-FS01\Products\Microsoft\Visual Studio Code" `
    + "\VSCodeSetup-x64-1.31.1.exe"

$arguments = "/silent" `
    + " /mergetasks='!runcode,addcontextmenufiles,addcontextmenufolders" `
        + ",addtopath'"

Start-Process `
    -FilePath $setupPath `
    -ArgumentList $arguments `
    -Wait
```

> **Important:**
>
> Wait for the installation to complete before proceeding to the next step.

> **Note:**
>
> Visual Studio Code will start automatically after it is installed (despite the
> "!runcode" option being specified). This is currently a known issue with the
> installation:
>
> [Installer doesn't disable launch of VScode even when installing with /mergetasks=!runcode #46350](https://github.com/Microsoft/vscode/issues/46350)

## Modify Visual Studio Code shortcut to use custom extension and user data locations

Close Visual Studio Code and modify the program shortcut as follows:

"C:\Program Files\Microsoft VS Code\Code.exe"
--extensions-dir "C:\NotBackedUp\vscode-data\extensions"
--user-data-dir "C:\NotBackedUp\vscode-data\user-data"

> **Note:**
>
> The disk space consumed by Visual Studio Code extensions and user data can
> quickly become quite large (e.g. 600+ MB for extensions and 100+ MB for user
> data). Since I use redirected folders and user profile quotas, I prefer to
> store these files in a custom location.

## Install Visual Studio Code extensions

### Install extension: Azure Resource Manager Tools

```
ext install msazurermtools.azurerm-vscode-tools
```

### Install extension: Beautify

```
ext install hookyqr.beautify
```

### Install extension: C&#35;

```
ext install ms-vscode.csharp
```

### Install extension: Debugger for Chrome

```
ext install msjsdiag.debugger-for-chrome
```

### Install extension: ESLint

```
ext install dbaeumer.vscode-eslint
```

### Install extension: GitLens - Git supercharged

```
ext install eamodio.gitlens
```

### Install extension: markdownlint

```
ext install davidanson.vscode-markdownlint
```

### Install extension: PowerShell

```
ext install ms-vscode.powershell
```

### Install extension: Prettier - Code formatter

```
ext install esbenp.prettier-vscode
```

### Install extension: TSLint

```
ext install ms-vscode.vscode-typescript-tslint-plugin
```

### Install extension: vscode-icons

```
ext install vscode-icons-team.vscode-icons
```

> **Notes:**
>
> - HTML formatting issue with Prettier:
>
>   - [Add the missing option to disable crappy Prettier VSCode HTML formatter #636](https://github.com/prettier/prettier-vscode/issues/636)

> - Potential issue when using both Beautify and Prettier extensions:
>
>   - [Prettier & Beautify](https://css-tricks.com/prettier-beautify/)

## Configure Visual Studio Code settings

1. Open the **Command Palette** (press **Ctrl+Shift+P**)
1. Select **Preferences: Open Settings (JSON)**

### settings.json

```JSON
{
    "editor.formatOnSave": true,
    "editor.renderWhitespace": "boundary",
    "editor.rulers": [80],
    "files.trimTrailingWhitespace": true,
    "git.autofetch": true,
    "html.format.wrapLineLength": 80,
    "prettier.disableLanguages": ["html"],
    "terminal.integrated.shell.windows":
        "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "workbench.iconTheme": "vscode-icons"
}
```
