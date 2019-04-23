# Cmder configuration

## Configure miscellaneous settings according to personal preferences

```PowerShell
Start-Process C:\NotBackedUp\Public\Toolbox\Cmder\Cmder.exe
```

### Settings

- General
  - General settings
    - Startup task: **{PowerShell::PowerShell}**
  - Fonts
    - Main console font
      - Size: **14**
  - Size & Pos
    - Console buffer height
      - Length of backscroll buffer: **3000**
- Startup
  - Tasks
    - {PowerShell::PowerShell as Administrator}
      - Remove _"-NoProfile"_ from command window
    - {PowerShell::PowerShell}
      - Remove _"-NoProfile"_ from command window
    - Custom tasks
      - **VS2015**
        - **cmd /k "%VS140COMNTOOLS%VsDevCmd.bat" -new_console:d:"C:\NotBackedUp":t:"VS2015"**
      - **VS2017**
        - **cmd /k "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat" -new_console:d:"C:\NotBackedUp":t:"VS2017"**
- Features
  - Transparency
    - Active window transparency: **disabled** _(unchecked)_

## Configure custom color scheme

```PowerShell
mkdir C:\NotBackedUp\GitHub\martinlindhe
pushd C:\NotBackedUp\GitHub\martinlindhe

git clone https://github.com/martinlindhe/base16-conemu.git

cd base16-conemu

.\Install-ConEmuTheme.ps1 `
    -ConfigPath "C:\NotBackedUp\Public\Toolbox\cmder\vendor\conemu-maximus5\ConEmu.xml" `
    -Operation Add `
    -ThemePathOrName .\themes\base16-default-dark.xml

popd
```

**Note:** Restart Cmder for new color theme to appear in Settings.

### Settings

- Features
  - Colors
    - Scheme: **Base16 Default Dark**
    - Set color 0: **#3b3b3b** ("Black")
    - Set color 1/4: **#1e4173** ("DarkBlue")
    - Set color 2: **#3b8c1a** ("DarkGreen")
    - Set color 3/6: **#aab9cd** ("DarkCyan")
    - Set color 4/1: **#bd1c1c** ("DarkRed")
    - Set color 5: **#926387** ("DarkMagenta")
    - Set color 6/3: **#ffff99** ("DarkYellow")
    - Set color 7: **#dddddd** ("Gray")
    - Set color 8: **#959595** ("DarkGray")
    - Set color 9: **#3c78c3** ("Blue")
    - Set color 10: **#77c856** ("Green")
    - Set color 11: **#c8d7eb** ("Cyan")
    - Set color 12: **#ff9999** ("Red")
    - Set color 13: **#ba8baf** ("Magenta")
    - Set color 14: **#ffffcc** ("Yellow")
    - Set color 15: **#ffffff** ("White")
    - Save scheme as **Technology Toolbox Dark**

Update hard-coded foreground color in PowerShell profile:

```PowerShell
Notepad C:\NotBackedUp\Public\Toolbox\cmder\vendor\profile.ps1
```

Update line 108 as follows:

108: Microsoft.PowerShell.Utility\Write-Host \$pwd.ProviderPath -NoNewLine -ForegroundColor ~~Green~~ **DarkGray**

Display console colors:

```PowerShell
$colors = [enum]::GetValues([System.ConsoleColor])
Foreach ($bgcolor in $colors){
    Foreach ($fgcolor in $colors) {
        Write-Host "$fgcolor|"  -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine
    }

    Write-Host " on $bgcolor"
}
```

Original source: https://stackoverflow.com/a/41954792

## References

[Customize Windows Cmder Prompt](https://amreldib.com/blog/CustomizeWindowsCmderPrompt/)

[cmder-powershell-powerline-prompt](https://github.com/AmrEldib/cmder-powershell-powerline-prompt#cmder-powershell-powerline-prompt)

[base16](http://chriskempson.com/projects/base16/)

[Nord - An arctic, north-bluish color palette](https://github.com/arcticicestudio/nord)
