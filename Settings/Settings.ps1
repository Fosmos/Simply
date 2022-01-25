Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$v = @{}
$variablesPath = Resolve-Path "..\@Resources\Variables.inc"
$raw = Get-Content -Path $variablesPath
foreach ($line in $raw)
{
    if ($line -match "^(\w+)\s??=\s??(.*?);?\n?$")
    {
        Write-Host $matches[1]:  $matches[2]
        $v[$matches[1]] = $matches[2]
    }
}

if ($v["playerName"] -eq "") { $v["playerName"]='Spotify' }
if ($v["playerName"] -eq "Spotify" -AND $v["playerPlugin"] -eq "NowPlaying") { $v["playerName"]="Spotify (Now Playing)" }
$rmPath = (Get-Process "Rainmeter").Path
& $rmPath !ActivateConfig "Simply\Dummy" "Dummy.ini"

$assemblies=(
    "System", 
    "System.Runtime.InteropServices",
    "System.Windows.Forms"
)

$psforms = @'
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace PSForms
{
    public class ListViewX : ListView
    {
        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
        public extern static int SetWindowTheme(IntPtr hWnd, string pszSubAppName, string pszSubIdList);

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(this.Handle, "explorer", null);
        }
    }

    // [WIP]
    public class NumericUpDownX : NumericUpDown
    {
        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
        public extern static int SetWindowTheme(IntPtr hWnd, string pszSubAppName, string pszSubIdList);

        public NumericUpDownX()
        {
            this.Paint += NumericUpDownX_Paint;
            this.GotFocus += NumericUpDownX_GotFocus;
            this.LostFocus += NumericUpDownX_LostFocus;
        }

        public string Unit { get; set; }

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(this.Handle, "explorer", null);
        }

        private void NumericUpDownX_Paint(object sender, PaintEventArgs e)
        {
            //this.Text = this.Value + Unit;
        }

        private void NumericUpDownX_GotFocus(object sender, EventArgs e)
        {
            //this.Text = this.Value.ToString();
        }

        private void NumericUpDownX_LostFocus(object sender, EventArgs e)
        {
            //this.Text = this.Value + Unit;
        }

        /*
        protected override void UpdateEditText()
        {
            // Append the units to the end of the numeric value
            //this.Text = this.Value + Unit;
        }*/
    }
}
'@

$wppsdef = @'
[DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool WritePrivateProfileString(string lpAppName,
    string lpKeyName,
    string lpString,
    string lpFileName);
'@

$wpps = Add-Type -MemberDefinition $wppsdef -Name WinWritePrivateProfileString -Namespace Win32Utils -PassThru
Add-Type -ReferencedAssemblies $assemblies -TypeDefinition $psforms -Language CSharp

# Window Settings
$form                               = New-Object system.Windows.Forms.Form
$form.ClientSize                    = '260,175'
$form.text                          = $v["Config"]
$form.TopMost                       = $false
$form.Icon                          = [Drawing.Icon]::ExtractAssociatedIcon($rmPath)
$form.AutoSize                      = $false
$form.FormBorderStyle               = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.ShowInTaskbar                 = $false
$form.MinimizeBox                   = $false
$form.MaximizeBox                   = $false
$form.Font                          = 'Arial,9'

### <MediaPlayer> ###
    # MediaPlayer
    $lblPlayer                      = New-Object system.Windows.Forms.Label
    $lblPlayer.text                 = "Media Player:"
    $lblPlayer.AutoSize             = $true
    $lblPlayer.width                = 25
    $lblPlayer.height               = 10
    $lblPlayer.location             = New-Object System.Drawing.Point(10,10)

    $cbPlayer                       = New-Object System.Windows.Forms.ComboBox
    $cbPlayer.width                 = 100
    $cbPlayer.height                = 20
    $cbPlayer.location              = New-Object System.Drawing.Point(150,8)
    $cbPlayer.Font                  = 'Microsoft Sans Serif,8'
    $cbPlayer.DropDownStyle         = 'DropDownList'
    $cbPlayer.Items.AddRange(@('Spotify','Spotify (Now Playing)','Web','WMP','iTunes'))
    $cbPlayer.SelectedItem          = $v["playerName"]

    # Chameleon Colors
    $cbChameleon                    = New-Object system.Windows.Forms.CheckBox
    $cbChameleon.text               = "Chameleon Colors"
    $cbChameleon.AutoSize           = $true
    $cbChameleon.width              = 100
    $cbChameleon.height             = 20
    $cbChameleon.location           = New-Object System.Drawing.Point(10,35)
    $cbChameleon.Checked            = [int]$v["Chameleon"]
    $cbChameleon.Enabled            = $false

    # Scale
    $lblImageSize                   = New-Object system.Windows.Forms.Label
    $lblImageSize.text              = "Image Scale:"
    $lblImageSize.AutoSize          = $true
    $lblImageSize.width             = 25
    $lblImageSize.height            = 10
    $lblImageSize.location          = New-Object System.Drawing.Point(10,65)

    $numImageSize                   = New-Object PSForms.NumericUpDownX
    $numImageSize.AutoSize          = $true
    $numImageSize.width             = 100
    $numImageSize.height            = 10
    $numImageSize.location          = New-Object System.Drawing.Point(150,63)
    $numImageSize.Font              = 'Microsoft Sans Serif,8'
    $numImageSize.DecimalPlaces     = 0
    $numImageSize.Minimum           = 10
    $numImageSize.Maximum           = 1000
    $numImageSize.Value             = $v["CoverSize"]

    # Info Orientation
    $lblOri                         = New-Object system.Windows.Forms.Label
    $lblOri.text                    = "Orientation:"
    $lblOri.AutoSize                = $true
    $lblOri.width                   = 25
    $lblOri.height                  = 10
    $lblOri.location                = New-Object System.Drawing.Point(10,95)

    $cbOri                          = New-Object System.Windows.Forms.ComboBox
    $cbOri.width                    = 100
    $cbOri.height                   = 20
    $cbOri.location                 = New-Object System.Drawing.Point(150,93)
    $cbOri.Font                     = 'Microsoft Sans Serif,8'
    $cbOri.DropDownStyle            = 'DropDownList'
    $cbOri.Items.AddRange(@('Horizontal','Vertical')) #,'Center (WIP)'))
    $cbOri.SelectedItem             = $v["Orientation"]

    # Info Direction
    $cbDir                          = New-Object system.Windows.Forms.CheckBox
    $cbDir.text                     = "Invert Direction"
    $cbDir.AutoSize                 = $true
    $cbDir.width                    = 100
    $cbDir.height                   = 20
    $cbDir.location                 = New-Object System.Drawing.Point(10,115)
    $cbDir.Checked                  = [int]$v["Direction"]

    # AutoHide
    $cbHide                         = New-Object System.Windows.Forms.CheckBox
    $cbHide.text                    = "Auto-Hide Cover"
    $cbHide.AutoSize                = $true
    $cbHide.width                   = 100
    $cbHide.height                  = 20
    $cbHide.location                = New-Object System.Drawing.Point(138, 115)
    $cbHide.Checked                 = [int]$v["autohide"]
### <MediaPlayer/>

# Apply Button
$btnApply                           = New-Object system.Windows.Forms.Button
$btnApply.text                      = "Apply"
$btnApply.width                     = 240
$btnApply.height                    = 30
$btnApply.location                  = New-Object System.Drawing.Point(10,135)
$btnApply.Add_Click({ applyClick })

### <Helper Functions> ###
    function WriteKeyValue([string] $key, [string] $value)
    {
        $wpps::WritePrivateProfileString("Variables", $key, $value, $variablesPath)
    }

    function CommandMeasure([string] $measure, [string] $arguments, [string] $config)
    {
        & $rmPath !CommandMeasure "$measure" "$arguments" "$config"
    }

    function MediaPlayer
    {
        # Since there are 2 Spotify options set it as the default
        WriteKeyValue playerName 'Spotify'
        WriteKeyValue playerPlugin 'NowPlaying'
        WriteKeyValue playerEXE '%userprofile%\AppData\Roaming\Spotify\Spotify.exe'
        WriteKeyValue ImageName 'spotify.png'
        WriteKeyValye likeVal "SetRating 5"
        WriteKeyValue noLikeVal "SetRating 0"
        WriteKeyValue heartTint 1DB954

        if($cbPlayer.SelectedItem.equals("Spotify"))
        {
            # This is the WebNowPlaying version of Spotify
            WriteKeyValue playerPlugin 'Web'

        } elseif ($cbPlayer.SelectedItem.equals("Web"))
        {
            WriteKeyValue playerName 'Web'
            WriteKeyValue playerPlugin 'Web'
            WriteKeyValue playerEXE ''
            WriteKeyValue ImageName 'Web.png'
            WriteKeyValue heartTint 2870B8
        } elseif ($cbPlayer.SelectedItem.equals("WMP"))
        {
            WriteKeyValue playerName 'WMP'
            WriteKeyValue playerEXE 'wmplayer.exe'
            WriteKeyValue ImageName 'WMP.png'
            WriteKeyValue heartTint 2870B8
        } elseif ($cbPlayer.SelectedItem.equals("iTunes"))
        {
            WriteKeyValue playerName 'iTunes'
            WriteKeyValue playerEXE 'iTunes.exe'
            WriteKeyValue ImageName 'itunes.png'
            WriteKeyValue heartTint D3D3D3
        }
    }

    function applyClick
    {
        #$doChameleon = [int]$cbChameleon.Checked
        #WriteKeyValue Chameleon $doChameleon

        # Set the media player data
        MediaPlayer

        $doInvert = [int]$cbDir.Checked
        WriteKeyValue Direction $doInvert

        # Set the direction
        WriteKeyValue Orientation $cbOri.SelectedItem
        if ($cbOri.SelectedItem.equals("Vertical")) {
            WriteKeyValue Justify "Center"
            WriteKeyValue Origin "(#Width#*0.5)"
            WriteKeyValue CoverOrigin "(#Origin#-#CoverSize#*0.5)"
        } else
        {
            if ($cbDir.Checked) {
                WriteKeyValue Justify "Right"
                WriteKeyValue Origin "(#CoverSize#*6)"
            }
            else {
                WriteKeyValue Justify "Left"
                WriteKeyValue Origin 0
            }

            WriteKeyValue CoverOrigin "#Origin#"
        }

        # Set the cover size
        WriteKeyValue CoverSize $numImageSize.Value

        $doHide = [int]$cbHide.Checked
        WriteKeyValue autohide $doHide

        # Refresh the skin
        & $rmPath !RefreshGroup "Simply"
    }
### <HelperFunctions/> ###

$form.controls.AddRange(@($lblPlayer,$cbPlayer,$cbChameleon,$lblOri,$cbOri,$lblImageSize,$numImageSize,$cbDir,$cbHide,$btnApply))

$form.ResumeLayout()

[Windows.Forms.Application]::Run($form)